# Prompt Yönetim Aracı — Architecture

**Belge tipi:** V1 uygulama mimarisi belgesi  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmış kodlama öncesi hazırlık belgesi  
**Kapsam:** Flutter V1 mimari yapı, klasör düzeni, katman sınırları ve veri akışı  
**Son güncelleme:** 2026-05-25

---

## 1. Belgenin Amacı

Bu belge, Prompt Yönetim Aracı V1 uygulamasının Flutter mimarisini tanımlar.

Amaç; V1’in manuel prompt yaşam döngüsü çekirdeğini sade, test edilebilir, Firebase’e doğrudan bağımlı olmayan ve ileride V1.5 / V2 katmanlarına büyüyebilecek bir uygulama yapısıyla inşa etmektir.

Bu belge şu sorulara cevap verir:

- Kod hangi ana klasör yapısıyla ilerleyecek?
- Feature’lar nasıl ayrılacak?
- Domain / data / presentation katmanları nasıl kullanılacak?
- UI ile Firebase arasındaki sınır nerede olacak?
- Repository, service, DTO ve mapper yapıları ne işe yarayacak?
- V2 AI Gateway için mimari kapı nasıl açık tutulacak?

Bu belge kod tutorial’ı değildir. Teknik uygulama sırasında yön gösteren mimari referans belgesidir.

---

## 2. Mimari Ana Karar

V1 geliştirme yaklaşımı:

```text
Feature-first + hafif clean architecture
```

Bu kararın anlamı:

- Uygulama önce özellik alanlarına ayrılır.
- Her feature kendi içinde katmanlara bölünür.
- Gereksiz soyutlama yapılmaz.
- UI, data ve domain birbirine karıştırılmaz.
- Firebase detayları UI katmanına sızmaz.
- V1 önce çalışan dikey çekirdek akışla inşa edilir.

V1’de hedef, teorik olarak kusursuz ama ağır bir mimari kurmak değildir. Hedef, çalışan çekirdek ürünü temiz sınırlarla kurmaktır.

---

## 3. Ana Klasör Yapısı

V1 için ana yapı şu şekilde olacaktır:

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

### 3.1 `app/`

`app/`, uygulamanın genel kabuğunu taşır.

İçerebileceği alanlar:

- App root
- Theme
- Routing
- App-level providers
- AuthGate bağlantısı
- Global navigation setup

Örnek:

```text
lib/
  app/
    routing/
    theme/
```

---

### 3.2 `core/`

`core/`, feature bağımsız ortak yapıları içerir.

İçerebileceği alanlar:

- Ortak hata sınıfları
- Ortak result / failure yapıları
- Constants
- Validators
- Date helpers
- Logging helpers
- Common widgets
- Utility fonksiyonları
- Firebase config wrapper, gerekirse

Örnek:

```text
lib/
  core/
    constants/
    errors/
    utils/
    validation/
    widgets/
```

Kural:

> `core/`, “nereye koyacağımı bilemedim” klasörü olmayacaktır.

Bir kod gerçekten birden fazla feature tarafından kullanılıyorsa `core/` içine alınmalıdır. Aksi hâlde ilgili feature içinde kalmalıdır.

---

### 3.3 `features/`

`features/`, ürünün ana iş alanlarını taşır.

V1 ana feature’ları:

- `auth`
- `prompts`
- `settings`

Her feature kendi içinde `domain`, `data` ve `presentation` katmanlarına ayrılır.

---

## 4. Feature İç Yapısı

Her feature için standart yapı:

```text
feature_name/
  domain/
  data/
  presentation/
```

Daha detaylı önerilen yapı:

```text
feature_name/
  domain/
    entities/
    repositories/
    usecases/
  data/
    dto/
    mappers/
    repositories/
    services/
  presentation/
    screens/
    providers/
    widgets/
```

Bu yapı her feature’da birebir aynı yoğunlukta kullanılmak zorunda değildir. Küçük feature’larda bazı klasörler boş kalabilir. Ancak mimari yön korunmalıdır.

---

## 5. Katmanların Sorumlulukları

### 5.1 Domain Katmanı

`domain/`, iş mantığının ve platformdan bağımsız modelin bulunduğu katmandır.

İçerebilir:

