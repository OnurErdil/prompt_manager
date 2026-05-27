# Prompt Yönetim Aracı — V1 Scope

## 1. Belge Bilgisi

**Belge tipi:** V1 kapsam belgesi  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında oluşturuldu  
**Kapsam:** V1 manuel prompt yaşam döngüsü çekirdeği  
**Son güncelleme:** 2026-05-25

Bu belge, Prompt Yönetim Aracı V1’in kapsam sınırlarını belirlemek için hazırlanmıştır. V1’de hangi özelliklerin yer alacağı, hangi özelliklerin kapsam dışında kalacağı, minimum ekran kapsamı, teknik kapsam özeti, milestone bağlantısı ve V1’in tamamlandı sayılması için minimum şartlar bu belgede tanımlanır.

---

## 2. V1’in Temel Tanımı

V1, Prompt Yönetim Aracı’nın **AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir**.

Kullanıcı V1’de değerli promptları yakalayacak, Prompt Kartı olarak kaydedecek, değişken alanlarla yeniden kullanılabilir hâle getirecek, kütüphanede arayıp filtreleyecek, normal veya değişkenli kopyala-doldur ile kullanacak ve gerektiğinde güncelleyecektir.

V1’in amacı, ürünün uzun vadeli “kişisel AI çalışma hafızası” vizyonunu küçültmeden, ilk çalışan çekirdeği sade ve uygulanabilir şekilde kurmaktır.

---

## 3. V1 Ana Başarı Ölçütü

V1’in ana başarı ölçütü şu akışın uçtan uca çalışmasıdır:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

| Ana Akış Adımı | V1’de Karşılığı |
|---|---|
| Yakala | Hızlı Ekle / Detaylı Ekle |
| Kartlaştır | Prompt Kartı alanlarıyla kayıt |
| Değişkenleştir | `[DEĞİŞKEN_ADI]` alanlarını algılama |
| Bul | Kütüphane, arama, filtreleme |
| Kullan | Normal Kopyala / Değişkenli Kopyala-Doldur |
| Güncelle | Prompt düzenleme, status değişimi, arşiv |

V1 tamamlandı sayılabilmesi için bu akışın sadece teorik olarak değil, çalışan uygulama içinde güvenilir biçimde tamamlanması gerekir.

---

## 4. V1 Ana Kullanıcı Akışı

### 4.1 Yakala

Kullanıcı değerli bir promptu hızlıca sisteme alır.

V1 karşılığı:

- Hızlı Ekle
- Detaylı Ekle
- Prompt metniyle minimum kayıt

### 4.2 Kartlaştır

Prompt yalnızca düz metin olarak değil, bağlamlı bir Prompt Kartı olarak tutulur.

V1 karşılığı:

- Başlık
- Açıklama
- Notlar
- Kategori
- Etiketler
- Durum
- Değişkenler
- Oluşturulma / güncellenme tarihi

### 4.3 Değişkenleştir

Prompt içindeki tekrar doldurulacak alanlar değişken standardıyla ayrılır.

V1 standardı:

```text
[DEĞİŞKEN_ADI]
```

### 4.4 Bul

Kullanıcı promptlarını kütüphanede arama ve filtreleme ile bulur.

V1 karşılığı:

- Basit metin arama
- Kategori filtresi
- Etiket filtresi
- Durum filtresi

### 4.5 Kullan

Kullanıcı promptu tekrar kullanabilir.

V1 karşılığı:

- Normal Kopyala
- Değişkenli Kopyala-Doldur

### 4.6 Güncelle

Kullanıcı promptu zaman içinde düzenleyebilir, durumunu değiştirebilir veya arşivleyebilir.

V1 karşılığı:

- Prompt düzenleme
- Status değiştirme
- Arşivleme
- `updatedAt` güncelleme

---

## 5. V1 In Scope Özellikler

## 5.1 Kullanıcı Hesabı ve Auth

V1’de olacak:

- Kullanıcı hesabı
- E-posta / şifre ile kayıt
- E-posta / şifre ile giriş
- Çıkış yapma
- AuthGate / Splash davranışı
- Kullanıcıya bağlı veri
- Her kullanıcının yalnızca kendi promptlarını görmesi

