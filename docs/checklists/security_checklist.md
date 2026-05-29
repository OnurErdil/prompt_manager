# Security Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1’de güvenlik ve kullanıcı verisi izolasyonunun doğru şekilde korunup korunmadığını kontrol etmek için kullanılır.

Ana güvenlik ilkesi:

> Her kullanıcı yalnızca kendi prompt verilerini okuyabilmeli ve değiştirebilmelidir.

V1’de güvenlik yalnızca Firestore rules meselesi değildir. Auth, `ownerId`, repository/service sınırı, UI davranışı, client tarafında secret tutulmaması ve V1 dışı AI/backend özelliklerinin sızmaması birlikte kontrol edilmelidir.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- M1 sonunda Auth akışı kontrol edilirken,
- M3 sonunda Firestore data layer ve ilk rules taslağı hazırlandığında,
- M4 sonunda create/read kullanıcı izolasyonu test edilirken,
- M6 sonunda update/archive güvenliği kontrol edilirken,
- M10 final V1 güvenlik kapanışında,
- Dış AI security review alınmadan önce veya sonra.

## 3. Bağlı Belgeler

- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `ADR-010-archive-instead-of-delete-v1.md`
- `firestore_rules_checklist.md`
- `architecture_boundary_checklist.md`
- `scope_leak_checklist.md`

## 4. Ana Güvenlik İlkeleri

- [ ] Auth olmayan kullanıcı prompt verisi okuyamaz.
- [ ] Auth olmayan kullanıcı prompt verisi oluşturamaz.
- [ ] Auth olmayan kullanıcı prompt verisi güncelleyemez.
- [ ] Auth olmayan kullanıcı prompt verisi silemez.
- [ ] Kullanıcı yalnızca kendi promptlarını okuyabilir.
- [ ] Kullanıcı yalnızca kendi promptlarını oluşturabilir.
- [ ] Kullanıcı yalnızca kendi promptlarını güncelleyebilir.
- [ ] Kullanıcı başka kullanıcının promptlarını göremez.
- [ ] Kullanıcı başka kullanıcının promptlarını değiştiremez.
- [ ] V1’de kalıcı delete kapalıdır.
- [ ] AI API key client tarafında tutulmaz.
- [ ] V1’de AI Gateway veya AI provider bağlantısı yoktur.

## 5. Auth Güvenliği Kontrolü

- [ ] Firebase Auth kullanılıyor.
- [ ] Kullanıcı giriş yapmadan korumalı alana erişemiyor.
- [ ] Kullanıcı çıkış yaptıktan sonra korumalı alana erişemiyor.
- [ ] AuthGate giriş durumuna göre doğru yönlendirme yapıyor.
- [ ] Login/Register ekranları kalıcı güvenlik kararlarını tek başına yönetmiyor.
- [ ] Auth state merkezi biçimde izleniyor.
- [ ] Auth hataları kullanıcıya anlaşılır şekilde gösteriliyor.
- [ ] Auth hata mesajlarında gereksiz teknik detay sızmıyor.
- [ ] Auth olmayan kullanıcı Firestore query başlatamıyor veya rules tarafından engelleniyor.

## 6. Firestore Path Güvenliği

V1 path kararı:

```text
users/{userId}/prompts/{promptId}
```

Kontrol maddeleri:

- [ ] Promptlar `users/{uid}/prompts/{promptId}` altında tutuluyor.
- [ ] Kullanıcı yalnızca kendi `uid` path’iyle işlem yapıyor.
- [ ] Service/repository yanlış UID path’i kullanmıyor.
- [ ] UI Firestore path bilgisini bilmiyor.
- [ ] Kullanıcı başka UID path’ine read yapamıyor.
- [ ] Kullanıcı başka UID path’ine create yapamıyor.
- [ ] Kullanıcı başka UID path’ine update yapamıyor.
- [ ] Collection yapısı V1 kişisel kullanım modeliyle uyumlu.
- [ ] Team/workspace/public path yapıları V1’e eklenmedi.

## 7. OwnerId Güvenliği

