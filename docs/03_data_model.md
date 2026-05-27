# Prompt Yönetim Aracı — Data Model

**Belge tipi:** V1 canonical data model belgesi  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmış kodlama öncesi kaynak belge  
**Kapsam:** PromptCard canonical model, alanlar, veri davranışları, validation, değişken algılama ve Firestore uyumluluğu  
**Son güncelleme:** 2026-05-25

---

## 1. Belgenin Amacı

Bu belge, Prompt Yönetim Aracı V1 için kullanılacak temel veri modelini tanımlar.

Ana amaç, V1’in ana ürün varlığı olan **PromptCard** modelini Firestore’dan bağımsız, platform taşınabilir ve ileride büyümeye açık şekilde tanımlamaktır.

Bu belge şu sorulara cevap verir:

- Prompt Kartı teknik olarak hangi alanlardan oluşacak?
- Hangi alan zorunlu, hangi alan opsiyonel olacak?
- Durum, kategori, etiket ve değişken alanları nasıl tutulacak?
- `[DEĞİŞKEN_ADI]` standardı nasıl algılanacak?
- `createdAt`, `updatedAt` ve `schemaVersion` nasıl kullanılacak?
- Firestore DTO / Mapper / Domain ayrımı nasıl korunacak?
- V1’de hangi veri alanları özellikle eklenmeyecek?

Bu belge Firestore kurulum rehberi değildir. Firestore collection yapısı, security rules ve teknik bağlantı detayları `04_firebase_firestore_plan.md` içinde ele alınacaktır.

---

## 2. Veri Modelinin Ana İlkeleri

V1 veri modeli şu ilkelerle kurulacaktır:

1. **PromptCard ürünün ana domain varlığıdır.**  
   Promptlar düz metin olarak değil, bağlamlı ve yeniden kullanılabilir Prompt Kartları olarak ele alınır.

2. **Veri modeli Firestore’a bağımlı olmayacaktır.**  
   Firestore V1 için saklama taşıyıcısıdır; canonical model platform bağımsız kalacaktır.

3. **Kullanıcı sahipliği `ownerId` ile korunacaktır.**  
   Her PromptCard bir kullanıcıya ait olacak ve bu sahiplik güvenlik kurallarının temelini oluşturacaktır.

4. **Tek zorunlu kullanıcı alanı `promptText` olacaktır.**  
   Hızlı yakalama deneyimini korumak için diğer alanlar opsiyonel veya sistem tarafından üretilen alanlar olacaktır.

5. **Sistem değerleri dil bağımsız teknik key’lerle tutulacaktır.**  
   Örneğin status değerleri `raw`, `needs_edit`, `ready`, `archived` olarak saklanır; kullanıcıya görünen Türkçe karşılıklar UI katmanında gösterilir.

6. **`schemaVersion` migration hazırlığı için tutulacaktır.**  
   V1’de gelişmiş migration sistemi kurulmayacak, ancak ileride model değişikliklerine zemin hazırlanacaktır.

7. **V1 veri modeli sade tutulacaktır.**  
   AI, analitik, kullanım sayısı, version history, embedding ve takım/workspace alanları V1’e eklenmeyecektir.

---

## 3. Canonical PromptCard Modeli

V1’de her prompt aşağıdaki canonical model ile temsil edilir:

```text
PromptCard
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

Bu model Firestore dokümanı olarak düşünülmemelidir. Firestore’da saklama için DTO ve Mapper katmanı kullanılacaktır.

---

## 4. PromptCard Alan Tablosu

| Alan | Tip | Zorunlu mu? | Kim üretir? | Açıklama |
|---|---|---:|---|---|
| `id` | string | Evet | Sistem | Prompt kartının benzersiz kimliği |
| `ownerId` | string | Evet | Sistem/Auth | Kartın ait olduğu kullanıcı |
| `title` | string | Hayır | Kullanıcı | Prompt başlığı |
| `promptText` | string | Evet | Kullanıcı | Ana prompt metni |
| `description` | string | Hayır | Kullanıcı | Promptun amacı / kısa açıklaması |
| `notes` | string | Hayır | Kullanıcı | Bağlam, kullanım notu veya hatırlatma |
| `category` | string | Hayır | Kullanıcı | Tek ana kategori / raf |
| `tags` | string[] | Hayır | Kullanıcı | Esnek çapraz etiketler |
| `status` | string | Evet | Sistem/Kullanıcı | Yaşam döngüsü durumu |
| `variables` | string[] | Hayır | Sistem | Prompt metninden algılanan değişkenler |
| `createdAt` | datetime | Evet | Sistem | Oluşturulma tarihi |
| `updatedAt` | datetime | Evet | Sistem | Son anlamlı güncelleme tarihi |
| `schemaVersion` | int | Evet | Sistem | Veri modeli sürümü |

---

## 5. Alan Açıklamaları

### 5.1. `id`

Prompt kartının benzersiz kimliğidir.

Davranış:

- Sistem tarafından oluşturulur.
- Kullanıcı tarafından düzenlenmez.
- Firestore document id ile eşleşebilir.
- Export/import senaryolarında korunabilir.
- Domain modelde string olarak tutulur.

---

### 5.2. `ownerId`

Prompt kartının hangi kullanıcıya ait olduğunu gösterir.

Davranış:

- Firebase Auth kullanıcısının UID değeriyle ilişkilendirilir.
- Kullanıcı tarafından düzenlenmez.
- Security rules için temel sahiplik alanıdır.
- Her kullanıcı yalnızca kendi `ownerId` değerine sahip kayıtları görebilmeli ve değiştirebilmelidir.

Kural:

> `ownerId`, V1 veri güvenliğinin ana kırmızı çizgisidir.

---

### 5.3. `title`

Prompt kartının başlığıdır.

Davranış:

- Kullanıcı tarafından girilebilir.
- Boş bırakılabilir.
- Boşsa UI tarafında “Başlıksız Prompt” veya prompt metninden türetilmiş kısa fallback gösterilebilir.
- V1’de AI başlık önerisi yoktur.
- AI başlık önerisi V2 park alanıdır.

---

### 5.4. `promptText`

Promptun ana metnidir.

Davranış:

- V1’de tek zorunlu kullanıcı alanıdır.
- Boş kaydedilemez.
- Değişken alanlar bu metinden algılanır.
- Normal Kopyala bu metni olduğu gibi kopyalar.
- Değişkenli Kopyala-Doldur bu metni template olarak kullanır.

Kural:

> `promptText` olmadan PromptCard oluşturulamaz.

---

### 5.5. `description`

Promptun amacı veya kısa açıklamasıdır.

Davranış:

- Opsiyoneldir.
- Promptun ne işe yaradığını hızlı anlamayı sağlar.
- Basit metin aramasına dahil edilebilir.
- V1’de AI tarafından otomatik doldurulmaz.

---

### 5.6. `notes`

Promptla ilgili bağlam, kullanım notu veya hatırlatma alanıdır.

Davranış:

- Opsiyoneldir.
- Kullanıcı “bu promptu şu durumda kullan” gibi notlar yazabilir.
- Basit metin aramasına dahil edilebilir.
- V1’de rich text gerekmez; düz metin yeterlidir.

---

### 5.7. `category`

Promptun ana rafıdır.

Davranış:

- Tek string alanı olarak tutulur.
- Boş olabilir.
- UI’da “Kategorisiz” gibi fallback gösterilebilir.
- Kategoriye göre filtreleme yapılabilir.
- V1’de çok katmanlı kategori ağacı yoktur.

Kural:

> Kategori = tek ana raf.

---

### 5.8. `tags`

Promptun esnek çapraz işaretleme alanıdır.

Tip:

```text
string[]
```

Davranış:

- Birden fazla etiket olabilir.
- Boş liste olabilir.
- Boş etiketler kaydedilmemelidir.
- Tekrarlanan etiketler tekilleştirilebilir.
- Etiketlere göre filtreleme yapılabilir.

Kural:

> Etiketler = esnek çapraz işaretleme.

---

### 5.9. `status`

Promptun yaşam döngüsündeki durumunu gösterir.

Teknik key’ler:

```text
raw
needs_edit
ready
archived
```

Kullanıcıya görünen karşılıklar:

| Teknik key | Kullanıcı etiketi |
|---|---|
| `raw` | Ham |
| `needs_edit` | Düzenlenecek |
| `ready` | Kullanıma Hazır |
| `archived` | Arşiv |

Davranış:

- Yeni prompt varsayılan olarak `raw` olabilir.
- Kullanıcı status değiştirebilir.
- `archived`, kalıcı silme yerine kullanılır.
- V1’de kalıcı silme kapsam dışıdır.

---

### 5.10. `variables`

Prompt metninden algılanan değişken alanlar listesidir.

Tip:

```text
string[]
```

Örnek prompt:

```text
[PROJE_ADI] için [HEDEF_KULLANICI] kitlesine uygun bir açıklama yaz.
```

Saklanan değişkenler:

```json
["PROJE_ADI", "HEDEF_KULLANICI"]
```

Davranış:

- `promptText` içinden otomatik algılanır.
- Aynı değişken birden fazla geçerse listede bir kez tutulur.
- Sıralama, prompt içinde ilk görülme sırasına göre korunabilir.
- Değişkenli Kopyala-Doldur ekranında bu liste form alanlarına dönüşür.

V1 dışında:

- Değişken tipi yoktur.
- Varsayılan değer yoktur.
- Zorunlu/opsiyonel değişken ayrımı yoktur.
- Koşullu blok yoktur.
- AI destekli değişken önerisi yoktur.

---

### 5.11. `createdAt`

Prompt kartının oluşturulma zamanıdır.

Davranış:

- Sistem tarafından atanır.
- Kullanıcı tarafından düzenlenmez.
- Firestore tarafında server timestamp kullanılabilir.
- Export/import senaryosunda korunabilir.

---

### 5.12. `updatedAt`

Prompt kartının son anlamlı güncellenme zamanıdır.

Davranış:

- Anlamlı değişikliklerde otomatik güncellenir.
- Normal Kopyala `updatedAt` değerini değiştirmez.
- Değişkenli Kopyala-Doldur kullanımı `updatedAt` değerini değiştirmez.
- V1’de `lastUsedAt` olmadığı için kullanım aksiyonları güncelleme sayılmaz.

`updatedAt` şu değişikliklerde güncellenir:

- `title`
- `promptText`
- `description`
- `notes`
- `category`
- `tags`
- `status`
- promptText değişimi nedeniyle `variables`

---

### 5.13. `schemaVersion`

Veri modelinin sürümünü gösterir.

Başlangıç değeri:

```text
1
```

Davranış:

- Yeni kayıtlarda `schemaVersion: 1` atanır.
- Kullanıcı tarafından düzenlenmez.
- İleride veri modeli değişirse migration için kullanılır.
- Export/import uyumluluğu için korunur.

---

## 6. Varsayılan Değerler

V1’de mümkün olduğunca güvenli varsayılan değerler kullanılmalıdır.

| Alan | Varsayılan |
|---|---|
| `title` | boş string veya UI fallback |
| `description` | boş string |
| `notes` | boş string |
| `category` | boş string veya UI’da “Kategorisiz” |
| `tags` | boş liste |
| `status` | `raw` |
| `variables` | promptText’ten algılanan liste veya boş liste |
| `schemaVersion` | `1` |

Not:

> V1’de null değerler yerine güvenli varsayılanlar tercih edilmelidir. Bu yaklaşım UI, filtreleme ve mapper tarafında hata riskini azaltır.

---

## 7. Validation ve Normalizasyon Kuralları

### 7.1. Zorunlu Validation Kuralları

- `promptText` boş olamaz.
- Sadece boşluk içeren `promptText` geçersizdir.
- `ownerId` boş olamaz.
- `status`, izin verilen teknik key’lerden biri olmalıdır.
- `tags`, string listesi olmalıdır.
- `variables`, string listesi olmalıdır.
- `schemaVersion`, pozitif integer olmalıdır.

### 7.2. Normalizasyon Kuralları

- Prompt metninin başındaki ve sonundaki gereksiz boşluklar temizlenebilir.
- Etiket değerleri trim edilebilir.
- Boş etiketler kaydedilmemelidir.
- Tekrarlanan etiketler tekilleştirilebilir.
- Değişkenler tekilleştirilebilir.
- Status değerleri teknik key formatında saklanır.
- Kullanıcıya görünen status metinleri UI katmanında çevrilir.

---

## 8. Değişken Algılama Standardı

V1 değişken standardı:

```text
[DEĞİŞKEN_ADI]
```

Algılama kuralları:

- Değişkenler köşeli parantezle tanımlanır.
- Değişken adı boş olamaz.
- Aynı değişken birden fazla geçerse `variables` listesinde bir kez tutulur.
- Değişkenler prompt metninde ilk görülme sırasına göre listelenebilir.
- Algılanan değişkenler Değişkenli Kopyala-Doldur ekranında input alanına dönüşür.
- Final prompt oluşturulurken her `[DEĞİŞKEN_ADI]`, kullanıcının girdiği değerle değiştirilir.

Örnek:

```text
[URUN_ADI] için [TON] tonunda kısa bir açıklama yaz.
```

Algılanan değişkenler:

```json
["URUN_ADI", "TON"]
```

V1 dışında:

- İç içe değişken yoktur.
- Değişken tipleri yoktur.
- Varsayılan değişken değerleri yoktur.
- Koşullu bloklar yoktur.
- AI destekli değişken önerisi yoktur.

---

## 9. DTO / Mapper / Domain Model Ayrımı

V1’de Firestore verisi doğrudan UI’a veya domain modeline taşınmayacaktır.

Önerilen akış:

```text
Firestore Document ⇄ PromptCardDto ⇄ PromptCardMapper ⇄ PromptCard
```

### 9.1. `PromptCard`

- Domain modeldir.
- Firestore tiplerini bilmez.
- Uygulamanın ana iş modelidir.
- Platform bağımsız kalır.

### 9.2. `PromptCardDto`

- Firestore ile uyumlu veri taşıma nesnesidir.
- Firestore alan adlarını ve timestamp dönüşümlerini karşılar.
- Data katmanında kullanılır.
- UI katmanına sızmamalıdır.

### 9.3. `PromptCardMapper`

- DTO ile domain modeli arasında dönüşüm yapar.
- Eksik opsiyonel alanlara güvenli varsayılanlar verebilir.
- `schemaVersion` üzerinden gelecekte migration hazırlığı yapabilir.
- Eski veya eksik veriyle uygulamanın çökmesini engellemeye yardımcı olur.

Kural:

> Firestore dokümanı uygulamanın domain modeli değildir. DTO ve Mapper ayrımı korunacaktır.

---

## 10. Firestore Saklama Uyumluluğu Notu

Firestore collection yapısı `04_firebase_firestore_plan.md` içinde netleştirilecektir.

V1 için önerilen yapı:

```text
users/{userId}/prompts/{promptId}
```

Ancak hangi Firestore path yapısı seçilirse seçilsin şu ilke korunacaktır:

> PromptCard içinde `ownerId` bulunacak ve kullanıcı sahipliği canonical modelde saklanacaktır.

Bu sayede export/import, migration veya ileride collection yapısı değişikliği durumlarında sahiplik bilgisi korunur.

---

## 11. Arama ve Filtreleme İçin Veri Desteği

V1’de basit arama ve filtreleme desteklenecektir.

Filtreleme alanları:

- `category`
- `tags`
- `status`
- `updatedAt`

Basit metin arama alanları:

- `title`
- `promptText`
- `description`
- `notes`

V1’de olmayacaklar:

- Semantik arama
- Embedding alanları
- Full-text search altyapısı
- AI destekli arama
- Search backend entegrasyonu

V2/V3 park alanı adayları:

- `embedding`
- `semanticKeywords`
- `aiGeneratedSummary`
- Search backend entegrasyonu
- Semantik arama

Bu alanlar V1 veri modeline eklenmeyecektir.

---

## 12. Tarih ve Yaşam Döngüsü Davranışları

### 12.1. `createdAt`

- Oluşturma anında atanır.
- Sonradan değişmez.
- Kullanıcı tarafından düzenlenmez.

### 12.2. `updatedAt`

Şu durumlarda güncellenir:

- Prompt metni değişirse
- Başlık değişirse
- Açıklama değişirse
- Not değişirse
- Kategori değişirse
- Etiketler değişirse
- Status değişirse
- Prompt metni değişimi nedeniyle değişken listesi yeniden hesaplanırsa

Şu durumlarda güncellenmez:

- Normal Kopyala
- Değişkenli Kopyala-Doldur
- Detay sayfasını görüntüleme
- Listeleme
- Arama / filtreleme

Çünkü V1’de kullanım analitiği, `usageCount` veya `lastUsedAt` yoktur.

---

## 13. Arşiv Davranışı

V1’de arşivleme veri silme değildir.

Kural:

```text
status: archived
```

Davranış:

- Arşivlenen prompt silinmez.
- Arşivlenen prompt veri olarak korunur.
- Varsayılan kütüphane görünümünde arşivlenen promptlar gizlenebilir.
- Arşiv filtresiyle arşivlenen promptlar görüntülenebilir.
- Kalıcı silme V1 kapsamı değildir.

---

## 14. V1 Dışında Bırakılan Veri Alanları

Aşağıdaki alanlar V1 modeline eklenmeyecektir:

```text
usageCount
lastUsedAt
versionHistory
deletedAt
isFavorite
collectionId
workspaceId
teamId
aiSummary
aiScore
healthScore
embedding
modelUsed
tokenUsage
costEstimate
shareVisibility
```

Gerekçe:

> V1, prompt yaşam döngüsü çekirdeğini kanıtlar. Analitik, AI, takım, gelişmiş sürümleme ve maliyet/kota alanları V1 modelini şişirmeyecektir.

Bu alanlar ileride V1.5, V2 veya V3 kapsamında tekrar değerlendirilebilir.

---

## 15. Örnek PromptCard Kaydı

```json
{
  "id": "prompt_001",
  "ownerId": "user_123",
  "title": "Ürün fikri değerlendirme promptu",
  "promptText": "[URUN_FIKRI] fikrini hedef kullanıcı, problem, değer önerisi ve V1 kapsamı açısından değerlendir.",
  "description": "Yeni uygulama fikirlerini ilk değerlendirme için kullanılır.",
  "notes": "Proje başlatma öncesi kullanılabilir.",
  "category": "Ürün Geliştirme",
  "tags": ["ürün", "strateji", "v1"],
  "status": "ready",
  "variables": ["URUN_FIKRI"],
  "createdAt": "2026-05-25T10:00:00Z",
  "updatedAt": "2026-05-25T10:00:00Z",
  "schemaVersion": 1
}
```

---

## 16. SchemaVersion ve Migration Hazırlığı

V1’de gelişmiş migration sistemi kurulmayacaktır. Ancak migration hazırlığı için `schemaVersion` alanı kullanılacaktır.

Kurallar:

- Yeni tüm kayıtlarda `schemaVersion: 1` atanır.
- Mapper, eksik opsiyonel alanları güvenli varsayılanlarla karşılayabilir.
- İleride veri modeli değişirse `schemaVersion` üzerinden dönüşüm yapılabilir.
- Export/import formatı bu sürüm bilgisini taşıyabilir.

Bu yaklaşım bugünden ağır bir migration sistemi kurmadan geleceğe küçük bir kapı bırakır.

---

## 17. Export / Import Uyumluluğu Notu

V1’de import/export kapsam dışıdır. Ancak veri modeli ileride export/import’a uygun tutulmalıdır.

İlkeler:

- Alan adları anlaşılır ve platform bağımsız olmalıdır.
- Firebase’e özel tipler canonical modelde yer almamalıdır.
- `schemaVersion` korunmalıdır.
- `createdAt` ve `updatedAt` taşınabilir formatta düşünülmelidir.
- Kullanıcı verisi ileride JSON, Markdown veya benzeri formatlara çevrilebilir olmalıdır.

---

## 18. Güvenlik ve Veri Sahipliği Notu

Veri güvenliği için temel ilkeler:

- Her PromptCard bir kullanıcıya aittir.
- Kullanıcı sahipliği `ownerId` ile tutulur.
- Kullanıcı yalnızca kendi promptlarını okuyup değiştirebilmelidir.
- Client tarafında AI API key veya gizli servis anahtarı tutulmamalıdır.
- V1 PromptCard içinde hassas sistem secret’ları saklanmamalıdır.
- Firestore security rules ayrı belgede detaylandırılacaktır.

---

## 19. İlgili ADR Kayıtları

Bu belge şu ADR kayıtlarıyla ilişkilidir:

- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-010-archive-instead-of-delete-v1.md`

İleride gerekirse şu ADR açılabilir:

- `ADR-015-schema-version-and-migration-strategy.md`

---

## 20. Referans Belgeler

Bu belge şu kaynaklarla birlikte kullanılmalıdır:

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`

---

## 21. Kapanış Notu

`03_data_model.md`, Prompt Yönetim Aracı V1’in canonical PromptCard veri modelini tanımlayan ana kaynak belgedir.

Bu belgeye göre V1’de:

- PromptCard Firestore’dan bağımsız domain model olarak korunacak,
- `promptText` tek zorunlu kullanıcı alanı olacak,
- kullanıcı sahipliği `ownerId` ile temsil edilecek,
- durumlar teknik key ile saklanacak,
- değişkenler `[DEĞİŞKEN_ADI]` standardıyla algılanacak,
- arşivleme `status: archived` olarak yapılacak,
- V1 dışı AI, analitik, usage, version history ve workspace alanları modele eklenmeyecektir.
