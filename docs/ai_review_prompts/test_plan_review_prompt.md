# Test Plan Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 için hazırlanan test ve güvenlik planını dış AI’a inceletmek için kullanılır.

Bu review’un amacı yeni özellik önermek değil; V1’in test planında eksik kalan kritik kullanıcı akışlarını, güvenlik senaryolarını, veri davranışı kontrollerini, cihaz/platform testlerini ve milestone bazlı test yerleşimini yakalamaktır.

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- 0.9 test/security planı oluşturulduktan sonra
- M3 — Firestore Data Layer sonrası
- M4 — İlk Çekirdek Akış sonrası
- M6 — Update / Status / Arşiv sonrası
- M9 — Değişkenli Kopyala-Doldur sonrası
- M10 — V1 final kapanış öncesi
- Test kapsamı yetersiz göründüğünde
- Dış AI’dan test boşluğu analizi almak istendiğinde

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

Temel problem:
Prompt değer kaybı. Yani iyi bir promptun zamanla bulunabilir, anlaşılabilir, geliştirilebilir ve yeniden kullanılabilir olmaktan çıkması.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 teknik kararları:
- Flutter kullanılacak.
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Feature-first + hafif clean architecture kullanılacak.
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- Firestore path: users/{userId}/prompts/{promptId}
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilecek.
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.
```

## 4. V1 Test Yaklaşımı

Review yapacak AI’ya şu yaklaşımı ver:

```md
V1 test yaklaşımı:
- Test ve güvenlik M10’a ertelenmeyecek, milestone içine dağıtılacak.
- Her şeyi test etmek değil, V1’in kırmızı çizgilerini test etmek hedeflenecek.
- Manuel testler ana kullanıcı akışını doğrulayacak.
- Unit testler değişken algılama, validation ve küçük iş mantıklarını hedefleyecek.
- Widget testleri kritik form ve ekran davranışlarını hedefleyecek.
- Repository/Mapper testleri data dönüşümünü kontrol edecek.
- Firestore rules testleri kullanıcı izolasyonunu kontrol edecek.
- Cihaz/platform testleri Android mobil odağında yapılacak.
```

## 5. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- 07_test_security_plan.md
- 06_acceptance_criteria.md
- M0-M10 milestone planı
- Checklist dosyaları
- Security checklist
- Firestore rules checklist
- Device/platform test checklist
- Mevcut test dosyaları, varsa
- Bilinen açıklar ve development notes
```

## 6. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 6.1 Genel Test Stratejisi

- Test planı V1 kapsamına uygun mu?
- Test ve güvenlik milestone’lara dağıtılmış mı?
- Test planı gereksiz ağır mı?
- Kritik V1 risklerini gerçekten yakalıyor mu?
- M10 ilk test zamanı değil, final kontrol zamanı olarak mı ele alınmış?

### 6.2 Manuel Testler

- Ana akış test ediliyor mu?
- Kayıt/giriş/çıkış test ediliyor mu?
- Hızlı Ekle test ediliyor mu?
- Kütüphane listeleme test ediliyor mu?
- Prompt Detay test ediliyor mu?
- Normal Kopyala test ediliyor mu?
- Prompt Düzenleme test ediliyor mu?
- Status ve Arşiv test ediliyor mu?
- Detaylı Ekle test ediliyor mu?
- Arama/filtreleme test ediliyor mu?
- Değişkenli Kopyala-Doldur test ediliyor mu?

### 6.3 Unit Test Adayları

- Variable extraction testleri yeterli mi?
- Status validation testleri yeterli mi?
- Prompt validation testleri yeterli mi?
- Tag normalization testleri düşünülmüş mü?
- Tarih davranışı testleri düşünülmüş mü?
- Archive/delete ayrımı test ediliyor mu?

### 6.4 Widget Test Adayları

- Login formu test ediliyor mu?
- Register formu test ediliyor mu?
- Hızlı Ekle formu test ediliyor mu?
- Kütüphane empty/list/error state test ediliyor mu?
- Değişkenli Kopyala-Doldur formu test ediliyor mu?
- Klavye/overflow riskleri en azından cihaz checklist’inde var mı?

