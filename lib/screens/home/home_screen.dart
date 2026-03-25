import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/product_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/cards/product_card.dart';
import '../notifications/notifications_screen.dart';
import '../product/product_detail_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;

  final List<Map<String, dynamic>> _banners = [
    {'title': 'عروض خاصة', 'subtitle': 'خصومات تصل إلى 50%', 'color': [const Color(0xFFD4AF37), const Color(0xFFF4D03F)]},
    {'title': 'إلكترونيات', 'subtitle': 'أحدث الأجهزة بأفضل الأسعار', 'color': [const Color(0xFF3498DB), const Color(0xFF5DADE2)]},
    {'title': 'عقارات', 'subtitle': 'اكتشف أفضل العقارات', 'color': [const Color(0xFF27AE60), const Color(0xFF58D68D)]},
    {'title': 'أزياء', 'subtitle': 'تشكيلة جديدة لموسم 2024', 'color': [const Color(0xFFE74C3C), const Color(0xFFEC7063)]},
    {'title': 'سيارات', 'subtitle': 'سيارات جديدة ومستعملة', 'color': [const Color(0xFF9B59B6), const Color(0xFFAF7AC5)]},
  ];

  final List<Map<String, dynamic>> _quickServices = [
    {'icon': Icons.construction, 'name': 'معلمات', 'color': Colors.orange},
    {'icon': Icons.apartment, 'name': 'عقارات', 'color': Colors.blue},
    {'icon': Icons.flight, 'name': 'سفر', 'color': Colors.green},
    {'icon': Icons.local_shipping, 'name': 'شحن', 'color': Colors.purple},
    {'icon': Icons.sports_esports, 'name': 'ألعاب', 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getProducts();
    });
  }

  Future<void> _refresh() async {
    await context.read<ProductProvider>().getProducts(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productProvider = context.watch<ProductProvider>();
    final notificationProvider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        onNotificationTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
        },
        onSearchTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
        },
        notificationCount: notificationProvider.unreadCount,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBannerSlider(),
              const SizedBox(height: 24),
              _buildSectionTitle('مزيد من ما تريد'),
              const SizedBox(height: 12),
              _buildQuickServices(),
              const SizedBox(height: 24),
              _buildSectionTitle('منتجات مقترحة لك'),
              const SizedBox(height: 12),
              _buildProductsGrid(productProvider),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() => _currentBannerIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = _banners[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: banner['color'] as List<Color>),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(banner['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(banner['subtitle'], style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((entry) {
            return Container(
              width: _currentBannerIndex == entry.key ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                gradient: _currentBannerIndex == entry.key ? AppTheme.goldGradient : null,
                color: _currentBannerIndex == entry.key ? null : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(gradient: AppTheme.goldGradient, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppTheme.lightText)),
        ],
      ),
    );
  }

  Widget _buildQuickServices() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _quickServices.length,
        itemBuilder: (context, index) {
          final service = _quickServices[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [(service['color'] as Color).withOpacity(0.2), (service['color'] as Color).withOpacity(0.1)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(service['icon'] as IconData, color: service['color'] as Color, size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(service['name'] as String, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(ProductProvider productProvider) {
    if (productProvider.isLoading && productProvider.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (productProvider.products.isEmpty) {
      return const Center(child: Text('لا توجد منتجات'));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) {
          final product = productProvider.products[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
            },
            isFavorite: productProvider.isFavorite(product['id']),
            onFavoriteTap: () => productProvider.toggleFavorite(product['id']),
          );
        },
      ),
    );
  }
}
