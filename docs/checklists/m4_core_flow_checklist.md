# M4 — Core Flow Checklist

## 1. Amaç

Bu checklist, **M4 — İlk Çekirdek Akış** milestone’unun doğru şekilde tamamlanıp tamamlanmadığını kontrol etmek için kullanılır.

M4’ün amacı, Prompt Yönetim Aracı V1’in ilk çalışan dikey omurgasını kurmaktır:

```text
Login/Register/AuthGate → Kütüphane → Hızlı Ekle → Firestore’a kullanıcıya bağlı kayıt → Kütüphanede Gör
```

Bu milestone sonunda kullanıcı giriş yapmış halde değerli bir promptu hızlıca ekleyebilmeli ve eklenen promptu kendi kütüphanesinde görebilmelidir.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- Hızlı Ekle ekranı geliştirildikten sonra,
- Kütüphane boş hali ve listeleme tamamlandıktan sonra,
- Firestore create/read akışı bağlandıktan sonra,
- M5 — Prompt Detay ve Normal Kopyala aşamasına geçmeden önce.

## 3. Bağlı Belgeler

- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `m1_auth_routing_checklist.md`
- `m2_domain_model_checklist.md`
- `m3_firestore_data_layer_checklist.md`
- `security_checklist.md`
- `architecture_boundary_checklist.md`
- `scope_leak_checklist.md`
- `device_platform_test_checklist.md`

## 4. Ön Koşullar

- [ ] M1 — App Shell, Routing ve Auth tamamlandı.
- [ ] Kullanıcı giriş/kayıt/çıkış akışı çalışıyor.
- [ ] AuthGate doğru yönlendirme yapıyor.
- [ ] M2 — PromptCard Domain Model tamamlandı.
- [ ] `PromptCard` modeli hazır.
- [ ] Değişken algılama mantığı hazır veya net planlı.
- [ ] M3 — Firestore Data Layer tamamlandı.
- [ ] DTO / Mapper / Repository / Service yapısı hazır.
- [ ] İlk Firestore security rules taslağı hazır.
- [ ] UI doğrudan Firebase’e erişmiyor.

## 5. Ana Akış Kontrolü

M4’ün ana akışı:

```text
Giriş yap → Kütüphane → Hızlı Ekle → Kaydet → Kütüphanede Gör
```

Kontrol maddeleri:

- [ ] Kullanıcı giriş yaptıktan sonra kütüphane ekranına ulaşabiliyor.
- [ ] Kütüphane ekranından Hızlı Ekle ekranına geçilebiliyor.
- [ ] Kullanıcı Hızlı Ekle ile prompt metni girebiliyor.
- [ ] Geçerli prompt metni kaydedilebiliyor.
- [ ] Prompt Firestore’a kullanıcıya bağlı olarak kaydediliyor.
- [ ] Kayıt sonrası kullanıcı kütüphaneye dönebiliyor veya yeni promptu görebiliyor.
- [ ] Eklenen prompt kütüphane listesinde görünüyor.
- [ ] Akış sırasında uygulama çökmeden ilerliyor.

## 6. Kütüphane Boş Hali Kontrolü

- [ ] Kullanıcının hiç promptu yoksa boş kütüphane durumu gösteriliyor.
- [ ] Boş durum mesajı kullanıcıya ne yapacağını anlatıyor.
- [ ] Boş durumdan Hızlı Ekle aksiyonuna geçilebiliyor.
- [ ] Boş durumda teknik hata mesajı gösterilmiyor.
- [ ] Boş kütüphane ile veri yükleniyor/loading durumu birbirine karışmıyor.
- [ ] Boş durum küçük ekranlarda taşmıyor.

## 7. Hızlı Ekle Ekranı Kontrolü

- [ ] Hızlı Ekle ekranı oluşturuldu.
- [ ] Prompt metni girişi için alan var.
- [ ] Prompt metni alanı uzun metin yazmaya uygun.
- [ ] Kaydet aksiyonu var.
- [ ] Geri dönme / iptal davranışı var.
- [ ] Prompt metni boşsa kayıt yapılmıyor.
- [ ] Prompt metni sadece boşluksa kayıt yapılmıyor.
- [ ] Boş kayıt denemesinde kullanıcıya anlaşılır hata gösteriliyor.
- [ ] Kaydetme sırasında loading state gösteriliyor.
- [ ] Kayıt başarılı olduğunda kullanıcıya anlaşılır geri bildirim veriliyor.
- [ ] Kayıt başarısız olduğunda kullanıcıya anlaşılır hata gösteriliyor.
- [ ] Hızlı Ekle ekranı doğrudan Firestore çağırmıyor.

