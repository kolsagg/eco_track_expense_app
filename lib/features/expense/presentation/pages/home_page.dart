import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/color_constants.dart';
import '../widgets/expense_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String _selectedPeriod = 'Günlük';
  late AnimationController _animationController;
  late Animation<double> _animation;
  // Tutar animasyonu için değişkenler
  double _startAmount = 2450.00; // İlk başlangıç değeri
  double _endAmount = 2450.00;   // İlk hedef değeri
  double _animatedAmount = 2450.00; // Mevcut animasyon değeri
  
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }
  
  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Süreyi 1500'den 800'e düşürelim
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart, // Hızlı başlayıp sonra yavaşlayan eğri - daha iyi hissiyat sağlar
    );
    
    // Performans için animasyon dinleyicisini optimize edelim
    _animationController.addListener(() {
      final currentAmount = _startAmount + (_endAmount - _startAmount) * _animation.value;
      
      // Sadece değer değiştiğinde setState çağıralım ve küçük değişiklikleri görmezden gelelim
      if ((_animatedAmount - currentAmount).abs() > 1.0) {
        setState(() {
          _animatedAmount = currentAmount;
        });
      }
    });
    
    // Başlangıçta animasyonu başlat
    _animationController.forward();
  }
  
  // Periyoda göre sayısal tutar değerini döndüren yardımcı metod
  double _getNumericAmount(String period) {
    switch (period) {
      case 'Günlük':
        return 2450.00;
      case 'Haftalık':
        return 12150.00;
      case 'Aylık':
        return 45320.00;
      case 'Yıllık':
        return 527840.00;
      default:
        return 0.00;
    }
  }
  
  // Animasyonlu tutarı formatlı şekilde döndüren metod
  String _getAnimatedAmount() {
    if (_animatedAmount <= 0) return '₺0.00';
    
    // Tutarı formatlı şekilde döndür (yuvarlayarak)
    final roundedAmount = (_animatedAmount / 10).round() * 10; // En yakın 10'a yuvarla
    final formattedAmount = roundedAmount.toStringAsFixed(2);
    final parts = formattedAmount.split('.');
    
    // Binlik ayırıcı ekle
    final intPart = parts[0];
    final formattedIntPart = intPart.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    
    return '₺$formattedIntPart.${parts[1]}';
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _changePeriod(String period) {
    if (_selectedPeriod != period) {
      // Haptik geri bildirim
      HapticFeedback.lightImpact();
      
      // Yeni periyota geçmeden önce mevcut değerleri kaydet
      _startAmount = _animatedAmount; 
      _endAmount = _getNumericAmount(period);
      
      setState(() {
        _selectedPeriod = period;
      });
      
      // Animasyonu baştan başlat
      _animationController.reset();
      _animationController.forward();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Eski null kontrolü artık gerekli değil
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Kullanıcı selamlama başlığı
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    // Profil resmi
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // TODO: Profil sayfasına git
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Ink(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            image: const DecorationImage(
                              image: NetworkImage('https://picsum.photos/200'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Selamlama metni
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Merhaba,',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Emre Kolunsağ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bildirim ikonu
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // TODO: Bildirimler sayfasına git
                        },
                        borderRadius: BorderRadius.circular(22.5),
                        child: Ink(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Ana içerik - Grafik ve periyot seçici
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Periyot seçici - Yeni yaklaşım
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildPeriodTabNew('Günlük', _selectedPeriod == 'Günlük'),
                            ),
                            Expanded(
                              child: _buildPeriodTabNew('Haftalık', _selectedPeriod == 'Haftalık'),
                            ),
                            Expanded(
                              child: _buildPeriodTabNew('Aylık', _selectedPeriod == 'Aylık'),
                            ),
                            Expanded(
                              child: _buildPeriodTabNew('Yıllık', _selectedPeriod == 'Yıllık'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Dairesel grafik - Animasyonlu
                      SizedBox(
                        height: 260,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Grafik çemberi - animasyonlu
                            Center(
                              child: SizedBox(
                                width: 220,
                                height: 220,
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter: CircularChartPainter(
                                        selectedPeriod: _selectedPeriod,
                                        animationValue: _animation.value,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Grafik içindeki metin - sadece tutar animasyonlu
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    constraints: const BoxConstraints(maxWidth: 180),
                                    child: AnimatedBuilder(
                                      animation: _animation,
                                      builder: (context, child) {
                                        return Text(
                                          _getAnimatedAmount(),
                                          style: TextStyle(
                                            fontSize: _selectedPeriod == 'Yıllık' ? 21 : 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            height: 1.1,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Toplam Harcama',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Önceki döneme göre karşılaştırma ve kategoriler - aynı animasyon içinde
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _animation.value,
                            child: Column(
                              children: [
                                // Önceki döneme göre karşılaştırma
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        size: 14,
                                        color: Colors.green.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getComparisonText(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Grafik açıklamaları
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: _buildLegendItem('Yemek', const Color(0xFF66BB6A), _getCategoryPercentage('Yemek')),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: _buildLegendItem('Market', const Color(0xFF26A69A), _getCategoryPercentage('Market')),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: _buildLegendItem('Eğlence', const Color(0xFF5E35B1), _getCategoryPercentage('Eğlence')),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Son Harcamalar başlığı
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Son Harcamalar',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // TODO: Tüm harcamaları görüntüle
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text(
                            'Hepsini Gör',
                            style: TextStyle(
                              color: ColorConstants.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Harcamalar listesi
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildExpenseItem(),
                childCount: 2,
              ),
            ),
            
            // Alt boşluk - Azaltıldı
            const SliverToBoxAdapter(
              child: SizedBox(height: 75), // Daha fazla boşluk bırakalım
            ),
          ],
        ),
      ),
      // Alt gezinme çubuğu - Daha belirgin ve eklem konseptine uygun
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ana NavigationBar (ortada "eklem" için kesik)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50.withOpacity(0.95), // Daha koyu ve hafif opak
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300, width: 1), // Sınır ekleyerek daha belirgin
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 58, // Biraz daha yüksek
              child: Row(
                children: [
                  // Sol taraftaki butonlar (Sol kol)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50.withOpacity(0.95), // Daha koyu ve hafif opak
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabItem(Icons.home_outlined, Icons.home, 'Ana Sayfa', true),
                          _buildTabItem(Icons.analytics_outlined, Icons.analytics, 'Analiz', false),
                        ],
                      ),
                    ),
                  ),
                  
                  // Orta boşluk - FAB için (Eklem noktası)
                  const SizedBox(width: 72),
                  
                  // Sağ taraftaki butonlar (Sağ kol)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50.withOpacity(0.95), // Daha koyu ve hafif opak
                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(25)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabItem(Icons.receipt_outlined, Icons.receipt, 'Makbuzlar', false),
                          _buildTabItem(Icons.person_outline, Icons.person, 'Profil', false),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Gerçek Eklem Efekti - Hafif kenarlar ekleyerek eklem görünümü sağlıyoruz
            Positioned(
              top: 0,
              child: Container(
                width: 75,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50.withOpacity(0.95), // Daha koyu ve hafif opak
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(76),
                    bottomRight: Radius.circular(76),
                  ),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Yeşil Yuvarlak Ekle Butonu - Eklem konseptine uygun
      floatingActionButton: Container(
        height: 67,
        width: 67,
        margin: const EdgeInsets.only(bottom: 0), // Eklem noktasına göre ayarlıyoruz
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3), // Beyaz sınır (eklem kemiği)
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: const Color(0xFF4CAF50),
          shape: const CircleBorder(),
          elevation: 0,
          child: InkWell(
            onTap: () {
              // Haptik geri bildirim
              HapticFeedback.mediumImpact();
              // TODO: Yeni harcama ekle
            },
            borderRadius: BorderRadius.circular(31),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String _getPeriodAmount() {
    // Farklı periyotlar için farklı tutarlar
    switch (_selectedPeriod) {
      case 'Günlük':
        return '₺2,450.00';
      case 'Haftalık':
        return '₺12,150.00';
      case 'Aylık':
        return '₺45,320.00';
      case 'Yıllık':
        return '₺527,840.00';
      default:
        return '₺0.00';
    }
  }

  String _getComparisonText() {
    // Farklı periyotlar için karşılaştırma metinleri
    switch (_selectedPeriod) {
      case 'Günlük':
        return 'Önceki güne göre %12 daha az';
      case 'Haftalık':
        return 'Önceki haftaya göre %8 daha az';
      case 'Aylık':
        return 'Önceki aya göre %15 daha az';
      case 'Yıllık':
        return 'Önceki yıla göre %5 daha az';
      default:
        return '';
    }
  }
  
  String _getCategoryPercentage(String category) {
    // Farklı periyotlar için farklı kategori yüzdeleri
    if (_selectedPeriod == 'Günlük') {
      if (category == 'Yemek') return '40%';
      if (category == 'Market') return '25%';
      if (category == 'Eğlence') return '35%';
    } else if (_selectedPeriod == 'Haftalık') {
      if (category == 'Yemek') return '35%';
      if (category == 'Market') return '45%';
      if (category == 'Eğlence') return '20%';
    } else if (_selectedPeriod == 'Aylık') {
      if (category == 'Yemek') return '30%';
      if (category == 'Market') return '40%';
      if (category == 'Eğlence') return '30%';
    } else if (_selectedPeriod == 'Yıllık') {
      if (category == 'Yemek') return '25%';
      if (category == 'Market') return '50%';
      if (category == 'Eğlence') return '25%';
    }
    return '0%';
  }

  // Yeni periyot tab tasarımı
  Widget _buildPeriodTabNew(String text, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _changePeriod(text),
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF4CAF50).withOpacity(0.4),
        highlightColor: const Color(0xFF4CAF50).withOpacity(0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500), // Daha uzun süren geçiş
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4CAF50) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected ? [
              BoxShadow(
                color: const Color(0xFF4CAF50).withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 1),
              ),
            ] : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ($percentage)',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Haptik geri bildirim
          HapticFeedback.selectionClick();
          // TODO: Harcama detayına git
        },
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.grey.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              // Kategori ikonu
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF66BB6A).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant,
                  color: const Color(0xFF66BB6A),
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              
              // Alışveriş bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Öğle Yemeği',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Yemek',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tutar ve zaman
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '₺150.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '14:30',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              
              // Detay butonu
              IconButton(
                icon: const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Haptik geri bildirim
                  HapticFeedback.selectionClick();
                  // Harcama detayına git
                  // TODO: Navigate to expense detail
                },
                splashColor: Colors.grey.withOpacity(0.1),
                highlightColor: Colors.grey.withOpacity(0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(IconData icon, IconData selectedIcon, String label, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Haptik geri bildirim
          HapticFeedback.selectionClick();
          // TODO: Sekmeye geçiş yap
        },
        borderRadius: BorderRadius.circular(15),
        splashColor: const Color(0xFF4CAF50).withOpacity(0.2),
        highlightColor: const Color(0xFF4CAF50).withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade600, // Ana sayfa için daha koyu yeşil
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade600, // Ana sayfa için daha koyu yeşil
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  final String selectedPeriod;
  final double animationValue;

  CircularChartPainter({
    required this.selectedPeriod,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    final strokeWidth = size.width * 0.12;
    
    // Arka plan çemberi çiz - tam daire
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
      
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Kategori renklerine göre Paint nesneleri - Daha belirgin renkler
    final firstCategoryPaint = Paint()
      ..color = const Color(0xFF66BB6A) // Yeşil - Yemek
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
      
    final secondCategoryPaint = Paint()
      ..color = const Color(0xFF26A69A) // Turkuaz - Market
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
      
    final thirdCategoryPaint = Paint()
      ..color = const Color(0xFF5E35B1) // Mor - Eğlence
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    // Daire parçalarını çizmek için açılar
    const double spaceBetweenSegments = 0.08; // radyan cinsinden boşluk
    const double fullCircle = 2 * math.pi;
    final double totalSpace = spaceBetweenSegments * 3;
    
    // Periyoda göre farklı kategori oranları
    double firstRatio, secondRatio, thirdRatio;
    
    switch (selectedPeriod) {
      case 'Günlük':
        firstRatio = 0.40; // Yemek: %40
        secondRatio = 0.25; // Market: %25
        thirdRatio = 0.35; // Eğlence: %35
        break;
      case 'Haftalık':
        firstRatio = 0.35; // Yemek: %35
        secondRatio = 0.45; // Market: %45
        thirdRatio = 0.20; // Eğlence: %20
        break;
      case 'Aylık':
        firstRatio = 0.30; // Yemek: %30
        secondRatio = 0.40; // Market: %40
        thirdRatio = 0.30; // Eğlence: %30
        break;
      case 'Yıllık':
        firstRatio = 0.25; // Yemek: %25
        secondRatio = 0.50; // Market: %50
        thirdRatio = 0.25; // Eğlence: %25
        break;
      default:
        firstRatio = 0.33;
        secondRatio = 0.33;
        thirdRatio = 0.34;
    }
    
    // Toplam oran 1 olmalı
    final totalRatio = firstRatio + secondRatio + thirdRatio;
    firstRatio /= totalRatio;
    secondRatio /= totalRatio;
    thirdRatio /= totalRatio;
    
    // Parçaların açıları
    final double firstSegmentAngle = (fullCircle - totalSpace) * firstRatio;
    final double secondSegmentAngle = (fullCircle - totalSpace) * secondRatio;
    final double thirdSegmentAngle = (fullCircle - totalSpace) * thirdRatio;
    
    // Animasyon değerine göre açıları hesapla
    final animatedFirstAngle = firstSegmentAngle * animationValue;
    final animatedSecondAngle = secondSegmentAngle * animationValue;
    final animatedThirdAngle = thirdSegmentAngle * animationValue;
    
    // Birinci kategori (Yemek)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57, // Başlangıç açısı (saat 12 yönünde)
      animatedFirstAngle,
      false,
      firstCategoryPaint,
    );
    
    // İkinci kategori (Market)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57 + firstSegmentAngle + spaceBetweenSegments,
      animatedSecondAngle,
      false,
      secondCategoryPaint,
    );
    
    // Üçüncü kategori (Eğlence)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57 + firstSegmentAngle + secondSegmentAngle + (2 * spaceBetweenSegments),
      animatedThirdAngle,
      false,
      thirdCategoryPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 