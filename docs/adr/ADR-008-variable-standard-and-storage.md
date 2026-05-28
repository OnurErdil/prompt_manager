# ADR-008 — Variable Standard and Storage

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1'de kullanıcı prompt metni içinde tekrar doldurulabilir değişken alanları kullanabilecektir. Bu değişkenler, Değişkenli Kopyala-Doldur akışının temel girdisidir.

V1'de değişken sistemi sade, okunabilir, platformdan bağımsız ve Firestore'da kolay saklanabilir olmalıdır. Koşullu bloklar, tipli değişkenler, varsayılan değerler veya gelişmiş template motoru V1 kapsamında değildir.

## Karar

V1 değişken standardı köşeli parantez içinde büyük harfli değişken adı olacaktır:

```text
[VARIABLE_NAME]
```

Türkçe kullanımda da aynı teknik format korunacaktır:

```text
[PROJE_ADI]
[HEDEF_KITLE]
[TON]
```

Prompt metninden algılanan değişkenler `PromptCard` modeli içinde string listesi olarak tutulacaktır:

```text
variables: string[]
```

Firestore tarafında bu alan string array olarak saklanacaktır.

## Format Kuralları

V1 değişken formatı:

```text
[VARIABLE_NAME]
```

Kurallar:

- Değişken köşeli parantezle başlar ve biter.
- Değişken adı boş olamaz.
- Teknik standardın önerilen biçimi büyük harf, rakam ve alt çizgidir.
- Boşluk yerine alt çizgi kullanılır.
- Aynı değişken prompt içinde birden fazla geçerse `variables` listesinde bir kez tutulur.
- Prompt içinde değişken yoksa `variables` boş liste olur.

Örnek:

```text
[PROJECT_NAME] için [TARGET_AUDIENCE] kitlesine uygun bir açıklama yaz.
```

Algılanan liste:

```text
variables: ["PROJECT_NAME", "TARGET_AUDIENCE"]
```

## Alternatifler

### Alternatif 1 — Süslü parantez

```text
{{variableName}}
```

Avantajları:

- Bazı template sistemlerinde yaygındır.
- Gelişmiş template motorlarına benzer.

Dezavantajları:

- V1 için fazla teknik görünebilir.
- Kullanıcı tarafından elle yazımı daha zahmetlidir.
- Prompt metinlerinde görsel olarak daha kalabalıktır.

### Alternatif 2 — Dolar işaretli placeholder

```text
$variableName
```

Avantajları:

- Kısa yazılır.
- Bazı programlama dillerine aşinadır.

Dezavantajları:

- Normal metinde yanlış pozitif üretme ihtimali daha yüksektir.
- Sınırları köşeli parantez kadar net değildir.
- Teknik kullanıcı olmayanlar için daha soyut kalabilir.

### Alternatif 3 — Köşeli parantez standardı

```text
[VARIABLE_NAME]
```

Avantajları:

- Prompt metni içinde görsel olarak net ayrılır.
- Elle yazması kolaydır.
- Regex ile algılaması basittir.
- V1'in manuel çekirdeği için yeterince güçlüdür.
- Değişkenli kopyala-doldur akışına doğrudan bağlanır.

Dezavantajları:

- Normal metinde köşeli parantez kullanımı varsa yanlış algılama riski olabilir.
- Tip, açıklama veya varsayılan değer taşımaz.
- Gelişmiş template ihtiyaçları için ileride genişletme gerekebilir.

## Gerekçe

V1'in amacı gelişmiş bir template motoru kurmak değil, kullanıcının prompt içindeki doldurulabilir alanları kolayca işaretleyip yeniden kullanabilmesini sağlamaktır.

`[VARIABLE_NAME]` standardı bu ihtiyacı sade şekilde karşılar. Kullanıcı metin içinde değişkenleri kolay görür; uygulama da bu alanları promptText üzerinden algılayıp doldurma formuna dönüştürebilir.

`variables: string[]` alanı, prompt metninden türetilmiş bir index/veri yardımcısıdır. Canonical prompt metninin yerine geçmez.

## Sonuçlar

Bu karar sonucunda:

- V1 değişken standardı `[VARIABLE_NAME]` olacaktır.
- `PromptCard.variables` alanı string listesi olacaktır.
- Firestore'da `variables` string array olarak saklanacaktır.
- Aynı değişken tekrar ederse listede tek kez tutulacaktır.
- Değişken yoksa boş liste kullanılacaktır.
- Değişken formu bu liste üzerinden üretilecektir.
- Değişken değerleri PromptCard içinde kalıcı olarak saklanmayacaktır.
- V1'de tipli değişken, koşullu blok veya template expression sistemi olmayacaktır.

## Veri Modeli Etkisi

`PromptCard` içinde:

```text
promptText: string
variables: string[]
```

`variables`, `promptText` içinden türetilir. Kaynak gerçeklik prompt metnidir.

Örnek:

```text
promptText: "[URUN_ADI] için [KANAL] kanalına uygun metin yaz."
variables: ["URUN_ADI", "KANAL"]
```

## Değişkenli Kopyala-Doldur Etkisi

Değişkenli kopyala-doldur akışı:

1. Prompt metni okunur.
2. `variables` listesi üzerinden input alanları oluşturulur.
3. Kullanıcı değerleri doldurur.
4. `[VARIABLE_NAME]` alanları kullanıcı değerleriyle değiştirilir.
5. Final prompt üretilir ve kopyalanır.

Bu işlem PromptCard'ı otomatik olarak değiştirmez.

## Riskler

- Kullanıcı köşeli parantezi normal metin amacıyla kullanırsa yanlış değişken algılanabilir.
- Farklı yazım biçimleri (`[proje adı]`, `[ProjeAdi]`) tutarsızlık yaratabilir.
- Çok uzun değişken adları UI'da taşma riski oluşturabilir.
- Prompt metni değiştiğinde `variables` yeniden hesaplanmazsa veri tutarsızlığı oluşabilir.

## Risk Azaltma

- M2'de variable parser için unit test yazılacaktır.
- Prompt metni create/update sırasında değişirse `variables` yeniden hesaplanacaktır.
- UI uzun değişken adlarında overflow kontrolü yapacaktır.
- Checklist'lerde değişken standardı ve tekrar eden değişken davranışı kontrol edilecektir.

## İlgili Belgeler

- `01_v1_scope.md`
- `03_data_model.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `docs/checklists/g05_data_model_checklist.md`
- `docs/checklists/m2_domain_model_checklist.md`
- `ADR-003-canonical-promptcard-model.md`

## Kapanış Notu

Bu ADR ile V1 değişken standardının `[VARIABLE_NAME]` olacağı ve prompttan algılanan değişkenlerin `variables: string[]` alanında saklanacağı karar altına alınmıştır.