## 8. Prompt Oluşturma Veri Kontrolü

Yeni prompt oluşturulduğunda şu alanlar doğru oluşmalıdır:

- [ ] `id` atanıyor.
- [ ] `ownerId` auth kullanıcısının uid değeriyle uyumlu.
- [ ] `promptText` kaydediliyor.
- [ ] `title` boşsa güvenli fallback davranışı var veya boş saklanıyor.
- [ ] `description` güvenli varsayılanla saklanıyor.
- [ ] `notes` güvenli varsayılanla saklanıyor.
- [ ] `category` güvenli varsayılanla saklanıyor.
- [ ] `tags` boş liste olarak saklanabiliyor.
- [ ] `status` varsayılan olarak `raw` veya kilitli karara uygun atanıyor.
- [ ] `variables` promptText’ten algılanıyor.
- [ ] `createdAt` atanıyor.
- [ ] `updatedAt` atanıyor.
- [ ] `schemaVersion: 1` atanıyor.

## 9. Değişken Algılama Kontrolü

M4’te değişkenli kopyala-doldur henüz yapılmaz; ancak create sırasında variables alanı doğru hazırlanmalıdır.

- [ ] Prompt metninde `[PROJE_ADI]` varsa `variables` içine ekleniyor.
- [ ] Birden fazla değişken algılanıyor.
- [ ] Aynı değişken tekrar ederse tekilleştiriliyor.
- [ ] Değişken yoksa `variables` boş liste oluyor.
- [ ] Değişken algılama kayıt akışını bozmuyor.
- [ ] Değişken algılama hatası kayıt akışını çökertmiyor.
- [ ] V1 dışı değişken tipi / varsayılan değer / koşullu blok eklenmedi.

## 10. Firestore Create Kontrolü

- [ ] Prompt `users/{uid}/prompts/{promptId}` altında kaydediliyor.
- [ ] Firestore dokümanında `ownerId` auth UID ile aynı.
- [ ] Firestore dokümanında `promptText` boş değil.
- [ ] Firestore dokümanında `status` geçerli key.
- [ ] Firestore dokümanında `schemaVersion` var.
- [ ] Firestore dokümanında `createdAt` var.
- [ ] Firestore dokümanında `updatedAt` var.
- [ ] Create işlemi repository/service üzerinden yapılıyor.
- [ ] UI Firestore path bilgisini bilmiyor.
- [ ] Create sırasında kullanıcı başka UID path’ine kayıt atamıyor.

## 11. Kütüphane Listeleme Kontrolü

- [ ] Kullanıcı kendi promptlarını liste halinde görebiliyor.
- [ ] Liste Firestore’dan repository üzerinden geliyor.
- [ ] DTO / Mapper dönüşümü sonrası domain model kullanılıyor.
- [ ] UI Firestore document snapshot kullanmıyor.
- [ ] Liste item’ında başlık veya fallback başlık gösteriliyor.
- [ ] Liste item’ında prompt önizlemesi veya açıklama gösterilebiliyor.
- [ ] Liste item’ında status bilgisi gösterilebilir.
- [ ] Liste item’ında updatedAt bilgisi gösterilebilir.
- [ ] Liste boşsa boş durum, veri varsa liste gösteriliyor.
- [ ] Listeleme sırasında loading state var.
- [ ] Listeleme başarısız olursa anlaşılır hata gösteriliyor.

## 12. Kullanıcı İzolasyonu Kontrolü

M4’te ilk gerçek izolasyon kontrolü yapılmalıdır.

- [ ] Kullanıcı A kendi promptlarını görebiliyor.
- [ ] Kullanıcı B kendi promptlarını görebiliyor.
- [ ] Kullanıcı A, Kullanıcı B’nin promptlarını göremiyor.
- [ ] Kullanıcı B, Kullanıcı A’nın promptlarını göremiyor.
- [ ] Kullanıcı A, Kullanıcı B path’ine create yapamıyor.
- [ ] Kullanıcı B, Kullanıcı A path’ine create yapamıyor.
- [ ] Auth olmayan kullanıcı prompt listesine erişemiyor.
- [ ] Auth olmayan kullanıcı prompt oluşturamıyor.
- [ ] Bu testlerin M10’da tekrar yapılacağı not edildi.

