class AppConstants {
  // App Info
  static const String appName = 'EcoTrack';
  static const String appVersion = '1.0.0';
  static const String companyName = 'Taki';
  
  // Time Periods
  static const List<String> timePeriods = [
    'Günlük',
    'Haftalık',
    'Aylık',
    'Yıllık',
  ];
  
  // Storage keys
  static const String storageKeyExpenses = 'expenses';
  static const String storageKeyReceipts = 'receipts';
  static const String storageKeyCategories = 'categories';
  static const String storageKeySettings = 'settings';
  static const String storageKeyTheme = 'theme';
  
  // Default categories
  static const List<String> defaultCategories = [
    'Yiyecek & İçecek',
    'Ulaşım',
    'Alışveriş',
    'Faturalar',
    'Eğlence',
    'Sağlık',
    'Diğer',
  ];

  // Chart Types
  static const List<String> chartTypes = [
    'Pasta Grafik',
    'Çizgi Grafik',
    'Sütun Grafik',
  ];

  // Currency
  static const String defaultCurrency = '₺';
  static const String currencyFormat = '#,##0.00';
} 