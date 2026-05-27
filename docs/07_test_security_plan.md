# Prompt Yönetim Aracı — Test / Security Plan

## 1. Belge Bilgisi

**Belge tipi:** V1 test, güvenlik ve kalite kontrol planı  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmış kodlama öncesi hazırlık belgesi  
**Kapsam:** V1 manuel prompt yaşam döngüsü çekirdeği için test stratejisi, güvenlik kontrolleri, cihaz/platform testleri ve milestone bazlı kalite planı  
**Son güncelleme:** 2026-05-25

Bu belge, Prompt Yönetim Aracı V1 geliştirme sürecinde testlerin, güvenlik kontrollerinin, cihaz/platform kontrollerinin ve kalite kapılarının nasıl ele alınacağını tanımlar.

---

## 2. Test ve Güvenlik Planının Amacı

Bu belgenin amacı, V1 geliştirme sürecinde kaliteyi yalnızca “ekranlar açılıyor mu?” seviyesinde değil; doğru veri davranışı, kullanıcı izolasyonu, mimari sınır, cihaz kullanılabilirliği ve V1 kapsam koruması açısından da kontrol etmektir.

V1’de kalite şu anlama gelir:

- Kullanıcı ana akışı çalışır.
- Kullanıcı verisi başka kullanıcılara sızmaz.
- UI katmanı Firebase’e doğrudan erişmez.
- PromptCard modeli Firestore’a bağımlı olmaz.
- Firestore rules kullanıcı izolasyonunu korur.
- Hata ve boş durumlar kullanıcıyı çıkmaza sokmaz.
- Android cihazlarda temel kullanım akışı güvenilir çalışır.
- V1 dışı AI, ödeme, marketplace, takım sistemi ve benzeri kapsamlar ürüne sızmaz.

Ana ilke:

> Test ve güvenlik V1’in sonuna bırakılmayacak; M0-M10 milestone’larının içine dağıtılacaktır.

---

## 3. Temel Kalite İlkeleri

V1 boyunca şu kalite ilkeleri korunacaktır:

- Kullanıcı verisi kullanıcıya özeldir.
- Auth olmayan kullanıcı prompt verisi okuyamaz veya yazamaz.
- Kullanıcı yalnızca kendi promptlarını okuyabilir ve güncelleyebilir.
- `ownerId`, kullanıcı sahipliğinin temel alanıdır.
- `ownerId` create sırasında auth kullanıcısıyla eşleşmeli, update sırasında değiştirilememelidir.
- `promptText` boş kaydedilemez.
- `status`, yalnızca izin verilen teknik key değerlerinden biri olabilir.
- Arşivleme kalıcı silme değildir; `status: archived` ile yapılır.
- V1’de kalıcı delete yoktur.
- UI Firebase Auth veya Firestore’a doğrudan erişmez.
- Veri akışı `Screen → Provider/Notifier → Repository → Service → Firebase` şeklinde korunur.
- Domain modeli Firestore tiplerine bağımlı olmaz.
- Firestore DTO’su presentation katmanına sızmaz.
- V1’de AI API key, ödeme sistemi, abonelik, AI kota ekranı ve Cloud Functions yoktur.

---

## 4. Test Stratejisi

V1 için test stratejisi sade ama hedefli olacaktır.

Amaç, her şeyi otomatik testlerle kaplamak değil; V1’in kırmızı çizgilerini güvence altına almaktır.

| Test türü | V1’deki amacı |
|---|---|
| Manuel test | Ana kullanıcı akışlarını doğrulamak |
| Unit test | Küçük iş mantıklarını kontrol etmek |
| Widget test | Kritik ekran/form davranışlarını kontrol etmek |
| Repository / Mapper testleri | Domain ↔ DTO dönüşümünü doğrulamak |
| Auth akışı testleri | Login/Register/AuthGate davranışını kontrol etmek |
| Firestore security rules testleri | Kullanıcı izolasyonunu doğrulamak |
| Cihaz / platform testleri | Gerçek cihaz, emülatör, ekran, klavye ve overflow davranışlarını kontrol etmek |
| Mimari sınır kontrolü | UI/Firebase sınırını ve katman ayrımını korumak |
| Scope leak kontrolü | V1 dışı özelliklerin ürüne sızmasını engellemek |

