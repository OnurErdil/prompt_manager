# ADR-007 — Firestore User-Scoped Path

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1'de kullanıcıların promptları Cloud Firestore üzerinde saklanacaktır. Her prompt kartı tek bir kullanıcıya ait olmalı ve kullanıcılar yalnızca kendi promptlarını okuyup değiştirebilmelidir.

V1 kişisel kullanım odaklıdır. Team, workspace, public sharing veya organizasyon yapısı V1 kapsamında değildir. Bu nedenle Firestore veri yolu kullanıcı izolasyonunu sade, güvenli ve okunabilir şekilde desteklemelidir.

## Karar

V1 için Firestore prompt veri yolu şu şekilde kullanılacaktır:

```text
users/{userId}/prompts/{promptId}
```

Her kullanıcının promptları kendi kullanıcı dokümanı altındaki `prompts` alt koleksiyonunda tutulacaktır:

```text
users
  {userId}
    prompts
      {promptId}
```

`PromptCard` canonical domain modelinde `ownerId` alanı yine korunacaktır.

## Alternatifler

### Alternatif 1 — User-scoped subcollection

```text
users/{userId}/prompts/{promptId}
```

Avantajları:

- Kullanıcı verisi doğal olarak kullanıcı altında gruplanır.
- Security rules daha okunabilir olur.
- V1 kişisel kullanım modeliyle uyumludur.
- Kullanıcı izolasyonu path üzerinden net kontrol edilir.
- UI katmanının global prompt collection bilmesine gerek kalmaz.

Dezavantajları:

- Tüm kullanıcıların promptları üzerinde global sorgular daha zordur.
- İleride team/workspace yapısı gelirse veri yolu yeniden değerlendirilebilir.
- Admin veya analytics ihtiyaçlarında collection group query gerekebilir.

### Alternatif 2 — Top-level prompts collection

```text
prompts/{promptId}
```

Her dokümanda `ownerId` tutulur.

Avantajları:

- Tüm promptlar tek collection altında tutulur.
- Global sorgular daha kolay olabilir.
- Bazı admin veya analytics senaryoları daha pratik olabilir.

Dezavantajları:

- Her sorguda `ownerId` filtresi unutulmamalıdır.
- Security rules daha dikkatli yazılmalıdır.
- V1 kişisel kullanım için gereksiz global yüzey oluşturur.
- Yanlış query veya gevşek rule kullanıcı verisi sızıntısı riski doğurur.

## Gerekçe

`users/{userId}/prompts/{promptId}` yapısı V1'in bireysel kullanıcı ve kullanıcı izolasyonu hedefiyle en doğrudan uyumlu yapıdır.

Rules tarafında temel sahiplik kontrolü path üzerinden kurulabilir:

```text
request.auth.uid == userId
```

`ownerId` alanı ise domain modelde korunur. Bunun nedenleri:

- `PromptCard` modelinin yalnızca Firestore path'ine bağımlı olmaması,
- export/import veya migration senaryolarında sahiplik bilgisinin taşınabilmesi,
- ileride başka backend veya farklı collection yapısına geçiş ihtimalinin açık kalması,
- sahiplik ilkesinin veri modelinde de açıkça temsil edilmesi.

## Sonuçlar

Bu karar sonucunda:

- V1 prompt verileri `users/{userId}/prompts/{promptId}` altında tutulacaktır.
- Her PromptCard dokümanında `ownerId` alanı bulunacaktır.
- Create sırasında `ownerId == request.auth.uid` kontrol edilecektir.
- Read/update işlemleri `request.auth.uid == userId` kuralına bağlı olacaktır.
- Update sırasında `ownerId` değiştirilemeyecektir.
- Delete V1'de kapalı kalacaktır.
- Firestore service katmanı doğru kullanıcı path'i üzerinden işlem yapacaktır.
- UI Firestore path bilgisini bilmeyecektir.

## Security Rules İlkesi

Temel rules yaklaşımı:

```text
match /users/{userId}/prompts/{promptId} {
  allow read: if request.auth != null
              && request.auth.uid == userId;

  allow create: if request.auth != null
                && request.auth.uid == userId
                && request.resource.data.ownerId == request.auth.uid;

  allow update: if request.auth != null
                && request.auth.uid == userId
                && resource.data.ownerId == request.auth.uid
                && request.resource.data.ownerId == resource.data.ownerId;

  allow delete: if false;
}
```

Bu final rules dosyası değildir; M3 ve sonrasında security rules checklist'i ile doğrulanacaktır.

## Query Planı

V1 temel listeleme yaklaşımı:

```text
users/{userId}/prompts
  orderBy updatedAt desc
```

V1 filtreleri:

- `status`
- `category`
- `tags array-contains`
- `updatedAt`

V1'de semantik arama veya global full-text search yoktur.

## Riskler

- Team/workspace modeli gelirse path yapısı yeniden değerlendirilebilir.
- `ownerId` path ile uyumsuz yazılırsa veri tutarsızlığı oluşabilir.
- Firestore rules eksik yazılırsa path bazlı izolasyon zayıflayabilir.
- Service katmanında yanlış `userId` path'i kullanılırsa veri erişim hataları oluşabilir.

## Risk Azaltma

- Create sırasında `ownerId` auth UID ile eşleştirilecektir.
- Update sırasında `ownerId` değiştirilemeyecektir.
- UI katmanı Firestore path veya `FirebaseFirestore.instance` bilmeyecektir.
- Repository/service katmanı doğru UID kullanımından sorumlu olacaktır.
- M3, M4, M6 ve M10 içinde Firestore rules ve cross-user erişim kontrolleri yapılacaktır.

## İlgili Belgeler

- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `07_test_security_plan.md`
- `docs/checklists/g04_firestore_rules_checklist.md`
- `docs/checklists/security_checklist.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1'de Firestore prompt veri yolunun `users/{userId}/prompts/{promptId}` olacağı ve canonical modelde `ownerId` alanının korunacağı karar altına alınmıştır.
