# M5 — Prompt Detay ve Normal Kopyala Checklist

## 1. Prompt Detay Route'u

- [x] `/library/:promptId` route'u tanımlı.
- [x] Route, `promptId` path parametresini okuyor.
- [x] Route, `PromptDetailScreen` ekranına doğru `promptId` değerini iletiyor.
- [x] `/library` route'u çalışmaya devam ediyor.
- [x] `/library/quick-add` route'u kırılmadı.

## 2. Kütüphane List Item → Detay Geçişi

- [x] Prompt library list item kullanıcı aksiyonuyla tıklanabilir.
- [x] List item tap, `RoutePaths.promptDetailLocation(prompt.id)` ile detay route'una gidiyor.
- [x] Doğru prompt id ile detay ekranı açılıyor.
- [x] Listeleme davranışı M4 kapsamındaki read/list akışını bozmuyor.

## 3. Detay Veri Okuma

- [x] Prompt detay verisi `PromptRepository.getPromptById(userId, promptId)` ile okunuyor.
- [x] Repository, data service üzerinden user-scoped prompt dokümanını okuyor.
- [x] DTO ve Firestore snapshot bilgisi presentation katmanına sızmıyor.
- [x] UI, Firestore path veya Firestore API bilmeden domain entity üzerinden render ediyor.

## 4. User Yoksa Sorgu Yapılmaması

- [x] Auth user yoksa provider repository çağrısı yapmıyor.
- [x] `promptId` boşsa provider repository çağrısı yapmıyor.
- [x] User yok/boş id durumunda detail state güvenli şekilde `null` dönüyor.

## 5. Loading / Error / Not Found / Data State

- [x] Loading state gösteriliyor.
- [x] Error state gösteriliyor.
- [x] Not found/null state gösteriliyor.
- [x] Data state başlık, prompt metni ve ilgili alanları gösteriyor.

## 6. Normal Kopyala

- [x] Detail ekranında Normal Kopyala aksiyonu var.
- [x] Normal Kopyala kullanıcı aksiyonu ile tetikleniyor.
- [x] Kopyalama sonrası kullanıcıya snackbar feedback gösteriliyor.
- [x] Clipboard davranışı widget test ile doğrulandı.

## 7. Clipboard'a Sadece `promptText` Kopyalama

- [x] Clipboard'a yalnızca `promptText` gönderiliyor.
- [x] Başlık, açıklama, not, kategori, etiket, status veya metadata kopyalanmıyor.
- [x] Değişkenli kopyala-doldur akışı M5'e eklenmedi.

## 8. Kopyalama Sonrası Firestore Write Yapılmaması

- [x] Normal Kopyala akışında repository write çağrısı yok.
- [x] Normal Kopyala akışında service write çağrısı yok.
- [x] Normal Kopyala akışında `createPrompt`, `updatePrompt`, `set`, `update` veya `delete` çağrısı yok.

## 9. `updatedAt` / `usageCount` / `lastUsedAt`

- [x] Normal Kopyala `updatedAt` değiştirmiyor.
- [x] `usageCount` eklenmedi.
- [x] `lastUsedAt` eklenmedi.
- [x] Usage analytics davranışı eklenmedi.

## 10. M5 Kapsam Dışı Özellikler

- [x] Prompt düzenleme eklenmedi.
- [x] Status değiştirme eklenmedi.
- [x] Arşivleme eklenmedi.
- [x] Kalıcı silme eklenmedi.
- [x] Detaylı Ekle eklenmedi.
- [x] Arama / filtreleme eklenmedi.
- [x] Değişkenli kopyala-doldur eklenmedi.
- [x] Version history eklenmedi.
- [x] AI özellikleri eklenmedi.
- [x] Import/export eklenmedi.

## 11. Mimari Sınır

- [x] UI/app katmanında doğrudan `FirebaseFirestore` kullanılmıyor.
- [x] UI/app katmanında doğrudan `FirebaseAuth` kullanılmıyor.
- [x] Presentation tarafına DTO, snapshot veya Firestore path sızmadı.
- [x] Akış Screen → Provider → Repository → Service → Firebase çizgisinde.

## 12. Analyze / Test Sonucu

- [x] `flutter analyze` temiz geçti.
- [x] `flutter test` temiz geçti.
- [x] Test sonucu: 53/53 geçti.
- [x] Kod audit'inde blocker bulunmadı.

## 13. Manuel Smoke Test Alanı

- [ ] Login ol.
- [ ] Prompt ekle.
- [ ] Library list item'a dokun.
- [ ] Detail ekranının doğru prompt ile açıldığını kontrol et.
- [ ] Normal Kopyala'ya dokun.
- [ ] Başka yere yapıştır.
- [ ] Sadece `promptText` yapıştırıldığını doğrula.
- [ ] Firestore'da `updatedAt` değişmediğini kontrol et.
- [ ] Firestore'da `usageCount` oluşmadığını/değişmediğini kontrol et.
- [ ] Firestore'da `lastUsedAt` oluşmadığını/değişmediğini kontrol et.

## 14. Kapanış Kararı

- [x] M5 kod audit'i temiz.
- [x] M5 kapsam sızıntısı yok.
- [x] M5 kapanabilir.
- [x] M6 aşamasına geçilebilir.