---

## 5. Manuel Test Planı

V1’in ana manuel test akışı:

```text
Kayıt ol → Giriş yap → Hızlı Ekle → Kütüphanede gör → Detaya gir → Normal Kopyala → Düzenle → Arşivle → Filtrele → Değişkenli Kopyala-Doldur
```

### 5.1 Ana Manuel Test Maddeleri

- [ ] Yeni kullanıcı kayıt olabilir.
- [ ] Kullanıcı giriş yapabilir.
- [ ] Kullanıcı çıkış yapabilir.
- [ ] AuthGate giriş durumuna göre doğru ekranı gösterir.
- [ ] Kütüphane boşken anlaşılır boş durum gösterilir.
- [ ] Hızlı Ekle ile prompt kaydedilir.
- [ ] Detaylı Ekle ile metadata içeren prompt kaydedilir.
- [ ] Prompt kütüphanede görünür.
- [ ] Prompt detayına girilir.
- [ ] Normal Kopyala çalışır.
- [ ] Prompt düzenlenir.
- [ ] Status değiştirilir.
- [ ] Prompt arşivlenir.
- [ ] Arşivlenen prompt varsayılan görünümde doğru davranır.
- [ ] Metin arama çalışır.
- [ ] Kategori filtresi çalışır.
- [ ] Etiket filtresi çalışır.
- [ ] Status filtresi çalışır.
- [ ] Değişkenli Kopyala-Doldur final prompt üretir.
- [ ] Final prompt kopyalanabilir.

---

## 6. Unit Test Adayları

Unit testler küçük ama kritik iş mantıklarını hedefler.

### 6.1 Değişken Algılama

Test edilmesi gereken durumlar:

- [ ] `[PROJE_ADI]` algılanır.
- [ ] Birden fazla değişken algılanır.
- [ ] Aynı değişken birden fazla geçerse tekilleştirilir.
- [ ] Değişken yoksa boş liste döner.
- [ ] Boş parantez `[]` değişken sayılmaz.
- [ ] Hatalı formatlar uygulamayı bozmaz.

Örnek:

```text
"[PROJE_ADI] için [TON] ile metin yaz" → ["PROJE_ADI", "TON"]
```

### 6.2 Status Validation

- [ ] `raw` geçerlidir.
- [ ] `needs_edit` geçerlidir.
- [ ] `ready` geçerlidir.
- [ ] `archived` geçerlidir.
- [ ] Rastgele değer geçersizdir.

### 6.3 Prompt Validation

- [ ] Boş `promptText` geçersizdir.
- [ ] Sadece boşluk içeren `promptText` geçersizdir.
- [ ] Dolu `promptText` geçerlidir.
- [ ] Boş tag değerleri temizlenir.
- [ ] Tekrarlanan tag değerleri tekilleştirilebilir.

### 6.4 Tarih Davranışı

- [ ] Oluşturulan kayıtta `createdAt` ve `updatedAt` oluşur.
- [ ] Düzenleme sonrası `updatedAt` değişir.
- [ ] Normal Kopyala `updatedAt` değiştirmez.

---

## 7. Widget Test Adayları

Widget testleri V1’de her ekran için zorunlu olmayabilir. Öncelik, kritik ekran ve form davranışlarıdır.

### 7.1 Login Ekranı

- [ ] E-posta ve şifre alanları görünür.
- [ ] Boş form gönderilirse hata gösterilir.
- [ ] Loading state gösterilir.
- [ ] Auth hatası okunabilir mesajla gösterilir.

### 7.2 Hızlı Ekle Ekranı

- [ ] Prompt metni alanı görünür.
- [ ] Boş prompt kaydedilemez.
- [ ] Geçerli prompt gönderilebilir.
- [ ] Kayıt sırasında loading state gösterilir.

### 7.3 Kütüphane Ekranı

- [ ] Boş durum gösterilir.
- [ ] Prompt listesi gösterilir.
- [ ] Prompt kartına tıklanınca detay akışı tetiklenir.

### 7.4 Değişkenli Kopyala-Doldur Ekranı

- [ ] Algılanan değişkenler input alanı olarak görünür.
- [ ] Değişken yoksa uygun mesaj görünür.
- [ ] Doldurulan değerlerle final prompt oluşturulur.

