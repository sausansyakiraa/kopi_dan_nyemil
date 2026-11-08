import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'confirmation_screen.dart';
import 'home_screen.dart' show QtyStepper;

/// 7. Alamat pengiriman (Checkout)
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: appState.orderNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _openAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _AddressFormSheet(),
    );
  }

  void _submitOrder() {
    if (appState.totalItems == 0) {
      showSnack(context, 'Keranjang masih kosong, pilih menu dulu di Home');
      return;
    }
    if (appState.address == null) {
      showSnack(context, 'Isi alamat dulu');
      _openAddressSheet();
      return;
    }

    final name = appState.address!.fullName;
    appState.clearCart();
    appState.clearOrderNote();
    _noteController.clear();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ConfirmationScreen(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final ordered = dummyMenu.where((e) => (appState.cart[e.id] ?? 0) > 0);
        final addr = appState.address;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // a. Header Checkout dengan tombol kembali
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.ink),
                    onPressed: () => appState.setTab(0),
                  ),
                  const SizedBox(width: 4),
                  const Heading('Checkout'),
                ],
              ),
              const SizedBox(height: 20),

              // b. Bagian "Alamat pengiriman"
              const Text(
                'Alamat pengiriman',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Material(
                color: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: InkWell(
                  onTap: _openAddressSheet,
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: addr == null
                        ? Row(
                            children: const [
                              Icon(Icons.location_on_outlined, color: AppColors.brown),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Tambah alamat pengiriman',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: AppColors.muted),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on, color: AppColors.brown),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      addr.fullName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: AppColors.ink,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      addr.address,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.ink,
                                      ),
                                    ),
                                    if (addr.detail.trim().isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        addr.detail,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Ubah',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.brown,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // c. Bagian "Pesanan kamu"
              const Text(
                'Pesanan kamu',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              if (appState.totalItems == 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Text(
                    'Belum ada pesanan. Tambahkan menu dari halaman Home.',
                    style: TextStyle(color: AppColors.muted),
                  ),
                )
              else ...[
                for (final item in ordered)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                formatRupiah(item.price),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QtyStepper(item: item),
                      ],
                    ),
                  ),

                // d. Catatan untuk resto
                const SizedBox(height: 16),
                const Text(
                  'Catatan untuk resto',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  onChanged: (note) => appState.setOrderNote(note),
                  decoration: const InputDecoration(
                    hintText: 'Contoh: tidak pakai gula, es dipisah',
                  ),
                ),

                // e. Garis pemisah & Total
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      formatRupiah(appState.totalPrice),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: AppColors.brown,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 24),

              // f. Tombol Order dan Kirim
              PrimaryButton(
                label: 'Order dan Kirim',
                onPressed: _submitOrder,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddressFormSheet extends StatefulWidget {
  const _AddressFormSheet();

  @override
  State<_AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<_AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    final currentAddr = appState.address;
    _nameController = TextEditingController(
      text: currentAddr?.fullName ?? appState.currentUser?.fullName ?? '',
    );
    _addressController = TextEditingController(
      text: currentAddr?.address ?? '',
    );
    _detailController = TextEditingController(
      text: currentAddr?.detail ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final newAddress = DeliveryAddress(
      fullName: _nameController.text.trim(),
      address: _addressController.text.trim(),
      detail: _detailController.text.trim(),
    );

    appState.saveAddress(newAddress);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Alamat pengiriman',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _nameController,
                hint: 'Nama Lengkap',
                action: TextInputAction.next,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              AppTextField(
                controller: _addressController,
                hint: 'Alamat',
                maxLines: 3,
                action: TextInputAction.next,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Alamat wajib diisi' : null,
              ),
              AppTextField(
                controller: _detailController,
                hint: 'Patokan atau detail lengkap',
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: 'Save',
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}