V1’de olmayacak:

- Takım hesabı
- Organizasyon / workspace yapısı
- Rol ve yetki sistemi
- Sosyal giriş zorunluluğu
- Gelişmiş profil yönetimi

---

## 5.2 Prompt Ekleme

V1’de iki prompt ekleme yolu olacak:

- Hızlı Ekle
- Detaylı Ekle

Temel kural:

> Prompt metni, V1’de kullanıcının doldurması gereken tek zorunlu alandır.

Hızlı Ekle, kullanıcının değerli promptu sürtünmesiz şekilde sisteme almasını sağlar. Detaylı Ekle ise promptun daha baştan bağlamlı, sınıflandırılmış ve tekrar kullanılabilir bir Prompt Kartı olarak oluşturulmasına imkân verir.

---

## 5.3 Prompt Kartı

V1’de her prompt **Prompt Kartı** olarak tutulacaktır.

PromptCard alanları:

```text
id
ownerId
title
promptText
description
notes
category
tags
status
variables
createdAt
updatedAt
schemaVersion
```

Bu alanların detaylı açıklaması `03_data_model.md` belgesinde tutulacaktır.

---

## 5.4 Durum Sistemi

V1’de durum sistemi, promptun yaşam döngüsündeki yerini göstermek için kullanılacaktır.

Kullanıcıya görünen durumlar:

- Ham
- Düzenlenecek
- Kullanıma Hazır
- Arşiv

Teknik key’ler:

```text
raw
needs_edit
ready
archived
```

Arşiv, V1’de kalıcı silmenin yerine geçer.

> V1’de kalıcı silme kapsam dışıdır.

---

## 5.5 Kategori ve Etiketler

V1’de kategori ve etiket sistemi sade tutulacaktır.

- **Kategori:** Tek ana raf gibi çalışır.
- **Etiketler:** Esnek çapraz işaretleme alanı olarak çalışır.

V1’de olacak:

- Tek kategori
- Çoklu etiket
- Kategoriye göre filtreleme
- Etikete göre filtreleme

V1’de olmayacak:

- Çok katmanlı kategori ağacı
- AI otomatik etiketleme
- Etiket öneri motoru
- Taksonomi yönetim paneli

---

## 5.6 Değişken Alanlar

V1 değişken standardı:

```text
[DEĞİŞKEN_ADI]
```

V1’de olacak:

- Prompt metni içinden değişkenleri algılama
- Değişkenleri `variables` listesine çıkarma
- Değişkenli kopyala-doldur akışında bu alanları kullanıcıya doldurtma

V1’de olmayacak:

- Gelişmiş değişken tipleri
- Varsayılan değer sistemi
- Koşullu prompt blokları
- Zorunlu / opsiyonel değişken ayrımı
- AI destekli değişken önerisi

---

## 5.7 Kütüphane

V1’de kütüphane, promptların bulunabilirlik ve yeniden kullanım merkezi olarak çalışacaktır.

V1’de olacak:

- Prompt listesi
- Boş kütüphane hâli
- Prompt kartı özet görünümü
- Prompt detayına geçiş
- Temel sıralama / son güncelleme odaklı listeleme

V1’de olmayacak:

- Dashboard
- Gelişmiş koleksiyon sistemi
- Favoriler
- Pinleme
- Usage analytics
- Çoklu görünüm modları

---

## 5.8 Arama ve Filtreleme

V1’de olacak:

- Basit metin arama
- Başlık, prompt metni, açıklama ve notlarda arama
- Kategori filtresi
- Etiket filtresi
- Durum filtresi

V1’de olmayacak:

- Semantik arama
- Embedding tabanlı arama
- AI destekli arama
- Karmaşık sorgu dili
- Gelişmiş full-text search altyapısı

V1 için basit client-side arama yeterli kabul edilir.

---

## 5.9 Normal Kopyala

Normal Kopyala, prompt metnini olduğu gibi kopyalar.

V1’de olacak:

- Prompt metnini panoya kopyalama
- Kopyalama sonrası kullanıcıya basit başarı bildirimi

V1’de olmayacak:

- Kullanım sayısı artırma
- `lastUsedAt` güncelleme
- AI aracına otomatik gönderme