---

## 8. Repository / Mapper Testleri

### 8.1 Mapper Testleri

- [ ] DTO → PromptCard dönüşümü doğru çalışır.
- [ ] PromptCard → DTO dönüşümü doğru çalışır.
- [ ] Eksik opsiyonel alanlar güvenli varsayılanlarla karşılanır.
- [ ] `schemaVersion` yoksa güvenli fallback uygulanır.
- [ ] Timestamp dönüşümleri doğru yapılır.
- [ ] `tags` ve `variables` liste olarak korunur.

### 8.2 Repository Testleri

Mock service ile kontrol edilecekler:

- [ ] Create çağrısı doğru DTO üretir.
- [ ] Read çağrısı domain model döner.
- [ ] Update çağrısı doğru alanları gönderir.
- [ ] Archive çağrısı delete değil, `status: archived` update’i yapar.
- [ ] Repository Firebase detayını presentation’a sızdırmaz.

---

## 9. Auth Akışı Testleri

Auth, V1’in veri güvenliği kapısıdır.

Kontrol edilecekler:

- [ ] Kullanıcı kayıt olabilir.
- [ ] Kullanıcı giriş yapabilir.
- [ ] Kullanıcı çıkış yapabilir.
- [ ] Auth state değişince AuthGate doğru ekranı gösterir.
- [ ] Giriş yapmamış kullanıcı kütüphaneye erişemez.
- [ ] Login/Register ekranları kalıcı navigation kararlarını tek başına yönetmez.
- [ ] Auth hataları kullanıcıya anlaşılır şekilde verilir.

Ana kural:

> AuthGate merkezi karar noktasıdır. Login/Register ekranları kalıcı rota kararlarını tek başına yönetmemelidir.

---

## 10. Firestore Security Rules Test Planı

### 10.1 Security Rules Ana Hedefleri

- Auth olmayan kullanıcı okuyamaz.
- Auth olmayan kullanıcı yazamaz.
- Kullanıcı yalnızca kendi `users/{uid}/prompts` alanına erişir.
- Başka kullanıcı path’ine erişim engellenir.
- Create sırasında `ownerId == request.auth.uid` olmalıdır.
- Update sırasında `ownerId` değiştirilemez.
- `promptText` boş olamaz.
- `status` yalnızca izin verilen key’lerden biri olabilir.
- Delete V1’de kapalıdır.

### 10.2 Auth Olmayan Kullanıcı Senaryoları

- [ ] Prompt listesi okuyamaz.
- [ ] Prompt oluşturamaz.
- [ ] Prompt güncelleyemez.
- [ ] Prompt silemez.

### 10.3 Kullanıcı A / Kullanıcı B İzolasyon Senaryoları

- [ ] Kullanıcı A kendi promptunu oluşturabilir.
- [ ] Kullanıcı A kendi promptunu okuyabilir.
- [ ] Kullanıcı A kendi promptunu güncelleyebilir.
- [ ] Kullanıcı A kendi promptunu arşivleyebilir.
- [ ] Kullanıcı A, Kullanıcı B’nin promptunu okuyamaz.
- [ ] Kullanıcı A, Kullanıcı B’nin promptunu güncelleyemez.
- [ ] Kullanıcı A, Kullanıcı B’nin path’ine kayıt atamaz.

### 10.4 Malicious / Hatalı Veri Senaryoları

- [ ] Create sırasında farklı `ownerId` gönderilirse reddedilir.
- [ ] Update sırasında `ownerId` değiştirilmeye çalışılırsa reddedilir.
- [ ] Boş `promptText` gönderilirse reddedilir.
- [ ] Geçersiz `status` gönderilirse reddedilir.
- [ ] Delete isteği reddedilir.

Kırmızı alarm niteliğindeki gevşek kural:

```text
allow read, write: if request.auth != null;
```

Bu kural tek başına yeterli değildir. Kullanıcı giriş yaptı diye tüm kullanıcı verilerine erişememelidir.

---

## 11. Kullanıcı İzolasyonu Kontrolleri

V1’in en kritik güvenlik kabulü:

> Kullanıcı A, Kullanıcı B’nin promptlarını görememeli ve değiştirememeli.

