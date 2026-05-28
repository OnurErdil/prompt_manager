# ADR-009 — No Permanent Delete in V1

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı V1'de kullanıcıların promptları kişisel çalışma varlıkları olarak ele alınacaktır. Ürünün temel amacı iyi promptların kaybolmasını önlemek ve onları tekrar kullanılabilir bilgi varlıklarına dönüştürmektir.

Bu nedenle promptların yanlışlıkla kalıcı olarak silinmesi V1 için önemli bir veri kaybı riski oluşturur. V1 kabul kriterleri için kalıcı delete zorunlu değildir.

## Karar

V1'de kalıcı silme özelliği olmayacaktır.

Prompt arşivleme, veri silme olarak değil status değişimi olarak uygulanacaktır:

```text
status: archived
```

Arşivlenen prompt Firestore'dan silinmeyecek; yalnızca yaşam döngüsü durumu `archived` olarak güncellenecektir.

## Alternatifler

### Alternatif 1 — Kalıcı delete

Kullanıcı promptu tamamen silebilir.

Avantajları:

- Kullanıcıya tam kontrol hissi verir.
- Veri temizliği kolay görünür.
- Basit delete operasyonu ile uygulanabilir.

Dezavantajları:

- Yanlışlıkla veri kaybı riski yüksektir.
- Geri alma sistemi yoksa kullanıcı değerli promptunu kaybedebilir.
- V1'in prompt değer kaybını önleme amacıyla çelişir.
- Firestore rules tarafında ek delete güvenliği gerekir.

### Alternatif 2 — Soft delete / deletedAt

Prompt silinmiş gibi işaretlenir, `deletedAt` alanı tutulur.

Avantajları:

- Geri alma veya çöp kutusu sistemi kurulabilir.
- Kalıcı delete'e göre daha güvenlidir.

Dezavantajları:

- V1 veri modeline ek alan ve ek yaşam döngüsü karmaşıklığı getirir.
- Arşiv ve silme ayrımı kullanıcı deneyiminde karışabilir.
- Çöp kutusu / geri alma gibi ek UI ihtiyacı doğurabilir.

### Alternatif 3 — Status ile arşivleme

Prompt silinmez, yalnızca `status: archived` olur.

Avantajları:

- V1 için en sade çözümdür.
- Veri kaybı riskini azaltır.
- Mevcut status sistemiyle uyumludur.
- Ek `deletedAt` veya çöp kutusu sistemi gerektirmez.
- Kullanıcı promptu arşiv filtresiyle geri bulabilir.

Dezavantajları:

- Kullanıcı tamamen silme beklentisi duyabilir.
- Veri temizlik ihtiyacı ileride tekrar gündeme gelebilir.
- Uzun vadede arşivler büyüyebilir.

## Gerekçe

Prompt Yönetim Aracı'nın ana problemi prompt değer kaybıdır. Bu problemi çözen bir ürünün V1'de yanlışlıkla kalıcı veri kaybı yaratabilecek bir delete akışı sunması doğru değildir.

V1'in ana amacı promptları yakalamak, kartlaştırmak, bulmak, kullanmak ve güncellemektir. Kalıcı silme bu çekirdek akış için zorunlu değildir.

Status ile arşivleme V1 için daha güvenli ve daha sade bir yaşam döngüsü davranışıdır.

## Sonuçlar

Bu karar sonucunda:

- V1'de kalıcı silme butonu olmayacaktır.
- Repository V1 davranışı olarak kalıcı delete sunmayacaktır.
- Firestore rules içinde delete kapalı tutulacaktır.
- Arşivleme `status: archived` update'i olarak yapılacaktır.
- Arşivlenen prompt Firestore'da kalacaktır.
- Varsayılan kütüphane görünümü arşivleri gizleyebilir.
- Arşiv filtresiyle arşivlenmiş promptlar görüntülenebilir.
- `deletedAt`, `isDeleted` veya trash alanları V1 modeline eklenmeyecektir.
- Geri alma / çöp kutusu sistemi V1 kapsamına alınmayacaktır.

## Veri Modeli Etkisi

V1 PromptCard modeli içinde `status` alanı kullanılacaktır.

Geçerli status key'leri:

```text
raw
needs_edit
ready
archived
```

V1'de şu alanlar eklenmeyecektir:

```text
deletedAt
isDeleted
trashExpiresAt
deletedBy
```

## Firestore Rules Etkisi

V1'de delete işlemi kapalı olmalıdır:

```text
allow delete: if false;
```

Arşivleme update operasyonudur:

```text
status: archived
```

Update sırasında:

- Kullanıcı yalnızca kendi promptunu güncelleyebilmelidir.
- `ownerId` değiştirilememelidir.
- `createdAt` değişmemelidir.
- `status` izin verilen key'lerden biri olmalıdır.

## Kullanıcı Deneyimi Etkisi

V1'de kullanıcı promptu silmez; arşivler.

Önerilen UX dili:

- Arşive taşı
- Arşivlenmiş promptlar
- Arşiv filtresi
- Arşivden çıkar, ileride gerekirse

V1'de "kalıcı olarak sil" dili veya davranışı gösterilmemelidir.

## Riskler

- Kullanıcı bazı promptları tamamen silmek isteyebilir.
- Arşiv birikirse kütüphane yönetimi zorlaşabilir.
- Arşiv filtresi net tasarlanmazsa kullanıcı promptun kaybolduğunu sanabilir.
- Privacy beklentileri ileride kalıcı silme ihtiyacını gündeme getirebilir.

## Risk Azaltma

- V1'de arşiv filtresi açık ve anlaşılır olmalıdır.
- Arşivlenen promptun silinmediği kullanıcı deneyiminde net olmalıdır.
- Kalıcı silme ihtiyacı V1 sonrası park alanında değerlendirilebilir.
- Firestore rules ve scope leak checklist'lerinde delete kapalı kontrolü yapılacaktır.

## İlgili Belgeler

- `01_v1_scope.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `docs/checklists/g04_firestore_rules_checklist.md`
- `docs/checklists/scope_leak_checklist.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-007-firestore-user-scoped-path.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1'de kalıcı silme yerine `status: archived` yaklaşımının kullanılacağı karar altına alınmıştır. V1'de promptlar silinmeyecek, arşivlenecektir.
