# Prompt Yönetim Aracı — Firebase / Firestore Plan

## 1. Belge Bilgisi

**Belge tipi:** V1 Firebase / Firestore planı  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmıştır  
**Kapsam:** Firebase Auth, Cloud Firestore, kullanıcı veri sahipliği, security rules yaklaşımı ve milestone bazlı Firebase uygulama sırası  
**Son güncelleme:** 2026-05-25

Bu belge, Prompt Yönetim Aracı V1’in Firebase Auth ve Cloud Firestore kullanım planını tanımlar.

---

## 2. Firebase Kullanım Amacı

V1’de Firebase’in temel görevi:

- Kullanıcı hesabı sağlamak,
- Prompt verilerini kullanıcıya bağlı olarak saklamak,
- Cloud-first veri deneyimini desteklemek,
- Flutter ile hızlı ve yönetilebilir backend entegrasyonu sağlamak,
- V1 için güvenli ve yeterli veri altyapısı kurmaktır.

Temel ilke:

> Firestore, V1 için saklama taşıyıcısıdır; ürünün canonical veri modeli Firestore’a bağımlı olmayacaktır.

---

## 3. V1 Firebase Kapsamı

### V1’de olacaklar

- Firebase project kurulumu
- Firebase Auth
- Email/password giriş ve kayıt
- Logout
- AuthGate / Splash davranışı
- Cloud Firestore
- Kullanıcıya bağlı prompt saklama
- Prompt oluşturma
- Prompt listeleme
- Prompt detay okuma
- Prompt güncelleme
- Prompt arşivleme
- Basit Firestore security rules
- Kullanıcı izolasyonu

### V1’de olmayacaklar

- Cloud Functions
- AI API çağrıları
- AI Gateway
- Model routing
- Token / cost log
- AI quota backend
- Payment / subscription backend
- Push notification
- Remote Config
- Analytics zorunluluğu
- Crashlytics zorunluluğu
- Storage
- Team / workspace veri yapısı
- Public sharing
- Admin panel
- Kalıcı delete

---

## 4. Firebase Auth Planı

V1 için minimum Auth yöntemi:

```text
Email / password authentication
```

### Minimum Auth davranışı

- Kullanıcı kayıt olabilir.
- Kullanıcı giriş yapabilir.
- Kullanıcı çıkış yapabilir.
- AuthGate, giriş durumuna göre doğru ekrana yönlendirir.
- Giriş yapmayan kullanıcı prompt verilerine erişemez.
- Kullanıcı UID değeri, PromptCard `ownerId` alanı için temel kimliktir.

### AuthGate kuralı

> Login ve Register ekranları uygulama akışını tek başına yönetmeyecek; AuthGate merkezi yönlendirme katmanı olarak çalışacaktır.

Bu karar, auth akışının dağılmasını engeller ve ileride email verification gibi ek akışlar gelirse merkezi kontrol sağlar.

---

## 5. Firestore Veri Saklama Planı

V1’de prompt verileri Cloud Firestore’da saklanacaktır.

Her prompt, kullanıcının hesabına bağlı kişisel veri olarak ele alınacaktır.

Ana ilke:

> Her kullanıcı yalnızca kendi prompt kartlarını okuyabilmeli ve değiştirebilmelidir.

---

## 6. Collection Yapısı Kararı

V1 için önerilen Firestore yapısı:

```text
users/{userId}/prompts/{promptId}
```

Örnek yapı:

```text
users
  {uid}
    prompts
      {promptId}
```

### Bu yapının gerekçesi

- Kullanıcı verisi doğal olarak kullanıcı altında gruplanır.
- Security rules daha okunabilir olur.
- Kullanıcı izolasyonu daha sade uygulanır.
- V1 kişisel kullanım odaklı olduğu için uygundur.
- Team / workspace olmadığı için top-level karmaşıklık gerekmez.

### `ownerId` yine tutulacak mı?

Evet.