Bu yalnızca UI düzeyinde gizleme ile sağlanmaz. Firestore rules ile zorunlu kılınmalıdır.

Kontrol düzeyleri:

1. **UI düzeyi**  
   Kullanıcı yalnızca kendi promptlarını listeleyen query kullanır.

2. **Repository düzeyi**  
   Repository auth uid ile doğru path’i kullanır.

3. **Security rules düzeyi**  
   Başka UID path’ine erişim reddedilir.

4. **Test düzeyi**  
   Cross-user read/write senaryoları denenir.

---

## 12. Cihaz / Platform Testleri

V1 test planı, yalnızca kod ve güvenlik kontrollerini değil; cihaz, ekran, klavye, overflow ve gerçek kullanım kontrollerini de kapsar.

### 12.1 Ana Cihaz Odağı

V1’in ana cihaz test odağı:

> Android mobil.

Web, desktop ve tablet testleri V1 için opsiyonel smoke test olarak değerlendirilebilir; V1 kabul kriterinin ana odağı Android mobil çekirdeğin güvenilir çalışmasıdır.

### 12.2 Android Gerçek Cihaz Testleri

- [ ] Uygulama gerçek Android cihazda açılır.
- [ ] Login / Register ekranları düzgün çalışır.
- [ ] Klavye açıldığında form taşması oluşmaz.
- [ ] Hızlı Ekle ekranında uzun prompt yazarken overflow oluşmaz.
- [ ] Kütüphane listesi küçük ekranda düzgün görünür.
- [ ] Prompt Detay uzun metinde kaydırılabilir.
- [ ] Değişkenli Kopyala-Doldur ekranı uzun değişken listesinde bozulmaz.
- [ ] Kopyalama işlemi gerçek cihazda çalışır.
- [ ] Android geri tuşu davranışı doğru çalışır.

### 12.3 Emülatör Testleri

- [ ] Android emülatörde uygulama açılır.
- [ ] Ana auth akışı çalışır.
- [ ] Prompt ekleme ve listeleme çalışır.
- [ ] Ekran boyutu değişimlerinde temel layout bozulmaz.

### 12.4 Ekran Boyutu Kontrolü

| Cihaz tipi | Test amacı |
|---|---|
| Küçük Android telefon | Overflow, form sıkışması, klavye davranışı |
| Orta boy Android telefon | Ana kullanım akışı |
| Büyük ekran telefon | Liste ve detay yerleşimi |
| Tablet / geniş ekran | Opsiyonel smoke test |

### 12.5 Opsiyonel Web / Desktop Smoke Test

- [ ] Uygulama web’de açılabiliyor mu?
- [ ] Ana ekranlar kırılmadan görünüyor mu?
- [ ] Auth akışı temel seviyede çalışıyor mu?

Bu testler V1’in ana kabul şartı değildir; teknik görünürlük sağlamak için opsiyoneldir.

---

## 13. Hata Durumu ve Edge Case Planı

### 13.1 Auth Hataları

- Yanlış şifre
- Geçersiz e-posta
- Zayıf şifre
- Kullanıcı zaten var
- Network sorunu

### 13.2 Prompt Hataları

- Boş `promptText`
- Çok uzun `promptText`
- Boş kategori / etiket
- Tekrarlanan etiket
- Geçersiz status
- Değişken formatı hataları

### 13.3 Firestore Hataları

- Permission denied
- Network unavailable
- Timeout
- Document not found
- Mapper dönüşüm hatası
- Eski veya eksik `schemaVersion` verisi

### 13.4 UI Boş Durumları

- Boş kütüphane
- Arama sonucu yok
- Arşiv sonucu yok
- Değişken yok
- Filtre sonucu yok

---

## 14. Milestone Bazlı Test / Security Yerleşimi

### M0 — Proje Hazırlığı ve Teknik Zemin

- [ ] Flutter test altyapısı çalışıyor.
- [ ] Proje build alıyor.
- [ ] Firebase bağlantı dosyaları doğru.
- [ ] Temel klasör yapısı doğru.

### M1 — App Shell, Routing ve Auth

