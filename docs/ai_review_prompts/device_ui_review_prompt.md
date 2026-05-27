# Device UI Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1’de ekranların Android mobil cihazlarda kullanılabilir olup olmadığını dış AI’a inceletmek için kullanılır.

Bu review’un amacı yeni UI özelliği önermek değil; mevcut ekran ve akışların farklı cihaz, ekran boyutu, klavye, scroll, overflow, navigation ve clipboard davranışları açısından risk taşıyıp taşımadığını kontrol etmektir.

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M1 — Login/Register/AuthGate sonrası
- M4 — Kütüphane + Hızlı Ekle sonrası
- M5 — Prompt Detay + Normal Kopyala sonrası
- M6 — Düzenleme + Status + Arşiv sonrası
- M7 — Detaylı Ekle sonrası
- M8 — Arama / Filtreleme sonrası
- M9 — Değişkenli Kopyala-Doldur sonrası
- M10 — Final V1 cihaz/UI kapanışında
- Küçük ekran veya klavye overflow sorunu görüldüğünde
- Gerçek cihaz testlerinde sorun çıktığında

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 ana cihaz odağı:
Android mobil.

V1’de web/desktop/tablet ana kabul şartı değildir; opsiyonel smoke test olarak ele alınabilir.
```

## 4. V1 Ekranları

Review yapacak AI’ya V1 ekran listesini ver:

```md
V1 minimum ekranları:
- AuthGate / Splash
- Login
- Register
- Prompt Kütüphanesi
- Hızlı Ekle
- Detaylı Ekle
- Prompt Detay
- Prompt Düzenle
- Değişkenli Kopyala-Doldur
- Basit Ayarlar / Hesap
```

## 5. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Screen/widget kodları
- Ekran görüntüleri, varsa
- Cihaz test notları
- Overflow hata logları
- Form layout kodları
- Navigation/routing kodları
- Clipboard/kopyalama kodları
- Device/platform test checklist sonuçları
- Özellikle sorunlu görünen ekranlar
```

## 6. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 6.1 Genel Mobil Kullanılabilirlik

- Ekranlar küçük Android telefonda kullanılabilir mi?
- Ana aksiyon butonları erişilebilir mi?
- Uzun metinler ekranı bozuyor mu?
- Loading/error/empty state mobilde okunabilir mi?
- Ekranlar V1 için gereğinden fazla kalabalık mı?

### 6.2 Klavye Davranışı

- Klavye açılınca input alanları kapanıyor mu?
- Kaydet / giriş / devam butonları klavye altında kayboluyor mu?
- Form scroll edilebiliyor mu?
- Text input focus davranışı doğru mu?
- Login/Register/Hızlı Ekle/Detaylı Ekle/Değişkenli form klavye ile kullanılabilir mi?

### 6.3 Overflow Riski

- Küçük ekranda RenderFlex overflow riski var mı?
- Uzun başlıklar liste kartını bozuyor mu?
- Uzun prompt metinleri detay ekranında taşıyor mu?
- Çok sayıda etiket UI’ı bozuyor mu?
- Çok sayıda değişken input’u ekranı bozuyor mu?
- Hata mesajları küçük ekranda taşıyor mu?

### 6.4 Scroll Davranışı

- Uzun prompt metni scroll edilebilir mi?
- Detaylı Ekle formu scroll edilebilir mi?
- Prompt Düzenle ekranı uzun metinle kullanılabilir mi?
- Değişkenli Kopyala-Doldur ekranı çok input ile scroll edilebilir mi?
- Kütüphane listesi çok item ile scroll edilebilir mi?

### 6.5 Navigation / Geri Tuşu

- Android geri tuşu doğru davranıyor mu?
- Login/Register arası geçiş net mi?
- Logout sonrası geri tuşu korumalı ekrana döndürüyor mu?
- Kütüphane → Hızlı Ekle → geri akışı doğru mu?
- Detay → Düzenle → geri/kaydet davranışı doğru mu?
- Değişkenli Kopyala-Doldur ekranından geri dönüş doğru mu?

### 6.6 Clipboard / Kopyalama

- Normal Kopyala kullanıcı aksiyonuyla çalışıyor mu?
- Değişkenli final prompt kopyalanabiliyor mu?
- Kopyalama sonrası kullanıcıya bildirim var mı?
- Kopyalama `updatedAt` değiştirmiyor mu?
- Clipboard davranışı gerçek Android cihazda test edilmeli mi?

### 6.7 Ekran Bazlı Riskler

AI’dan şu ekranları ayrı ayrı değerlendirmesini iste:

- Login
- Register
- Kütüphane
- Hızlı Ekle
- Prompt Detay
- Prompt Düzenle
- Detaylı Ekle
- Arama / Filtreleme
- Değişkenli Kopyala-Doldur
- Ayarlar / Hesap

### 6.8 V1 Scope Leak

UI tarafında şu V1 dışı ekranlar veya kontroller sızmış mı?

- AI öneri butonu
- AI kredi/kota ekranı
- Payment/subscription ekranı
- Team/workspace ekranı
- Marketplace/public sharing
- Analytics dashboard
- Version history ekranı
- Kalıcı delete/trash ekranı
- Browser extension/import/export ekranı

## 7. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Device UI Review Sonucu

## 1. Genel Değerlendirme
Mobil kullanılabilirlik durumu.

## 2. Kritik Cihaz/UI Sorunları
Her sorun için:
- Sorun:
- Hangi ekranda:
- Hangi cihaz/ekran koşulunda:
- Neden kritik:
- Önerilen düzeltme:

## 3. Orta Öncelikli Sorunlar
- ...

## 4. Düşük Öncelikli İyileştirmeler
- ...

