# 📊 Gider Takip Uygulaması

Bu uygulama, giderleri takip etmek için kapsamlı ve kullanıcı dostu bir çözüm sunmayı amaçlamaktadır. Kullanıcılar QR kodları, dijital makbuzlar veya manuel giriş yoluyla işlemlerini kaydedebilir. Amaç, bireylerin finansal durumlarını etkili bir şekilde yönetmelerine ve harcama alışkanlıklarına dair değerli bilgiler edinmelerine yardımcı olmaktır.

## ✨ Özellikler

### 🔹 Akıllı Gider Takibi
- **QR kod tarama** ile otomatik işlem kaydı
- **Kağıt makbuzları dijital kayıtlara** dönüştürme
- Makbuz olmadığı durumlarda **manuel gider girişi**
- Daha iyi finansal yönetim için **kategorize edilmiş gider takibi**

### 🔹 Dijital Makbuz Depolama
- Tüm işlem verilerini dijital olarak saklayarak kağıt makbuzlara olan ihtiyacı ortadan kaldırır
- Kullanıcıların tarih, kategori veya tutara göre **makbuzları aramasına ve filtrelemesine** olanak tanır

### 🔹 Sezgisel Kullanıcı Arayüzü
- Zahmetsiz bir kullanıcı deneyimi için basit ve şık UI tasarımı
- **Mobil cihazlar ve tabletler** için optimize edilmiş

## 📦 Kullanılan Teknolojiler

- Flutter (Cross-platform uygulama geliştirme)
- Riverpod (State Management)
- Go Router (Navigation)
- Freezed (Code Generation)
- GetIt (Dependency Injection)
- Camera (QR kod tarama)
- Local Storage (Makbuz depolama)

## 🏗️ Proje Yapısı

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── color_constants.dart
│   │   └── text_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       ├── extensions/
│       └── helpers/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── expense/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── controllers/
│   └── receipt/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── cards/
│   │   └── inputs/
│   └── services/
│       ├── storage_service.dart
│       └── camera_service.dart
└── main.dart
```

## 🚀 Başlangıç

1. Repoyu klonlayın
```bash
git clone https://github.com/kolsagg/cursor_test.git
```

2. Proje dizinine gidin
```bash
cd cursor_test
```

3. Bağımlılıkları yükleyin
```bash
flutter pub get
```

4. Uygulamayı çalıştırın
```bash
flutter run
```

## 🧪 Testler

Testleri çalıştırmak için:

```bash
flutter test
```

## 📝 Lisans

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.

## 👥 İletişim

Emre Kolunsag - [@kolsagg](https://github.com/kolsagg)

Proje Linki: [https://github.com/kolsagg/cursor_test](https://github.com/kolsagg/cursor_test)