### 6.5 Repository / Mapper Testleri

- DTO → Domain testi var mı?
- Domain → DTO testi var mı?
- Eksik alan fallback testleri var mı?
- Timestamp/date dönüşümü test ediliyor mu?
- Repository mock service ile test edilebilir mi?
- Archive’in delete değil update olduğu test ediliyor mu?

### 6.6 Firestore Rules / Security Testleri

- Auth olmayan kullanıcı testleri var mı?
- Cross-user read testleri var mı?
- Cross-user create testleri var mı?
- Cross-user update testleri var mı?
- ownerId değiştirilemiyor mu test ediliyor?
- Delete kapalı mı test ediliyor?
- promptText boş kayıt engelleniyor mu test ediliyor?
- status validation test ediliyor mu?

### 6.7 Cihaz / Platform Testleri

- Android emülatör testleri var mı?
- Gerçek Android cihaz testleri var mı?
- Küçük ekran overflow kontrolü var mı?
- Klavye davranışı kontrol ediliyor mu?
- Uzun prompt metni scroll kontrolü var mı?
- Clipboard / kopyalama gerçek cihazda test ediliyor mu?
- Geri tuşu davranışı test ediliyor mu?
- Tablet/web smoke test opsiyonel olarak doğru konumlandırılmış mı?

### 6.8 Milestone Bazlı Yerleşim

- M1 Auth testleri doğru mu?
- M2 domain model testleri doğru mu?
- M3 data layer/rules testleri doğru mu?
- M4 core flow testleri doğru mu?
- M5 detail/copy testleri doğru mu?
- M6 update/archive testleri doğru mu?
- M7 detailed add testleri doğru mu?
- M8 search/filter testleri doğru mu?
- M9 variable fill testleri doğru mu?
- M10 final güvenlik/test kapanışı doğru mu?

### 6.9 Scope Leak

Test planı V1 dışı alanları gereksiz test kapsamına almış mı?

- AI özellikleri
- Payment/subscription
- Team/workspace
- Marketplace/public sharing
- Usage analytics
- Version history
- Semantic search/embedding
- Permanent delete/trash
- Browser extension/import/export

## 7. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Test Plan Review Sonucu

## 1. Genel Değerlendirme
Test planı V1 için yeterli mi?

## 2. Güçlü Noktalar
- ...

## 3. Kritik Eksikler
Her eksik için:
- Eksik:
- Neden kritik:
- Hangi milestone’da ele alınmalı:
- Önerilen test:

## 4. Orta Öncelikli Eksikler
- ...

## 5. Düşük Öncelikli İyileştirmeler
- ...

## 6. Manuel Test Kapsamı
- ...

## 7. Unit Test Kapsamı
- ...

## 8. Widget Test Kapsamı
- ...

## 9. Repository / Mapper Test Kapsamı
- ...

## 10. Firestore Rules / Security Test Kapsamı
- ...

## 11. Cihaz / Platform Test Kapsamı
- ...

## 12. Milestone Bazlı Test Yerleşimi
- ...

## 13. V1 Scope Leak Kontrolü
- Test planı gereksiz V1 dışı alanları kapsıyor mu?

## 14. Önerilen Aksiyonlar
Kritik / Orta / Düşük olarak sırala.

