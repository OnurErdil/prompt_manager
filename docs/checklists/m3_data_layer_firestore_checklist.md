# M3 — Firestore Data Layer Checklist

## 1. Amaç

Bu checklist, **M3 — Data Layer ve Firestore Bağlantısı** milestone’unun doğru şekilde tamamlanıp tamamlanmadığını kontrol etmek için kullanılır.

M3’ün amacı, M2’de kurulan Firebase’den bağımsız `PromptCard` domain modelini Cloud Firestore ile güvenli, katmanlı ve test edilebilir şekilde bağlamaktır.

Bu milestone sonunda şu yapı çalışır hale gelmelidir:

```text
Firestore Document ⇄ PromptCardDto ⇄ PromptCardMapper ⇄ PromptCard
```

ve veri akışı şu sınırı korumalıdır:

```text
Screen → Provider/Notifier → Repository → Service → Firebase
```

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- Firestore service oluşturulurken,
- DTO / Mapper yazılırken,
- Repository implementation hazırlanırken,
- İlk Firestore security rules taslağı yazılırken,
- M4 — İlk Çekirdek Akış aşamasına geçmeden önce.

## 3. Bağlı Belgeler

- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `firestore_rules_checklist.md`
- `security_checklist.md`
- `architecture_boundary_checklist.md`
- `data_model_checklist.md`

## 4. Ön Koşullar

- [ ] M2 — PromptCard Domain Model tamamlandı.
- [ ] `PromptCard` domain modeli hazır.
- [ ] Status key’leri hazır.
- [ ] Variable extraction mantığı hazır veya net.
- [ ] Repository interface yönü net.
- [ ] Firebase project ve FlutterFire yapılandırması M0/M1 kapsamında hazır veya M3 içinde tamamlanacak.
- [ ] Firestore path kararı `users/{userId}/prompts/{promptId}` olarak kabul edildi.

## 5. Firestore Collection Yapısı Kontrolü

V1 için önerilen yapı:

```text
users/{userId}/prompts/{promptId}
```

Kontrol maddeleri:

- [ ] Firestore path yapısı `04_firebase_firestore_plan.md` ile uyumlu.
- [ ] Kullanıcı promptları `users/{uid}/prompts` altında tutuluyor.
- [ ] Prompt dokümanı içinde `ownerId` alanı yine saklanıyor.
- [ ] Firestore path bilgisi UI katmanına sızmıyor.
- [ ] Top-level `prompts` yapısına plansız geçilmedi.
- [ ] Team/workspace/public sharing path yapıları V1’e eklenmedi.

## 6. PromptCardDto Kontrolü

- [ ] `PromptCardDto` oluşturuldu.
- [ ] DTO Firestore alanlarıyla uyumlu.
- [ ] DTO içinde `id` alanı yönetimi net.
- [ ] DTO içinde `ownerId` alanı var.
- [ ] DTO içinde `title` alanı var.
- [ ] DTO içinde `promptText` alanı var.
- [ ] DTO içinde `description` alanı var.
- [ ] DTO içinde `notes` alanı var.
- [ ] DTO içinde `category` alanı var.
- [ ] DTO içinde `tags` alanı var.
- [ ] DTO içinde `status` alanı var.
- [ ] DTO içinde `variables` alanı var.
- [ ] DTO içinde `createdAt` alanı var.
- [ ] DTO içinde `updatedAt` alanı var.
- [ ] DTO içinde `schemaVersion` alanı var.
- [ ] DTO, domain modelden ayrı tutuluyor.
- [ ] DTO presentation katmanında kullanılmıyor.

## 7. Mapper Kontrolü

- [ ] `PromptCardMapper` oluşturuldu.
- [ ] DTO → Domain dönüşümü var.
- [ ] Domain → DTO dönüşümü var.
- [ ] Firestore timestamp/date dönüşümleri merkezi şekilde yapılıyor.
- [ ] Eksik opsiyonel alanlar güvenli varsayılanlarla karşılanıyor.
- [ ] `tags` güvenli şekilde string listesine dönüştürülüyor.
- [ ] `variables` güvenli şekilde string listesine dönüştürülüyor.
- [ ] `status` geçerli key değilse güvenli davranış planlandı.
- [ ] `schemaVersion` yoksa güvenli fallback planlandı.
- [ ] Mapper içinde UI logic yok.
- [ ] Mapper içinde Firestore query logic yok.

## 8. Firestore Service Kontrolü

- [ ] Prompt Firestore service oluşturuldu.
- [ ] Firestore create operasyonu service içinde.
- [ ] Firestore read/list operasyonu service içinde.
- [ ] Firestore update operasyonu service içinde.
- [ ] Firestore archive/status update operasyonu service içinde.
- [ ] Firestore path oluşturma logic’i service veya data katmanında.
- [ ] Service UI state bilmiyor.
- [ ] Service widget veya BuildContext bilmiyor.
- [ ] Service domain business logic ile şişirilmedi.
- [ ] Service doğrudan DTO veya Firestore data ile çalışıyor.

