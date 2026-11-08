import 'package:flutter/material.dart';

import '../app_state.dart';
import 'address_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Kerangka dengan bottom navigation: Home, Order, Profile.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: appState.tabIndex,
              children: const [
                HomeScreen(),
                AddressScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: appState.tabIndex,
            onDestinationSelected: appState.setTab,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: appState.totalItems > 0,
                  label: Text('${appState.totalItems}'),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                selectedIcon: const Icon(Icons.shopping_bag, color: Colors.white),
                label: 'Order',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: Colors.white),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}