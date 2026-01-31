import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class CategoryScreen extends StatelessWidget {
  final String? categoryName;
  const CategoryScreen({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    final String title = categoryName ?? 'Semua Kategori';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // List kategori untuk fallback
    final List<String> allCategoriesList = [
      'CPU', 'Motherboard', 'VGA', 'Hard Drive', 'SSD', 'RAM', 'PSU', 'Casing', 'Cooling Fan'
    ];

    // Data Produk Realistik berdasarkan Kategori (10 per kategori)
    final Map<String, List<Product>> categoryProducts = {
      'CPU': [
        Product(name: 'AMD Ryzen 5 5600X', description: '6 Cores, 12 Threads, 3.7GHz', price: 2450000, image: 'assets/images/cpu.png'),
        Product(name: 'Intel Core i5-12400F', description: '6 Cores, 12 Threads, LGA1700', price: 2100000, image: 'assets/images/cpu.png'),
        Product(name: 'AMD Ryzen 7 5800X', description: '8 Cores, 16 Threads, 3.8GHz', price: 3800000, image: 'assets/images/cpu.png'),
        Product(name: 'Intel Core i7-13700K', description: '16 Cores, 24 Threads, Gen 13', price: 6200000, image: 'assets/images/cpu.png'),
        Product(name: 'AMD Ryzen 3 3200G', description: '4 Cores, 4 Threads, Vega 8 Graphics', price: 1250000, image: 'assets/images/cpu.png'),
        Product(name: 'Intel Core i3-10100F', description: '4 Cores, 8 Threads, LGA1200', price: 1100000, image: 'assets/images/cpu.png'),
        Product(name: 'AMD Ryzen 9 7900X', description: '12 Cores, 24 Threads, Zen 4', price: 7500000, image: 'assets/images/cpu.png'),
        Product(name: 'Intel Core i9-14900K', description: '24 Cores, 32 Threads, LGA1700', price: 9500000, image: 'assets/images/cpu.png'),
        Product(name: 'AMD Ryzen 5 3600', description: '6 Cores, 12 Threads, Zen 2', price: 1350000, image: 'assets/images/cpu.png'),
        Product(name: 'Intel Core i5-11400', description: '6 Cores, 12 Threads, UHD 730', price: 1950000, image: 'assets/images/cpu.png'),
      ],
      'Motherboard': [
        Product(name: 'ASUS ROG Strix B550-F', description: 'AM4, ATX, PCIe 4.0, RGB', price: 2900000, image: 'assets/images/motherboard.png'),
        Product(name: 'MSI MAG Z690 Tomahawk', description: 'LGA 1700, DDR5, WiFi 6E', price: 4200000, image: 'assets/images/motherboard.png'),
        Product(name: 'Gigabyte B660M DS3H', description: 'LGA 1700, Micro-ATX, DDR4', price: 1850000, image: 'assets/images/motherboard.png'),
        Product(name: 'ASRock B450 Steel Legend', description: 'AM4, ATX, RGB, Dual M.2', price: 1650000, image: 'assets/images/motherboard.png'),
        Product(name: 'ASUS Prime H610M-E', description: 'LGA 1700, Micro-ATX, DDR4', price: 1250000, image: 'assets/images/motherboard.png'),
        Product(name: 'MSI B550M Pro-VDH WiFi', description: 'AM4, Micro-ATX, WiFi Support', price: 1750000, image: 'assets/images/motherboard.png'),
        Product(name: 'Gigabyte Z790 AORUS ELITE', description: 'LGA 1700, DDR5, High Performance', price: 4800000, image: 'assets/images/motherboard.png'),
        Product(name: 'ASUS TUF Gaming X570-Plus', description: 'AM4, ATX, PCIe 4.0, WiFi', price: 3450000, image: 'assets/images/motherboard.png'),
        Product(name: 'MSI A520M-A Pro', description: 'AM4, Entry Level Micro-ATX', price: 950000, image: 'assets/images/motherboard.png'),
        Product(name: 'ASRock Z690 Phantom Gaming', description: 'LGA 1700, ATX, Gaming Focus', price: 3100000, image: 'assets/images/motherboard.png'),
      ],
      'VGA': [
        Product(name: 'NVIDIA RTX 4060 Ti', description: '8GB GDDR6, Ray Tracing, DLSS 3', price: 6500000, image: 'assets/images/vga.png'),
        Product(name: 'AMD Radeon RX 6700 XT', description: '12GB GDDR6, RDNA 2', price: 5200000, image: 'assets/images/vga.png'),
        Product(name: 'NVIDIA RTX 3060', description: '12GB GDDR6, Mid-Range King', price: 4500000, image: 'assets/images/vga.png'),
        Product(name: 'NVIDIA GTX 1650', description: '4GB GDDR6, No External Power', price: 2100000, image: 'assets/images/vga.png'),
        Product(name: 'AMD Radeon RX 7900 XTX', description: '24GB GDDR6, High End RDNA 3', price: 16500000, image: 'assets/images/vga.png'),
        Product(name: 'NVIDIA RTX 4090', description: '24GB GDDR6X, Ultimate Power', price: 32000000, image: 'assets/images/vga.png'),
        Product(name: 'AMD Radeon RX 6600', description: '8GB GDDR6, Best Value 1080p', price: 3400000, image: 'assets/images/vga.png'),
        Product(name: 'NVIDIA RTX 4070', description: '12GB GDDR6X, Power Efficient', price: 9800000, image: 'assets/images/vga.png'),
        Product(name: 'NVIDIA GTX 1660 Super', description: '6GB GDDR6, Budget King', price: 3100000, image: 'assets/images/vga.png'),
        Product(name: 'AMD Radeon RX 580', description: '8GB GDDR5, Legend Still Lives', price: 1450000, image: 'assets/images/vga.png'),
      ],
      'Hard Drive': [
        Product(name: 'Seagate Barracuda 1TB', description: '7200RPM, 64MB Cache, SATA 3', price: 750000, image: 'assets/images/hard_drive.png'),
        Product(name: 'WD Blue 2TB', description: '5400RPM, SATA 6Gb/s, 256MB Cache', price: 950000, image: 'assets/images/hard_drive.png'),
        Product(name: 'Toshiba P300 1TB', description: '7200RPM, Performance HDD', price: 720000, image: 'assets/images/hard_drive.png'),
        Product(name: 'Seagate IronWolf 4TB', description: 'NAS Optimized, 5900RPM', price: 1850000, image: 'assets/images/hard_drive.png'),
        Product(name: 'WD Red Plus 2TB', description: 'NAS Internal Hard Drive', price: 1250000, image: 'assets/images/hard_drive.png'),
        Product(name: 'Seagate SkyHawk 2TB', description: 'Surveillance Optimized', price: 1050000, image: 'assets/images/hard_drive.png'),
        Product(name: 'WD Black 1TB', description: '7200RPM, High Performance', price: 1150000, image: 'assets/images/hard_drive.png'),
        Product(name: 'Toshiba X300 4TB', description: '7200RPM, Large Cache', price: 1950000, image: 'assets/images/hard_drive.png'),
        Product(name: 'Seagate Barracuda 4TB', description: 'High Capacity Desktop Drive', price: 1550000, image: 'assets/images/hard_drive.png'),
        Product(name: 'WD Blue 500GB', description: 'Budget Desktop Storage', price: 450000, image: 'assets/images/hard_drive.png'),
      ],
      'SSD': [
        Product(name: 'Samsung 980 Pro 1TB', description: 'NVMe M.2 Gen4, 7000MB/s', price: 1450000, image: 'assets/images/ssd.png'),
        Product(name: 'Crucial P3 500GB', description: 'NVMe M.2 Gen3, 3500MB/s', price: 650000, image: 'assets/images/ssd.png'),
        Product(name: 'Samsung 870 EVO 500GB', description: 'SATA 2.5 Inch SSD', price: 800000, image: 'assets/images/ssd.png'),
        Product(name: 'WD Black SN850X 1TB', description: 'Gen4 NVMe, Heat Sink Support', price: 1650000, image: 'assets/images/ssd.png'),
        Product(name: 'Kingston NV2 1TB', description: 'Budget Gen4 NVMe SSD', price: 950000, image: 'assets/images/ssd.png'),
        Product(name: 'Samsung 970 EVO Plus 2TB', description: 'Trusted Gen3 Performance', price: 2150000, image: 'assets/images/ssd.png'),
        Product(name: 'ADATA XPG SX8200 Pro 512GB', description: 'Fast Gen3 Performance', price: 750000, image: 'assets/images/ssd.png'),
        Product(name: 'TeamGroup T-Force Vulcan 500GB', description: 'SATA 2.5" RGB Support', price: 720000, image: 'assets/images/ssd.png'),
        Product(name: 'Lexar NM790 1TB', description: 'Gen4 x4, Up to 7400MB/s', price: 1250000, image: 'assets/images/ssd.png'),
        Product(name: 'PNY CS900 240GB', description: 'Cheapest SATA SSD', price: 2950000, image: 'assets/images/ssd.png'),
      ],
      'RAM': [
        Product(name: 'Corsair Vengeance 16GB', description: 'DDR4 3200MHz (2x8GB) RGB', price: 850000, image: 'assets/images/ram.png'),
        Product(name: 'Kingston FURY 32GB', description: 'DDR5 5600MHz (2x16GB)', price: 1800000, image: 'assets/images/ram.png'),
        Product(name: 'G.Skill Trident Z 16GB', description: 'DDR4 3600MHz RGB CL16', price: 1200000, image: 'assets/images/ram.png'),
        Product(name: 'Team Elite Plus 8GB', description: 'DDR4 2666MHz Budget RAM', price: 350000, image: 'assets/images/ram.png'),
        Product(name: 'ADATA XPG Spectrix 16GB', description: 'DDR4 3200MHz RGB White', price: 920000, image: 'assets/images/ram.png'),
        Product(name: 'Corsair Dominator Platinum 32GB', description: 'DDR5 6000MHz High End', price: 2850000, image: 'assets/images/ram.png'),
        Product(name: 'Kingston ValueRAM 4GB', description: 'DDR4 2400MHz Basic RAM', price: 220000, image: 'assets/images/ram.png'),
        Product(name: 'T-Force Delta RGB 16GB', description: 'DDR4 3200MHz Black', price: 880000, image: 'assets/images/ram.png'),
        Product(name: 'Crucial RAM 16GB', description: 'DDR5 4800MHz Basic DDR5', price: 1350000, image: 'assets/images/ram.png'),
        Product(name: 'G.Skill Ripjaws V 16GB', description: 'DDR4 3200MHz Dual Channel', price: 780000, image: 'assets/images/ram.png'),
      ],
      'PSU': [
        Product(name: 'Cooler Master 750W', description: '80+ Gold Fully Modular', price: 1350000, image: 'assets/images/psu.png'),
        Product(name: 'Corsair RM850x', description: '850W 80+ Gold Fully Modular', price: 1950000, image: 'assets/images/psu.png'),
        Product(name: 'Deepcool DN500', description: '500W 80+ Standard', price: 550000, image: 'assets/images/psu.png'),
        Product(name: 'Seasonic Focus GX-650', description: '650W 80+ Gold Modular', price: 1450000, image: 'assets/images/psu.png'),
        Product(name: 'EVGA 600 W1', description: '600W 80+ White Rated', price: 680000, image: 'assets/images/psu.png'),
        Product(name: 'Thermaltake Toughpower 850W', description: 'ARGB, 80+ Gold Modular', price: 2100000, image: 'assets/images/psu.png'),
        Product(name: 'FSP HV Pro 550W', description: '80+ Bronze Budget PSU', price: 580000, image: 'assets/images/psu.png'),
        Product(name: 'AeroCool LUX 550W', description: '80+ Bronze RGB PSU', price: 480000, image: 'assets/images/psu.png'),
        Product(name: 'Super Flower Leadex III 750W', description: '80+ Gold Modular Premium', price: 1650000, image: 'assets/images/psu.png'),
        Product(name: 'SilverStone ET550-B', description: '550W 80+ Bronze Essential', price: 620000, image: 'assets/images/psu.png'),
      ],
      'Casing': [
        Product(name: 'NZXT H5 Flow', description: 'Mid-Tower, High Airflow, Black', price: 1200000, image: 'assets/images/casing.png'),
        Product(name: 'Paradox Gaming Trickster', description: 'ATX Case with 3 RGB Fans', price: 550000, image: 'assets/images/casing.png'),
        Product(name: 'Lian Li PC-O11 Dynamic', description: 'Showcase Dual Chamber ATX', price: 2450000, image: 'assets/images/casing.png'),
        Product(name: 'Corsair 4000D Airflow', description: 'Tempered Glass Mid-Tower', price: 1450000, image: 'assets/images/casing.png'),
        Product(name: 'Fractal Design Meshify C', description: 'Compact ATX High Airflow', price: 1550000, image: 'assets/images/casing.png'),
        Product(name: 'Cooler Master MasterBox Q300L', description: 'Micro-ATX Mini Tower', price: 750000, image: 'assets/images/casing.png'),
        Product(name: 'Tecware Forge M', description: 'Mesh Micro-ATX + 4 RGB Fans', price: 480000, image: 'assets/images/casing.png'),
        Product(name: 'Deepcool Matrexx 55 V3', description: 'E-ATX Case with RGB Strip', price: 780000, image: 'assets/images/casing.png'),
        Product(name: 'Phanteks Eclipse G360A', description: 'High Airflow Performance Case', price: 1350000, image: 'assets/images/casing.png'),
        Product(name: 'MSI MAG Forge 100R', description: 'Mid Tower with ARGB Fans', price: 820000, image: 'assets/images/casing.png'),
      ],
      'Cooling Fan': [
        Product(name: 'Deepcool AK400', description: 'Single Tower CPU Air Cooler', price: 350000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Cooler Master ML240L', description: '240mm AIO Liquid Cooler RGB', price: 950000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Noctua NH-D15', description: 'Premium Dual Tower Cooler', price: 1650000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'ID-Cooling SE-224-XT', description: 'Budget Performance Air Cooler', price: 280000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'NZXT Kraken X53', description: '240mm AIO with Infinity Mirror', price: 1950000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Arctic P12 PWM PST', description: '120mm Case Fan High Static', price: 120000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Be Quiet! Dark Rock Pro 4', description: 'Quiet Performance CPU Cooler', price: 1350000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Corsair iCUE H150i ELITE', description: '360mm LCD Display AIO', price: 4100000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Thermalright Peerless Assassin', description: 'Top Value Dual Tower', price: 650000, image: 'assets/images/cooling_fan.png'),
        Product(name: 'Lian Li UNI Fan SL120', description: 'Modular ARGB Case Fan', price: 350000, image: 'assets/images/cooling_fan.png'),
      ],
    };

    if (categoryName == null) {
      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.grey.shade100,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: isDark ? Colors.grey.shade900 : Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: allCategoriesList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.category, color: Colors.teal),
                title: Text(allCategoriesList[index]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(categoryName: allCategoriesList[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }

    final List<Product> products = categoryProducts[categoryName] ?? [];

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: products.isEmpty
          ? const Center(child: Text('Belum ada produk untuk kategori ini'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => ProductCard(product: products[index]),
            ),
    );
  }
}
