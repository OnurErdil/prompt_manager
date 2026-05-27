# Flutter Code Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 geliştirme sürecinde Flutter kod kalitesini dış AI’a inceletmek için kullanılır.

Bu review’un amacı kodu baştan yazdırmak değildir. Amaç; mevcut kodun V1 mimari kararlarına, Flutter iyi pratiklerine, okunabilirliğe, test edilebilirliğe ve kullanıcı deneyimi gereksinimlerine uygun olup olmadığını kontrol ettirmektir.

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M1 — Auth / Routing sonrası
- M4 — İlk Çekirdek Akış sonrası
- M5 — Prompt Detay ve Normal Kopyala sonrası
- M6 — Prompt Düzenleme / Status / Arşiv sonrası
- M7 — Detaylı Ekle sonrası
- M8 — Arama / Filtreleme sonrası
- M9 — Değişkenli Kopyala-Doldur sonrası
- Büyük UI veya state refactor öncesi/sonrası
- Flutter analyzer uyarıları veya UI overflow sorunları olduğunda

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 teknik kararları:
- Flutter kullanılacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain model olacak.
- V1’de AI, payment, marketplace, team/workspace, analytics, semantic search ve kalıcı delete yok.
```

## 4. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Flutter screen/widget dosyaları
- Provider/Notifier dosyaları
- Routing dosyaları
- Form validation dosyaları
- Repository çağrı noktaları
- Error/loading/empty state kodları
- Kopyalama/clipboard kodları
- İlgili testler veya test eksikleri
- Flutter analyzer çıktısı, varsa
- UI overflow veya cihaz test notları, varsa
```

## 5. Kontrol Kriterleri

AI’dan şu kriterlere göre review yapmasını iste:

### 5.1 Flutter Kod Kalitesi

- Widget’lar okunabilir mi?
- Build method içinde fazla iş mantığı var mı?
- Widget parçalama dengeli mi?
- Gereksiz aşırı parçalama var mı?
- Aynı UI veya validation kodu tekrar ediyor mu?
- Naming anlaşılır mı?
- Dosya yapısı feature-first mimariyle uyumlu mu?

### 5.2 State Management

- Provider/Notifier sorumluluğu doğru mu?
- Loading / success / error state net mi?
- UI state ve domain/data logic karışmış mı?
- Provider/Notifier fazla büyümüş mü?
- Async işlemler güvenli yönetiliyor mu?
- Hata durumları state’e doğru yansıyor mu?

### 5.3 Routing / Navigation

- AuthGate merkezi yönlendirme olarak korunuyor mu?
- Login/Register ekranları kalıcı rota kararını tek başına mı veriyor?
- Geri tuşu davranışı riskli mi?
- Kayıt sonrası navigation tutarlı mı?
- Nested veya karmaşık navigation V1 için gereksiz mi?

### 5.4 Form ve Validation

- Boş alan validation doğru mu?
- `promptText` boş kaydedilebiliyor mu?
- Hata mesajları okunabilir mi?
- Klavye açılınca form bozulabilir mi?
- Text input davranışı uzun metin için uygun mu?
- Detaylı Ekle formu V1 için fazla karmaşık mı?

### 5.5 Error / Loading / Empty State

- Loading state var mı?
- Error state var mı?
- Empty state var mı?
- Kullanıcıya ham teknik Firebase hatası gösteriliyor mu?
- Kayıt/listeme/update hata durumları çökme yaratır mı?
- Retry veya kullanıcı aksiyonu net mi?

### 5.6 Mimari Uyum

- UI doğrudan Firebase’e erişiyor mu?
- Screen içinde `FirebaseAuth.instance` veya `FirebaseFirestore.instance` var mı?
- UI repository/service yerine direkt data katmanına mı ulaşıyor?
- DTO presentation’a sızmış mı?
- Domain model Firebase’den bağımsız mı?
- `core/` gereksiz büyümüş mü?

### 5.7 Cihaz / UI Riskleri

- Küçük ekranda overflow riski var mı?
- Klavye açılınca butonlar kaybolabilir mi?
- Uzun prompt metni scroll edilebilir mi?
- Değişkenli form çok sayıda input ile bozulabilir mi?
- Prompt listesi uzun metinlerle bozulabilir mi?
- Kopyalama gerçek cihazda doğru çalışır mı?

### 5.8 V1 Scope Leak

Şu alanlar koda sızmış mı?

- AI özelliği
- AI API client
- Payment/subscription
- Team/workspace
- Marketplace/public sharing
- Usage analytics
- Version history
- Semantic search/embedding
- Permanent delete/trash
- Browser extension/import/export

## 6. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Flutter Code Review Sonucu

