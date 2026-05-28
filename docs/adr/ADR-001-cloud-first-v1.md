# ADR-001 - Cloud-first V1 Kararı

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı, kullanıcının iyi promptlarını yalnızca geçici metinler olarak değil, zaman içinde değer kazanan kişisel AI çalışma varlıkları olarak ele alır.

V1'in ana hedefi, kullanıcının değerli promptları yakalaması, Prompt Kartı olarak saklaması, daha sonra bulması, yeniden kullanması ve güncellemesidir. Bu nedenle veri saklama yaklaşımı ürünün temel değer önerisini doğrudan etkiler.

Başlangıçta üç ana seçenek değerlendirildi:

1. Local-only veri saklama
2. Local-first + cloud sync yaklaşımı
3. Cloud-first veri saklama

## Karar

Prompt Yönetim Aracı V1, **cloud-first** yaklaşımıyla geliştirilecektir.

V1'de kullanıcı hesabı gerekli olacak ve prompt verileri kullanıcı hesabına bağlı olarak bulutta saklanacaktır.

V1 için ana teknik aday:

- Firebase Auth
- Cloud Firestore

## Alternatifler

### 1. Local-only

Verilerin yalnızca cihazda tutulması.

Avantajları:

- Daha basit başlangıç
- Backend ihtiyacı az
- İlk geliştirme daha hızlı görünebilir

Dezavantajları:

- Cihaz değişiminde veri kaybı riski
- Hesap bazlı kullanım yok
- Uzun vadeli kişisel AI çalışma hafızası vizyonuna zayıf uyum
- Export/import ihtiyacı erken doğabilir
- Ürünün değerli promptları kalıcı çalışma varlığına dönüştürme vaadini zayıflatır

### 2. Local-first + cloud sync

Verinin önce cihazda tutulup sonra bulutla senkronize edilmesi.

Avantajları:

- Offline deneyim güçlü olabilir
- Uzun vadede esnek bir mimari sağlayabilir
- Kullanıcı deneyimi açısından değerli olabilir

Dezavantajları:

- V1 için fazla karmaşık
- Conflict resolution gerekir
- Sync hataları doğabilir
- Geliştirme yükünü artırır
- İlk çekirdek ürün akışını geciktirebilir

### 3. Cloud-first

Verinin kullanıcı hesabına bağlı olarak bulutta tutulması.

Avantajları:

- Kullanıcı verisi hesapla korunur
- Cihazlar arası erişim için zemin sağlar
- V1 için yönetilebilir karmaşıklık sunar
- Firebase Auth + Firestore ile hızlı geliştirilebilir
- Uzun vadeli kişisel AI çalışma hafızası vizyonuyla uyumludur

Dezavantajları:

- Kullanıcı hesabı zorunluluğu getirir
- İnternet bağlantısına bağımlılık artar
- Firebase / backend güvenlik kuralları dikkatli tasarlanmalıdır

## Gerekçe

Cloud-first yaklaşım V1 için en dengeli seçenektir.

Prompt Yönetim Aracı'nın ana vaadi, iyi promptların sohbetlerde ve dağınık kayıtlarda değer kaybetmesini önlemek ve onları kalıcı kişisel çalışma varlıklarına dönüştürmektir.

Bu nedenle prompt verilerinin yalnızca cihazda tutulması ürünün uzun vadeli değer önerisiyle tam uyumlu değildir. Kullanıcının promptları, hesabına bağlı olarak daha güvenli, taşınabilir ve sürdürülebilir bir yapıda saklanmalıdır.

Local-first + cloud sync güçlü bir uzun vadeli seçenek olabilir, ancak V1 için gereksiz teknik karmaşıklık yaratır. V1'in amacı önce manuel prompt yaşam döngüsü çekirdeğini kanıtlamaktır.

## Sonuçlar

Bu kararın sonuçları:

- V1'de kullanıcı hesabı gerekli olacaktır.
- Firebase Auth kullanılacaktır.
- Prompt verileri Cloud Firestore'da tutulacaktır.
- Her PromptCard bir kullanıcıya `ownerId` ile bağlanacaktır.
- Her kullanıcı yalnızca kendi promptlarını okuyup değiştirebilmelidir.
- Firestore security rules V1'in kritik güvenlik parçası olacaktır.
- Local-only veya local-first sync V1 kapsamına alınmayacaktır.

## Riskler

### İnternet bağımlılığı

Cloud-first yaklaşım internet bağlantısı gerektirir.

V1 için bu kabul edilebilir görülmüştür. Explicit offline-first deneyim V1 kapsamı değildir.

### Güvenlik kuralları riski

Firestore rules gevşek yazılırsa kullanıcı verileri açığa çıkabilir.

Özellikle şu tarz gevşek kural kabul edilemez:

```text
allow read, write: if request.auth != null;
```

Kullanıcı izolasyonu `request.auth.uid`, path ve `ownerId` üzerinden sağlanmalıdır.

### Vendor lock-in riski

Firebase V1 için seçilse de ürünün canonical veri modeli Firestore'a bağımlı olmayacaktır. Bu risk, platform bağımsız `PromptCard` modeli, DTO ve Mapper ayrımıyla azaltılacaktır.

## Ne zaman tekrar değerlendirilecek?

Bu karar şu durumlarda tekrar değerlendirilebilir:

- Offline-first kullanım güçlü bir kullanıcı ihtiyacı hâline gelirse
- Firestore maliyetleri veya limitleri ürün büyümesini zorlamaya başlarsa
- Supabase / PostgreSQL gibi ilişkisel backend ihtiyacı belirginleşirse
- Export/import, çoklu cihaz veya migration ihtiyaçları büyürse
- V2/V3 aşamasında kişisel AI çalışma hafızası daha karmaşık veri ilişkileri gerektirirse

## İlgili Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`

## İlgili ADR Kayıtları

- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `ADR-009-firestore-user-subcollection-structure.md`
