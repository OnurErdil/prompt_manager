# ADR-004 — Feature-first + Hafif Clean Architecture

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1, Flutter ile geliştirilecek ve Firebase Auth + Cloud Firestore kullanacaktır. Ürün V1’de manuel ama güçlü bir prompt yaşam döngüsü çekirdeği kuracaktır.

V1’in ana feature alanları şunlardır:

- `auth`
- `prompts`
- `settings`

V1 geliştirme stratejisi önce çalışan dikey çekirdek akışı kurmak olacaktır:

```text
Login/Register/AuthGate → Kütüphane → Hızlı Ekle → Firestore’a kullanıcıya bağlı kayıt → Kütüphanede Gör → Prompt Detay → Normal Kopyala
```

Bu nedenle kod yapısının hem düzenli hem de hızlı geliştirilebilir olması gerekir. Aşırı soyutlama V1’i yavaşlatabilir; çok basit/dağınık yapı ise ileride bakım ve büyümeyi zorlaştırabilir.

## Karar

Prompt Yönetim Aracı V1, **feature-first + hafif clean architecture** yaklaşımıyla geliştirilecektir.

Ana klasör yapısı:

```text
lib/
  app/
  core/
  features/
    auth/
      domain/
      data/
      presentation/
    prompts/
      domain/
      data/
      presentation/
    settings/
      domain/
      data/
      presentation/
```

Her feature kendi içinde şu katmanlara ayrılacaktır:

```text
domain/
data/
presentation/
```

## Alternatifler

### Alternatif 1 — Tek klasör / basit yapı

Örnek:

```text
lib/
  screens/
  services/
  models/
  widgets/
```

Avantajları:

- Başlangıçta hızlıdır.
- Küçük prototiplerde kolaydır.
- Daha az dosya yapısı vardır.

Dezavantajları:

- Ürün büyüdükçe kod karışır.
- Feature sınırları belirsizleşir.
- UI, service ve model sorumlulukları iç içe geçebilir.
- Firebase çağrıları kolayca ekranlara sızabilir.
- V2 AI veya gelişmiş data layer eklenirken bakım zorlaşır.

### Alternatif 2 — Layer-first yapı

Örnek:

```text
lib/
  domain/
  data/
  presentation/
```

Avantajları:

- Katman ayrımı nettir.
- Büyük sistemlerde düzenli olabilir.

Dezavantajları:

- Feature bazlı çalışmayı zorlaştırabilir.
- Küçük/orta Flutter projelerinde gezinme maliyeti artabilir.
- `auth`, `prompts`, `settings` gibi ürün alanları dosya ağacında dağılabilir.

### Alternatif 3 — Tam clean architecture

Avantajları:

- Çok güçlü katman ayrımı sağlar.
- Test edilebilirlik yüksektir.
- Büyük ve uzun vadeli projelerde güçlüdür.

Dezavantajları:

- V1 için fazla ağır olabilir.
- Çok fazla boilerplate üretebilir.
- İlk çalışan dikey akışı yavaşlatabilir.
- Ürünün doğrulanmadan önce mimariye aşırı yatırım yapılmasına yol açabilir.

### Alternatif 4 — Feature-first + hafif clean architecture

Avantajları:

- Feature bazlı düzen sağlar.
- Domain/data/presentation sınırlarını korur.
- V1 için yeterince düzenli, ama aşırı ağır değildir.
- Firebase bağımlılığını data katmanında tutmayı kolaylaştırır.
- V2 AI veya yeni feature’lara büyüme zemini sağlar.

Dezavantajları:

- Tek klasör yapısına göre daha fazla başlangıç disiplini ister.
- Katmanlar doğru kullanılmazsa sadece klasör kalabalığına dönüşebilir.
- `core/` klasörünün gereksiz çöplüğe dönüşmesi riski vardır.

## Gerekçe

V1’in hedefi, ürünün çekirdek değerini kanıtlayan çalışan bir dikey akış kurmaktır. Ancak ürünün uzun vadeli vizyonu kişisel AI çalışma hafızasına kadar büyüyebilir.

Bu nedenle mimari:

- V1’i yavaşlatmayacak kadar hafif,
- Kodun dağılmasını önleyecek kadar düzenli,
- Firebase’e bağımlılığı sınırlayacak kadar katmanlı,
- V2 AI katmanına büyümeyi destekleyecek kadar esnek

olmalıdır.

Feature-first + hafif clean architecture bu dengeyi sağlar.

## Sonuçlar

Bu karar sonucunda:

- Ana klasörler `app`, `core`, `features` olacaktır.
- V1 feature’ları `auth`, `prompts`, `settings` olarak ayrılacaktır.
- Her feature içinde `domain`, `data`, `presentation` katmanları bulunacaktır.
- `domain` katmanı iş modeli ve repository interface gibi platformdan bağımsız yapıları taşıyacaktır.
- `data` katmanı DTO, mapper, repository implementation ve Firebase service yapılarını taşıyacaktır.
- `presentation` katmanı screen, widget, provider/notifier ve UI state yapılarını taşıyacaktır.
- UI katmanı Firebase Auth veya Firestore’a doğrudan erişmeyecektir.
- Kod organizasyonu milestone’lara göre kontrollü ilerleyecektir.

## Riskler

- Katmanlar yanlış kullanılırsa klasör yapısı sadece görüntüde kalabilir.
- Basit işler için fazla dosya açma eğilimi doğabilir.
- `core/` klasörü “nereye koyacağımı bilemedim” klasörüne dönüşebilir.
- Feature sınırları korunmazsa farklı feature’lar birbirine bağımlı hâle gelebilir.
- Tam clean architecture’a kayılırsa V1 geliştirme hızı düşebilir.

## Risk Azaltma

- `02_architecture.md` mimari ana referans olacaktır.
- `architecture_boundary_checklist.md` ile milestone sonlarında mimari sınır kontrol edilecektir.
- `scope_leak_checklist.md` ile V1 dışı yapıların sızması engellenecektir.
- `core/` klasörüne yalnızca gerçekten feature bağımsız ortak yapılar alınacaktır.
- İlk hedef, çalışan dikey çekirdek akışı temiz sınırlarla kurmak olacaktır.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda yeniden değerlendirilebilir:

- Uygulama feature sayısı ciddi şekilde artarsa,
- V2 AI katmanı yeni backend / gateway yapıları gerektirirse,
- Test edilebilirlik için ek katmanlar zorunlu hâle gelirse,
- `core/` yapısı kontrolsüz büyürse,
- Feature sınırları pratikte yetersiz kalırsa,
- Proje web/desktop/çok platformlu geniş ölçekli ürüne dönüşürse.

## İlgili Belgeler

- `02_architecture.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1’de Flutter uygulamasının feature-first + hafif clean architecture yaklaşımıyla geliştirileceği kilitlenmiştir. Amaç, V1’i aşırı mühendisliğe boğmadan düzenli, test edilebilir ve büyümeye açık bir kod yapısı kurmaktır.
