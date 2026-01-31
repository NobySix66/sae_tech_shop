import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'main_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.cartItems;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat Pengiriman', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)
                  ),
                  Card(
                    color: isDark ? Colors.grey.shade900 : Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.teal),
                      title: Text('Erlangga Yuda', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      subtitle: Text('Jl. Raya No. 123, Bandung, Jawa Barat', style: TextStyle(color: isDark ? Colors.grey : Colors.black54)),
                      trailing: Icon(Icons.chevron_right, color: isDark ? Colors.grey : Colors.black26),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rincian Pesanan', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)
                  ),
                  ...items.map((item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.product.name, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        subtitle: Text('${item.quantity}x @ Rp ${item.product.price}', style: TextStyle(color: isDark ? Colors.grey : Colors.black54)),
                        trailing: Text(
                          'Rp ${item.product.price * item.quantity}', 
                          style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.tealAccent : Colors.black)
                        ),
                      )),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Metode Pembayaran', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)
                  ),
                  const SizedBox(height: 8),
                  _paymentOption('Transfer Bank', Icons.account_balance),
                  _paymentOption('E-Wallet (Gopay/OVO)', Icons.account_balance_wallet),
                  _paymentOption('COD (Bayar di Tempat)', Icons.payments),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              boxShadow: [BoxShadow(color: isDark ? Colors.black54 : Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran', 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black)
                    ),
                    Text(
                      'Rp ${cart.totalAmount}', 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog(context, cart);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Konfirmasi Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RadioListTile(
      value: title,
      groupValue: selectedPayment,
      activeColor: Colors.teal,
      onChanged: (val) {
        setState(() => selectedPayment = val.toString());
      },
      title: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      secondary: Icon(icon, color: Colors.teal),
    );
  }

  void _showSuccessDialog(BuildContext context, CartProvider cart) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('Pesanan Berhasil!', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          ],
        ),
        content: Text(
          'Terima kasih! Pesanan Anda sedang kami proses dan akan segera dikirim.', 
          textAlign: TextAlign.center,
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                final double currentTotal = cart.totalAmount;
                final String currentPayment = selectedPayment;

                // 1. Tambah notifikasi
                cart.addNotification(
                  'Pembayaran Berhasil!',
                  'Pesanan Anda senilai Rp $currentTotal telah berhasil dibayar menggunakan $currentPayment.',
                );
                
                // 2. Simpan order dan KOSONGKAN CART
                cart.addOrder();

                // 3. Tutup Dialog
                Navigator.pop(ctx);

                // 4. RESET ke MainScreen (Tab Home)
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kembali ke Home'),
            ),
          ),
        ],
      ),
    );
  }
}