## 9. Repository Implementation Kontrolü

- [ ] Firestore repository implementation oluşturuldu.
- [ ] Repository implementation data katmanında.
- [ ] Repository interface domain tarafında korunuyor.
- [ ] Repository service üzerinden Firestore’a erişiyor.
- [ ] Repository DTO / Mapper kullanarak domain model döndürüyor.
- [ ] Repository UI’a Firestore document/snapshot döndürmüyor.
- [ ] Repository hata durumlarını uygun şekilde ele alıyor.
- [ ] Repository archive işlemini delete değil `status: archived` update’i olarak yapıyor.
- [ ] Repository `ownerId` ve auth UID ilişkisini doğru yönetiyor.

## 10. Create Davranışı Kontrolü

- [ ] Authenticated kullanıcıyla prompt oluşturma planlandı/çalışıyor.
- [ ] Path UID, auth UID ile uyumlu.
- [ ] `ownerId` auth UID ile atanıyor.
- [ ] `promptText` boşsa kayıt yapılmıyor.
- [ ] `status` geçerli key olarak atanıyor.
- [ ] Varsayılan status `raw` olarak planlandı veya net karara bağlandı.
- [ ] `variables` promptText’ten hesaplanıyor.
- [ ] `createdAt` atanıyor.
- [ ] `updatedAt` atanıyor.
- [ ] `schemaVersion: 1` atanıyor.
- [ ] Create işlemi domain model/DTO sınırını koruyor.

## 11. Read/List Davranışı Kontrolü

- [ ] Kullanıcı kendi promptlarını listeleyebiliyor.
- [ ] Listeleme `users/{uid}/prompts` altından yapılıyor.
- [ ] Listeleme `updatedAt` sıralamasıyla uyumlu planlandı.
- [ ] Firestore dokümanları mapper üzerinden domain modele dönüyor.
- [ ] Arşivli promptların varsayılan görünüm davranışı net veya M8’e bırakıldı.
- [ ] UI Firestore snapshot dinlemiyor.
- [ ] Repository domain model listesi döndürüyor.
- [ ] Auth olmayan kullanıcı için veri okuma yapılmıyor.

## 12. Update Davranışı Kontrolü

- [ ] Update operasyonu repository/service üzerinden yapılacak şekilde kuruldu.
- [ ] Kullanıcı yalnızca kendi promptunu güncelleyebiliyor.
- [ ] `ownerId` update sırasında değiştirilmiyor.
- [ ] `createdAt` update sırasında değiştirilmiyor.
- [ ] `updatedAt` anlamlı değişiklikte güncelleniyor.
- [ ] `promptText` değişirse `variables` yeniden hesaplanıyor.
- [ ] `status` geçerli key olarak kalıyor.
- [ ] Update işlemi M6’da detaylandırılacak şekilde temel altyapı hazır.

## 13. Archive Davranışı Kontrolü

- [ ] Arşivleme delete olarak tasarlanmadı.
- [ ] Arşivleme `status: archived` update’i olarak tasarlandı.
- [ ] V1’de kalıcı delete yapılmıyor.
- [ ] Firestore delete operasyonu repository’de V1 davranışı olarak sunulmuyor.
- [ ] Archive davranışı `ADR-010-archive-instead-of-delete-v1.md` ile uyumlu.

## 14. Security Rules Taslak Kontrolü

M3’te final rules şart değildir; ancak ilk taslak olmalıdır.

- [ ] Firestore rules taslağı oluşturuldu.
- [ ] Auth olmayan kullanıcı read yapamıyor.
- [ ] Auth olmayan kullanıcı create yapamıyor.
- [ ] Kullanıcı yalnızca kendi `users/{uid}/prompts` path’ine erişebiliyor.
- [ ] Create sırasında `ownerId == request.auth.uid` kontrolü planlandı.
- [ ] Update sırasında `ownerId` değiştirilemezliği planlandı.
- [ ] Delete V1’de kapalı.
- [ ] `promptText` boş olamaz kontrolü planlandı.
- [ ] `status` izin verilen key’lerden biri olmalı kontrolü planlandı.
- [ ] Gevşek `allow read, write: if request.auth != null;` yaklaşımı kullanılmıyor.

## 15. Kullanıcı İzolasyonu Kontrolü

- [ ] Kullanıcı A kendi path’inde veri oluşturabiliyor.
- [ ] Kullanıcı A kullanıcı B path’inde veri oluşturamamalı.
- [ ] Kullanıcı A kullanıcı B promptlarını okuyamamalı.
- [ ] Kullanıcı A kullanıcı B promptlarını güncelleyememeli.
- [ ] Bu testlerin M4/M10’da tekrar yapılacağı not edildi.
- [ ] Security checklist ile ilişki kuruldu.

