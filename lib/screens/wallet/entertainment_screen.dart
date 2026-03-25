// شاشة خدمات الترفيه
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_button.dart';

class EntertainmentScreen extends StatefulWidget {
  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  String _selectedService = 'cinema';
  
  final List<Map<String, dynamic>> _services = [
    {
      'id': 'cinema',
      'name': 'سينما',
      'icon': Icons.movie,
      'color': Colors.red,
      'description': 'حجز تذاكر السينما',
    },
    {
      'id': 'theater',
      'name': 'مسرح',
      'icon': Icons.theater_comedy,
      'color': Colors.purple,
      'description': 'حجز تذاكر المسرح',
    },
    {
      'id': 'concert',
      'name': 'حفلات',
      'icon': Icons.music_note,
      'color': Colors.orange,
      'description': 'حجز تذاكر الحفلات',
    },
    {
      'id': 'sports',
      'name': 'رياضة',
      'icon': Icons.sports,
      'color': Colors.green,
      'description': 'حجز تذاكر المباريات',
    },
    {
      'id': 'amusement',
      'name': 'ملاهي',
      'icon': Icons.attractions,
      'color': Colors.pink,
      'description': 'حجز تذاكر الملاهي',
    },
    {
      'id': 'museum',
      'name': 'متاحف',
      'icon': Icons.museum,
      'color': Colors.brown,
      'description': 'حجز زيارة المتاحف',
    },
  ];

  final List<Map<String, dynamic>> _featuredEvents = [
    {
      'title': 'فيلم الأكشن الجديد',
      'location': 'سينما الروضة',
      'date': '15 مارس 2024',
      'price': 3000,
      'image': Icons.movie,
    },
    {
      'title': 'حفلة الفنان الكبير',
      'location': 'قصر الثقافة',
      'date': '20 مارس 2024',
      'price': 15000,
      'image': Icons.music_note,
    },
    {
      'title': 'مباراة القمة',
      'location': 'استاد الثورة',
      'date': '25 مارس 2024',
      'price': 5000,
      'image': Icons.sports_soccer,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: CustomAppBar(
        title: 'خدمات الترفيه',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الخدمات
            _buildServicesGrid(),
            
            SizedBox(height: 24),
            
            // الفعاليات المميزة
            Text(
              'فعاليات مميزة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppTheme.lightText,
              ),
            ),
            
            SizedBox(height: 16),
            
            _buildEventsList(),
            
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        final isSelected = _selectedService == service['id'];
        
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedService = service['id'];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.goldGradient : null,
              color: isSelected ? null : (service['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppTheme.goldPrimary : Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  service['icon'] as IconData,
                  color: isSelected ? Colors.white : service['color'] as Color,
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  service['name'],
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? Colors.white : AppTheme.lightText),
                  ),
                ),
              ],
            ),
          ),
        ).animate()
         .fadeIn(delay: (index * 100).ms)
         .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
      },
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _featuredEvents.length,
      itemBuilder: (context, index) {
        final event = _featuredEvents[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? AppTheme.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  event['image'] as IconData,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppTheme.lightText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          event['location'],
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          event['date'],
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${event['price']} ر.ي',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 80,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldPrimary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'حجز',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate()
         .fadeIn(delay: (index * 150).ms)
         .slideX(begin: 0.2, end: 0);
      },
    );
  }
}
