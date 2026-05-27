# G04 — Firestore Rules Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1’de Cloud Firestore security rules yapısının doğru, güvenli ve V1 kapsamına uygun olup olmadığını kontrol etmek için kullanılır.

Ana hedef:

> Kullanıcı yalnızca kendi `users/{userId}/prompts/{promptId}` altındaki promptlarını okuyabilmeli ve değiştirebilmelidir.

Bu checklist, Firestore rules tarafında kullanıcı izolasyonu, `ownerId` doğrulaması, create/read/update/archive davranışı, delete kapalı olma kuralı ve temel veri validation kontrollerini takip eder.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- M3 — Data Layer ve Firestore Bağlantısı sonunda ilk rules taslağı hazırlandığında,
- M4 — İlk Çekirdek Akış sonunda create/read izolasyonu test edilirken,
- M6 — Prompt Düzenleme, Status ve Arşiv sonunda update/archive rules kontrol edilirken,
- M10 — Güvenlik, Test ve V1 Kapanış sırasında final rules kontrolünde,
- Dış AI Firestore rules review öncesi veya sonrası.

## 3. Bağlı Belgeler

- `04_firebase_firestore_plan.md`
- `07_test_security_plan.md`
- `06_acceptance_criteria.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `ADR-010-archive-instead-of-delete-v1.md`
- `g01_security_checklist.md`
- `g02_architecture_boundary_checklist.md`
- `g03_scope_leak_checklist.md`

## 4. Firestore Path Kontrolü

V1 için beklenen yapı:

```text
users/{userId}/prompts/{promptId}
```

Kontrol maddeleri:

- [ ] Rules bu path için tanımlandı.
- [ ] `users/{userId}` path parametresi kullanılıyor.
- [ ] `prompts/{promptId}` alt koleksiyonu için read/create/update kuralları yazıldı.
- [ ] V1’de top-level `prompts/{promptId}` için plansız public rule yok.
- [ ] Team/workspace/public sharing path’leri V1’e eklenmedi.
- [ ] Rules, V1 kişisel kullanıcı modeline göre sade tutuldu.

## 5. Auth Kontrolü

- [ ] Auth olmayan kullanıcı read yapamıyor.
- [ ] Auth olmayan kullanıcı create yapamıyor.
- [ ] Auth olmayan kullanıcı update yapamıyor.
- [ ] Auth olmayan kullanıcı delete yapamıyor.
- [ ] Her read/create/update kuralında `request.auth != null` kontrolü var.
- [ ] Auth kontrolü tek başına yeterli güvenlik sayılmıyor.
- [ ] Auth kontrolüne ek olarak kullanıcı path eşleşmesi yapılıyor.

Yetersiz örnek:

```text
allow read, write: if request.auth != null;
```

Bu tek başına kullanılmamalıdır.

## 6. Kullanıcı Path İzolasyonu Kontrolü

Temel kural:

```text
request.auth.uid == userId
```

Kontrol maddeleri:

- [ ] Read kuralında `request.auth.uid == userId` kontrolü var.
- [ ] Create kuralında `request.auth.uid == userId` kontrolü var.
- [ ] Update kuralında `request.auth.uid == userId` kontrolü var.
- [ ] Delete kuralı V1’de kapalı.
- [ ] Kullanıcı başka kullanıcının path’ine erişemiyor.
- [ ] Kullanıcı başka kullanıcının prompt listesine erişemiyor.
- [ ] Kullanıcı başka kullanıcının tekil prompt dokümanına erişemiyor.

## 7. Read Rules Kontrolü

Read kuralı şu ilkeyi sağlamalıdır:

```text
Kullanıcı yalnızca kendi promptlarını okuyabilir.
```

Kontrol maddeleri:

- [ ] Auth olmayan read reddediliyor.
- [ ] Kullanıcı kendi `users/{uid}/prompts` listesini okuyabiliyor.
- [ ] Kullanıcı kendi tekil prompt dokümanını okuyabiliyor.
- [ ] Kullanıcı başka UID altındaki prompt listesini okuyamıyor.
- [ ] Kullanıcı başka UID altındaki tekil promptu okuyamıyor.
- [ ] Arşivlenmiş promptlar da yalnızca sahibine okunabilir.
- [ ] Public read rule yok.

## 8. Create Rules Kontrolü

Create kuralı şu ilkeyi sağlamalıdır:

```text
Kullanıcı yalnızca kendi path’inde ve kendi ownerId değeriyle prompt oluşturabilir.
```

Kontrol maddeleri:

- [ ] Auth olmayan create reddediliyor.
- [ ] Kullanıcı yalnızca kendi `users/{uid}/prompts` path’inde create yapabiliyor.
- [ ] `request.resource.data.ownerId == request.auth.uid` kontrolü var.
- [ ] Kullanıcı başka `ownerId` ile kayıt oluşturamıyor.
- [ ] `promptText` boş kayıt oluşturulamıyor.
- [ ] `status` geçerli key’lerden biri olmalı.
- [ ] `schemaVersion` varlığı kontrol ediliyor veya kontrol edilecek şekilde planlandı.
- [ ] `createdAt` ve `updatedAt` alanları için kabul edilen davranış net.
- [ ] V1 dışı alanlarla create davranışı güvenlik açığı oluşturmuyor.

## 9. Update Rules Kontrolü

Update kuralı şu ilkeyi sağlamalıdır:

```text
Kullanıcı yalnızca kendi promptunu güncelleyebilir ve ownerId değiştiremez.
```

Kontrol maddeleri:

- [ ] Auth olmayan update reddediliyor.
- [ ] Kullanıcı yalnızca kendi promptunu update edebiliyor.
- [ ] Kullanıcı başka UID path’indeki promptu update edemiyor.
- [ ] Mevcut `resource.data.ownerId` auth UID ile uyumlu.
- [ ] Yeni `request.resource.data.ownerId` eski `resource.data.ownerId` ile aynı kalıyor.
- [ ] `ownerId` değiştirilmeye çalışılırsa update reddediliyor.
- [ ] `createdAt` değiştirilemiyor veya bu davranış rules/logic düzeyinde kontrol ediliyor.
- [ ] `promptText` boş bırakılamıyor.
- [ ] `status` geçerli key’lerden biri olmalı.
- [ ] `updatedAt` güncelleme davranışı net.
- [ ] Update ile V1 dışı hassas alanlar manipüle edilemiyor.

## 10. Delete Rules Kontrolü

V1 kararı:

```text
allow delete: if false;
```

Kontrol maddeleri:

- [ ] V1’de delete kapalı.
- [ ] Authenticated kullanıcı da delete yapamıyor.
- [ ] Kullanıcı kendi promptunu bile kalıcı silemiyor.
- [ ] Delete yerine archive/status update kullanılacak.
- [ ] UI’da kalıcı delete yok.
- [ ] Repository kalıcı delete operasyonu sunmuyor.
- [ ] Delete kapalı olduğu M10’da tekrar test edilecek.

## 11. Status Validation Kontrolü

Geçerli status key’leri:

```text
raw
needs_edit
ready
archived
```

Kontrol maddeleri:

- [ ] Create sırasında status geçerli key olmalı.
- [ ] Update sırasında status geçerli key olmalı.
- [ ] Geçersiz status reddediliyor veya reddedilecek şekilde planlandı.
- [ ] `archived`, delete yerine status değeri olarak kabul ediliyor.
- [ ] Kullanıcı status alanına rastgele string yazamıyor.
- [ ] Status kullanıcıya görünen label olarak değil teknik key olarak saklanıyor.

## 12. PromptText Validation Kontrolü

- [ ] Create sırasında `promptText` var.
- [ ] Create sırasında `promptText` boş değil.
- [ ] Create sırasında sadece boşluklardan oluşan `promptText` davranışı değerlendirildi.
- [ ] Update sırasında `promptText` var.
- [ ] Update sırasında `promptText` boş değil.
- [ ] Boş promptText ile veri oluşturma reddediliyor.
- [ ] Boş promptText ile update reddediliyor.
- [ ] Bu kural UI validation’a bırakılmadan rules/backend tarafında da düşünülüyor.

## 13. Alan Validation Kontrolü

- [ ] `ownerId` string olarak bekleniyor.
- [ ] `promptText` string olarak bekleniyor.
- [ ] `title` string veya güvenli opsiyonel alan.
- [ ] `description` string veya güvenli opsiyonel alan.
- [ ] `notes` string veya güvenli opsiyonel alan.
- [ ] `category` string veya güvenli opsiyonel alan.
- [ ] `tags` liste olarak bekleniyor.
- [ ] `variables` liste olarak bekleniyor.
- [ ] `schemaVersion` sayı olarak bekleniyor.
- [ ] Bilinmeyen alanlara izin verilip verilmeyeceği değerlendirildi.
- [ ] Field whitelist yaklaşımı gerekirse M10’a kadar tekrar değerlendirilecek.

## 14. CreatedAt / UpdatedAt Kontrolü

- [ ] Create sırasında `createdAt` alanı oluşuyor.
- [ ] Create sırasında `updatedAt` alanı oluşuyor.
- [ ] Update sırasında `createdAt` değişmiyor veya değişmemesi sağlanıyor.
- [ ] Update sırasında `updatedAt` güncelleniyor.
- [ ] Client timestamp / server timestamp yaklaşımı net.
- [ ] Tarih alanları kullanıcı tarafından kötüye kullanılamayacak şekilde değerlendirildi.
- [ ] V1’de `lastUsedAt` yok.
- [ ] V1’de `deletedAt` yok.

## 15. Archive Rules Kontrolü

Arşivleme update operasyonudur:

```text
status: archived
```

Kontrol maddeleri:

- [ ] Kullanıcı kendi promptunu `archived` status değerine çekebiliyor.
- [ ] Kullanıcı başka kullanıcının promptunu arşivleyemiyor.
- [ ] Archive işlemi delete değildir.
- [ ] Archive sırasında `ownerId` değişmiyor.
- [ ] Archive sırasında `createdAt` değişmiyor.
- [ ] Archive sırasında `updatedAt` güncelleniyor.
- [ ] Delete rules kapalı kalıyor.

## 16. Cross-user Test Kontrolü

İki test kullanıcısı ile kontrol edilmelidir.

### Kullanıcı A

- [ ] Kendi promptunu okuyabiliyor.
- [ ] Kendi promptunu oluşturabiliyor.
- [ ] Kendi promptunu güncelleyebiliyor.
- [ ] Kendi promptunu arşivleyebiliyor.
- [ ] Kullanıcı B’nin promptunu okuyamıyor.
- [ ] Kullanıcı B’nin promptunu güncelleyemiyor.
- [ ] Kullanıcı B’nin path’ine create yapamıyor.

### Kullanıcı B

- [ ] Kendi promptunu okuyabiliyor.
- [ ] Kendi promptunu oluşturabiliyor.
- [ ] Kendi promptunu güncelleyebiliyor.
- [ ] Kendi promptunu arşivleyebiliyor.
- [ ] Kullanıcı A’nın promptunu okuyamıyor.
- [ ] Kullanıcı A’nın promptunu güncelleyemiyor.
- [ ] Kullanıcı A’nın path’ine create yapamıyor.

## 17. Malicious Request Kontrolü

Aşağıdaki kötü niyetli/hatalı istekler reddedilmelidir:

- [ ] Auth yokken read.
- [ ] Auth yokken create.
- [ ] Auth yokken update.
- [ ] Auth yokken delete.
- [ ] Farklı `ownerId` ile create.
- [ ] Update sırasında `ownerId` değiştirme.
- [ ] Update sırasında `createdAt` değiştirme.
- [ ] Boş `promptText` ile create.
- [ ] Boş `promptText` ile update.
- [ ] Geçersiz `status` ile create.
- [ ] Geçersiz `status` ile update.
- [ ] Delete isteği.

## 18. Rules Geliştirme Aşaması Kontrolü

### M3

- [ ] İlk rules taslağı yazıldı.
- [ ] Path izolasyonu planlandı.
- [ ] ownerId create kontrolü planlandı.
- [ ] Delete kapalı olacak şekilde planlandı.

### M4

- [ ] Read rules test edildi.
- [ ] Create rules test edildi.
- [ ] Cross-user read/create test edildi.

### M6

- [ ] Update rules test edildi.
- [ ] Archive/status update test edildi.
- [ ] ownerId değiştirilemiyor kontrol edildi.
- [ ] Delete kapalı kontrol edildi.

### M10

- [ ] Final rules review yapıldı.
- [ ] Cross-user tüm senaryolar test edildi.
- [ ] Gevşek rule kalmadı.
- [ ] Security checklist ile uyum kontrol edildi.

## 19. Emulator / Test Ortamı Notu

- [ ] Firestore rules testleri için emulator kullanımı değerlendirildi.
- [ ] En azından manuel iki kullanıcı testi yapılacak şekilde planlandı.
- [ ] Rules değişiklikleri production’a alınmadan önce test edilecek.
- [ ] Test sonuçları `09_development_notes.md` içine yazılacak.
- [ ] Dış AI review alınırsa sonuçlar ayrıca süzülecek.

## 20. Scope Leak Kontrolü

Firestore rules içinde veya backend planında aşağıdakiler olmamalıdır:

- [ ] Public read rule yok.
- [ ] Public write rule yok.
- [ ] Team/workspace permission rule yok.
- [ ] Marketplace/public sharing rule yok.
- [ ] AI usage/kota collection rules yok.
- [ ] Payment/subscription collection rules yok.
- [ ] Cloud Functions varsayımıyla gevşek client rules yok.
- [ ] Admin bypass rule yok.
- [ ] Kalıcı delete rule yok.

## 21. AI Review Hatırlatma

Firestore rules için önerilen review promptları:

- `firestore_rules_review_prompt.md`
- `security_review_prompt.md`

Kontrol maddeleri:

- [ ] M3 rules taslağı sonrası review değerlendirildi.
- [ ] M4 create/read sonrası review değerlendirildi.
- [ ] M6 update/archive sonrası review değerlendirildi.
- [ ] M10 final rules sonrası review değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] V1 dışı öneriler parking lot’a taşındı veya reddedildi.
- [ ] Kritik güvenlik önerileri checklist/notes içine işlendi.

## 22. Development Notes Kontrolü

- [ ] Rules taslağıyla ilgili açık sorular not edildi.
- [ ] Cross-user test sonuçları not edildi.
- [ ] Malicious request sonuçları not edildi.
- [ ] Gevşek rule tespit edilirse not edildi.
- [ ] Yeni güvenlik kararı gerekirse ADR adayı olarak yazıldı.
- [ ] M10 final rules sonucu not edilecek.

## 23. Kapanış Kararı

Bu checklist tamamlandı sayılabilmesi için:

- [ ] Auth olmayan erişim reddediliyor.
- [ ] Kullanıcı path izolasyonu çalışıyor.
- [ ] ownerId create/update güvenliği sağlanıyor.
- [ ] promptText validation var.
- [ ] status validation var.
- [ ] Delete kapalı.
- [ ] Archive update olarak çalışıyor.
- [ ] Cross-user read/write testleri başarılı.
- [ ] Gevşek `request.auth != null` kuralı tek başına kullanılmıyor.
- [ ] V1 dışı public/team/payment/AI rules eklenmedi.

## 24. Kapanış Notu

Firestore rules, V1’in gerçek kapı kilididir. UI’da bir butonu gizlemek güvenlik değildir; güvenlik, başka kullanıcının verisine giden kapının Firestore seviyesinde kapalı olmasıdır.
