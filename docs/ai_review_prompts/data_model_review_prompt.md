# Data Model Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1’de `PromptCard` veri modelinin kilitli canonical modele uygun olup olmadığını dış AI’a inceletmek için kullanılır.

Bu review özellikle şu soruya cevap arar:

> PromptCard modeli sade, platform bağımsız, V1 kapsamına uygun ve Firestore’dan bağımsız kalıyor mu?

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M2 — PromptCard Domain Model sonrası
- M3 — Firestore Data Layer ve DTO/Mapper sonrası
- M7 — Detaylı Ekle sonrası
- Yeni veri alanı eklenmesi önerildiğinde
- Data model scope leak şüphesi olduğunda
- M10 final V1 kapanış review sürecinde

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

Temel problem:
Prompt değer kaybı. Yani iyi bir promptun zamanla bulunabilir, anlaşılabilir, geliştirilebilir ve yeniden kullanılabilir olmaktan çıkması.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 veri kararı:
PromptCard, Firestore dokümanı değil, platform bağımsız canonical domain modeldir.

Firestore yalnızca V1 saklama taşıyıcısıdır. Domain model Firestore’a bağımlı olmamalıdır.
```

## 4. Canonical PromptCard Alanları

AI’ya şu alanların kilitli olduğunu belirt:

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

## 5. Kilit Veri Kuralları

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kilit veri kuralları:
- promptText tek zorunlu kullanıcı alanıdır.
- PromptCard domain model Firestore tiplerine bağımlı olmamalıdır.
- ownerId kullanıcı sahipliği için korunmalıdır.
- status teknik key olarak tutulmalıdır.
- Geçerli status key’leri: raw, needs_edit, ready, archived
- archived kalıcı silme değildir.
- Değişken standardı: [DEĞİŞKEN_ADI]
- variables promptText içinden algılanan string listesi olmalıdır.
- schemaVersion yeni kayıtlarda 1 olmalıdır.
- createdAt ve updatedAt sistem tarafından yönetilmelidir.
- DTO / Mapper ayrımı korunmalıdır.
```

## 6. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- PromptCard domain model dosyası
- Status enum/key dosyası
- Variable extraction helper
- Prompt validation helper
- PromptCardDto dosyası
- PromptCardMapper dosyası
- Repository interface
- Firestore repository implementation
- Örnek Firestore dokümanı
- İlgili testler
- İlgili checklist maddeleri
```

## 7. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 7.1 Alan Uyumluluğu

- PromptCard kilitli alanları eksiksiz mi?
- Fazladan V1 dışı alan eklenmiş mi?
- `promptText` zorunlu kalıyor mu?
- Sistem alanları kullanıcı alanlarıyla karışmış mı?
- `ownerId` korunuyor mu?

### 7.2 Platform Bağımsızlık

- Domain model Firebase `Timestamp` kullanıyor mu?
- Domain model Firestore `DocumentSnapshot` biliyor mu?
- Domain model Firestore path veya collection bilgisi içeriyor mu?
- PromptCard DTO’ya dönüşmüş mü?
- Domain model başka backend’e taşınabilir durumda mı?

### 7.3 Status Modeli

- Geçerli key’ler doğru mu?
- Kullanıcıya görünen Türkçe label domain modelde saklanıyor mu?
- `archived`, delete yerine doğru kullanılıyor mu?
- Geçersiz status değerleri engelleniyor mu?

### 7.4 Değişken Modeli

- `[DEĞİŞKEN_ADI]` formatı doğru mu?
- variables string listesi mi?
- Tekrarlanan değişkenler tekilleştiriliyor mu?
- Değişken yoksa boş liste dönebiliyor mu?
- V1 dışı değişken tipi, default değer, koşullu blok eklenmiş mi?

### 7.5 DTO / Mapper

- DTO data katmanında mı?
- Mapper DTO ↔ Domain dönüşümünü merkezi yapıyor mu?
- Firestore timestamp dönüşümleri mapper’da mı?
- Eksik alanlara güvenli fallback var mı?
- DTO presentation katmanına sızmış mı?

### 7.6 Validation / Normalizasyon

- Boş promptText engelleniyor mu?
- Tags trim/tekilleştirme davranışı var mı?
- Boş tag değerleri temizleniyor mu?
- Status validation var mı?
- schemaVersion güvenli mi?

### 7.7 V1 Scope Leak

Aşağıdaki alanlar modele sızmış mı?

- `usageCount`
- `lastUsedAt`
- `versionHistory`
- `deletedAt`
- `isFavorite`
- `collectionId`
- `workspaceId`
- `teamId`
- `aiSummary`
- `aiScore`
- `healthScore`
- `embedding`
- `semanticKeywords`
- `modelUsed`
- `tokenUsage`
- `costEstimate`
- `shareVisibility`
- `publicUrl`
- `marketplaceStatus`

## 8. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Data Model Review Sonucu

## 1. Genel Değerlendirme
Kısa veri modeli özeti.

## 2. Uyumlu Noktalar
- ...

## 3. Kritik Sorunlar
Her kritik sorun için:
- Sorun:
- Neden önemli:
- İlgili alan/dosya:
- Önerilen düzeltme:

## 4. Orta Öncelikli Sorunlar
- ...

## 5. Düşük Öncelikli İyileştirmeler
- ...

## 6. Canonical PromptCard Alan Kontrolü
- Eksik alan var mı?
- Fazla alan var mı?

## 7. Firestore Bağımsızlık Kontrolü
- Domain model Firebase’den bağımsız mı?

## 8. DTO / Mapper Kontrolü
- Ayrım doğru mu?

## 9. Status / Archive Kontrolü
- Status key’leri ve archived davranışı doğru mu?

## 10. Variable Extraction Kontrolü
- [DEĞİŞKEN_ADI] standardı doğru mu?

## 11. V1 Scope Leak Kontrolü
- V1 dışı alanlar sızmış mı?

## 12. Önerilen Aksiyonlar
Kritik / Orta / Düşük olarak sırala.

## 13. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 9. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- V1 PromptCard modeline AI alanları önermeyin.
- V1 PromptCard modeline usage analytics alanları önermeyin.
- V1 PromptCard modeline version history alanı önermeyin.
- V1 PromptCard modeline team/workspace alanları önermeyin.
- V1 PromptCard modeline embedding/semantic search alanları önermeyin.
- V1’e deletedAt/isDeleted/kalıcı delete modeli önermeyin.
- Firestore dokümanını doğrudan domain model olarak kullanmayı önermeyin.
- Firestore Timestamp tipini domain modelde tutmayı önermeyin.
- Gereksiz büyük migration sistemi önermeyin.
- V1 kapsamı dışındaki iyi fikirleri parking lot önerisi olarak işaretleyin.
```

