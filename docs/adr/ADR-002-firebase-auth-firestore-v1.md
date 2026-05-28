# ADR-002 — Firebase Auth + Cloud Firestore V1 Kararı

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1, kullanıcıya ait prompt kartlarını cloud-first yaklaşımla saklayacak bir mobil uygulama olarak planlanmıştır.

V1’de kullanıcı hesabı gerekli kabul edilmiştir. Her prompt kartı bir kullanıcıya ait olacak ve kullanıcı yalnızca kendi promptlarını okuyup değiştirebilmelidir.

Bu nedenle V1 için şu ihtiyaçları karşılayacak bir backend / veri saklama çözümü gereklidir:

- Kullanıcı kaydı ve giriş işlemleri
- Kullanıcı kimliği üzerinden veri sahipliği
- Prompt kartlarının kullanıcıya bağlı saklanması
- Flutter ile hızlı ve uyumlu geliştirme
- V1 seviyesinde basit create / read / update / archive akışları
- Güvenlik kurallarıyla kullanıcı izolasyonu
- Gelecekte V1.5 / V2 / V3 katmanlarına büyüyebilme

## Karar

Prompt Yönetim Aracı V1 için ana teknik aday olarak **Firebase Auth + Cloud Firestore** kullanılacaktır.

- Firebase Auth, kullanıcı hesabı, giriş, kayıt ve çıkış işlemleri için kullanılacaktır.
- Cloud Firestore, PromptCard kayıtlarının kullanıcıya bağlı saklanması için kullanılacaktır.
- Flutter istemcisi doğrudan Firebase’e UI katmanından erişmeyecektir.
- Firestore, V1 için saklama taşıyıcısıdır; ürünün canonical veri modeli Firestore’a bağımlı olmayacaktır.

## Alternatifler

### 1. Local-only saklama

Promptların yalnızca cihazda saklanması.

**Artıları:**

- Başlangıçta daha basit olabilir.
- Backend ihtiyacı azalır.
- Auth gerektirmez.

**Eksileri:**

- Cihaz değişiminde veri kaybı riski doğurur.
- Promptların kişisel çalışma sermayesi olarak korunması zayıflar.
- Çok cihazlı kullanım ve gelecekteki cloud özellikleri zorlaşır.
- V2 / V3 kişisel AI çalışma hafızası vizyonuyla zayıf uyumludur.

### 2. Local-first + cloud sync

Önce local veri tabanı, ardından cloud senkronizasyon.

**Artıları:**

- Offline deneyim güçlü olur.
- Gelişmiş veri kontrolü sağlar.

**Eksileri:**

- V1 için fazla karmaşıktır.
- Conflict resolution, sync state ve local/cloud tutarlılığı ek yük getirir.
- İlk çekirdek akışı geciktirebilir.

### 3. Supabase / PostgreSQL

İlişkisel backend alternatifi.

**Artıları:**

- SQL sorguları güçlüdür.
- İlişkisel veri, raporlama ve analitik için esnektir.
- Gelişmiş backend senaryolarına uygundur.

**Eksileri:**

- V1 için Firebase kadar hızlı başlangıç sağlamayabilir.
- Kullanıcının mevcut Flutter + Firebase deneyimiyle daha az uyumludur.
- V1’in basit kişisel prompt kartı saklama ihtiyacı için fazla ağır olabilir.

### 4. Custom backend

Özel API ve özel veri tabanı kurulması.

**Artıları:**

- Tam kontrol sağlar.
- Gelecekte AI Gateway ve özel backend mantıkları için esnek olabilir.

**Eksileri:**

- V1 için gereksiz geliştirme yükü getirir.
- Auth, veri saklama, güvenlik ve deployment süreçlerini büyütür.
- İlk ürün çekirdeğini geciktirir.

### 5. Firebase Auth + Cloud Firestore

Firebase tabanlı kullanıcı hesabı ve NoSQL veri saklama.

**Artıları:**

- Flutter ile güçlü uyumludur.
- Auth ve Firestore hızlı entegre edilir.
- V1 create / read / update / archive akışları için yeterlidir.
- Security rules ile kullanıcı izolasyonu sağlanabilir.
- Kullanıcının mevcut teknik deneyimine uygundur.
- V1’in cloud-first yönüyle uyumludur.

**Eksileri:**

