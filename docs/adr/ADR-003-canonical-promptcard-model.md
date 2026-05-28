# ADR-003 — Canonical PromptCard Model

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1’de kullanıcıların kaydettiği her prompt, yalnızca düz metin olarak değil, bağlamı, durumu, kategorisi, etiketleri, değişkenleri ve tarih bilgileri olan bir **Prompt Kartı** olarak ele alınacaktır.

V1 için Firebase Auth + Cloud Firestore ana teknik aday olarak seçilmiştir. Ancak ürünün uzun vadeli vizyonu yalnızca Firestore’da veri saklamak değildir. İleride Supabase/PostgreSQL, SQLite/local-first yapı, export/import, AI destekli işleme, semantik arama veya kişisel AI çalışma hafızası gibi büyüme ihtimalleri vardır.

Bu nedenle PromptCard modelinin Firestore doküman yapısına doğrudan bağımlı olup olmayacağı netleştirilmelidir.

## Karar

`PromptCard`, Firestore dokümanı değil, platform bağımsız canonical domain modeli olarak tanımlanacaktır.

Firestore, V1 için saklama taşıyıcısı olarak kullanılacaktır; ancak ürünün ana veri modeli Firestore’a bağımlı olmayacaktır.

Canonical PromptCard modeli şu alanlardan oluşacaktır:

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

## Alternatifler

### Alternatif 1 — Firestore dokümanını doğrudan model olarak kullanmak

Bu yaklaşımda Firestore’dan gelen veri doğrudan uygulama içinde model gibi kullanılabilir.

Avantajları:

- Başlangıçta daha hızlıdır.
- Daha az dosya ve dönüşüm kodu gerektirir.
- Küçük prototiplerde pratik olabilir.

Dezavantajları:

- Domain modeli Firestore’a bağımlı hâle gelir.
- Firestore `Timestamp`, document snapshot veya collection yapısı uygulama katmanlarına sızabilir.
- İleride backend değişikliği zorlaşır.
- Export/import ve migration senaryoları karmaşıklaşır.
- Test edilebilirlik zayıflar.

### Alternatif 2 — Firestore’dan bağımsız canonical domain model kullanmak

Bu yaklaşımda uygulamanın ana modeli `PromptCard` olur. Firestore verisi DTO ve mapper üzerinden domain modeline çevrilir.

Avantajları:

- Ürün veri modeli platform bağımsız kalır.
- Firestore yalnızca data katmanında sınırlı kalır.
- DTO / Mapper ile dönüşüm kontrol edilebilir.
- Migration ve schemaVersion yönetimi kolaylaşır.
- Test edilebilirlik artar.
- İleride farklı backend veya export/import senaryoları daha yönetilebilir olur.

Dezavantajları:

- Başlangıçta biraz daha fazla yapı gerektirir.
- DTO, mapper ve repository ayrımı dikkatli kurulmalıdır.

## Gerekçe

Prompt Yönetim Aracı’nın ana varlığı prompt metni değil, **PromptCard**’dır. PromptCard, kullanıcının kişisel AI çalışma bilgisini taşıyan temel bilgi varlığıdır.

Bu varlığın Firestore dokümanına indirgenmesi ürünün uzun vadeli yönünü daraltır. V1’de Firestore kullanılsa bile ürünün veri modeli Firestore’un teknik ayrıntılarından bağımsız kalmalıdır.

Bu nedenle canonical PromptCard modeli domain katmanında korunacak; Firestore ile uyumlu veri taşıma yapısı ise data katmanında DTO / Mapper ile çözülecektir.

## Sonuçlar

Bu karar sonucunda:

- `PromptCard` domain model olarak ele alınacaktır.
- Firestore veri yapısı doğrudan UI’a taşınmayacaktır.
- Firestore Document → DTO → Mapper → Domain PromptCard akışı korunacaktır.
- `schemaVersion` alanı migration ve export/import hazırlığı için tutulacaktır.
- `ownerId` kullanıcı sahipliği için canonical modelde yer alacaktır.
- `status` kullanıcıya görünen metinle değil, teknik key ile saklanacaktır.
- `variables` prompt metninden algılanan string listesi olarak tutulacaktır.
- İleride farklı backend veya veri aktarımı gerektiğinde canonical model temel alınacaktır.

## Riskler

- Başlangıçta model / DTO / mapper ayrımı ekstra dosya ve dikkat gerektirir.
- Küçük V1 için fazla yapı kuruluyormuş gibi görünebilir.
- Mapper doğru yazılmazsa veri dönüşüm hataları oluşabilir.
- Firestore alan adları ile domain alanları arasındaki uyum düzenli test edilmelidir.

## Risk Azaltma

- Data model belgesi `03_data_model.md` ana referans olarak kullanılacaktır.
- Mapper testleri `07_test_security_plan.md` içinde test adayı olarak tutulacaktır.
- `data_model_checklist.md` ile PromptCard alanları ve dönüşümler kontrol edilecektir.
- UI’ın Firestore DTO’su kullanmaması `architecture_boundary_checklist.md` ile takip edilecektir.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda yeniden değerlendirilebilir:

- Backend Firestore dışına taşınırsa,
- Export/import V1.5 veya V2 kapsamında aktif geliştirmeye alınırsa,
- PromptCard modeline büyük yeni alanlar eklenirse,
- V2 AI destekli alanlar modelde kalıcı yer isterse,
- Semantic search / embedding gibi yeni veri katmanları gündeme gelirse,
- Offline-first veya local-first yapı ciddi biçimde değerlendirilmeye başlanırsa.

## İlgili Belgeler

- `03_data_model.md`
- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1’de `PromptCard` modelinin ürünün platform bağımsız ana domain varlığı olarak korunması kararı kilitlenmiştir. Firestore V1 için veri saklama taşıyıcısıdır; ürünün veri modeli Firestore’a bağımlı değildir.
