import 'package:flutter/material.dart';

class ColorConstants {
  // Ana Renkler
  static const Color primary = Color(0xFF4CAF50);        // Ana yeşil
  static const Color primaryLight = Color(0xFF81C784);   // Açık yeşil
  static const Color primaryDark = Color(0xFF388E3C);    // Koyu yeşil
  static const Color secondary = Color(0xFF66BB6A);      // İkincil yeşil
  static const Color accent = Color(0xFF26A69A);         // Turkuaz aksent
  
  // Nötr Renkler
  static const Color background = Color(0xFFF5F5F5);     // Açık arka plan
  static const Color surface = Color(0xFFFFFFFF);        // Yüzey rengi
  static const Color cardBackground = Color(0xFFFFFFFF);  // Kart arka planı
  
  // Metin Renkleri
  static const Color textPrimary = Color(0xFF212121);    // Ana metin
  static const Color textSecondary = Color(0xFF757575);  // İkincil metin
  static const Color textLight = Color(0xFFFFFFFF);      // Açık metin
  
  // Durum Renkleri
  static const Color success = Color(0xFF43A047);        // Başarı
  static const Color error = Color(0xFFE53935);          // Hata
  static const Color warning = Color(0xFFFFA726);        // Uyarı
  static const Color info = Color(0xFF29B6F6);           // Bilgi
  
  // Gölgelendirme
  static const Color shadow = Color(0x1F000000);         // Gölge
  
  // Kategori Renkleri
  static const Map<String, Color> categoryColors = {
    'Yiyecek & İçecek': Color(0xFF81C784),  // Açık yeşil
    'Ulaşım': Color(0xFF26A69A),            // Turkuaz
    'Alışveriş': Color(0xFF66BB6A),         // Yeşil
    'Faturalar': Color(0xFF42A5F5),         // Mavi
    'Eğlence': Color(0xFF7986CB),           // Indigo
    'Sağlık': Color(0xFF4DB6AC),            // Teal
    'Diğer': Color(0xFF90A4AE),             // Gri
  };

  // Grafik Renkleri
  static const List<Color> chartColors = [
    Color(0xFF4CAF50),  // Yeşil
    Color(0xFF26A69A),  // Turkuaz
    Color(0xFF42A5F5),  // Mavi
    Color(0xFF7986CB),  // Indigo
    Color(0xFF4DB6AC),  // Teal
    Color(0xFF81C784),  // Açık yeşil
    Color(0xFF90A4AE),  // Gri
  ];
} 