## 13. Security Rules Kontrolü

- [ ] M3 security rules taslağı M4 create/read akışıyla test edildi.
- [ ] `request.auth.uid == userId` kontrolü çalışıyor.
- [ ] Create sırasında `ownerId == request.auth.uid` kontrolü çalışıyor veya test edilecek şekilde planlı.
- [ ] Auth olmayan read reddediliyor.
- [ ] Auth olmayan create reddediliyor.
- [ ] Cross-user read reddediliyor.
- [ ] Cross-user create reddediliyor.
- [ ] `allow read, write: if request.auth != null;` gibi gevşek kural kullanılmıyor.
- [ ] Delete hala kapalı veya M6/M10 için kapalı kalacağı not edildi.

## 14. Mimari Sınır Kontrolü

- [ ] Hızlı Ekle ekranı doğrudan Firestore çağırmıyor.
- [ ] Kütüphane ekranı doğrudan Firestore çağırmıyor.
- [ ] Screen içinde `FirebaseFirestore.instance` yok.
- [ ] Provider/Notifier repository çağırıyor.
- [ ] Repository service çağırıyor.
- [ ] Service Firebase ile konuşuyor.
- [ ] DTO presentation katmanına sızmadı.
- [ ] Domain model Firestore tiplerine bağımlı değil.
- [ ] Firestore path bilgisi UI katmanında yok.
- [ ] `core/` içine prompt feature’a özel kod atılmadı.

## 15. Error / Empty State Kontrolü

- [ ] Kütüphane loading state gösteriyor.
- [ ] Kütüphane boş state gösteriyor.
- [ ] Kütüphane error state gösteriyor.
- [ ] Hızlı Ekle validation error gösteriyor.
- [ ] Firestore permission error çökme yaratmıyor.
- [ ] Network error çökme yaratmıyor.
- [ ] Kayıt başarısız olursa kullanıcı bilgilendiriliyor.
- [ ] Listeleme başarısız olursa kullanıcı bilgilendiriliyor.
- [ ] Hata mesajları ham teknik Firebase exception olarak gösterilmiyor.

## 16. Cihaz / Platform Kontrolü

M4, ilk gerçek kullanıcı akışını içerdiği için cihaz testi önemlidir.

- [ ] Hızlı Ekle ekranı Android emülatörde test edildi.
- [ ] Hızlı Ekle ekranı mümkünse gerçek Android cihazda test edildi.
- [ ] Klavye açılınca prompt metni alanı ve kaydet butonu bozulmuyor.
- [ ] Uzun prompt yazıldığında ekran scroll davranışı çalışıyor.
- [ ] Küçük ekranda overflow yok.
- [ ] Kütüphane boş hali küçük ekranda düzgün görünüyor.
- [ ] Kütüphane listesi uzun başlık/uzun prompt önizlemesiyle bozulmuyor.
- [ ] Geri tuşu Hızlı Ekle’den kütüphaneye doğru çalışıyor.
- [ ] Kayıt sonrası navigation davranışı cihazda test edildi.
- [ ] Tablet/web smoke test opsiyonel olarak not edildi.

## 17. Test Kontrolü

Manuel testler:

- [ ] Yeni kullanıcıyla giriş yapıldı.
- [ ] Boş kütüphane görüldü.
- [ ] Hızlı Ekle ekranına geçildi.
- [ ] Boş promptText ile kayıt denendi.
- [ ] Geçerli promptText ile kayıt yapıldı.
- [ ] Prompt kütüphanede görüldü.
- [ ] Çıkış yapılıp başka kullanıcıyla test edildi.
- [ ] Cross-user veri görünürlüğü kontrol edildi.

Unit / teknik test adayları:

- [ ] Variable extraction testleri not edildi veya çalışıyor.
- [ ] Mapper testleri not edildi veya çalışıyor.
- [ ] Repository create/read testleri not edildi veya çalışıyor.
- [ ] Security rules create/read testleri not edildi veya çalışıyor.