Prompt dokümanı kullanıcı alt koleksiyonunda saklansa bile canonical PromptCard modelinde `ownerId` korunacaktır.

Gerekçeler:

- Canonical model kullanıcı sahipliğini açık taşır.
- Export/import senaryolarında sahiplik bilgisi korunur.
- İleride collection yapısı değişirse veri modeli kırılmaz.
- Top-level `prompts` yapısına geçmek gerekirse taşıma kolaylaşır.

---

## 7. PromptCard Firestore Doküman Yapısı

Firestore dokümanı canonical PromptCard alanlarını taşımalıdır.

Örnek:

```json
{
  "id": "prompt_001",
  "ownerId": "user_123",
  "title": "Ürün fikri değerlendirme promptu",
  "promptText": "[URUN_FIKRI] fikrini hedef kullanıcı, problem, değer önerisi ve V1 kapsamı açısından değerlendir.",
  "description": "Yeni uygulama fikirlerini değerlendirmek için kullanılır.",
  "notes": "Proje başlatma öncesi kullanılabilir.",
  "category": "Ürün Geliştirme",
  "tags": ["ürün", "strateji", "v1"],
  "status": "ready",
  "variables": ["URUN_FIKRI"],
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp",
  "schemaVersion": 1
}
```

Kritik mimari kural:

> Firestore dokümanı doğrudan UI’a taşınmayacak. Firestore Document → DTO → Mapper → Domain PromptCard akışı korunacaktır.

---

## 8. Kullanıcı Sahipliği ve `ownerId` İlkesi

Ana ilke:

> Bir kullanıcı yalnızca kendi `users/{uid}/prompts` altındaki kayıtları okuyabilir ve yazabilir.

Ek ilkeler:

- Auth olmayan kullanıcı hiçbir prompt verisini okuyamaz.
- Kullanıcı başka bir UID altındaki promptlara erişemez.
- Yeni prompt oluşturulurken `ownerId`, authenticated user UID ile eşleşmelidir.
- Update sırasında `ownerId` değiştirilememelidir.
- Prompt dokümanında `schemaVersion` bulunmalıdır.
- Status sadece izin verilen değerlerden biri olmalıdır.

---

## 9. Firestore Query Planı

### Temel listeleme

```text
users/{uid}/prompts
orderBy updatedAt desc
```

### Duruma göre filtreleme

```text
where status == raw / needs_edit / ready / archived
```

### Kategori filtresi

```text
where category == selectedCategory
```

### Etiket filtresi

```text
where tags array-contains selectedTag
```

### Arama

V1’de basit metin arama client-side olabilir.

Arama yapılacak alanlar:

- `title`
- `promptText`
- `description`
- `notes`

V1 dışında:

- Semantik arama
- Embedding tabanlı arama
- Gelişmiş full-text search
- Search backend

---

## 10. Create / Read / Update / Archive Davranışları

### Create

Prompt oluşturma davranışı.

Kurallar:

- Kullanıcı authenticated olmalı.
- Path UID ile auth UID aynı olmalı.
- `ownerId == request.auth.uid` olmalı.
- `promptText` boş olmamalı.
- `status` geçerli key olmalı.
- `createdAt` ve `updatedAt` atanmalı.
- `schemaVersion: 1` olmalı.
- `variables`, `promptText` içinden hesaplanmalı.

### Read

Prompt okuma davranışı.

Kurallar:

- Kullanıcı authenticated olmalı.
- Kullanıcı yalnızca kendi UID altındaki promptları okuyabilmeli.
- Arşivlenen promptlar veri olarak okunabilir.
- UI varsayılan görünümde arşivleri gizleyebilir.

### Update

Prompt güncelleme davranışı.

Kurallar:

- Kullanıcı authenticated olmalı.
- Kullanıcı yalnızca kendi promptunu güncelleyebilmeli.
- `ownerId` değişmemeli.
- `createdAt` değişmemeli.
- `updatedAt` güncellenmeli.
- `status` geçerli key olmalı.
- `promptText` boş bırakılmamalı.
- Prompt metni değişirse `variables` yeniden hesaplanmalı.

