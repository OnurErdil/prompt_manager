# ADR-010 — Single App, Multilingual-Ready

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1 ilk olarak Türkçe ürün diliyle geliştirilecektir. Hedef kullanıcı, bireysel AI power user olarak tanımlanmıştır ve ilk geliştirme akışı Türkçe karar belgeleriyle ilerlemektedir.

Buna rağmen ürün ileride farklı dillere açılabilir. Bu olasılık V1'de ayrı uygulama, ayrı kod tabanı veya çok dilli UI geliştirme yükü yaratmamalıdır.

## Karar

V1 tek uygulama olarak geliştirilecektir.

İlk ürün dili Türkçe olacaktır:

```text
Turkish first
```

Ancak uygulama yapısı gelecekte çok dilli UI'a hazırlanacak şekilde korunacaktır:

```text
one app, future multilingual UI
```

V1'de ayrı Türkçe/İngilizce uygulama, ayrı Firebase project veya ayrı kod tabanı oluşturulmayacaktır.

## Kapsam

Bu karar şunları kapsar:

- Tek Flutter app,
- tek Android package,
- tek V1 ürün çekirdeği,
- Türkçe ilk UI dili,
- gelecekte localization eklenebilir yapıyı bozmama.

Bu karar şunları V1'e eklemez:

- Tam localization sistemi,
- dil seçici ekranı,
- çeviri yönetim aracı,
- ayrı İngilizce ürün deneyimi,
- çok bölgeli Firebase ayrımı.

## Alternatifler

### Alternatif 1 — Sadece Türkçe ve localization hazırlığı olmadan ilerlemek

Avantajları:

- En hızlı başlangıçtır.
- V1 geliştirme yükünü azaltır.

Dezavantajları:

- Metinler dağınık şekilde kod içine yayılabilir.
- İleride çok dilli UI eklemek daha maliyetli olur.
- Aynı kavramlar farklı yerlerde tutarsız çevrilebilir.

### Alternatif 2 — V1'de tam çok dilli UI yapmak

Avantajları:

- İlk günden farklı dillere hazır olur.
- UI metinleri merkezi yönetilebilir.

Dezavantajları:

- V1 kapsamını büyütür.
- Ürün çekirdeği tamamlanmadan localization yükü getirir.
- M0-M10 planında gereksiz karmaşıklık yaratır.

### Alternatif 3 — Turkish first, multilingual-ready tek app

Avantajları:

- V1 hızını korur.
- Tek app ve tek veri modeli korunur.
- Gelecekte localization eklemek için kapı açık kalır.
- Ürün kararları farklı app varyantlarına bölünmez.

Dezavantajları:

- V1'de tam çok dillilik sunmaz.
- Kod içinde UI metinleri büyürse sonradan düzenleme gerekebilir.
- Terim tutarlılığı için dikkat gerekir.

## Gerekçe

V1'in önceliği manuel prompt yaşam döngüsü çekirdeğini çalışır hale getirmektir. Çok dilli UI değerli bir genişleme olabilir, ancak V1'in çekirdek kabul kriteri değildir.

Tek uygulama yaklaşımı ürün, veri modeli, Firebase yapısı ve geliştirme akışını sade tutar. Türkçe ilk yaklaşım mevcut karar belgeleri ve hedef başlangıç diliyle uyumludur.

Multilingual-ready ilke ise ileride localization eklenmesini zorlaştıracak ayrışmaları engeller.

## Sonuçlar

Bu karar sonucunda:

- V1 tek Flutter uygulaması olarak geliştirilecektir.
- Android package tek kalacaktır: `com.onurerdil.promptmanager`.
- İlk UI dili Türkçe olacaktır.
- Ayrı Türkçe/İngilizce app oluşturulmayacaktır.
- Ayrı Firebase project veya ayrı veri modeli oluşturulmayacaktır.
- Gelecekte localization eklenmesine engel olacak ürün kararı alınmayacaktır.
- V1'de tam localization implementation zorunlu değildir.

## Uygulama İlkeleri

V1 sırasında:

- UI metinleri Türkçe yazılabilir.
- Domain model teknik key'leri dil bağımsız tutulmalıdır.
- Kullanıcıya gösterilen etiketler ile teknik key'ler ayrı tutulmalıdır.
- Firestore alan adları İngilizce teknik alanlar olarak korunmalıdır.
- Kullanıcıya görünen metinler ile veri modeli key'leri birbirine karıştırılmamalıdır.

## Riskler

- UI metinleri kod içine dağılırsa ileride localization maliyeti artar.
- Türkçe kullanıcı metinleri ile teknik veri key'leri karışabilir.
- Erken localization kurulumu V1 hızını düşürebilir.
- Ayrı app fikri ileride veri ve bakım karmaşıklığı yaratabilir.

## Risk Azaltma

- Teknik key'ler dil bağımsız tutulacaktır.
- UI metinleri ile model alanları ayrıştırılacaktır.
- V1'de ayrı app veya ayrı backend açılmayacaktır.
- Çok dillilik ihtiyacı V1 sonrası planlandığında localization stratejisi ayrıca ele alınacaktır.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda yeniden değerlendirilebilir:

- Ürün Türkçe dışı kullanıcılarla test edilmeye başlanırsa,
- App Store / Play Store yayın dili genişletilecekse,
- V1 sonrası localization milestone'u açılırsa,
- UI metinleri yönetilemeyecek kadar büyürse,
- Ayrı pazar veya bölge gereksinimleri doğarsa.

## İlgili Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1'in tek uygulama olarak, Türkçe ilk ürün diliyle ve gelecekte çok dilli UI'a hazır kalacak şekilde geliştirileceği karar altına alınmıştır.