## 18. V1 Scope Leak Kontrolü

M4’te aşağıdakiler eklenmemiş olmalı:

- [ ] Prompt Detay ekranı M5 kapsamını aşacak şekilde büyütülmedi.
- [ ] Normal Kopyala M5 öncesinde plansız eklenmedi.
- [ ] Prompt düzenleme M6 öncesinde plansız eklenmedi.
- [ ] Detaylı Ekle M7 öncesinde plansız eklenmedi.
- [ ] Arama/filtreleme M8 öncesinde plansız eklenmedi.
- [ ] Değişkenli Kopyala-Doldur M9 öncesinde plansız eklenmedi.
- [ ] AI öneri sistemi eklenmedi.
- [ ] Semantik arama / embedding eklenmedi.
- [ ] Usage analytics eklenmedi.
- [ ] Kalıcı delete eklenmedi.
- [ ] Payment / quota / AI Gateway eklenmedi.

## 19. AI Review Hatırlatma

M4 sonunda dış AI review almak faydalıdır.

Önerilen promptlar:

- `milestone_review_prompt.md`
- `scope_guard_review_prompt.md`
- `security_review_prompt.md`
- Gerekirse `device_ui_review_prompt.md`

Kontrol maddeleri:

- [ ] M4 sonunda milestone review alınması değerlendirildi.
- [ ] Scope guard review alınması değerlendirildi.
- [ ] Security review alınması değerlendirildi.
- [ ] Cihaz/UI sorunları varsa device UI review düşünüldü.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] Kabul/ret/parking lot ayrımı yapıldı.
- [ ] Gerekli notlar `09_development_notes.md` içine yazıldı.

## 20. Development Notes Kontrolü

- [ ] M4 sırasında çıkan hızlı ekle sorunları yazıldı.
- [ ] Firestore create/read sorunları yazıldı.
- [ ] Kullanıcı izolasyonu test sonucu yazıldı.
- [ ] Cihaz/klavye/overflow test notları yazıldı.
- [ ] Checklist’e taşınacak yeni madde varsa not edildi.
- [ ] ADR’ye dönüşmesi gereken yeni karar adayı varsa not edildi.
- [ ] M4 kapanış notu eklendi veya eklenecek.

## 21. M4 Kapanış Kararı

M4 tamamlandı sayılabilmesi için:

- [ ] Kullanıcı giriş yaptıktan sonra kütüphaneye ulaşabiliyor.
- [ ] Kütüphane boş hali çalışıyor.
- [ ] Hızlı Ekle çalışıyor.
- [ ] Prompt Firestore’a kullanıcıya bağlı kaydediliyor.
- [ ] Prompt kütüphanede görünüyor.
- [ ] Kullanıcı yalnızca kendi promptlarını görüyor.
- [ ] Boş promptText kaydedilemiyor.
- [ ] Variables promptText’ten çıkarılıyor.
- [ ] Create/read security rules ilk kontrolü yapıldı.
- [ ] UI doğrudan Firestore’a erişmiyor.
- [ ] V1 dışı özellikler sızmadı.
- [ ] M5 — Prompt Detay ve Normal Kopyala aşamasına geçilebilir.

## 22. Kapanış Notu

M4, V1’in ilk gerçek ürün nabzıdır. Bu milestone sonunda kullanıcı değerli bir promptu sisteme atıp kendi kütüphanesinde görebiliyorsa, ürünün çekirdek kalbi ilk kez atmaya başlamış demektir.
## 23. M4 Manual Firestore Rules Notu

- [x] Firebase Console'da default deny (`allow read, write: if false;`) nedeniyle read/create hatasi goruldu.
- [x] M4 minimum user-scoped read/create rules Console'da yayinlandi.
- [x] Manuel testte login/register -> library -> Hizli Ekle -> Firestore create -> watchPrompts list akisi basarili calisti.
- [x] Root `firestore.rules` dosyasi projeye eklendi.
- [x] `firebase.json` icinde Firestore rules path'i `firestore.rules` olarak tanimlandi.
- [x] Update/delete M4 kapsaminda kapali tutuldu.
- [x] Genel fallback deny kurali korundu.
- [ ] M10 final guvenlik kapanisinda rules tekrar review edilecek.