### Archive

V1’de arşivleme kalıcı silme değildir.

```text
status: archived
```

Kurallar:

- Prompt silinmez.
- Status `archived` yapılır.
- V1’de kalıcı delete yoktur.
- Arşiv filtre ile görüntülenebilir.

---

## 11. Tarih Alanları ve Server Timestamp Yaklaşımı

### `createdAt`

- Prompt oluşturulurken atanır.
- Sonradan değişmemelidir.
- Firestore tarafında server timestamp kullanılabilir.

### `updatedAt`

Şu durumlarda güncellenir:

- `title` değişirse
- `promptText` değişirse
- `description` değişirse
- `notes` değişirse
- `category` değişirse
- `tags` değişirse
- `status` değişirse
- `variables` promptText değişimi nedeniyle yeniden hesaplanırsa

Şu durumlarda güncellenmez:

- Normal Kopyala
- Değişkenli Kopyala-Doldur kullanımı
- Detay sayfasını görüntüleme

V1’de kullanım analitiği olmadığı için `lastUsedAt` ve `usageCount` tutulmayacaktır.

---

## 12. Security Rules Planı

Security rules hedefleri:

- Auth olmayan kullanıcı erişemez.
- Kullanıcı yalnızca kendi UID path’ine erişir.
- Create sırasında `ownerId` auth UID ile aynı olmalıdır.
- Update sırasında `ownerId` değişmemelidir.
- Delete V1’de kapalı olmalıdır.
- `promptText` boş olmamalıdır.
- `status` izin verilen key’lerden biri olmalıdır.

### Taslak rules mantığı

Bu bölüm final rules kodu değil, belge düzeyinde kural mantığıdır:

```text
users/{userId}/prompts/{promptId}

allow read:
  request.auth != null
  and request.auth.uid == userId

allow create:
  request.auth != null
  and request.auth.uid == userId
  and request.resource.data.ownerId == request.auth.uid
  and request.resource.data.promptText is not empty

allow update:
  request.auth != null
  and request.auth.uid == userId
  and resource.data.ownerId == request.auth.uid
  and request.resource.data.ownerId == resource.data.ownerId

allow delete:
  false for V1
```

Kritik uyarı:

```text
allow read, write: if request.auth != null;
```

Bu kural tek başına yeterli değildir. Kullanıcı giriş yaptı diye herkesin verisini okuyabilmemelidir.

### M3.7 rules-readiness taslağı

Durum: Taslak dokümantasyon. Bu blok deploy edilmedi ve root `firestore.rules` dosyası olarak oluşturulmadı.

V1 path standardı:

```text
users/{userId}/prompts/{promptId}
```

Taslak Firestore Rules:

```js
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    function signedIn() {
      return request.auth != null;
    }

    function isOwnerPath(userId) {
      return signedIn() && request.auth.uid == userId;
    }

    function isAllowedStatus(status) {
      return status in ['raw', 'needs_edit', 'ready', 'archived'];
    }

    function hasAllowedPromptKeys(data) {
      return data.keys().hasOnly([
        'id',
        'ownerId',
        'title',
        'promptText',
        'description',
        'notes',
        'category',
        'tags',
        'status',
        'variables',
        'createdAt',
        'updatedAt',
        'schemaVersion',
      ]);
    }

    function hasRequiredPromptKeys(data) {
      return data.keys().hasAll([
        'id',
        'ownerId',
        'promptText',
        'tags',
        'status',
        'variables',
        'createdAt',
        'updatedAt',
        'schemaVersion',
      ]);
    }

    function optionalStringOrNull(value) {
      return value == null || value is string;
    }

    function validPromptData(data) {
      return hasAllowedPromptKeys(data)
        && hasRequiredPromptKeys(data)
        && data.id is string
        && data.id.size() > 0
        && data.ownerId is string
        && data.promptText is string
        && data.promptText.size() > 0
        && optionalStringOrNull(data.title)
        && optionalStringOrNull(data.description)
        && optionalStringOrNull(data.notes)
        && optionalStringOrNull(data.category)
        && data.tags is list
        && data.variables is list
        && isAllowedStatus(data.status)
        && data.createdAt is timestamp
        && data.updatedAt is timestamp
        && data.schemaVersion == 1;
    }

    match /users/{userId}/prompts/{promptId} {
      allow read: if isOwnerPath(userId);

      allow create: if isOwnerPath(userId)
        && request.resource.data.ownerId == request.auth.uid
        && request.resource.data.id == promptId
        && validPromptData(request.resource.data);

      allow update: if isOwnerPath(userId)
        && resource.data.ownerId == request.auth.uid
        && request.resource.data.ownerId == resource.data.ownerId
        && request.resource.data.id == resource.data.id
        && validPromptData(request.resource.data);

      allow delete: if false;
    }
  }
}
```

