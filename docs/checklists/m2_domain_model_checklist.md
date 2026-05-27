# M2 — Domain Model Checklist

## 1. Amaç

Bu checklist, **M2 — PromptCard Domain Model** milestone’unun doğru şekilde tamamlanıp tamamlanmadığını kontrol etmek için kullanılır.

M2’nin amacı, Prompt Yönetim Aracı’nın ana ürün varlığı olan `PromptCard` modelini Firebase’den bağımsız, test edilebilir ve V1 kapsamına uygun şekilde kurmaktır.

Bu milestone sonunda `PromptCard` modeli, status key’leri, değişken algılama mantığı, temel validation yaklaşımı ve repository interface yönü netleşmiş olmalıdır.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- PromptCard domain modeli oluşturulurken,
- Status key’leri tanımlanırken,
- Variable extraction helper hazırlanırken,
- Repository interface tasarlanırken,
- M3 — Data Layer ve Firestore Bağlantısı aşamasına geçmeden önce.

## 3. Bağlı Belgeler

- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `data_model_checklist.md`
- `architecture_boundary_checklist.md`
- `scope_leak_checklist.md`

## 4. Ön Koşullar

- [ ] M1 — App Shell, Routing ve Auth tamamlandı.
- [ ] AuthGate temel akışı çalışıyor.
- [ ] `features/prompts` klasör yapısı hazır.
- [ ] `03_data_model.md` belgesi referans olarak hazır.
- [ ] PromptCard canonical alanları kilitli.
- [ ] V1’de Firestore DTO’sunun domain model olmayacağı kabul edildi.

## 5. PromptCard Model Kontrolü

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

- [ ] `PromptCard` domain modeli oluşturuldu.
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
- [ ] Model alanları `03_data_model.md` ile uyumlu.

## 6. Platform Bağımsızlık Kontrolü

- [ ] `PromptCard` modeli Firestore document snapshot tiplerine bağımlı değil.
- [ ] `PromptCard` modeli Firebase `Timestamp` tipine bağımlı değil.
- [ ] `PromptCard` modeli Firebase Auth tiplerine bağımlı değil.
- [ ] Domain model içinde Firestore collection path bilgisi yok.
- [ ] Domain model içinde DTO dönüşüm kodu yok.
- [ ] Domain model içinde UI state bilgisi yok.
- [ ] Domain model, başka backend’e taşınabilir yapıda.

## 7. Zorunlu Alan Kontrolü

- [ ] V1’de tek zorunlu kullanıcı alanının `promptText` olduğu korunuyor.
- [ ] `promptText` boş olamaz kuralı tanımlandı.
- [ ] `ownerId` sistem/Auth tarafından atanacak alan olarak ele alındı.
- [ ] `id` sistem tarafından atanacak alan olarak ele alındı.
- [ ] `createdAt`, `updatedAt`, `schemaVersion` sistem alanları olarak ele alındı.
- [ ] Kullanıcı Hızlı Ekle’de sadece `promptText` ile kayıt oluşturabilecek şekilde model tasarlandı.

## 8. Status Kontrolü

Geçerli teknik status key’leri:

```text
raw
needs_edit
ready
archived
```

Kontrol maddeleri:

- [ ] `raw` status değeri tanımlandı.
- [ ] `needs_edit` status değeri tanımlandı.
- [ ] `ready` status değeri tanımlandı.
- [ ] `archived` status değeri tanımlandı.
- [ ] Geçersiz status değerleri engellenecek şekilde validation planlandı.
- [ ] Kullanıcıya görünen Türkçe label’lar domain modelin içinde sabitlenmedi.
- [ ] Çoklu dil desteği için teknik key yaklaşımı korundu.
- [ ] `archived` kalıcı silme değil, yaşam döngüsü durumu olarak ele alındı.

## 9. Değişken Algılama Kontrolü

V1 değişken standardı:

```text
[DEĞİŞKEN_ADI]
```

Kontrol maddeleri:

