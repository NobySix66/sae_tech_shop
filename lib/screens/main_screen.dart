import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/need_login_dialog.dart';
import 'home_screen.dart';
import 'setting_screen.dart';
import 'cart_screen.dart';
import 'account_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SettingScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'SAE Tech Shop',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.shopping_bag, color: Colors.teal, size: 40),
      children: const [
        Text(
          'Aplikasi e-commerce hardware komputer untuk tugas besar matakuliah mobile programming\n\n'
          'Dibuat oleh:\n'
          '• Erlangga Yuda Pratama\n'
          '• Shula Khalid Mauliawan\n'
          '• Adrian Nuryana',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2 && !auth.isLoggedIn) {
            // Cek login untuk tab Keranjang
            showDialog(
              context: context,
              builder: (_) => const NeedLoginDialog(
                message: 'Silahkan login terlebih dahulu untuk melihat keranjang belanja Anda.',
              ),
            );
            return;
          }

          if (index == 4) {
            _showAboutDialog();
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Akun',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