Notlar:

- `promptText.size() > 0` boş string değerini engeller. Sadece boşluklardan oluşan metin için ek client/domain validation korunmalıdır.
- `tags` ve `variables` V1'de liste olarak doğrulanır; eleman bazlı string kontrolü final rules review sırasında ayrıca değerlendirilecektir.
- `createdAt` update sırasında değiştirilemezliği final rules turunda ayrıca değerlendirilebilir. M3.7 taslağının ana güvenlik kapıları path ownership, `ownerId`, valid status, schema version ve delete yasağıdır.
- Bu taslak M4/M6/M10 güvenlik testleri ve dış Firestore rules review için başlangıç noktasıdır.

---

## 13. Milestone Bazlı Firebase Uygulama Sırası

### M0 — Proje Hazırlığı ve Teknik Zemin

- Firebase project hazırlanır.
- FlutterFire yapılandırması yapılır.
- Gerekli paketler eklenir.
- Ortam çalışıyor mu kontrol edilir.
- `firebase_options.dart` oluşur.

### M1 — App Shell, Routing ve Auth

- Firebase Auth bağlanır.
- Login ekranı çalışır.
- Register ekranı çalışır.
- Logout çalışır.
- AuthGate çalışır.
- Giriş yoksa Login/Register, giriş varsa Kütüphane yönlendirmesi yapılır.

### M2 — PromptCard Domain Model

- Firebase’den bağımsız `PromptCard` modeli oluşturulur.
- Status enum/key yapısı kurulur.
- Variable extraction mantığı domain/helper düzeyinde hazırlanır.
- Repository interface tanımlanır.

### M3 — Data Layer ve Firestore

- Firestore service hazırlanır.
- DTO hazırlanır.
- Mapper hazırlanır.
- Repository implementation hazırlanır.
- İlk security rules taslağı yazılır.

### M4 — İlk Çekirdek Akış

- Hızlı Ekle Firestore’a kayıt atar.
- Kullanıcı kendi promptlarını kütüphanede görür.
- Read/create kullanıcı izolasyonu kontrol edilir.

### M6 — Prompt Düzenleme, Status ve Arşiv

- Update kuralları kontrol edilir.
- Status update çalışır.
- Arşivleme `status: archived` olarak çalışır.
- `ownerId` değiştirilemezliği kontrol edilir.

### M10 — Güvenlik, Test ve V1 Kapanış

- Final Firestore rules kontrolü yapılır.
- Yetkisiz erişim test edilir.
- Cross-user read/write engellenir.
- Delete kapalı mı kontrol edilir.
- V1 dışı backend/AI/analytics sızıntısı kontrol edilir.

---

## 14. Index ve Performans Notları

V1’de performans planı sade tutulacaktır.