## 5. Klavye Davranışı Kontrolü
- ...

## 6. Overflow / Scroll Kontrolü
- ...

## 7. Navigation / Geri Tuşu Kontrolü
- ...

## 8. Clipboard / Kopyalama Kontrolü
- ...

## 9. Ekran Bazlı Değerlendirme
- Login:
- Register:
- Kütüphane:
- Hızlı Ekle:
- Prompt Detay:
- Prompt Düzenle:
- Detaylı Ekle:
- Arama / Filtreleme:
- Değişkenli Kopyala-Doldur:
- Ayarlar / Hesap:

## 10. Test Edilmesi Gereken Cihaz Senaryoları
- ...

## 11. V1 Scope Leak Kontrolü
- ...

## 12. Önerilen Aksiyonlar
Kritik / Orta / Düşük olarak sırala.

## 13. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 8. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- V1’i büyük responsive design projesine çevirmeyin.
- V1 için web/desktop/tablet desteğini ana kabul şartı yapmayın.
- V1’e AI öneri UI’ı önermeyin.
- V1’e payment/subscription UI’ı önermeyin.
- V1’e team/workspace UI’ı önermeyin.
- V1’e marketplace/public sharing UI’ı önermeyin.
- V1’e analytics dashboard önermeyin.
- V1’e version history veya trash UI’ı önermeyin.
- Çözüm önerileri küçük, uygulanabilir ve Android mobil öncelikli olsun.
- Gereksiz görsel süsleme yerine kullanılabilirlik ve hata azaltma önceliklendirilsin.
```

## 9. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter mobile UI / device testing reviewer gibi davran.

Aşağıdaki Prompt Yönetim Aracı V1 ekranlarını veya kodlarını Android mobil kullanılabilirlik açısından incele. Amacın yeni özellik önermek değil; küçük ekran, klavye, overflow, scroll, navigation, geri tuşu, clipboard/kopyalama ve cihaz test risklerini yakalamak.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. V1 AI’sız manuel çekirdektir.

ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 ANA CİHAZ ODAĞI:
Android mobil.

V1 EKRANLARI:
- AuthGate / Splash
- Login
- Register
- Prompt Kütüphanesi
- Hızlı Ekle
- Detaylı Ekle
- Prompt Detay
- Prompt Düzenle
- Değişkenli Kopyala-Doldur
- Basit Ayarlar / Hesap

İNCELEME GÖREVİ:
Sana verdiğim ekran kodlarını, ekran görüntülerini veya cihaz test notlarını şu açılardan incele:
1. Küçük Android ekranda kullanılabilir mi?
2. Klavye açılınca form bozulur mu?
3. Ana aksiyon butonları erişilebilir mi?
4. Uzun prompt metinleri scroll edilebilir mi?
5. Liste uzun başlık/prompt ile bozulur mu?
6. Değişkenli form çok input ile bozulur mu?
7. Android geri tuşu doğru çalışır mı?
8. Logout sonrası geri tuşu güvenlik riski yaratır mı?
9. Normal Kopyala ve final prompt kopyalama gerçek cihazda test edilmeli mi?
10. Loading/error/empty state mobilde okunabilir mi?
11. V1 dışı UI veya ekran sızmış mı?
12. Hangi cihaz senaryoları mutlaka test edilmeli?

ÇIKTI FORMATIN:
# Device UI Review Sonucu

## 1. Genel Değerlendirme
## 2. Kritik Cihaz/UI Sorunları
## 3. Orta Öncelikli Sorunlar
## 4. Düşük Öncelikli İyileştirmeler
## 5. Klavye Davranışı Kontrolü
## 6. Overflow / Scroll Kontrolü
## 7. Navigation / Geri Tuşu Kontrolü
## 8. Clipboard / Kopyalama Kontrolü
## 9. Ekran Bazlı Değerlendirme
## 10. Test Edilmesi Gereken Cihaz Senaryoları
## 11. V1 Scope Leak Kontrolü
## 12. Önerilen Aksiyonlar
## 13. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- V1’i büyük responsive design projesine çevirmeyin.
- V1 için web/desktop/tablet desteğini ana kabul şartı yapmayın.
- V1’e AI öneri UI’ı önermeyin.
- V1’e payment/subscription UI’ı önermeyin.
- V1’e team/workspace UI’ı önermeyin.
- V1’e marketplace/public sharing UI’ı önermeyin.
- V1’e analytics dashboard önermeyin.
- V1’e version history veya trash UI’ı önermeyin.
- Çözüm önerileri küçük, uygulanabilir ve Android mobil öncelikli olsun.
- Gereksiz görsel süsleme yerine kullanılabilirlik ve hata azaltma önceliklendirilsin.

İNCELEYECEĞİN İÇERİK:
[Buraya ekran kodları, ekran görüntüleri, cihaz test notları veya ilgili dosyalar eklenecek.]
```

## 10. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kritik cihaz/UI sorunları ilgili milestone içinde ele alınır.
- V1 dışı UI önerileri reddedilir veya parking lot’a taşınır.
- Cihaz test maddeleri `g06_device_platform_test_checklist.md` içine işlenir.
- Tekrarlayan UI dersi varsa Ortak Flutter Çözümleri Kütüphanesi’ne aday olabilir.
- Notlar `09_development_notes.md` içine yazılır.
- Bloklayıcı overflow/klavye sorunları çözülmeden milestone kapatılmaz.

## 11. Kapanış Notu

Bu prompt, UI’a süs aynası tutmak için değil, cep telefonunda gerçekten yürüyüp yürümediğini görmek için vardır. Ekran güzel olabilir; ama klavye açılınca buton kayboluyorsa kullanıcı için o ekran bir labirenttir.