- [ ] Login/Register manuel test edilir.
- [ ] AuthGate yönlendirme kontrol edilir.
- [ ] Logout kontrol edilir.
- [ ] Auth hata mesajları kontrol edilir.

### M2 — PromptCard Domain Model

- [ ] PromptCard unit testleri hazırlanır.
- [ ] Status validation testleri yapılır.
- [ ] Variable extraction testleri yapılır.
- [ ] Prompt validation testleri yapılır.

### M3 — Data Layer ve Firestore Bağlantısı

- [ ] DTO / Mapper testleri yapılır.
- [ ] Repository mock testleri yapılır.
- [ ] Firestore service smoke test yapılır.
- [ ] İlk security rules taslağı hazırlanır.

### M4 — İlk Çekirdek Akış

- [ ] Hızlı Ekle manuel test edilir.
- [ ] Firestore create/read kontrol edilir.
- [ ] Kullanıcı kendi promptlarını görüyor mu kontrol edilir.
- [ ] Cross-user read/create ilk güvenlik kontrolü yapılır.

### M5 — Prompt Detay ve Normal Kopyala

- [ ] Prompt detay manuel test edilir.
- [ ] Normal Kopyala kontrol edilir.
- [ ] Kopyalama `updatedAt` değiştirmiyor mu kontrol edilir.

### M6 — Prompt Düzenleme, Status ve Arşiv

- [ ] Update testleri yapılır.
- [ ] Archive testleri yapılır.
- [ ] `ownerId` değiştirilemiyor mu kontrol edilir.
- [ ] Delete kapalı mı kontrol edilir.
- [ ] Status validation kontrol edilir.

### M7 — Detaylı Ekle

- [ ] Metadata kayıt testleri yapılır.
- [ ] Etiket normalize / tekilleştirme kontrol edilir.
- [ ] Kategori kayıt kontrol edilir.
- [ ] Değişken algılama tekrar kontrol edilir.

### M8 — Arama ve Filtreleme

- [ ] Arama manuel test edilir.
- [ ] Kategori filtresi test edilir.
- [ ] Etiket filtresi test edilir.
- [ ] Status filtresi test edilir.
- [ ] Boş sonuç davranışı kontrol edilir.

### M9 — Değişkenli Kopyala-Doldur

- [ ] Değişken form alanları kontrol edilir.
- [ ] Final prompt üretimi test edilir.
- [ ] Eksik değişken davranışı kontrol edilir.
- [ ] Değişken yok durumu kontrol edilir.

### M10 — Güvenlik, Test ve V1 Kapanış

- [ ] Final manuel test turu yapılır.
- [ ] Final security rules kontrolü yapılır.
- [ ] Cross-user read/write testleri yapılır.
- [ ] Mimari sınır kontrol edilir.
- [ ] Scope leak kontrol edilir.
- [ ] Android cihaz/platform testleri yapılır.
- [ ] V1 acceptance criteria kapanışı yapılır.

---

## 15. Mimari Sınır Kontrolleri

- [ ] UI içinde `FirebaseFirestore.instance` yok.
- [ ] UI içinde `FirebaseAuth.instance` yok.
- [ ] Firestore query’leri service katmanında.
- [ ] DTO sınıfları presentation katmanında kullanılmıyor.
- [ ] Domain modeli Firebase `Timestamp` gibi tiplere bağımlı değil.
- [ ] Repository interface domain tarafında korunuyor.
- [ ] Repository implementation data tarafında.
- [ ] Mapper dönüşümleri merkezi.
- [ ] `core/` gereksiz çöplük klasörüne dönüşmemiş.

---

## 16. Scope Leak Kontrolleri

V1’de aşağıdaki alanlar bulunmamalıdır:

- [ ] AI prompt iyileştirme yok.
- [ ] AI başlık önerisi yok.
- [ ] AI açıklama önerisi yok.
- [ ] AI kategori / etiket önerisi yok.
- [ ] Semantik arama yok.
- [ ] Embedding yok.
- [ ] AI API key client tarafında yok.
- [ ] Cloud Functions yok.
- [ ] Payment / subscription yok.
- [ ] AI quota ekranı yok.
- [ ] Usage analytics yok.
- [ ] Version history yok.
- [ ] Team / workspace yok.
- [ ] Marketplace yok.
- [ ] Public sharing yok.
- [ ] Kalıcı delete yok.

