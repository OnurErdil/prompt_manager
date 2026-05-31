# M6 — Prompt Düzenleme / Status / Arşiv Checklist

## 1. Kapsam Uyumu

- [x] `/library/:promptId/edit` route'u eklendi.
- [x] Detay ekranından düzenleme ekranına geçiş eklendi.
- [x] Başarılı kayıt sonrası kullanıcı prompt detay ekranına dönüyor.
- [x] Prompt edit ekranı eklendi.
- [x] Başlık düzenlenebiliyor.
- [x] Prompt metni düzenlenebiliyor.
- [x] Açıklama düzenlenebiliyor.
- [x] Notlar düzenlenebiliyor.
- [x] Kategori düzenlenebiliyor.
- [x] Tags virgül ayrımlı input ile düzenlenebiliyor.
- [x] Tags split, trim ve empty filter davranışı uygulanıyor.
- [x] Status dropdown ile değiştirilebiliyor.
- [x] `promptText` boşsa kayıt engelleniyor.
- [x] `promptText` değişince `variables` yeniden parse ediliyor.
- [x] `updatedAt` kayıt sırasında yenileniyor.
- [x] `id`, `ownerId`, `createdAt`, `schemaVersion` korunuyor.
- [x] Arşiv ayrı delete aksiyonu değil, `status: archived` davranışı.
- [x] Archived promptlar M8 filtreleme gelene kadar kütüphanede görünmeye devam ediyor.

## 2. Mimari Sınır

- [x] UI/app katmanında doğrudan `FirebaseFirestore` kullanılmıyor.
- [x] UI/app katmanında doğrudan `FirebaseAuth` kullanılmıyor.
- [x] Presentation tarafına DTO, snapshot veya Firestore path sızmadı.
- [x] Akış Screen → Provider/Controller → Repository → Service → Firebase çizgisinde.
- [x] Mevcut repository/service yapısı bozulmadı.
- [x] Riverpod legacy kullanım paterni korunuyor.

## 3. Firestore Rules Güvenliği

- [x] Update yalnızca authenticated owner için açık.
- [x] Create yalnızca authenticated owner için açık.
- [x] Read yalnızca authenticated owner için açık.
- [x] Canonical PromptCard alan kontrolü var.
- [x] Extra alanlar engelleniyor.
- [x] Legacy extra alanlı eski dokümanlar edit sırasında canonical `set()` ile temizleniyor.
- [x] `ownerId` değiştirilemiyor.
- [x] `createdAt` değiştirilemiyor.
- [x] `schemaVersion` değiştirilemiyor.
- [x] `schemaVersion` `1` kalıyor.
- [x] `promptText` non-empty string olmak zorunda.
- [x] Status yalnızca `raw`, `needs_edit`, `ready`, `archived` olabilir.
- [x] `updatedAt` timestamp olmalı ve eski değerden farklı olmalı.
- [x] Delete kapalı.
- [x] Global fallback deny korunuyor.
- [x] Rules Firebase Console üzerinden publish edildi.
- [x] Canlı edit testi başarılı oldu.

## 4. Manuel Test

- [x] Kendi promptunu düzenleme canlı testte başarılı.
- [x] Firestore rules publish sonrası edit kaydı başarılı.
- [ ] `promptText` boş validation gerçek cihazda tekrar kontrol edilecek.
- [ ] Tags virgül split/trim/empty filter gerçek cihazda tekrar kontrol edilecek.
- [ ] `promptText` değişince variables yeniden parse davranışı Firestore dokümanında kontrol edilecek.
- [ ] Status `archived` seçip kaydetme Firestore dokümanında kontrol edilecek.
- [ ] Archived promptun M8'e kadar library'de görünmeye devam ettiği kontrol edilecek.
- [ ] Başka kullanıcı verisine erişim/update engeli manuel veya emulator ile kontrol edilecek.
- [ ] Delete reddi manuel veya emulator ile kontrol edilecek.
- [ ] Edit sonrası detay ekranında güncel veri görünmesi tekrar kontrol edilecek.

## 5. Analyze / Test

- [x] `flutter analyze` temiz geçti.
- [x] `flutter test` temiz geçti.
- [x] Test sonucu: 62/62 geçti.

## 6. Kapsam Dışı Sızıntı Kontrolü

- [x] Kalıcı silme eklenmedi.
- [x] Version history eklenmedi.
- [x] Usage analytics eklenmedi.
- [x] `lastUsedAt` eklenmedi.
- [x] `usageCount` eklenmedi.
- [x] Değişkenli kopyala-doldur eklenmedi.
- [x] Detaylı Ekle eklenmedi.
- [x] Arama / filtreleme eklenmedi.
- [x] AI özellikleri eklenmedi.
- [x] Import/export eklenmedi.
- [x] Koleksiyonlar eklenmedi.
- [x] Gelişmiş tag yönetimi eklenmedi.
- [x] Gelişmiş kategori koleksiyonu eklenmedi.
- [x] Prompt Health Check eklenmedi.

## 7. Park Notları

- [ ] Firebase CLI/PATH ve rules deploy komutu operasyonel olarak çözülmeli.
- [ ] M10 final security review sırasında Firestore rules tekrar gözden geçirilmeli.
- [ ] V1.5/V2'de server-owned alanlar eklenirse `set()` ile canonical replace davranışı tekrar değerlendirilmeli.

## 8. Kapanış Kararı

- [x] M6 kod audit'i tamamlandı.
- [x] M6 canlı edit testi başarılı.
- [x] M6 kapsam sızıntısı görülmedi.
- [x] M6 kapanabilir.
- [x] M7 aşamasına geçilebilir.