- İlk sürümde kullanıcı başına veri hacmi düşük/orta varsayılır.
- `updatedAt` sıralaması kullanılabilir.
- `status`, `category`, `tags` filtreleri gerekirse Firestore index isteyebilir.
- Büyük veri hacmi oluşursa pagination / limit eklenecektir.
- V1’de gelişmiş arama motoru kurulmayacaktır.

İleride değerlendirilebilecekler:

- Pagination
- Composite index
- Server-side search
- Algolia / Meilisearch / Typesense
- Embedding tabanlı semantik arama

Bu başlıklar V2/V3 park alanındadır.

---

## 15. Offline / Cache Notu

V1 cloud-first kabul edilmiştir.

Firestore’un yerel cache davranışı teknik avantaj olarak kullanılabilir; ancak V1’de explicit offline-first deneyim, conflict resolution veya local-first sync kapsam dışıdır.

---

## 16. V1 Dışında Bırakılan Firebase / Backend Başlıkları

V1 kapsamında olmayacak başlıklar:

- Cloud Functions
- AI Gateway
- Model routing
- Token / cost log
- AI quota backend
- Payment backend
- Push notification
- Analytics zorunluluğu
- Crashlytics zorunluluğu
- Firestore triggers
- Public sharing
- Team/workspace
- Admin panel
- Kalıcı delete

---

## 17. V2 AI Gateway İçin Güvenlik Notu

V1’de AI kullanılmayacaktır.

V2’de AI işlemleri eklendiğinde:

- Flutter istemcisi OpenAI, Gemini, Claude, Mistral veya başka bir sağlayıcıya doğrudan bağlanmayacaktır.
- AI API key client tarafında tutulmayacaktır.
- Model routing backend’de yapılacaktır.
- Usage log, kota ve maliyet takibi backend tarafındaki AI Gateway / Adapter mimarisiyle yönetilecektir.

---

## 18. Riskler ve Kontrol Listesi

### Ana riskler

- Firestore rules fazla gevşek yazılırsa kullanıcı verileri açığa çıkabilir.
- UI doğrudan Firestore’a bağlanırsa mimari sınır bozulur.
- `ownerId` doğrulanmazsa veri sahipliği zayıflar.
- Delete erken açılırsa veri kaybı riski doğar.
- V1’e AI/backend/kota sistemi sızarsa kapsam şişer.
- Client-side arama veri büyüyünce yavaşlayabilir.

### Kontrol soruları

- Auth olmayan kullanıcı prompt okuyabiliyor mu?
- Kullanıcı A, kullanıcı B’nin promptlarını okuyabiliyor mu?
- Kullanıcı `ownerId` alanını değiştirebiliyor mu?
- `promptText` boş kaydedilebiliyor mu?
- Arşivleme gerçekten delete yerine status update mi?
- UI içinde doğrudan Firebase çağrısı var mı?
- Firestore DTO’su UI’a sızmış mı?
- V1’de Cloud Functions veya AI API key eklenmiş mi?

---

## 19. İlgili ADR Kayıtları

Bu belge şu ADR kayıtlarıyla ilişkilidir:

- `ADR-001-cloud-first-v1.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-006-v1-manual-core-v2-ai-layer.md`
- `ADR-007-ai-gateway-adapter-v2.md`
- `ADR-009-firestore-user-subcollection-structure.md`
- `ADR-010-archive-instead-of-delete-v1.md`

---

## 20. Referans Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`

---

## 21. Kapanış Notu

`04_firebase_firestore_plan.md`, V1’in Firebase Auth ve Cloud Firestore kullanımını sade, güvenli ve V1 kapsamına uygun şekilde planlar.

Bu belgeye göre V1’de Firebase, ürünün cloud-first prompt saklama ve kullanıcı hesabı ihtiyacını karşılayan teknik taşıyıcıdır. Canonical veri modeli Firestore’a bağımlı olmayacak; kullanıcı sahipliği `ownerId` ve security rules ile korunacaktır.

V1’de AI, ödeme, kota, team/workspace, public sharing ve kalıcı delete kapsam dışında tutulacaktır.
