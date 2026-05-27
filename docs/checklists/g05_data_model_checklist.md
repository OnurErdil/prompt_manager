# G05 — Data Model Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1’de canonical `PromptCard` veri modelinin doğru, sade, platform bağımsız ve V1 kapsamına uygun kalıp kalmadığını kontrol etmek için kullanılır.

Ana ilke:

> PromptCard, Firestore dokümanı değil, ürünün platform bağımsız canonical domain modelidir.

Bu checklist; alanlar, tipler, zorunluluklar, varsayılan değerler, validation, normalizasyon, değişken algılama, DTO/Mapper ayrımı ve V1 dışı veri alanlarının modele sızmaması için kullanılır.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- M2 — PromptCard Domain Model sonunda,
- M3 — Firestore Data Layer sonunda,
- M4 — İlk Çekirdek Akış sonunda,
- M6 — Prompt Düzenleme, Status ve Arşiv sonunda,
- M7 — Detaylı Ekle sonunda,
- V1 veri modeline yeni alan eklenmesi gündeme geldiğinde,
- Dış AI data model review sonrası.

## 3. Bağlı Belgeler

- `03_data_model.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `ADR-010-archive-instead-of-delete-v1.md`
- `g02_architecture_boundary_checklist.md`
- `g03_scope_leak_checklist.md`
- `g04_firestore_rules_checklist.md`

## 4. Canonical PromptCard Alan Kontrolü

PromptCard şu alanları içermelidir:

```text
id
ownerId
title
promptText
description
notes
category
tags
status
variables
createdAt
updatedAt
schemaVersion
```

Kontrol maddeleri:

- [ ] `id` alanı var.
- [ ] `ownerId` alanı var.
- [ ] `title` alanı var.
- [ ] `promptText` alanı var.
- [ ] `description` alanı var.
- [ ] `notes` alanı var.
- [ ] `category` alanı var.
- [ ] `tags` alanı var.
- [ ] `status` alanı var.
- [ ] `variables` alanı var.
- [ ] `createdAt` alanı var.
- [ ] `updatedAt` alanı var.
- [ ] `schemaVersion` alanı var.
- [ ] Alan listesi `03_data_model.md` ile uyumlu.

## 5. Alan Tipleri Kontrolü

- [ ] `id` string olarak ele alınıyor.
- [ ] `ownerId` string olarak ele alınıyor.
- [ ] `title` string olarak ele alınıyor.
- [ ] `promptText` string olarak ele alınıyor.
- [ ] `description` string olarak ele alınıyor.
- [ ] `notes` string olarak ele alınıyor.
- [ ] `category` string olarak ele alınıyor.
- [ ] `tags` string listesi olarak ele alınıyor.
- [ ] `status` teknik string/key olarak ele alınıyor.
- [ ] `variables` string listesi olarak ele alınıyor.
- [ ] `createdAt` tarih/zaman değeri olarak ele alınıyor.
- [ ] `updatedAt` tarih/zaman değeri olarak ele alınıyor.
- [ ] `schemaVersion` integer olarak ele alınıyor.
- [ ] Domain model Firestore `Timestamp` tipine doğrudan bağımlı değil.

## 6. Zorunlu Alan Kontrolü

V1’de tek zorunlu kullanıcı alanı:

```text
promptText
```

Kontrol maddeleri:

- [ ] `promptText` kullanıcı tarafından zorunlu girilir.
- [ ] `promptText` boş kaydedilemez.
- [ ] `promptText` sadece boşluklardan oluşuyorsa geçersiz kabul edilir.
- [ ] `id` sistem tarafından atanır.
- [ ] `ownerId` Auth sistemi tarafından atanır.
- [ ] `createdAt` sistem tarafından atanır.
- [ ] `updatedAt` sistem tarafından atanır.
- [ ] `schemaVersion` sistem tarafından atanır.
- [ ] Başlık, açıklama, not, kategori ve etiketler opsiyonel kalır.
- [ ] Hızlı Ekle yalnızca `promptText` ile kayıt oluşturabilir.

## 7. Varsayılan Değer Kontrolü

- [ ] `title` boşsa UI fallback davranışı var veya güvenli boş değer kullanılıyor.
- [ ] `description` boş string veya güvenli varsayılanla ele alınıyor.
- [ ] `notes` boş string veya güvenli varsayılanla ele alınıyor.
- [ ] `category` boş string / kategorisiz fallback ile ele alınıyor.
- [ ] `tags` boş liste olarak saklanabiliyor.
- [ ] `status` varsayılanı `raw` olarak planlandı veya net karara bağlandı.
- [ ] `variables` promptText’ten çıkarılıyor veya boş liste oluyor.
- [ ] `schemaVersion` yeni kayıtlarda `1`.
- [ ] Null değerler UI ve filtreleme tarafında hata yaratmayacak şekilde ele alınıyor.

## 8. Status Model Kontrolü

Geçerli teknik key’ler:

```text
raw
needs_edit
ready
archived
```

Kontrol maddeleri:

- [ ] `raw` geçerli status.
- [ ] `needs_edit` geçerli status.
- [ ] `ready` geçerli status.
- [ ] `archived` geçerli status.
- [ ] Geçersiz status değerleri engelleniyor.
- [ ] Status kullanıcıya görünen Türkçe label olarak saklanmıyor.
- [ ] Status UI katmanında kullanıcı diline çevrilebilir.
- [ ] `archived`, kalıcı silme değil yaşam döngüsü durumu olarak kullanılıyor.
- [ ] `deletedAt` veya `isDeleted` alanları V1 modeline eklenmedi.

## 9. Değişken Algılama Kontrolü

V1 değişken standardı:

```text
[DEĞİŞKEN_ADI]
```

Kontrol maddeleri:

- [ ] Köşeli parantez içindeki değişkenler algılanıyor.
- [ ] `[PROJE_ADI]` gibi tek değişken algılanıyor.
- [ ] Birden fazla değişken algılanıyor.
- [ ] Aynı değişken tekrar ederse `variables` listesinde bir kez tutuluyor.
- [ ] Değişkenlerin sırası ilk görülme sırasına göre korunuyor veya davranış net.
- [ ] Değişken yoksa `variables` boş liste oluyor.
- [ ] Boş parantez `[]` değişken sayılmıyor.
- [ ] Hatalı formatlar uygulamayı çökertmiyor.
- [ ] V1’de değişken tipi yok.
- [ ] V1’de varsayılan değişken değeri yok.
- [ ] V1’de zorunlu/opsiyonel değişken ayrımı yok.
- [ ] V1’de koşullu prompt blokları yok.

## 10. Tags Kontrolü

- [ ] `tags` string listesi.
- [ ] Boş tag değerleri kaydedilmiyor.
- [ ] Tag değerleri trim ediliyor veya edilecek şekilde planlandı.
- [ ] Tekrarlanan tag değerleri tekilleştiriliyor veya davranış net.
- [ ] Büyük/küçük harf normalizasyonu kararı net veya development notes’a yazıldı.
- [ ] Tag listesi null yerine boş liste olabiliyor.
- [ ] Etiketler kategori yerine geçmiyor.
- [ ] Etiketler çoklu çapraz işaretleme alanı olarak kalıyor.

## 11. Category Kontrolü

- [ ] `category` tek string alanı.
- [ ] V1’de çoklu kategori yok.
- [ ] V1’de kategori ağacı yok.
- [ ] Kategori boş olabilir veya UI’da “Kategorisiz” fallback gösterilebilir.
- [ ] Kategori filtreleme için kullanılabilir.
- [ ] Kategori ve etiket rolleri karıştırılmıyor.
- [ ] Kategori = ana raf mantığı korunuyor.

## 12. Tarih Alanları Kontrolü

- [ ] `createdAt` oluşturma anında atanıyor.
- [ ] `createdAt` kullanıcı tarafından düzenlenmiyor.
- [ ] `createdAt` update sırasında değişmiyor.
- [ ] `updatedAt` oluşturma anında atanıyor.
- [ ] `updatedAt` anlamlı değişiklikte güncelleniyor.
- [ ] Normal Kopyala `updatedAt` değiştirmiyor.
- [ ] Değişkenli Kopyala-Doldur `updatedAt` değiştirmiyor.
- [ ] Detay görüntüleme `updatedAt` değiştirmiyor.
- [ ] V1’de `lastUsedAt` yok.
- [ ] V1’de `usageCount` yok.

## 13. SchemaVersion Kontrolü

- [ ] `schemaVersion` alanı var.
- [ ] Yeni kayıtlarda `schemaVersion: 1`.
- [ ] Kullanıcı tarafından düzenlenmiyor.
- [ ] Mapper eksik schemaVersion için güvenli fallback sağlayabiliyor veya planlandı.
- [ ] Migration hazırlığı için tutuluyor.
- [ ] V1’de gelişmiş migration sistemi kurulmadı.
- [ ] Export/import ileride gündeme gelirse schemaVersion korunacak şekilde not edildi.

## 14. Firestore Bağımsızlık Kontrolü

- [ ] Domain model Firestore document snapshot bilmiyor.
- [ ] Domain model Firestore collection path bilmiyor.
- [ ] Domain model Firebase Timestamp kullanmıyor.
- [ ] Domain model Firebase Auth UID tipine bağımlı değil; ownerId string olarak ele alınıyor.
- [ ] Firestore alan dönüşümleri DTO/Mapper içinde.
- [ ] Firestore service data katmanında.
- [ ] UI Firestore dokümanını doğrudan kullanmıyor.
- [ ] PromptCard Firestore DTO yerine geçmiyor.

## 15. DTO / Mapper Kontrolü

Beklenen akış:

```text
Firestore Document ⇄ PromptCardDto ⇄ PromptCardMapper ⇄ PromptCard
```

Kontrol maddeleri:

- [ ] `PromptCardDto` var.
- [ ] `PromptCardMapper` var.
- [ ] DTO → Domain dönüşümü var.
- [ ] Domain → DTO dönüşümü var.
- [ ] Timestamp/date dönüşümleri mapper içinde.
- [ ] Eksik opsiyonel alanlara güvenli varsayılan veriliyor.
- [ ] `tags` liste dönüşümü güvenli.
- [ ] `variables` liste dönüşümü güvenli.
- [ ] `status` dönüşümü güvenli.
- [ ] `schemaVersion` dönüşümü güvenli.
- [ ] DTO presentation katmanında kullanılmıyor.

## 16. Validation Kontrolü

- [ ] Boş `promptText` geçersiz.
- [ ] Sadece boşluklardan oluşan `promptText` geçersiz.
- [ ] Geçersiz status geçersiz.
- [ ] `tags` liste olarak doğrulanıyor.
- [ ] `variables` liste olarak doğrulanıyor.
- [ ] `schemaVersion` pozitif integer.
- [ ] `ownerId` boş olamaz.
- [ ] `id` boş olamaz.
- [ ] Validation UI’a tamamen bırakılmıyor.
- [ ] Firestore rules kritik validationları ayrıca destekliyor.

## 17. Arama / Filtreleme Veri Desteği Kontrolü

V1 filtre alanları:

- `category`
- `tags`
- `status`
- `updatedAt`

Kontrol maddeleri:

- [ ] `category` filtreleme için uygun.
- [ ] `tags` array/list filtreleme için uygun.
- [ ] `status` filtreleme için uygun.
- [ ] `updatedAt` sıralama için uygun.
- [ ] Basit metin arama için `title`, `promptText`, `description`, `notes` kullanılabilir.
- [ ] V1’de embedding alanı yok.
- [ ] V1’de semanticKeywords alanı yok.
- [ ] V1’de search index alanı yok.

## 18. Arşiv Davranışı Kontrolü

- [ ] Arşiv `status: archived` ile temsil ediliyor.
- [ ] Kalıcı silme yok.
- [ ] `deletedAt` yok.
- [ ] `isDeleted` yok.
- [ ] Trash/restore alanları yok.
- [ ] Arşivlenen prompt veri olarak saklanıyor.
- [ ] Arşiv filtresiyle gösterilebilir.
- [ ] Varsayılan listede gizlenme davranışı UI/filtre tarafında ele alınabilir.

## 19. V1 Dışında Bırakılan Alanlar Kontrolü

Aşağıdaki alanlar V1 modeline eklenmemiş olmalı:

- [ ] `usageCount`
- [ ] `lastUsedAt`
- [ ] `versionHistory`
- [ ] `deletedAt`
- [ ] `isFavorite`
- [ ] `collectionId`
- [ ] `workspaceId`
- [ ] `teamId`
- [ ] `aiSummary`
- [ ] `aiScore`
- [ ] `healthScore`
- [ ] `embedding`
- [ ] `semanticKeywords`
- [ ] `modelUsed`
- [ ] `tokenUsage`
- [ ] `costEstimate`
- [ ] `shareVisibility`
- [ ] `publicUrl`
- [ ] `marketplaceStatus`

## 20. Güvenlik Veri Kontrolü

- [ ] Her PromptCard bir kullanıcıya ait.
- [ ] `ownerId` sahiplik ilkesi için kullanılıyor.
- [ ] `ownerId` değiştirilemiyor.
- [ ] Kullanıcı başka kullanıcının ownerId değeriyle kayıt oluşturamıyor.
- [ ] Secret/API key gibi değerler PromptCard içinde saklanmıyor.
- [ ] AI provider bilgileri V1 PromptCard içinde yok.
- [ ] Token/maliyet bilgileri V1 PromptCard içinde yok.
- [ ] Public sharing alanları yok.

## 21. Test Kontrolü

Önerilen test adayları:

- [ ] PromptCard oluşturma testi.
- [ ] Boş promptText validation testi.
- [ ] Status validation testi.
- [ ] Variable extraction testi.
- [ ] Tag normalization testi.
- [ ] DTO → Domain mapper testi.
- [ ] Domain → DTO mapper testi.
- [ ] Eksik alan fallback testi.
- [ ] schemaVersion fallback testi.
- [ ] Archive status testi.

## 22. AI Review Hatırlatma

Data model review için önerilen promptlar:

- `data_model_review_prompt.md`
- Gerekirse `architecture_review_prompt.md`
- Gerekirse `scope_guard_review_prompt.md`

Kontrol maddeleri:

- [ ] M2 sonunda data model review değerlendirildi.
- [ ] M3 sonunda DTO/Mapper review değerlendirildi.
- [ ] Yeni alan eklenmek istendiğinde review veya scope check değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] V1 dışı alan önerileri parking lot’a taşındı veya reddedildi.
- [ ] Kabul edilen öneriler ilgili docs/checklist’e işlendi.

## 23. Development Notes Kontrolü

- [ ] Veri modeliyle ilgili açık sorular development notes’a yazıldı.
- [ ] Category fallback kararı gerekiyorsa not edildi.
- [ ] Title fallback kararı gerekiyorsa not edildi.
- [ ] Tag normalization kararı gerekiyorsa not edildi.
- [ ] Variable extraction davranışıyla ilgili karar not edildi.
- [ ] Yeni alan önerileri parking lot’a taşındı veya reddedildi.
- [ ] ADR’ye dönüşmesi gereken veri kararı varsa not edildi.

## 24. Kapanış Kararı

Bu checklist tamamlandı sayılabilmesi için:

- [ ] PromptCard canonical alanları eksiksiz.
- [ ] Model Firestore’dan bağımsız.
- [ ] promptText tek zorunlu kullanıcı alanı.
- [ ] status key’leri doğru.
- [ ] variables standardı doğru.
- [ ] DTO/Mapper ayrımı korunuyor.
- [ ] ownerId güvenliği destekleniyor.
- [ ] V1 dışı AI/analytics/team/version/delete alanları modele sızmadı.
- [ ] Veri modeli V1 ana akışını destekliyor.

## 25. Kapanış Notu

Data model checklist, ürünün kemik yapısını kontrol eder. V1’de kemik sade kalmalı; ileride kas ekleriz. Şimdiden fazladan uzuv eklersek ürün yürümek yerine sendelemeye başlar.