## 16. Mimari Sınır Kontrolü

- [ ] Screen içinde `FirebaseFirestore.instance` kullanılmıyor.
- [ ] Provider/Notifier içinde doğrudan Firestore query yazılmıyor.
- [ ] Firestore service data katmanında.
- [ ] Repository implementation data katmanında.
- [ ] Repository interface domain katmanında.
- [ ] DTO presentation katmanına sızmadı.
- [ ] Domain model Firestore tiplerine bağımlı değil.
- [ ] Mapper dönüşümleri merkezi.
- [ ] UI Firestore path veya collection adlarını bilmiyor.

## 17. Error Handling Kontrolü

- [ ] Firestore permission-denied hatası ele alınacak şekilde planlandı.
- [ ] Network hatası ele alınacak şekilde planlandı.
- [ ] Document not found durumu ele alınacak şekilde planlandı.
- [ ] Mapper dönüşüm hatası ele alınacak şekilde planlandı.
- [ ] Repository UI’a ham Firebase exception fırlatmıyor veya bunu iyileştirme planı var.
- [ ] Hata mesajları kullanıcıya okunabilir hale getirilecek.
- [ ] Teknik hata detayları gereksiz şekilde UI’a gösterilmeyecek.

## 18. Test Kontrolü

M3 test adayları:

- [ ] DTO → Domain mapper testi adayı not edildi.
- [ ] Domain → DTO mapper testi adayı not edildi.
- [ ] Eksik alan fallback testi adayı not edildi.
- [ ] Timestamp/date dönüşüm testi adayı not edildi.
- [ ] Repository mock service testi adayı not edildi.
- [ ] Archive’in delete değil update olduğu test adayı not edildi.
- [ ] İlk Firestore rules test senaryoları not edildi.
- [ ] Test notları `07_test_security_plan.md` ile uyumlu.

## 19. V1 Scope Leak Kontrolü

M3’te aşağıdakiler eklenmemiş olmalı:

- [ ] Cloud Functions
- [ ] AI Gateway
- [ ] AI API çağrısı
- [ ] Payment backend
- [ ] AI usage/kota backend
- [ ] Public sharing
- [ ] Team/workspace collection yapısı
- [ ] Admin panel
- [ ] Semantik arama / embedding
- [ ] Usage analytics
- [ ] Version history
- [ ] Kalıcı delete

## 20. AI Review Hatırlatma

M3 sonunda dış AI review almak özellikle faydalıdır.

Önerilen promptlar:

- `firestore_rules_review_prompt.md`
- `security_review_prompt.md`
- `architecture_review_prompt.md`
- Gerekirse `data_model_review_prompt.md`

Kontrol maddeleri:

- [ ] M3 sonunda Firestore rules review alınması değerlendirildi.
- [ ] Security review alınması değerlendirildi.
- [ ] Architecture boundary review alınması değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] Kritik güvenlik önerileri ayrıca incelendi.
- [ ] V1 dışı öneriler parking lot’a taşındı veya reddedildi.
- [ ] Gerekli notlar `09_development_notes.md` içine yazıldı.

## 21. Development Notes Kontrolü

- [ ] Firestore path ile ilgili notlar yazıldı.
- [ ] DTO / Mapper sorunları yazıldı.
- [ ] Security rules taslak eksikleri yazıldı.
- [ ] Cross-user test ihtiyacı yazıldı.
- [ ] ADR’ye dönüşmesi gereken yeni karar adayı varsa not edildi.
- [ ] Checklist’e taşınacak yeni madde varsa not edildi.
- [ ] M3 kapanış notu eklendi veya eklenecek.

## 22. M3 Kapanış Kararı

M3 tamamlandı sayılabilmesi için:

- [ ] Firestore service hazır.
- [ ] PromptCard DTO hazır.
- [ ] Mapper hazır.
- [ ] Repository implementation hazır.
- [ ] Domain ↔ DTO dönüşümü çalışıyor.
- [ ] Repository üzerinden create/read teknik olarak mümkün.
- [ ] UI doğrudan Firestore’a erişmiyor.
- [ ] İlk security rules taslağı hazır.
- [ ] Kullanıcı izolasyonu ilkesi data layer’da korunuyor.
- [ ] V1 dışı backend/AI/payment yapıları eklenmedi.
- [ ] M4 — İlk Çekirdek Akış aşamasına geçilebilir.

## 23. Kapanış Notu

M3’ün ana başarı ölçütü, PromptCard domain modelinin Firestore ile katmanlı ve güvenli şekilde bağlanmasıdır. Bu aşamada amaç tam ürün deneyimi değil; doğru veri köprüsünü kurmaktır. Köprü sağlam değilse M4’te kullanıcı yürürken tahta gıcırdar.