- [ ] Değişken algılama helper/utility fonksiyonu planlandı veya oluşturuldu.
- [ ] `[PROJE_ADI]` gibi değişkenler algılanıyor.
- [ ] Birden fazla değişken algılanabiliyor.
- [ ] Aynı değişken tekrar ederse tekilleştiriliyor.
- [ ] Değişkenlerin ilk görülme sırası korunabiliyor veya davranış net.
- [ ] Değişken yoksa boş liste dönüyor.
- [ ] Boş köşeli parantez `[]` geçerli değişken sayılmıyor.
- [ ] Hatalı formatlar uygulamayı bozmuyor.
- [ ] `variables` alanı promptText’ten türetilen string listesi olarak düşünülüyor.
- [ ] V1’de değişken tipi, varsayılan değer veya koşullu blok eklenmedi.

## 10. Validation Kontrolü

- [ ] Boş `promptText` geçersiz kabul ediliyor.
- [ ] Sadece boşluklardan oluşan `promptText` geçersiz kabul ediliyor.
- [ ] Geçerli `promptText` kabul ediliyor.
- [ ] `status` izin verilen key’lerden biri olmalı kuralı tanımlandı.
- [ ] `tags` string listesi olmalı.
- [ ] `variables` string listesi olmalı.
- [ ] `schemaVersion` pozitif integer olmalı.
- [ ] Validation kuralları UI’a gömülmeden domain/helper düzeyinde ele alınabiliyor.
- [ ] Validation kuralları V1 için gereksiz karmaşıklaştırılmadı.

## 11. Normalizasyon Kontrolü

- [ ] Tag değerleri trim edilecek şekilde planlandı.
- [ ] Boş tag değerleri kaydedilmeyecek şekilde planlandı.
- [ ] Tekrarlanan tag değerleri tekilleştirilebilecek şekilde planlandı.
- [ ] Prompt metni trim davranışı netleştirildi veya development notes’a açık soru olarak yazıldı.
- [ ] Kategori boşsa UI fallback davranışı ayrıca ele alınacak şekilde not edildi.
- [ ] Title boşsa UI fallback davranışı ayrıca ele alınacak şekilde not edildi.

## 12. Repository Interface Kontrolü

M2’de implementation zorunlu değildir; ancak repository yönü net olmalıdır.

- [ ] Prompt repository interface planlandı veya oluşturuldu.
- [ ] Repository interface domain tarafında konumlandırıldı.
- [ ] Repository interface Firebase detaylarını bilmiyor.
- [ ] Create prompt operasyonu için interface yönü net.
- [ ] Read/list prompt operasyonu için interface yönü net.
- [ ] Update prompt operasyonu için interface yönü net.
- [ ] Archive prompt operasyonu için interface yönü net.
- [ ] M3’te Firestore implementation yazılacak şekilde sınır ayrıldı.

## 13. Tarih Alanları Kontrolü

- [ ] `createdAt` oluşturma zamanı olarak tanımlandı.
- [ ] `updatedAt` son anlamlı güncelleme zamanı olarak tanımlandı.
- [ ] Normal Kopyala’nın `updatedAt` değiştirmeyeceği not edildi.
- [ ] Değişkenli Kopyala-Doldur’un `updatedAt` değiştirmeyeceği not edildi.
- [ ] `lastUsedAt` V1’e eklenmedi.
- [ ] `usageCount` V1’e eklenmedi.

## 14. SchemaVersion Kontrolü

- [ ] `schemaVersion` alanı modelde var.
- [ ] Başlangıç değeri `1` olarak planlandı.
- [ ] Kullanıcı tarafından düzenlenmeyecek sistem alanı olduğu net.
- [ ] Migration hazırlığı için tutulduğu not edildi.
- [ ] V1’de gelişmiş migration sistemi kurulmadı.

## 15. V1 Dışında Bırakılan Alanlar Kontrolü

