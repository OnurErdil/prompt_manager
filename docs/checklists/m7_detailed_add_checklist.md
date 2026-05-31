# M7 — Detaylı Ekle Checklist

## 1. Route

- [x] `/library/detailed-add` route'u eklendi.
- [x] RouteNames ve RoutePaths içinde düzenli tanımlandı.
- [x] `/library` route'u korunuyor.
- [x] `/library/quick-add` route'u korunuyor.
- [x] `/library/:promptId` route'u korunuyor.
- [x] `/library/:promptId/edit` route'u korunuyor.

## 2. Library Navigation

- [x] Kütüphane ekranından Detaylı Ekle ekranına geçiş eklendi.
- [x] Boş kütüphane durumunda Detaylı Ekle aksiyonu var.
- [x] Hızlı Ekle FAB davranışı korundu.
- [x] Kütüphane list item → detay geçişi bozulmadı.

## 3. Detailed Add Screen

- [x] Detaylı Ekle ayrı ekran olarak eklendi.
- [x] Kayıt başarılı olunca kullanıcı library ekranına dönüyor.
- [x] Kayıt sırasında loading state gösteriliyor.
- [x] Kayıt hatasında kullanıcıya feedback veriliyor.

## 4. Form Fields

- [x] `title` alanı var.
- [x] `promptText` alanı var.
- [x] `description` alanı var.
- [x] `notes` alanı var.
- [x] `category` alanı var.
- [x] `tags` alanı var.
- [x] `status` alanı var.

## 5. promptText Validation

- [x] `promptText` zorunlu.
- [x] `promptText.trim()` boşsa kayıt engelleniyor.
- [x] Boş promptText için validation testi var.

## 6. Trim Behavior

- [x] `title` trim ediliyor.
- [x] `promptText` trim ediliyor.
- [x] `description` trim ediliyor.
- [x] `notes` trim ediliyor.
- [x] `category` trim ediliyor.

## 7. Tags Parse

- [x] Tags virgülle split ediliyor.
- [x] Her tag trim ediliyor.
- [x] Boş tag'ler filtreleniyor.
- [x] Tags sonucu `string[]` olarak kaydediliyor.

## 8. Variables Parse

- [x] `variables`, `PromptVariableParser` ile `promptText` üzerinden otomatik çıkarılıyor.
- [x] Variables parse davranışı controller testinde doğrulandı.

## 9. Status Selection

- [x] Status seçilebilir.
- [x] `raw` seçeneği var.
- [x] `needs_edit` seçeneği var.
- [x] `ready` seçeneği var.
- [x] `archived` seçeneği var.
- [x] Status selection davranışı test edildi.

## 10. Firestore Create Rules

- [x] Create yalnızca authenticated owner için açık.
- [x] `ownerId`, `request.auth.uid` ile eşleşmek zorunda.
- [x] Canonical key kontrolü korunuyor.
- [x] Extra alanlar engelleniyor.
- [x] `promptText` non-empty string olmak zorunda.
- [x] `schemaVersion == 1` kontrolü korunuyor.
- [x] Create status kontrolü `isValidStatus(request.resource.data.status)` ile yapılıyor.
- [x] Delete kapalı.
- [x] Update rules bozulmadı.
- [x] Global fallback deny korunuyor.

## 11. Firebase Console Publish

- [x] Firestore rules Firebase Console üzerinden publish edildi.
- [x] Firebase CLI/PATH konusu M10 final security review öncesi operasyonel park notu olarak izlenecek.

## 12. Live Create Test

- [x] Canlı create testi başarılı oldu.
- [x] Seçilebilir status davranışı canlı rules ile uyumlu hale getirildi.

## 13. Architecture Boundary

- [x] UI doğrudan Firebase Auth kullanmıyor.
- [x] UI doğrudan Firebase Firestore kullanmıyor.
- [x] Presentation tarafına DTO, snapshot veya Firestore path sızmadı.
- [x] Akış Screen → Provider/Controller → Repository → Service → Firebase çizgisinde.
- [x] M6 edit controller yapısına benzer sade controller yaklaşımı kullanıldı.

## 14. Tests

- [x] Detaylı Ekle controller testi eklendi.
- [x] Detaylı Ekle screen/widget testi eklendi.
- [x] `promptText` boş validation testi var.
- [x] Tags split/trim/empty filter testi var.
- [x] Variables parse testi var.
- [x] Status seçimi testi var.
- [x] Başarılı kayıt sonrası library yönlendirme testi var.
- [x] `flutter analyze` başarılı.
- [x] `flutter test` başarılı.

## 15. Manual Test

- [x] Login ol.
- [x] Prompt Kütüphanesi'ni aç.
- [x] Detaylı Ekle ekranına gir.
- [x] `promptText` boşken kaydetmeyi dene ve validation gör.
- [x] Title, promptText, description, notes, category ve tags alanlarını doldur.
- [x] Status seç.
- [x] Kaydet.
- [x] Library ekranına dönüldüğünü kontrol et.
- [x] Yeni prompt'un library'de göründüğünü kontrol et.
- [x] Firestore doküman alanlarını kontrol et.

## 16. Scope Leak Control

- [x] AI öneri eklenmedi.
- [x] Import/export eklenmedi.
- [x] Koleksiyon eklenmedi.
- [x] Version history eklenmedi.
- [x] `usageCount` eklenmedi.
- [x] `lastUsedAt` eklenmedi.
- [x] Kalıcı delete eklenmedi.
- [x] Arama / filtreleme eklenmedi.
- [x] Değişkenli kopyala-doldur eklenmedi.
- [x] Gelişmiş tag/category yönetimi eklenmedi.

## 17. Commit / Push / Clean Git Status

- [x] Commit tamamlandı.
- [x] Push tamamlandı.
- [x] `git status --short` boş.

## 18. Kapanış Kararı

- [x] M7 kapanabilir.
- [x] M8 — Arama / Filtreleme sıradaki milestone olarak işaretlendi.