- Entity / model
- Repository interface
- Use case, gerekirse
- Domain validation
- Enum / value object benzeri yapılar

Örnek:

```text
features/prompts/domain/
  entities/
    prompt_card.dart
  repositories/
    prompt_repository.dart
```

Kural:

> Domain katmanı Firebase, Firestore, Firebase Timestamp veya platforma özel tipleri bilmez.

`PromptCard`, Firestore dokümanı değil; ürünün canonical domain modelidir.

---

### 5.2 Data Katmanı

`data/`, dış servislerle konuşan katmandır.

İçerebilir:

- Repository implementation
- Firebase service
- DTO
- Mapper
- Data source

Örnek:

```text
features/prompts/data/
  dto/
    prompt_card_dto.dart
  mappers/
    prompt_card_mapper.dart
  repositories/
    firebase_prompt_repository.dart
  services/
    prompt_firestore_service.dart
```

Kural:

> Firestore bilgisi data katmanında kalır.

Firestore document, collection path, query ve snapshot gibi detaylar presentation katmanına taşınmaz.

---

### 5.3 Presentation Katmanı

`presentation/`, UI ve state yönetimi katmanıdır.

İçerebilir:

- Screens
- Widgets
- Providers / Notifiers
- UI state classes
- Form controllers

Örnek:

```text
features/prompts/presentation/
  screens/
    prompt_library_screen.dart
    quick_add_prompt_screen.dart
    prompt_detail_screen.dart
  providers/
    prompt_library_provider.dart
    prompt_form_provider.dart
  widgets/
    prompt_card_tile.dart
```

Presentation katmanı:

- Kullanıcı aksiyonunu alır.
- Provider / Notifier üzerinden işlem başlatır.
- UI state’i gösterir.
- Repository veya Firebase detaylarını bilmez.

---

## 6. V1 Ana Feature’ları

## 6.1 Auth Feature

`auth` feature kullanıcı kimlik doğrulama akışını taşır.

V1’de kapsayacağı alanlar:

- Login
- Register
- Logout
- Auth state izleme
- AuthGate yönlendirmesi

Kritik kural:

> Login ve Register ekranları doğrudan kalıcı yönlendirme kararları vermemelidir. AuthGate merkezi karar noktası olarak çalışmalıdır.

AuthGate şunları belirler:

- Kullanıcı giriş yapmış mı?
- Giriş yapmamışsa Login / Register akışına mı gitmeli?
- Giriş yapmışsa Prompt Kütüphanesi’ne mi gitmeli?

---

## 6.2 Prompts Feature

`prompts` feature V1’in ana ürün alanıdır.

V1’de kapsayacağı alanlar:

- Prompt ekleme
- Prompt listeleme
- Prompt detay
- Prompt düzenleme
- Status değiştirme
- Arşivleme
- Arama / filtreleme
- Normal kopyala
- Değişkenli kopyala-doldur

Ana domain modeli:

```text
PromptCard
```

`PromptCard` canonical domain model olarak korunur ve Firestore’a bağımlı hâle getirilmez.

---

## 6.3 Settings Feature

`settings` feature V1’de sade tutulacaktır.

V1’de kapsayabileceği alanlar:

- Hesap bilgisi
- Çıkış yap
- Basit uygulama ayarları
- İleride dil / tema / export gibi alanlara yer açabilecek yapı

V1’de settings feature şişirilmemelidir.

V1’de olmayacaklar:

- Ödeme ayarları
- AI kota ekranı
- Gelişmiş profil yönetimi
- Takım / workspace ayarları

---

## 7. Veri Akışı

V1 veri akışı şu şekilde kilitlenmiştir:

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

Açılım:

| Katman | Görev |
|---|---|
| Screen | Kullanıcı arayüzü ve input |
| Provider / Notifier | UI state ve aksiyon yönetimi |
| Repository | Domain’in veri ihtiyacını soyutlar |
| Service | Firebase gibi dış servisle konuşur |
| Firebase | Auth / Firestore veri kaynağı |

Altın kural:

> Screen doğrudan Firebase Auth veya Cloud Firestore çağırmayacaktır.

---

## 8. Bağımlılık Yönü

Bağımlılık yönü sade ve kontrollü olmalıdır.

Ana ilkeler:

- Domain Firebase’i bilmez.
- UI Firebase’i bilmez.
- Data Firebase’i bilir.
- Repository interface domain tarafında olabilir.
- Repository implementation data tarafında olur.
- DTO ve mapper data katmanında kalır.
- Presentation, provider/notifier üzerinden repository davranışına erişir.

Özet:

```text
presentation → domain
data → domain
domain → dış teknolojiye bağımlı değil
```

---

## 9. Repository / Service / DTO / Mapper Mantığı

V1’de Firestore ile domain model arasında doğrudan bağlantı kurulmayacaktır.

Önerilen akış:

```text
Firestore Document ⇄ PromptCardDto ⇄ PromptCardMapper ⇄ PromptCard
```

### PromptCard

- Domain modeldir.
- Firestore tiplerini bilmez.
- Uygulamanın ana iş modelidir.

### PromptCardDto

- Firestore ile uyumlu veri taşıma nesnesidir.
- Timestamp dönüşümleri burada yönetilebilir.
- Firestore alan adları burada karşılanır.

### PromptCardMapper

- DTO ile domain modeli arasında dönüşüm yapar.
- Eksik alanlara güvenli varsayılan değer verebilir.
- `schemaVersion` ile gelecekte migration hazırlığına destek olabilir.

### Repository

- Presentation ve domain tarafına veri işlemlerini soyutlar.
- Data kaynağının Firebase mi başka bir backend mi olduğunu UI’a göstermez.

### Service

- Firebase Auth veya Firestore gibi teknik servislerle doğrudan konuşur.
- Collection path, query ve snapshot gibi detayları yönetir.

---

## 10. State Management Yaklaşımı

V1’de state yönetimi Provider / Notifier yaklaşımıyla ele alınacaktır.

Riverpod kullanılması durumunda temel yaklaşım:

- Screen’ler provider izler.
- Notifier kullanıcı aksiyonlarını yönetir.
- Notifier repository çağırır.
- Loading / error / success state’leri yönetilir.
- Form state ayrı tutulabilir.
- Firebase stream veya future doğrudan ekrana bağlanmaz; provider üzerinden yönetilir.

Bu belge paket versiyonlarını belirlemez. Paket sürümleri M0 teknik kurulum sırasında netleştirilecektir.

---

## 11. Routing ve AuthGate Yaklaşımı

Routing merkezi yönetilecektir.

V1 minimum rota alanları:

- AuthGate / Splash
- Login
- Register
- Prompt Library
- Quick Add
- Detailed Add
- Prompt Detail
- Prompt Edit
- Variable Fill
- Settings

Kritik kural:

> Auth durumuna göre yönlendirme merkezi yapılacak; ekranların kendi içinde dağınık navigation kararları vermesi azaltılacaktır.

AuthGate, giriş durumuna göre ana yönlendirme kararını verecektir.

---

## 12. Error Handling Yaklaşımı

V1’de hata yönetimi sade ama katmanlı olmalıdır.

Önerilen yaklaşım:

- Data katmanı teknik hatayı yakalar.
- Repository bunu domain’e uygun hata tipine çevirebilir.
- Provider / Notifier hatayı UI state’e dönüştürür.
- Screen kullanıcıya okunabilir mesaj gösterir.

Kontrol edilecek hata alanları:

- Auth hataları
- Firestore permission hataları
- Network hataları
- Validation hataları
- Empty state
- Unexpected error

Kural:

> Teknik hata detayları UI’a ham şekilde fırlatılmamalıdır.

---

## 13. Validation Yaklaşımı

V1’de validation basit ama merkezi olmalıdır.

Temel validation kuralları:

- `promptText` boş olamaz.
- Sadece boşluk içeren `promptText` geçersizdir.
- `status` yalnızca izin verilen teknik key’lerden biri olabilir.
- `tags` string listesi olarak normalize edilir.
- Boş tag değerleri kaydedilmez.
- Tekrarlanan tag değerleri tekilleştirilebilir.
- `[DEĞİŞKEN_ADI]` formatı algılanır.
- Tekrarlanan değişkenler tekilleştirilebilir.
- `updatedAt` anlamlı değişiklikte güncellenir.

Detaylı veri davranışları `03_data_model.md` belgesinde tanımlanır.

---

## 14. Firebase Kullanım Sınırları

