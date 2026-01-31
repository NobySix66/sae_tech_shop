import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Jika belum login, tampilkan tombol login atau langsung redirect
    if (!auth.isLoggedIn) {
      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_outlined, size: 80, color: isDark ? Colors.grey.shade700 : Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Anda belum masuk ke akun', 
                style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87)
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Login Sekarang', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }

    // Jika sudah login, tampilkan Profile
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        foregroundColor: Colors.teal,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile
            Container(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.username ?? 'User',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Platinum Member',
                          style: TextStyle(
                            color: isDark ? Colors.tealAccent : Colors.teal.shade700, 
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: isDark ? Colors.grey : Colors.grey),
                    onPressed: () {},
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Statistik/Saldo (Dummy)
            Container(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, 'Saldo', 'Rp 500.000'),
                  _buildStatItem(context, 'Poin', '1.250'),
                  _buildStatItem(context, 'Voucher', '5'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Menu List
            _buildMenuItem(context, Icons.shopping_bag_outlined, 'Pesanan Saya', 'Lihat riwayat belanja'),
            _buildMenuItem(context, Icons.favorite_border, 'Favorit Saya', 'Produk yang Anda sukai'),
            _buildMenuItem(context, Icons.location_on_outlined, 'Alamat Pengiriman', 'Kelola alamat'),
            _buildMenuItem(context, Icons.payment_outlined, 'Metode Pembayaran', 'Kartu & E-Wallet'),
            
            const SizedBox(height: 12),
            
            _buildMenuItem(context, Icons.help_outline, 'Pusat Bantuan', ''),
            _buildMenuItem(context, Icons.security_outlined, 'Keamanan Akun', ''),

            const SizedBox(height: 24),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    auth.logout();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Keluar dari Akun', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black,
          )
        ),
        const SizedBox(height: 4),
        Text(
          label, 
          style: TextStyle(
            color: isDark ? Colors.grey : Colors.grey, 
            fontSize: 12
          )
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      color: isDark ? Colors.grey.shade900 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title, 
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black87,
          )
        ),
        subtitle: subtitle.isNotEmpty 
          ? Text(
              subtitle, 
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey : Colors.grey,
              )
            ) 
          : null,
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