- Firestore sorgu ve veri modelleme sınırları dikkatli yönetilmelidir.
- Security rules gevşek yazılırsa veri güvenliği riski doğar.
- İleri seviye ilişkisel raporlama için ideal olmayabilir.
- Veri modeli Firestore’a fazla bağlanırsa ileride taşıma zorlaşabilir.

## Gerekçe

Firebase Auth + Cloud Firestore V1 için en dengeli çözümdür.

Bu kararın gerekçeleri:

- V1’in cloud-first veri saklama ihtiyacını karşılar.
- Kullanıcı hesabı ve kullanıcıya bağlı veri sahipliği için yeterlidir.
- Flutter ile hızlı geliştirme sağlar.
- V1’in manuel prompt yaşam döngüsü çekirdeğini geciktirmeden kurulabilir.
- PromptCard create / read / update / archive akışları için uygundur.
- Security rules ile kullanıcı izolasyonu uygulanabilir.
- V1 için özel backend kurma maliyetini ve karmaşıklığını azaltır.
- Gelecekte veri modeli platform bağımsız tutulduğu sürece Firebase dışı alternatiflere geçiş kapısı açık kalır.

Ana koruma ilkesi:

> Firestore, V1 için saklama taşıyıcısıdır; PromptCard modeli Firestore dokümanı olarak tasarlanmayacaktır.

## Sonuçlar

Bu karar sonucunda:

- V1’de kullanıcı hesabı Firebase Auth ile kurulacaktır.
- Prompt verileri Cloud Firestore’da kullanıcıya bağlı saklanacaktır.
- Firestore collection yapısı ayrıca Firebase / Firestore planı belgesinde tanımlanacaktır.
- `ownerId` alanı kullanıcı sahipliği için canonical PromptCard modelinde korunacaktır.
- UI katmanı Firebase Auth veya Firestore’a doğrudan erişmeyecektir.
- Data katmanında DTO / Mapper / Repository / Service ayrımı kurulacaktır.
- Security rules V1 güvenliğinin temel parçası olacaktır.
- Firestore rules geliştirme sürecine dağıtılacaktır:
    - M3: İlk rules taslağı
    - M4: Read/create kullanıcı izolasyonu
    - M6: Update/archive güvenlik kontrolü
    - M10: Final güvenlik kontrolü

## Riskler

### Risk 1 — Firestore rules gevşek kalabilir

Özellikle şu tip kural V1 için yeterli değildir:

```text
allow read, write: if request.auth != null;
```

Bu kural, giriş yapmış tüm kullanıcıların veri erişimini gereğinden genişletebilir.

**Önlem:** Security checklist, Firestore rules checklist ve M10 final güvenlik kontrolü kullanılacaktır.

### Risk 2 — UI doğrudan Firebase’e bağlanabilir

Hızlı geliştirme sırasında UI içinde doğrudan Firebase çağrısı yapılması mimari sınırı bozar.

**Önlem:** `ADR-005-ui-does-not-access-firebase-directly.md` ve architecture boundary checklist uygulanacaktır.

### Risk 3 — Veri modeli Firestore’a bağımlı hâle gelebilir

Domain model içinde Firestore Timestamp veya document snapshot gibi teknik detaylar sızarsa platform bağımsızlık bozulur.

**Önlem:** Canonical PromptCard modeli, DTO ve Mapper ayrımı korunacaktır.

### Risk 4 — İleride ilişkisel ihtiyaçlar artabilir

V2 / V3 aşamalarında gelişmiş analitik, raporlama veya ilişkisel veri ihtiyacı artarsa Firestore sınırlayıcı olabilir.

**Önlem:** Veri modeli platform bağımsız tutulacak; Supabase / PostgreSQL park alternatifi korunacaktır.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda tekrar değerlendirilebilir:

- Kullanıcı verisi ilişkisel yapıya ciddi biçimde ihtiyaç duymaya başlarsa
- Çok gelişmiş raporlama / analitik ihtiyacı doğarsa
- Firestore maliyeti veya sorgu sınırları ürün büyümesini zorlamaya başlarsa
- Offline-first deneyim stratejik öncelik hâline gelirse
- V2 / V3 backend ihtiyaçları Firebase’in ötesine geçerse
- AI Gateway / Adapter için ayrı backend zorunlu hâle gelirse

## İlgili Belgeler

- `00_project_overview.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `07_test_security_plan.md`
- `ADR-001-cloud-first-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