## 1. Genel Değerlendirme
Kod genel olarak V1 kararlarına uygun mu?

## 2. Güçlü Noktalar
- ...

## 3. Kritik Sorunlar
Her sorun için:
- Sorun:
- Dosya/alan:
- Neden önemli:
- Önerilen düzeltme:

## 4. Orta Öncelikli Sorunlar
- ...

## 5. Düşük Öncelikli İyileştirmeler
- ...

## 6. Flutter UI / Widget Kalitesi
- ...

## 7. State Management Kontrolü
- ...

## 8. Routing / Navigation Kontrolü
- ...

## 9. Form / Validation Kontrolü
- ...

## 10. Error / Loading / Empty State Kontrolü
- ...

## 11. Mimari Uyum Kontrolü
- ...

## 12. Cihaz / UI Riskleri
- ...

## 13. V1 Scope Leak Kontrolü
- ...

## 14. Önerilen Aksiyonlar
Kritik / Orta / Düşük olarak sırala.

## 15. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 7. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- Kodu baştan yazmayı önermeyin; önce küçük ve hedefli düzeltmeler önerin.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription önermeyin.
- V1’e team/workspace önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete/trash önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını UI’da kullanmayı önermeyin.
- Gereksiz büyük mimari refactor önermeden önce V1’e uygun küçük çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.
```

## 8. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter code reviewer gibi davran.

Aşağıdaki Prompt Yönetim Aracı V1 kodlarını incele. Amacın kodu baştan yazmak veya yeni özellik önermek değil; mevcut kodun Flutter kalitesi, state yönetimi, form davranışı, routing, error/loading/empty state, cihaz/UI riski, mimari uyum ve V1 scope açısından doğru olup olmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. V1 AI’sız manuel çekirdektir.

V1 ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

KİLİTLİ TEKNİK KARARLAR:
- Flutter kullanılacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain model olacak.
- V1’de AI, payment, marketplace, team/workspace, analytics, semantic search ve kalıcı delete yok.

İNCELEME GÖREVİ:
Sana verdiğim kodları şu açılardan incele:
1. Flutter widget yapısı okunabilir mi?
2. Build method içinde fazla iş mantığı var mı?
3. Provider/Notifier sorumluluğu doğru mu?
4. Loading/error/success state yeterli mi?
5. AuthGate ve routing doğru mu?
6. Form validation doğru mu?
7. Klavye/overflow/scroll riskleri var mı?
8. UI doğrudan Firebase’e erişiyor mu?
9. Repository/Service sınırı korunuyor mu?
10. DTO presentation’a sızmış mı?
11. Domain model Firebase’den bağımsız mı?
12. V1 scope dışı bir şey sızmış mı?

ÇIKTI FORMATIN:
# Flutter Code Review Sonucu

## 1. Genel Değerlendirme
## 2. Güçlü Noktalar
## 3. Kritik Sorunlar
## 4. Orta Öncelikli Sorunlar
## 5. Düşük Öncelikli İyileştirmeler
## 6. Flutter UI / Widget Kalitesi
## 7. State Management Kontrolü
## 8. Routing / Navigation Kontrolü
## 9. Form / Validation Kontrolü
## 10. Error / Loading / Empty State Kontrolü
## 11. Mimari Uyum Kontrolü
## 12. Cihaz / UI Riskleri
## 13. V1 Scope Leak Kontrolü
## 14. Önerilen Aksiyonlar
## 15. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- Kodu baştan yazmayı önermeyin; önce küçük ve hedefli düzeltmeler önerin.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription önermeyin.
- V1’e team/workspace önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete/trash önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını UI’da kullanmayı önermeyin.
- Gereksiz büyük mimari refactor önermeden önce V1’e uygun küçük çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.

İNCELEYECEĞİN İÇERİK:
[Buraya screen/widget/provider/notifier/routing/form kodları, analyzer çıktısı veya ilgili dosyalar eklenecek.]
```

## 9. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kritik Flutter hataları önce ele alınır.
- V1 dışı öneriler reddedilir veya parking lot’a taşınır.
- Mimari ihlal varsa `g02_architecture_boundary_checklist.md` ile kontrol edilir.
- Cihaz/UI riski varsa `g06_device_platform_test_checklist.md` içine not edilir.
- Tekrarlanabilir Flutter dersi varsa Ortak Flutter Çözümleri Kütüphanesi’ne aday olabilir.
- Notlar `09_development_notes.md` içine yazılır.

## 10. Kapanış Notu

Bu prompt, dış AI’ya “kodumu devral” demek için değil, “kodumun vidası gevşemiş mi?” diye baktırmak için vardır. Tornavida bizde kalır.
