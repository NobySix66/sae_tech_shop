import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';
import 'category_screen.dart';
import 'notification_screen.dart';
import 'favorite_screen.dart';
import 'tracking_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController(viewportFraction: 0.9);

  int _currentBanner = 0;

  final List<String> banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'CPU', 'icon': Icons.memory},
    {'name': 'Motherboard', 'icon': Icons.devices},
    {'name': 'VGA', 'icon': Icons.videogame_asset},
    {'name': 'Hard Drive', 'icon': Icons.storage},
    {'name': 'SSD', 'icon': Icons.sd_storage},
    {'name': 'RAM', 'icon': Icons.memory},
    {'name': 'PSU', 'icon': Icons.power},
    {'name': 'Casing', 'icon': Icons.smart_toy},
    {'name': 'Cooling Fan', 'icon': Icons.ac_unit},
  ];

  final List<Product> allProducts = [
    Product(
      name: 'AMD Ryzen 5 5600X',
      description: '6 Cores, 12 Threads, 3.7GHz Boost',
      price: 2450000,
      image: 'assets/images/cpu.png',
    ),
    Product(
      name: 'Intel Core i5-12400F',
      description: '6 Cores, 12 Threads, LGA1700',
      price: 2100000,
      image: 'assets/images/cpu.png',
    ),
    Product(
      name: 'AMD Ryzen 7 5800X',
      description: '8 Cores, 16 Threads, High Performance',
      price: 3800000,
      image: 'assets/images/cpu.png',
    ),
    Product(
      name: 'NVIDIA RTX 4060 Ti',
      description: '8GB GDDR6, Ray Tracing, DLSS 3',
      price: 6500000,
      image: 'assets/images/vga.png',
    ),
    Product(
      name: 'AMD Radeon RX 6700 XT',
      description: '12GB GDDR6, RDNA 2 Architecture',
      price: 5200000,
      image: 'assets/images/vga.png',
    ),
    Product(
      name: 'Corsair Vengeance 16GB',
      description: 'DDR4 3200MHz (2x8GB) RGB',
      price: 850000,
      image: 'assets/images/ram.png',
    ),
    Product(
      name: 'Kingston FURY 32GB',
      description: 'DDR5 5600MHz High Speed',
      price: 1800000,
      image: 'assets/images/ram.png',
    ),
    Product(
      name: 'Samsung 980 Pro 1TB',
      description: 'NVMe M.2 Gen4 SSD, 7000MB/s',
      price: 1450000,
      image: 'assets/images/ssd.png',
    ),
    Product(
      name: 'Seagate Barracuda 2TB',
      description: 'SATA HDD 7200RPM Bulk Storage',
      price: 900000,
      image: 'assets/images/hard_drive.png',
    ),
    Product(
      name: 'ASUS ROG Strix B550-F',
      description: 'AM4 ATX, PCIe 4.0, Aura Sync',
      price: 2900000,
      image: 'assets/images/motherboard.png',
    ),
    Product(
      name: 'MSI MAG Z690 Tomahawk',
      description: 'LGA 1700, DDR5, WiFi 6E',
      price: 4200000,
      image: 'assets/images/motherboard.png',
    ),
    Product(
      name: 'Cooler Master 750W',
      description: '80+ Gold Fully Modular',
      price: 1350000,
      image: 'assets/images/psu.png',
    ),
    Product(
      name: 'NZXT H5 Flow',
      description: 'Mid-Tower Case, High Airflow',
      price: 1200000,
      image: 'assets/images/casing.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoSlideBanner);
  }

  void _autoSlideBanner() {
    if (_bannerController.hasClients) {
      if (!mounted) return;
      setState(() {
        _currentBanner = (_currentBanner + 1) % banners.length;
      });
      _bannerController.animateToPage(
        _currentBanner,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 3), _autoSlideBanner);
    }
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://maps.app.goo.gl/ZQKJYWTSsogjFQyCA');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka peta')),
      );
    }
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchScreen(
                      query: value,
                      allProducts: allProducts,
                    ),
                  ),
                );
              }
            },
            decoration: InputDecoration(
              hintText: 'Search hardware...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: isDark ? Colors.white : Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: isDark ? Colors.white : Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _bannerController,
                itemCount: banners.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      banners[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onPageChanged: (i) => setState(() => _currentBanner = i),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => Container(
                  width: _currentBanner == i ? 16 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentBanner == i ? Colors.teal : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _launchUrl,
                    icon: const Icon(Icons.store, size: 20),
                    label: const Text('Toko Fisik', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TrackingScreen()),
                      );
                    },
                    icon: const Icon(Icons.local_shipping, size: 20),
                    label: const Text('Lacak Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.teal.shade900 : Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Kategori Hardware',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryScreen(categoryName: cat['name']),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(cat['icon'], color: Colors.teal),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Produk Terpopuler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lihat Semua',
                  style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (_, i) => ProductCard(product: allProducts[i]),
            ),
          ],
        ),
      ),
    );
  }
}