### 14.1 Firebase Auth

- Auth feature data/service katmanında kullanılır.
- Auth state provider üzerinden presentation’a taşınır.
- UI doğrudan `FirebaseAuth.instance` çağırmaz.

### 14.2 Cloud Firestore

- Prompts feature data/service katmanında kullanılır.
- Firestore path ve query yapısı service içinde kalır.
- DTO / mapper ile domain model ayrılır.
- Kullanıcı izolasyonu `ownerId` ve Firestore Security Rules ile korunur.
- UI doğrudan `FirebaseFirestore.instance` çağırmaz.

---

## 15. V2 AI Gateway İçin Mimari Hazırlık Notu

V1 AI içermeyecektir.

Ancak mimari, V2’de AI destekli katman eklendiğinde kırılmayacak şekilde korunacaktır.

V2 için ön ilke:

```text
Flutter istemcisi AI sağlayıcısını bilmeyecek.
AI API key client tarafında tutulmayacak.
Model routing backend’de yapılacak.
AI Gateway / Adapter backend tarafında konumlanacak.
```

V1’de yapılmayacaklar:

- AI prompt iyileştirme
- AI başlık önerisi
- AI kategori / etiket önerisi
- Semantik arama
- AI API key
- Cloud Functions / AI Gateway
- AI kota ekranı

Bu başlıklar V2 / V2.5 / V3 park alanında tutulacaktır.

---

## 16. Test Edilebilirlik İlkeleri

Mimari test edilebilirliği desteklemelidir.

İlkeler:

- Domain model Firebase’den bağımsız olduğu için test edilebilir olmalıdır.
- Repository interface mock’lanabilir olmalıdır.
- Mapper test edilebilir olmalıdır.
- Variable extraction logic ayrı test edilebilir olmalıdır.
- Provider / Notifier testleri mümkün olmalıdır.
- Firestore rules testleri ayrı güvenlik planında ele alınmalıdır.

Detaylı test yaklaşımı `07_test_security_plan.md` belgesinde tanımlanır.

---

## 17. Mimari Sınır Kontrol Listesi

Her milestone sonunda şu sorular kontrol edilmelidir:

- UI doğrudan Firebase Auth çağırıyor mu?
- UI doğrudan Cloud Firestore çağırıyor mu?
- Firestore DTO’su UI’a sızmış mı?
- Domain modeli Firebase tiplerine bağımlı mı?
- Provider içinde fazla iş mantığı birikmiş mi?
- Repository yalnızca veri erişimini mi soyutluyor?
- Mapper gerekli dönüşümleri yapıyor mu?
- Feature dışına gereksiz bağımlılık taşmış mı?
- V1 dışı AI / analytics / payment katmanı mimariye sızmış mı?
- Yeni kod doğru feature altında mı?
- Ortak kod gerçekten ortak mı?
- `core/` gereksiz “her şeyi at” klasörüne dönüşmüş mü?

Bu kontroller `architecture_boundary_checklist.md` içinde daha ayrıntılı tutulacaktır.

---

## 18. İlgili ADR Kayıtları

Bu belge aşağıdaki ADR kayıtlarıyla ilişkilidir:

- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-006-v1-manual-core-v2-ai-layer.md`
- `ADR-007-ai-gateway-adapter-v2.md`

İhtiyaç doğarsa ayrıca şu ADR açılabilir:

- `ADR-013-state-management-approach.md`
- `ADR-014-authgate-central-routing.md`

---

## 19. Referans Belgeler

Bu belge şu belgelerle birlikte kullanılmalıdır:

- `00_project_overview.md`
- `01_v1_scope.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`
- `09_development_notes.md`

---

## 20. Kapanış Notu

`02_architecture.md`, Prompt Yönetim Aracı V1’in Flutter mimari omurgasını tanımlar.

Kilitli mimari karar:

> V1, feature-first + hafif clean architecture ile geliştirilecek; ana yapı `app / core / features`, ana feature’lar `auth / prompts / settings`, feature içi katmanlar `domain / data / presentation` olacaktır. Veri akışı `Screen → Provider/Notifier → Repository → Service → Firebase` şeklinde korunacak, UI Firebase Auth veya Cloud Firestore’a doğrudan erişmeyecektir.