---

## 5.10 Değişkenli Kopyala-Doldur

Değişkenli Kopyala-Doldur, prompt içindeki `[DEĞİŞKEN_ADI]` alanlarını kullanıcıya doldurtur ve final prompt üretir.

V1’de olacak:

- Değişkenleri form alanı olarak gösterme
- Kullanıcının değişken değerlerini doldurması
- Final prompt üretme
- Final promptu kopyalama

V1’de olmayacak:

- Değişken tipleri
- Varsayılan değerler
- Koşullu bloklar
- AI destekli değişken önerisi

---

## 5.11 Prompt Düzenleme ve Arşiv

V1’de olacak:

- Prompt düzenleme
- Başlık düzenleme
- Prompt metni düzenleme
- Açıklama / not düzenleme
- Kategori / etiket düzenleme
- Status değiştirme
- Arşivleme
- Anlamlı değişiklikte `updatedAt` güncelleme

V1’de olmayacak:

- Version history
- Diff görüntüleme
- Geri alma sistemi
- Kalıcı silme
- Değişiklik yorumları

---

## 6. V1 Out of Scope Özellikler

Aşağıdaki özellikler V1 kapsamına alınmayacaktır:

- AI destekli prompt iyileştirme
- AI destekli başlık önerme
- AI destekli kategori / etiket önerme
- AI destekli açıklama önerme
- Semantik arama
- Embedding
- Browser extension
- Import / export
- Koleksiyonlar / gruplar
- Kullanım sayısı
- `lastUsedAt`
- Version history
- Prompt Health Check
- Hazır prompt marketplace
- Takım / workspace sistemi
- Web uygulaması zorunluluğu
- Abonelik / ödeme sistemi
- AI kredi / kota ekranı
- Push notification
- Gelişmiş onboarding
- Cloud Functions
- AI Gateway
- Public sharing
- Kalıcı delete

Bu özellikler stratejik olarak değerli olabilir; ancak doğru yerleri V1.5, V2 veya V3’tür.

---

## 7. V1.5 / V2 / V3 Parking Lot Bağlantısı

### V1.5

Kullanım rahatlatma ve destekleyici özellikler:

- Browser extension
- Basit import / export
- Koleksiyonlar / gruplar
- Kullanım sayısı
- Onboarding
- Prompt şablon kütüphanesi
- Kullanım sonrası mini review / Prompt Health Check
- Favori / pinleme, gerekirse

### V2

AI destekli akıllı katman:

- AI destekli başlık önerme
- AI açıklama önerisi
- Prompt iyileştirme
- Otomatik kategori / etiket önerme
- Semantik arama
- AI destekli import / export
- Güçlü şablon sistemi
- AI Gateway / Adapter
- AI hakkı / kredi sistemi

### V2.5

Gelişmiş AI / kota / büyük işlem katmanı:

- Toplu prompt iyileştirme
- Toplu sınıflandırma
- Büyük import analizi
- Kütüphane sağlık taraması
- Preflight maliyet tahmini
- Ek kredi gerektiren işlemler

### V3

Uzun vadeli kişisel AI çalışma hafızası:

- Proje bazlı prompt sistemleri
- Workflow’lar
- Entegrasyonlar
- Gelişmiş analitik
- Ajan destekli bakım
- Promptlar arası ilişki haritası

---

## 8. V1 Teknik Kapsam Özeti

V1 teknik kapsamı:

- Flutter
- Cloud-first yaklaşım
- Firebase Auth
- Cloud Firestore
- Kullanıcı hesabı gerekli
- Canonical PromptCard modeli
- Firestore’a bağımlı olmayan veri modeli
- Feature-first + hafif clean architecture
- `app / core / features`
- `auth / prompts / settings`
- UI Firebase’e doğrudan erişmeyecek

Veri akışı:

```text
Screen → Provider/Notifier → Repository → Service → Firebase
```

Bu teknik detayların ayrıntısı `02_architecture.md`, `03_data_model.md` ve `04_firebase_firestore_plan.md` belgelerinde tutulacaktır.

---

## 9. V1 Minimum Ekran Kapsamı

V1 minimum ekranları:

- AuthGate / Splash
- Login
- Register
- Prompt Kütüphanesi
- Hızlı Ekle
- Detaylı Ekle
- Prompt Detay
- Prompt Düzenle
- Değişkenli Kopyala-Doldur
- Basit Ayarlar / Hesap

V1’de olmayacak ekranlar:

- Dashboard
- AI kullanım paneli
- Marketplace
- Takım yönetimi
- Gelişmiş profil
- Ödeme / abonelik ekranı
- Gelişmiş istatistik ekranı

---

## 10. V1 Milestone Bağlantısı

| Milestone | Scope Bağlantısı |
|---|---|
| M0 | Proje zemini |
| M1 | Auth ve routing |
| M2 | PromptCard domain modeli |
| M3 | Firestore data layer |
| M4 | İlk çekirdek akış |
| M5 | Detay ve normal kopyala |
| M6 | Düzenleme, status, arşiv |
| M7 | Detaylı ekle |
| M8 | Arama ve filtreleme |
| M9 | Değişkenli kopyala-doldur |
| M10 | Güvenlik, test, V1 kapanış |

Detaylı milestone rotası `05_milestone_plan.md` belgesinde tutulacaktır.

---

## 11. Scope Leak Kontrol Soruları

V1’e yeni özellik eklenmeden önce şu sorular sorulmalıdır:

1. Bu özellik `Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle` akışına doğrudan hizmet ediyor mu?
2. V1’in manuel çekirdeğini kanıtlamak için şart mı?
3. Olmadan V1 kullanılamaz mı?
4. Bu özellik V1.5’e taşınsa ürünün çekirdeği bozulur mu?
5. Bu özellik AI, analitik, entegrasyon veya büyüme katmanına mı ait?
6. Bu özellik geliştirme süresini gereksiz uzatır mı?
7. Bu özellik veri modelini V1 için gereksiz karmaşıklaştırır mı?

Karar kuralı:

> Cevap net değilse özellik V1’e alınmaz, parking lot’a taşınır.

---

## 12. V1 Tamamlandı Sayılması İçin Minimum Şartlar

V1 tamamlandı sayılabilmesi için:

- Kullanıcı kayıt olabilir.
- Kullanıcı giriş yapabilir.
- Kullanıcı çıkış yapabilir.
- AuthGate doğru yönlendirme yapar.
- Kullanıcı promptu Hızlı Ekle ile kaydedebilir.
- Kullanıcı promptu Detaylı Ekle ile zengin kart olarak kaydedebilir.
- Prompt Firestore’da kullanıcıya bağlı saklanır.
- Kullanıcı yalnızca kendi promptlarını görür.
- Kütüphanede prompt listelenir.
- Prompt detayına girilebilir.
- Normal Kopyala çalışır.
- Prompt düzenlenebilir.
- Status değiştirilebilir.
- Prompt arşivlenebilir.
- Arama çalışır.
- Kategori filtresi çalışır.
- Etiket filtresi çalışır.
- Durum filtresi çalışır.
- `[DEĞİŞKEN_ADI]` değişkenleri algılanır.
- Değişkenli Kopyala-Doldur final prompt üretir.
- `createdAt / updatedAt` doğru çalışır.
- Firestore rules temel kullanıcı izolasyonunu sağlar.
- UI Firebase’e doğrudan erişmez.
- V1 dışı AI / analytics / marketplace / workspace gibi kapsamlar ürüne sızmamıştır.

---

## 13. Referans Belgeler

Bu belge aşağıdaki belgelerle birlikte kullanılacaktır:

- `00_project_overview.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`

---

## 14. Kapanış Notu

`01_v1_scope.md`, Prompt Yönetim Aracı V1’in kapsam sınırlarını koruyan ana belgedir.

Bu belgeye göre V1, **manuel ama güçlü bir prompt yaşam döngüsü çekirdeği** olarak geliştirilecektir. AI destekli akıllı katmanlar, gelişmiş arama, kullanım analitiği, ödeme, takım yapısı ve büyük entegrasyonlar V1 dışında tutulacaktır.

V1’in başarı ölçütü:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

akışının güvenli, sade ve çalışır biçimde tamamlanmasıdır.