## 15. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 8. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- V1 test planını enterprise seviyesinde ağırlaştırmayın.
- V1’e AI özelliği testi önermeyin.
- V1’e payment/subscription testi önermeyin.
- V1’e team/workspace testi önermeyin.
- V1’e marketplace/public sharing testi önermeyin.
- V1’e semantic search/embedding testi önermeyin.
- V1’e usage analytics/version history testi önermeyin.
- V1’e kalıcı delete/trash testi önermeyin.
- Eksik test önerilerini milestone’lara dağıtarak verin.
- M10’u ilk test zamanı değil, final doğrulama zamanı olarak ele alın.
```

## 9. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter/Firebase test plan reviewer gibi davran.

Aşağıdaki Prompt Yönetim Aracı V1 test/security planını incele. Amacın yeni özellik önermek değil; V1’in kritik kullanıcı akışları, veri davranışları, güvenlik senaryoları, repository/mapper testleri, Firestore rules testleri ve cihaz/platform testleri açısından eksik kalan noktaları yakalamak.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

V1 KAPSAMI:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 TEKNİK KARARLARI:
- Flutter kullanılacak.
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- Firestore path: users/{userId}/prompts/{promptId}
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilecek.
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.

TEST YAKLAŞIMI:
- Test ve güvenlik M10’a ertelenmeyecek, milestone içine dağıtılacak.
- Her şeyi test etmek değil, V1’in kırmızı çizgilerini test etmek hedeflenecek.
- Manuel testler ana kullanıcı akışını doğrulayacak.
- Unit testler değişken algılama, validation ve küçük iş mantıklarını hedefleyecek.
- Widget testleri kritik form ve ekran davranışlarını hedefleyecek.
- Repository/Mapper testleri data dönüşümünü kontrol edecek.
- Firestore rules testleri kullanıcı izolasyonunu kontrol edecek.
- Cihaz/platform testleri Android mobil odağında yapılacak.

İNCELEME GÖREVİ:
Sana verdiğim test planını şu açılardan incele:
1. Ana manuel test akışları yeterli mi?
2. Unit test adayları doğru mu?
3. Widget test adayları doğru mu?
4. Repository/Mapper testleri yeterli mi?
5. Firestore security rules testleri yeterli mi?
6. Kullanıcı izolasyonu testleri yeterli mi?
7. Cihaz/platform testleri yeterli mi?
8. Edge case ve hata durumları düşünülmüş mü?
9. Testler milestone’lara doğru dağıtılmış mı?
10. Test planı V1 için gereksiz ağır mı?
11. V1 dışı alanlar test kapsamına sızmış mı?
12. M10 final kapanış için hangi testler kesin yapılmalı?

ÇIKTI FORMATIN:
# Test Plan Review Sonucu

## 1. Genel Değerlendirme
## 2. Güçlü Noktalar
## 3. Kritik Eksikler
## 4. Orta Öncelikli Eksikler
## 5. Düşük Öncelikli İyileştirmeler
## 6. Manuel Test Kapsamı
## 7. Unit Test Kapsamı
## 8. Widget Test Kapsamı
## 9. Repository / Mapper Test Kapsamı
## 10. Firestore Rules / Security Test Kapsamı
## 11. Cihaz / Platform Test Kapsamı
## 12. Milestone Bazlı Test Yerleşimi
## 13. V1 Scope Leak Kontrolü
## 14. Önerilen Aksiyonlar
## 15. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- V1 test planını enterprise seviyesinde ağırlaştırmayın.
- V1’e AI özelliği testi önermeyin.
- V1’e payment/subscription testi önermeyin.
- V1’e team/workspace testi önermeyin.
- V1’e marketplace/public sharing testi önermeyin.
- V1’e semantic search/embedding testi önermeyin.
- V1’e usage analytics/version history testi önermeyin.
- V1’e kalıcı delete/trash testi önermeyin.
- Eksik test önerilerini milestone’lara dağıtarak verin.
- M10’u ilk test zamanı değil, final doğrulama zamanı olarak ele alın.

İNCELEYECEĞİN İÇERİK:
[Buraya 07_test_security_plan.md, checklist maddeleri, test dosyaları veya milestone test özeti eklenecek.]
```

## 10. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kritik eksikler `07_test_security_plan.md` veya ilgili checklist’e işlenir.
- V1 dışı test önerileri reddedilir veya parking lot’a taşınır.
- Milestone bazlı test yerleşimi gerekiyorsa güncellenir.
- Cihaz testi önerileri `g06_device_platform_test_checklist.md` içine eklenir.
- Firestore rules test önerileri `g04_firestore_rules_checklist.md` içine eklenir.
- Notlar `09_development_notes.md` içine yazılır.

## 11. Kapanış Notu

Bu prompt test planına “daha çok test” diye bağırmak için değil, doğru testlerin doğru yerde olup olmadığını anlamak için vardır. Test ağı balıkçı ağı gibidir; her şeyi değil, kaçmaması gerekenleri yakalamalıdır.