## 10. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter/Firebase data model reviewer gibi davran.

Aşağıdaki projede PromptCard veri modelini incele. Amacın yeni özellik önermek değil; mevcut V1 veri modelinin kilitli canonical kararlara uygun olup olmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. Temel problem “prompt değer kaybı”dır.

V1 KAPSAMI:
V1 AI’sız manuel prompt yaşam döngüsü çekirdeğidir.

ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

KİLİTLİ VERİ KARARLARI:
- PromptCard, Firestore dokümanı değil, platform bağımsız canonical domain modeldir.
- Firestore yalnızca V1 saklama taşıyıcısıdır.
- Domain model Firestore tiplerine bağımlı olmamalıdır.
- DTO / Mapper ayrımı korunmalıdır.
- promptText tek zorunlu kullanıcı alanıdır.
- ownerId kullanıcı sahipliği için korunmalıdır.
- status teknik key olarak tutulmalıdır.
- Geçerli status key’leri: raw, needs_edit, ready, archived
- archived kalıcı silme değildir.
- Değişken standardı: [DEĞİŞKEN_ADI]
- variables promptText içinden algılanan string listesi olmalıdır.
- schemaVersion yeni kayıtlarda 1 olmalıdır.
- createdAt ve updatedAt sistem tarafından yönetilmelidir.

CANONICAL PROMPTCARD ALANLARI:
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

İNCELEME GÖREVİ:
Sana verdiğim model/DTO/mapper/repository kodlarını şu açılardan incele:
1. PromptCard alanları canonical modele uygun mu?
2. Eksik veya V1 dışı fazla alan var mı?
3. Domain model Firebase/Firestore tiplerinden bağımsız mı?
4. DTO / Mapper ayrımı doğru mu?
5. promptText tek zorunlu kullanıcı alanı olarak korunuyor mu?
6. ownerId sahiplik ilkesi doğru mu?
7. status key’leri doğru mu?
8. archived davranışı delete yerine doğru kullanılıyor mu?
9. [DEĞİŞKEN_ADI] değişken standardı doğru mu?
10. variables alanı doğru üretiliyor mu?
11. schemaVersion ve tarih alanları doğru mu?
12. V1 dışı AI/analytics/team/version/embedding/delete alanları sızmış mı?

ÇIKTI FORMATIN:
# Data Model Review Sonucu

## 1. Genel Değerlendirme
## 2. Uyumlu Noktalar
## 3. Kritik Sorunlar
## 4. Orta Öncelikli Sorunlar
## 5. Düşük Öncelikli İyileştirmeler
## 6. Canonical PromptCard Alan Kontrolü
## 7. Firestore Bağımsızlık Kontrolü
## 8. DTO / Mapper Kontrolü
## 9. Status / Archive Kontrolü
## 10. Variable Extraction Kontrolü
## 11. V1 Scope Leak Kontrolü
## 12. Önerilen Aksiyonlar
## 13. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- V1 PromptCard modeline AI alanları önermeyin.
- V1 PromptCard modeline usage analytics alanları önermeyin.
- V1 PromptCard modeline version history alanı önermeyin.
- V1 PromptCard modeline team/workspace alanları önermeyin.
- V1 PromptCard modeline embedding/semantic search alanları önermeyin.
- V1’e deletedAt/isDeleted/kalıcı delete modeli önermeyin.
- Firestore dokümanını doğrudan domain model olarak kullanmayı önermeyin.
- Firestore Timestamp tipini domain modelde tutmayı önermeyin.
- Gereksiz büyük migration sistemi önermeyin.
- V1 kapsamı dışındaki iyi fikirleri parking lot önerisi olarak işaretleyin.

İNCELEYECEĞİN İÇERİK:
[Buraya PromptCard model dosyası, DTO, Mapper, repository interface/implementation, örnek veri veya ilgili kodlar eklenecek.]
```

## 11. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Canonical modele uyumlu gerçek hataları düzelt.
- V1 dışı alan önerilerini reddet veya parking lot’a taşı.
- DTO/Mapper sorunu varsa ilgili checklist’e işle.
- Kalıcı veri kararı gerekiyorsa ADR adayı aç.
- Notları `09_development_notes.md` içine yaz.
- `g05_data_model_checklist.md` ile tekrar kontrol et.

## 12. Kapanış Notu

Bu promptun görevi veri modelini büyütmek değil, kemik yapısını doğru tutmaktır. V1’de PromptCard sade kalacak; geleceğin kaslarını parking lot’ta bekleteceğiz.