---

## 17. V1 Kapanış Güvenlik Kontrolü

M10 sonunda ayrı bir final güvenlik kontrolü yapılacaktır.

- [ ] Firestore rules production’a uygun.
- [ ] `allow read, write: if request.auth != null;` gibi gevşek kural yok.
- [ ] Kullanıcı path’i auth UID ile eşleşiyor.
- [ ] `ownerId` create sırasında doğrulanıyor.
- [ ] `ownerId` update sırasında değiştirilemiyor.
- [ ] Delete kapalı.
- [ ] Cross-user read reddediliyor.
- [ ] Cross-user write reddediliyor.
- [ ] Auth olmayan erişim reddediliyor.
- [ ] Client tarafında gizli API key / secret yok.
- [ ] AI API key yok.
- [ ] Test kullanıcılarıyla izolasyon denenmiş.

---

## 18. V1 Dışında Bırakılan Test / Security Başlıkları

V1 kapsamında aşağıdaki ileri seviye başlıklar zorunlu değildir:

- Gelişmiş penetration test
- SOC2 / ISO benzeri kurumsal güvenlik süreçleri
- Tam otomatik E2E test zorunluluğu
- Load test
- AI abuse detection
- Payment security
- Team permission matrix
- Admin panel güvenliği
- Public sharing güvenliği

Bu başlıklar ürün büyüdükçe V2/V3 kapsamında tekrar değerlendirilebilir.

---

## 19. Riskler ve Önlem Planı

### Risk 1: Firestore rules gevşek kalır

Önlem:

- M3’te taslak rules
- M4’te read/create izolasyonu
- M6’da update/archive kontrolü
- M10’da final güvenlik turu

### Risk 2: UI doğrudan Firebase’e bağlanır

Önlem:

- Architecture boundary checklist
- Code review
- Repository / Service ayrımı

### Risk 3: Testler sona bırakılır

Önlem:

- Her milestone’a küçük test hedefi koymak
- M10’u ilk test zamanı değil, final kapanış yapmak

### Risk 4: V1 kapsamı şişer

Önlem:

- Scope leak checklist
- Parking lot belgesi
- V1 dışı maddelerin açık yazılması

### Risk 5: Veri modeli erken karmaşıklaşır

Önlem:

- V1 PromptCard alanlarına sadık kalmak
- AI / analytics / version history alanlarını V1’e eklememek

### Risk 6: Cihazlarda UI bozulur

Önlem:

- Android gerçek cihaz ve emülatör testleri
- Küçük ekran, klavye, overflow ve uzun metin testleri
- Device/platform checklist kullanımı

---

## 20. İlgili Checklist Bağlantıları

Bu belge şu checklist’lerle birlikte kullanılacaktır:

```text
docs/checklists/security_checklist.md
docs/checklists/architecture_boundary_checklist.md
docs/checklists/scope_leak_checklist.md
docs/checklists/device_platform_test_checklist.md
docs/checklists/firestore_rules_checklist.md
docs/checklists/data_model_checklist.md
docs/checklists/m0_project_setup_checklist.md
docs/checklists/m1_auth_routing_checklist.md
docs/checklists/m2_domain_model_checklist.md
docs/checklists/m3_firestore_data_layer_checklist.md
docs/checklists/m10_v1_release_readiness_checklist.md
```

---

## 21. Referans Belgeler

- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `08_parking_lot_v1_5_v2.md`
- `09_development_notes.md`

---

## 22. Kapanış Kararı

`07_test_security_plan.md`, Prompt Yönetim Aracı V1’in test, güvenlik ve kalite kontrol planı olarak kullanılacaktır.

Bu belge; manuel test stratejisini, unit/widget/repository/mapper test adaylarını, Auth akışı testlerini, Firestore security rules test planını, kullanıcı izolasyonu kontrollerini, hata ve edge case senaryolarını, cihaz/platform testlerini, milestone bazlı test/security yerleşimini, mimari sınır kontrollerini, scope leak kontrollerini ve M10 final V1 güvenlik kapanış kontrolünü içerir.

Test ve güvenlik V1’in sonuna bırakılmayacak; M0-M10 milestone’larının içine dağıtılacaktır.