- [ ] Her PromptCard `ownerId` alanı taşıyor.
- [ ] `ownerId`, auth kullanıcısının uid değeriyle uyumlu.
- [ ] Create sırasında `ownerId == request.auth.uid` kontrol ediliyor.
- [ ] Update sırasında `ownerId` değiştirilemiyor.
- [ ] Client’ın farklı `ownerId` gönderme denemesi reddediliyor.
- [ ] `ownerId` kullanıcı tarafından düzenlenebilir alan olarak gösterilmiyor.
- [ ] DTO / Mapper dönüşümünde `ownerId` korunuyor.
- [ ] Export/import ileride gündeme gelirse `ownerId` sahiplik ilkesi yeniden ele alınacak şekilde not edildi.

## 8. Firestore Rules Genel Kontrolü

- [ ] Rules auth olmayan read’i reddediyor.
- [ ] Rules auth olmayan create’i reddediyor.
- [ ] Rules auth olmayan update’i reddediyor.
- [ ] Rules delete’i V1’de reddediyor.
- [ ] Rules `request.auth.uid == userId` kontrolü yapıyor.
- [ ] Rules create sırasında `ownerId` doğruluyor.
- [ ] Rules update sırasında `ownerId` değişimini engelliyor.
- [ ] Rules `promptText` boş kayıtları engelliyor.
- [ ] Rules `status` değerini izin verilen key’lerle sınırlıyor.
- [ ] Rules `schemaVersion` varlığını kontrol edecek şekilde planlandı veya değerlendirildi.
- [ ] Rules `schemaVersion == 1` kontrolünü içeriyor veya final review için açık not olarak tutuluyor.
- [ ] Rules `tags` alanını array/list olarak kontrol ediyor.
- [ ] Rules `variables` alanını array/list olarak kontrol ediyor.
- [ ] Rules `title`, `description`, `notes` ve `category` alanlarını string veya null olarak kabul edecek şekilde planlandı.
- [ ] Rules create sırasında document id ile `id` alanı uyumunu kontrol ediyor veya final review için değerlendiriyor.
- [ ] Rules aşırı gevşek değil.

Özellikle şu yaklaşım tek başına yeterli değildir:

```text
allow read, write: if request.auth != null;
```

Bu kural yalnızca kullanıcının giriş yapmış olmasını kontrol eder, kullanıcı izolasyonunu garanti etmez.

## 9. Create Güvenliği

- [ ] Kullanıcı authenticated değilse create reddediliyor.
- [ ] Kullanıcı yalnızca kendi path’inde create yapabiliyor.
- [ ] Create sırasında `ownerId` auth UID ile aynı.
- [ ] Create sırasında `promptText` boş değil.
- [ ] Create sırasında `status` geçerli key.
- [ ] Create sırasında `schemaVersion` atanıyor.
- [ ] Create sırasında `createdAt` ve `updatedAt` atanıyor.
- [ ] Create sırasında kullanıcı sistem alanlarını kötüye kullanamıyor.
- [ ] Create işlemi repository/service üzerinden yapılıyor.

## 10. Read Güvenliği

- [ ] Kullanıcı authenticated değilse read reddediliyor.
- [ ] Kullanıcı yalnızca kendi promptlarını okuyabiliyor.
- [ ] Kullanıcı başka kullanıcının prompt listesini okuyamıyor.
- [ ] Kullanıcı başka kullanıcının tekil prompt detayını okuyamıyor.
- [ ] Kütüphane query’si yalnızca auth UID path’ine yapılıyor.
- [ ] UI içinde başka kullanıcı verisi gösterilmiyor.
- [ ] Arşivlenmiş promptlar yalnızca sahibine görünür.
- [ ] Hata durumunda başka kullanıcı verisi fallback olarak gösterilmiyor.

## 11. Update Güvenliği

- [ ] Kullanıcı authenticated değilse update reddediliyor.
- [ ] Kullanıcı yalnızca kendi promptunu güncelleyebiliyor.
- [ ] Kullanıcı başka kullanıcının promptunu güncelleyemiyor.
- [ ] Update sırasında `ownerId` değiştirilemiyor.
- [ ] Update sırasında `createdAt` değiştirilemiyor.
- [ ] Update sırasında `promptText` boş bırakılamıyor.
- [ ] Update sırasında `status` geçerli key olarak kalıyor.
- [ ] Update sırasında `updatedAt` güncelleniyor.
- [ ] Update işlemi repository/service üzerinden yapılıyor.
- [ ] UI doğrudan Firestore update çağırmıyor.