Aşağıdaki alanlar V1 domain modeline eklenmemiş olmalı:

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
- [ ] `modelUsed`
- [ ] `tokenUsage`
- [ ] `costEstimate`
- [ ] `shareVisibility`

## 16. Test Kontrolü

M2’de özellikle unit test adayları belirlenmelidir.

- [ ] Variable extraction için unit test adayları not edildi.
- [ ] Status validation için unit test adayları not edildi.
- [ ] Prompt validation için unit test adayları not edildi.
- [ ] Tag normalization için test adayları not edildi.
- [ ] Domain modelin Firebase’den bağımsız test edilebilir olduğu kontrol edildi.
- [ ] Test notları `07_test_security_plan.md` ve gerekirse `09_development_notes.md` ile uyumlu.

## 17. Mimari Sınır Kontrolü

- [ ] Domain katmanında Firebase import’u yok.
- [ ] Domain katmanında Firestore DTO yok.
- [ ] Domain katmanında UI widget/state yok.
- [ ] Data implementation M2’de erken ve dağınık yazılmadı.
- [ ] Repository interface domain tarafında kalıyor.
- [ ] Firestore service M3’e bırakıldı.
- [ ] DTO / Mapper M3’e bırakıldı veya sadece iskelet halinde tutuldu.

## 18. Scope Leak Kontrolü

M2’de aşağıdakiler eklenmemiş olmalı:

- [ ] AI başlık önerisi alanı
- [ ] AI açıklama alanı
- [ ] AI skor / health score alanı
- [ ] Embedding alanı
- [ ] Version history alanı
- [ ] Usage analytics alanı
- [ ] Team/workspace alanı
- [ ] Public sharing alanı
- [ ] Kalıcı delete alanı
- [ ] Payment / quota alanı

## 19. AI Review Hatırlatma

M2 sonunda dış AI review almak mantıklıdır.

Önerilen prompt:

- `data_model_review_prompt.md`
- Gerekirse `architecture_review_prompt.md`
- Gerekirse `scope_guard_review_prompt.md`

Kontrol maddeleri:

- [ ] M2 sonunda data model review alınması değerlendirildi.
- [ ] Review alınırsa PromptCard alanları ve Firebase bağımsızlığı özellikle kontrol ettirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] Kabul/ret/parking lot ayrımı yapıldı.
- [ ] Gerekli notlar `09_development_notes.md` içine yazıldı.

## 20. Development Notes Kontrolü

- [ ] M2 sırasında çıkan açık sorular development notes’a yazıldı.
- [ ] Category fallback kararı gerekiyorsa not edildi.
- [ ] Title fallback kararı gerekiyorsa not edildi.
- [ ] Tag normalization kararı gerekiyorsa not edildi.
- [ ] Variable extraction regex/parser notu gerekiyorsa yazıldı.
- [ ] ADR’ye dönüşmesi gereken karar adayı varsa not edildi.
- [ ] M2 kapanış notu eklendi veya eklenecek.

## 21. M2 Kapanış Kararı

M2 tamamlandı sayılabilmesi için:

- [ ] PromptCard domain modeli hazır.
- [ ] Model canonical alanlarla uyumlu.
- [ ] Model Firebase’den bağımsız.
- [ ] Status key’leri hazır.
- [ ] Variable extraction mantığı hazır veya net planlı.
- [ ] Temel validation yaklaşımı hazır.
- [ ] Repository interface yönü net.
- [ ] V1 dışı AI / analytics / team / version alanları modele eklenmedi.
- [ ] M3 — Data Layer ve Firestore Bağlantısı aşamasına geçilebilir.

## 22. Kapanış Notu

M2’nin ana başarı ölçütü, Prompt Yönetim Aracı’nın ana ürün varlığı olan `PromptCard` modelinin Firestore’dan bağımsız, sade, test edilebilir ve V1 kapsamına uygun şekilde kurulmasıdır. Firestore sonraki milestone’da gelir; model önce kendi ayakları üzerinde durmalıdır.
