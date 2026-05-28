# ADR-005 — UI Firebase’e Doğrudan Erişmeyecek

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1, Firebase Auth ve Cloud Firestore kullanacaktır. V1’de kullanıcı kayıt/giriş yapacak, promptlarını Firestore’da kullanıcıya bağlı saklayacak, kütüphanede listeleyecek, detayını açacak, düzenleyecek ve arşivleyecektir.

Flutter uygulamalarında Firebase çağrılarını doğrudan ekranların içine yazmak başlangıçta hızlı görünebilir. Ancak bu yaklaşım büyüyen projelerde kodun dağılmasına, test edilebilirliğin düşmesine ve veri güvenliği hatalarının UI katmanına sızmasına yol açabilir.

0.7 ve 0.9 mimari kararlarında veri akışı şu şekilde kilitlenmiştir:

```text
Screen → Provider/Notifier → Repository → Service → Firebase
```

Bu kararın ayrı bir ADR olarak kayıt altına alınması gerekir.

## Karar

UI katmanı Firebase Auth veya Cloud Firestore’a doğrudan erişmeyecektir.

Screen ve widget dosyaları içinde doğrudan şu tip kullanımlar yapılmayacaktır:

```text
FirebaseAuth.instance
FirebaseFirestore.instance
```

Firebase erişimi data/service katmanında tutulacaktır. UI, işlemleri Provider/Notifier üzerinden başlatacak; Provider/Notifier repository ile konuşacak; repository service üzerinden Firebase’e erişecektir.

## Alternatifler

### Alternatif 1 — Screen içinde doğrudan Firebase çağrısı

Avantajları:

- Başlangıçta hızlıdır.
- Daha az dosya gerektirir.
- Prototip için pratik olabilir.

Dezavantajları:

- UI ve data erişimi birbirine karışır.
- Test yazmak zorlaşır.
- Firestore path ve query bilgileri ekranlara sızar.
- Hata yönetimi dağınık olur.
- Repository / service sınırları kurulamaz.
- Backend değişimi çok zorlaşır.

### Alternatif 2 — Provider içinde doğrudan Firebase çağrısı

Avantajları:

- Firebase çağrıları ekranlardan kısmen ayrılmış olur.
- UI daha temiz görünür.

Dezavantajları:

- Provider fazla sorumluluk alır.
- Repository soyutlaması zayıflar.
- Data source değişimi yine zor olabilir.
- DTO / mapper düzeni yeterince net kurulmayabilir.

### Alternatif 3 — Repository / Service ayrımı

Avantajları:

- UI teknik servis detaylarını bilmez.
- Repository domain ihtiyacını soyutlar.
- Service Firebase gibi dış sistemle konuşur.
- Test edilebilirlik artar.
- Firestore’dan başka backend’e geçiş ihtimali korunur.
- Data dönüşümleri DTO / Mapper üzerinden yönetilebilir.

Dezavantajları:

- Başlangıçta daha fazla dosya ve disiplin gerektirir.
- Küçük özelliklerde biraz daha yavaş ilerlenebilir.

## Gerekçe

Prompt Yönetim Aracı’nın V1’i küçük görünse de ürünün uzun vadeli hedefi kişisel AI çalışma hafızasına büyüyebilecek bir sistemdir. Bu nedenle UI’ın Firebase’e doğrudan bağlanması kısa vadeli hız kazandırsa bile uzun vadede teknik borç üretir.

UI’ın görevi kullanıcı etkileşimini yönetmek ve state göstermek olmalıdır. Firebase Auth, Firestore path, query, timestamp, DTO veya security davranışları UI katmanının sorumluluğu değildir.

Bu nedenle Firebase erişimi data/service katmanında tutulacak ve UI yalnızca Provider/Notifier üzerinden işlem yapacaktır.

## Sonuçlar

Bu karar sonucunda:

- Screen ve widget dosyaları Firebase Auth veya Firestore çağırmayacaktır.
- Firebase query ve path bilgisi service katmanında kalacaktır.
- Repository domain ihtiyacını soyutlayacaktır.
- Provider/Notifier UI state ve kullanıcı aksiyonlarını yönetecektir.
- DTO ve mapper yapısı data katmanında kalacaktır.
- UI, Firestore document snapshot veya Firebase timestamp gibi teknik tipleri bilmeyecektir.
- Mimari sınırlar milestone sonlarında kontrol edilecektir.

## Veri Akışı

V1 veri akışı:

```text
Screen
  ↓
Provider / Notifier
  ↓
Repository
  ↓
Service
  ↓
Firebase
```

Katman görevleri:

| Katman | Görev |
|---|---|
| Screen / Widget | Kullanıcı arayüzü ve input |
| Provider / Notifier | UI state ve kullanıcı aksiyonları |
| Repository | Domain veri ihtiyacını soyutlama |
| Service | Firebase Auth / Firestore ile iletişim |
| Firebase | Dış veri ve auth kaynağı |

## Riskler

- Başlangıçta doğrudan Firebase çağrısı daha hızlı görünebilir.
- Basit ekranlarda repository/service ayrımı fazla gibi hissedilebilir.
- Provider içine fazla iş mantığı birikebilir.
- Service katmanı yanlış tasarlanırsa repository sadece geçiş borusuna dönüşebilir.
- Ekip/tek geliştirici disiplin kaybederse UI-Firebase sınırı zamanla bozulabilir.

## Risk Azaltma

- `02_architecture.md` ana mimari referans olarak kullanılacaktır.
- `architecture_boundary_checklist.md` ile her milestone sonunda UI-Firebase sınırı kontrol edilecektir.
- `flutter_code_review_prompt.md` ve `architecture_review_prompt.md` ile dış AI review alınabilecektir.
- Kod review sırasında UI içinde `FirebaseAuth.instance` veya `FirebaseFirestore.instance` aranacaktır.
- DTO’ların presentation katmanına sızmaması ayrıca kontrol edilecektir.

## Kontrol Maddeleri

Bu kararın uygulandığını doğrulamak için:

- UI içinde `FirebaseAuth.instance` yok.
- UI içinde `FirebaseFirestore.instance` yok.
- Firestore path bilgisi screen/widget içinde yok.
- Firestore query logic service katmanında.
- Repository interface domain tarafında.
- Repository implementation data tarafında.
- Provider/Notifier repository çağırıyor.
- DTO presentation katmanında kullanılmıyor.
- Domain model Firebase tiplerine bağımlı değil.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda yeniden değerlendirilebilir:

- Uygulama mimarisi kökten değişirse,
- Firebase dışı backend’e geçiş yapılırsa,
- State management yaklaşımı büyük ölçüde değişirse,
- Offline-first / local-first mimari gündeme gelirse,
- V2 AI Gateway nedeniyle client-backend iletişim modeli yeniden tasarlanırsa.

Ancak bu durumlarda bile temel ilke korunmalıdır:

> UI teknik servis detaylarına doğrudan bağımlı olmamalıdır.

## İlgili Belgeler

- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `07_test_security_plan.md`
- `06_acceptance_criteria.md`
- `architecture_boundary_checklist.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-009-firestore-user-subcollection-structure.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1’de UI katmanının Firebase Auth veya Cloud Firestore’a doğrudan erişmeyeceği kararı kilitlenmiştir. Ekranlar kullanıcı deneyimini yönetir; Firebase erişimi repository/service yapısı üzerinden data katmanında tutulur.
