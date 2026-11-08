import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';
import '../theme.dart';

/// 5. Home - daftar makanan & minuman (data dummy)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MenuCategory? _filter; // null = semua

  @override
  Widget build(BuildContext context) {
    final items = dummyMenu
        .where((e) => _filter == null || e.category == _filter)
        .toList();

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'Halo ${appState.displayName},',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Mau makan atau minum apa hari ini?',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 8,
                children: [
                  _chip('Semua', null),
                  _chip('Minuman', MenuCategory.minuman),
                  _chip('Makanan', MenuCategory.makanan),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _MenuCard(item: items[i]),
              ),
            ),
            if (appState.totalItems > 0) _CartBar(),
          ],
        );
      },
    );
  }

  Widget _chip(String label, MenuCategory? value) {
    final selected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      selectedColor: AppColors.ink,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.ink,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _filter = value),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final qty = appState.cart[item.id] ?? 0;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.peach,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, size: 34, color: AppColors.brown),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                for (final d in item.details)
                  Text(
                    '• $d',
                    style: const TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                const SizedBox(height: 4),
                Text(
                  formatRupiah(item.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.brown,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          qty == 0
              ? IconButton.filled(
            onPressed: () => appState.addToCart(item),
            style: IconButton.styleFrom(backgroundColor: AppColors.ink),
            icon: const Icon(Icons.add, color: Colors.white),
          )
              : QtyStepper(item: item),
        ],
      ),
    );
  }
}

/// Tombol - qty + (dipakai di Home dan halaman Order).
class QtyStepper extends StatelessWidget {
  final MenuItem item;
  const QtyStepper({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final qty = appState.cart[item.id] ?? 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _btn(Icons.remove, () => appState.removeFromCart(item)),
        SizedBox(
          width: 28,
          child: Text(
            '$qty',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        _btn(Icons.add, () => appState.addToCart(item)),
      ],
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.ink),
        ),
        child: Icon(icon, size: 16, color: AppColors.ink),
      ),
    );
  }
}

class _CartBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Material(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => appState.setTab(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  '${appState.totalItems} item • ${formatRupiah(appState.totalPrice)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Lihat Order',
                  style: TextStyle(color: Colors.white),
                ),
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}