# M8 — Arama / Filtreleme Checklist

## Kapsam

- [x] Library ekranına client-side arama alanı eklendi.
- [x] Arama `title`, `promptText`, `description`, `notes`, `category` ve `tags` alanlarında çalışıyor.
- [x] Status filtresi eklendi: Aktif, `raw`, `needs_edit`, `ready`, `archived`.
- [x] Varsayılan Aktif görünüm `archived` promptları gizliyor.
- [x] `archived` filtresi yalnızca archived promptları gösteriyor.
- [x] Category seçenekleri mevcut promptların `category` alanından türetiliyor.
- [x] Tag seçenekleri mevcut promptların `tags` alanından türetiliyor.
- [x] Boş/whitespace category ve tag değerleri seçeneklerden çıkarılıyor.
- [x] Category ve tag seçenekleri trim ediliyor, tekilleştiriliyor ve alfabetik sıralanıyor.
- [x] Arama, status, category ve tag filtreleri birlikte çalışıyor.
- [x] Filtreleri temizle aksiyonu default Aktif state'e dönüyor.
- [x] Ham kütüphane boşsa mevcut empty library state korunuyor.
- [x] Filtre sonucu boşsa ayrı empty result state gösteriliyor.
- [x] Prompt detayına geçiş davranışı korundu.
- [x] Hızlı Ekle ve Detaylı Ekle aksiyonları korundu.

## Mimari / Scope

- [x] Ham prompt listesi `currentUserPromptsProvider` üzerinden gelmeye devam ediyor.
- [x] Firestore query / repository / service davranışı değiştirilmedi.
- [x] UI doğrudan Firebase Auth veya Firestore kullanmıyor.
- [x] Arama / filtreleme presentation/provider katmanında tutuldu.
- [x] AI arama, semantik arama, external search veya Firestore full-text search eklenmedi.
- [x] Category CRUD, tag yönetim ekranı ve saved filters eklenmedi.
- [x] usageCount, lastUsedAt, import/export veya değişkenli kopyala-doldur eklenmedi.

## Test

- [x] Default listede archived promptların görünmediği test edildi.
- [x] Archived filtresi seçilince archived promptların göründüğü test edildi.
- [x] Raw / needs_edit / ready status filtreleri test edildi.
- [x] Title araması test edildi.
- [x] Prompt text araması test edildi.
- [x] Description / notes / category / tags araması test edildi.
- [x] Category filtresi test edildi.
- [x] Tag filtresi test edildi.
- [x] Arama + filtre kombinasyonu test edildi.
- [x] Clear filters davranışı test edildi.
- [x] Empty library state'in korunduğu test edildi.
- [x] Empty result state test edildi.
- [x] Detail navigation davranışı test edildi.
- [x] Hızlı Ekle ve Detaylı Ekle aksiyonları test edildi.