## 12. Archive / Delete Güvenliği

V1 kararı:

```text
status: archived
```

Kontrol maddeleri:

- [ ] Arşivleme delete işlemi değildir.
- [ ] Arşivleme `status: archived` update’i olarak çalışır.
- [ ] V1’de kalıcı delete butonu yok.
- [ ] Firestore rules delete’i reddediyor.
- [ ] Repository V1’de kalıcı delete operasyonu sunmuyor.
- [ ] UI kullanıcıya “kalıcı sil” davranışı sunmuyor.
- [ ] Arşivlenen prompt yalnızca sahibine görünür.
- [ ] Arşivden çıkarma ileride eklenirse yine update güvenliğiyle kontrol edilecek.

## 13. Client Secret / API Key Kontrolü

- [ ] AI API key client tarafında yok.
- [ ] OpenAI / Gemini / Claude / Mistral key client tarafında yok.
- [ ] Keystore, private key, service account gibi secret dosyalar repo’ya eklenmedi.
- [ ] Local gizli değerler `.gitignore` ile korunuyor.
- [ ] PowerShell script secret/config üretmiyor.
- [ ] Firebase client config ile gizli server secret’lar birbirine karıştırılmadı.
- [ ] V2 AI Gateway gelene kadar client tarafında AI provider bağlantısı kurulmadı.

## 14. Mimari Güvenlik Sınırı

- [ ] UI içinde `FirebaseAuth.instance` yok.
- [ ] UI içinde `FirebaseFirestore.instance` yok.
- [ ] Screen/widget Firestore path bilmiyor.
- [ ] Provider/Notifier repository çağırıyor.
- [ ] Repository service çağırıyor.
- [ ] Service Firebase ile konuşuyor.
- [ ] DTO presentation katmanına sızmadı.
- [ ] Domain model Firebase tiplerine bağımlı değil.
- [ ] Güvenlik kontrolü yalnızca UI gizlemesine bırakılmadı.
- [ ] Firestore rules gerçek güvenlik kapısı olarak kullanılıyor.

## 15. Veri Modeli Güvenliği

- [ ] `id` sistem tarafından atanıyor.
- [ ] `ownerId` sistem/Auth tarafından atanıyor.
- [ ] `promptText` boş olamaz.
- [ ] `status` teknik key olarak saklanıyor.
- [ ] `status` izin verilen değerlerden biri.
- [ ] `tags` güvenli string listesi.
- [ ] `variables` güvenli string listesi.
- [ ] `schemaVersion` var.
- [ ] `createdAt` kullanıcı tarafından manipüle edilemeyecek şekilde planlandı.
- [ ] `updatedAt` anlamlı güncellemelerde sistem tarafından yönetiliyor.
- [ ] V1 dışı hassas veya gereksiz alanlar modele eklenmedi.

## 16. Error Handling Güvenliği

- [ ] Permission denied hatası uygulamayı çökertmiyor.
- [ ] Network hatası uygulamayı çökertmiyor.
- [ ] Auth hataları anlaşılır gösteriliyor.
- [ ] Firestore hata mesajları ham teknik detaylarla kullanıcıya gösterilmiyor.
- [ ] Hata mesajları başka kullanıcı verisini ifşa etmiyor.
- [ ] Loglarda secret/API key yok.
- [ ] Debug loglarında kullanıcı prompt içeriği gereksiz şekilde yazdırılmıyor veya üretim için kontrol ediliyor.

## 17. Cihaz / Platform Güvenlik Kontrolü

- [ ] Gerçek Android cihazda logout sonrası korumalı ekran erişimi kontrol edildi.
- [ ] Geri tuşu ile logout sonrası korumalı ekrana dönülemiyor.
- [ ] Uygulama yeniden açıldığında AuthGate doğru davranıyor.
- [ ] Kayıt/giriş ekranlarında klavye ve autofill davranışı temel düzeyde kontrol edildi.
- [ ] Clipboard kullanımı yalnızca kullanıcı aksiyonu ile yapılıyor.
- [ ] Kopyalanan prompt verisinin sistem clipboard’unda kalacağı kullanıcı deneyimi açısından kabul edildi veya ileride not edilecek.

## 18. Scope Leak Güvenlik Kontrolü

V1’de aşağıdaki güvenlik/altyapı yüzeyleri eklenmemiş olmalı:

- [ ] AI Gateway yok.
- [ ] AI API provider bağlantısı yok.
- [ ] Payment backend yok.
- [ ] Subscription backend yok.
- [ ] AI quota backend yok.
- [ ] Public sharing yok.
- [ ] Team/workspace permission sistemi yok.
- [ ] Admin panel yok.
- [ ] Cloud Functions yok.
- [ ] Firestore triggers yok.
- [ ] Public read rule yok.
- [ ] Kalıcı delete yok.

## 19. Manuel Güvenlik Test Senaryoları

### Auth olmayan kullanıcı

- [ ] Prompt listesi okuyamaz.
- [ ] Prompt oluşturamaz.
- [ ] Prompt güncelleyemez.
- [ ] Prompt silemez.

### Kullanıcı A

- [ ] Kendi promptunu oluşturabilir.
- [ ] Kendi promptunu okuyabilir.
- [ ] Kendi promptunu güncelleyebilir.
- [ ] Kendi promptunu arşivleyebilir.
- [ ] Kullanıcı B’nin promptunu okuyamaz.
- [ ] Kullanıcı B’nin promptunu güncelleyemez.
- [ ] Kullanıcı B’nin path’ine kayıt atamaz.

### Malicious veri

- [ ] Farklı `ownerId` ile create denemesi reddedilir.
- [ ] `ownerId` değiştirme update’i reddedilir.
- [ ] Başka `userId` path’ine create denemesi reddedilir.
- [ ] Başka `userId` path’inde read/update denemesi reddedilir.
- [ ] Document id ile veri içindeki `id` uyuşmazlığı reddedilir veya final rules review’da karara bağlanır.
- [ ] Boş `promptText` reddedilir.
- [ ] Geçersiz `status` reddedilir.
- [ ] `schemaVersion` 1 değilse reddedilir.
- [ ] `tags` veya `variables` array/list değilse reddedilir.
- [ ] Delete isteği reddedilir.

## 20. AI Review Hatırlatma

Güvenlik review için önerilen promptlar:

- `security_review_prompt.md`
- `firestore_rules_review_prompt.md`
- `scope_guard_review_prompt.md`

Kullanım zamanları:

- [ ] M3 sonunda rules taslağı için review değerlendirildi.
- [ ] M4 sonunda create/read izolasyonu için review değerlendirildi.
- [ ] M6 sonunda update/archive için review değerlendirildi.
- [ ] M10 final güvenlik kapanışı için review değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] V1 dışı öneriler parking lot’a taşındı veya reddedildi.
- [ ] Kritik öneriler ilgili checklist veya ADR’ye işlendi.

## 21. Development Notes Kontrolü

- [ ] Güvenlik testlerinde çıkan sorunlar `09_development_notes.md` içine yazıldı.
- [ ] Firestore rules eksikleri not edildi.
- [ ] Kullanıcı izolasyonu test sonuçları not edildi.
- [ ] Client secret / config riski varsa not edildi.
- [ ] Checklist’e eklenecek yeni güvenlik maddesi varsa not edildi.
- [ ] ADR’ye dönüşmesi gereken güvenlik kararı varsa not edildi.

## 22. Final V1 Güvenlik Kapanışı

M10 sonunda V1 güvenlik kapanışı için:

- [ ] Auth olmayan erişim reddediliyor.
- [ ] Cross-user read reddediliyor.
- [ ] Cross-user write reddediliyor.
- [ ] `ownerId` create/update güvenliği sağlanıyor.
- [ ] Delete kapalı.
- [ ] UI Firebase’e doğrudan erişmiyor.
- [ ] Client tarafında AI API key yok.
- [ ] V1 dışı payment/AI/team/public backend yok.
- [ ] Firestore rules gevşek değil.
- [ ] Cihazda logout/geri tuşu davranışı kontrol edildi.
- [ ] Güvenlik açıkları development notes’a yazıldı veya kapatıldı.

## 23. Kapanış Notu

Security checklist, V1’in sadece çalışan değil, güvenli çalışan bir çekirdek olmasını sağlamak için kullanılır. Kullanıcı verisi kale içindedir; UI ise kalenin dekoru değil, kapıya giden yoldur. Asıl kilit Firestore rules, `ownerId` ve doğru mimari sınırlarla korunur.
