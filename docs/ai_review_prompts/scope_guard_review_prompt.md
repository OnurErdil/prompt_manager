# Scope Guard Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 geliştirme sürecinde dış AI’dan **V1 kapsam dışı sızıntı kontrolü** almak için kullanılır.

Bu review özellikle şu soruya cevap arar:

> Mevcut kod, plan, öneri veya milestone çıktısı V1’in manuel çekirdek kapsamını koruyor mu, yoksa V1.5 / V2 / V3’e ait fikirler erkenden içeri mi sızıyor?

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- Her milestone sonunda
- Yeni özellik önerisi geldiğinde
- Dış AI review sonrası gelen önerileri süzerken
- Kodlama sırasında “bunu da ekleyelim” fikri doğduğunda
- M4 sonrası ilk çekirdek akış tamamlanırken
- M8 arama/filtreleme sırasında semantik arama riski doğarsa
- M9 değişkenli sistem sırasında template engine riski doğarsa
- M10 final V1 scope kapanışında

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

Temel problem:
Prompt değer kaybı. Yani iyi bir promptun zamanla bulunabilir, anlaşılabilir, geliştirilebilir ve yeniden kullanılabilir olmaktan çıkması.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1’in amacı:
Kullanıcının promptlarını hızlıca yakalaması, Prompt Kartı olarak saklaması, kategori/etiket/durum/değişken alanlarla düzenlemesi, arama/filtreleme ile bulması, normal veya değişkenli şekilde kopyalaması ve güncellemesidir.
```

## 4. V1’de Olacaklar

Review yapacak AI’ya V1’in kabul edilen kapsamını ver:

```md
V1’de olacaklar:
- Firebase Auth ile kullanıcı hesabı
- Cloud Firestore ile kullanıcıya bağlı veri saklama
- Hızlı Ekle
- Detaylı Ekle
- Prompt Kartı
- Prompt Kütüphanesi
- Basit metin arama
- Kategori filtresi
- Etiket filtresi
- Durum filtresi
- Normal Kopyala
- Değişkenli Kopyala-Doldur
- Prompt Düzenleme
- Status sistemi: raw, needs_edit, ready, archived
- Arşivleme: status: archived
- Basit Ayarlar / Hesap
```

## 5. V1’de Olmayacaklar

Review yapacak AI’ya şu listeyi net ver:

```md
V1’de olmayacaklar:
- AI başlık önerisi
- AI açıklama önerisi
- AI kategori / etiket önerisi
- AI prompt iyileştirme
- AI değişken önerisi
- AI Prompt Health Check
- AI Gateway
- AI provider API entegrasyonu
- AI quota / kredi ekranı
- Payment / subscription
- Ek kredi sistemi
- Semantik arama
- Embedding
- Search backend
- Usage analytics
- Kullanım sayısı
- Last used date
- Version history
- Prompt diff
- Kalıcı delete
- Trash / restore
- Browser extension
- Import / export
- Team / workspace
- Public sharing
- Marketplace
- Admin panel
- Cloud Functions
```

## 6. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Yeni özellik önerisi
- Milestone çıktısı
- Kod parçaları
- Klasör yapısı
- Veri modeli
- UI ekran listesi
- Firestore collection yapısı
- Dış AI’dan gelen öneriler
- Checklist sonucu
- Development notes
```

## 7. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 7.1 V1 Ana Akış Uyumu

- Öneri veya kod V1 ana akışına doğrudan hizmet ediyor mu?
- `Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle` akışını tamamlıyor mu?
- Bu özellik olmadan V1 kullanılabilir mi?
- Bu özellik V1’in minimum çekirdeği için şart mı?

### 7.2 AI Sızıntısı

Aşağıdakiler içeri girmiş mi?

- AI başlık önerisi
- AI açıklama önerisi
- AI kategori/etiket önerisi
- AI prompt iyileştirme
- AI değişken önerisi
- AI otomatik düzenleme
- AI Gateway
- AI API key
- Model routing
- Token/kota/maliyet sistemi

### 7.3 Search Sızıntısı

Aşağıdakiler içeri girmiş mi?

- Semantik arama
- Embedding
- Vector database
- Search backend
- Ranking/relevance scoring
- AI destekli arama

### 7.4 Analytics Sızıntısı

Aşağıdakiler içeri girmiş mi?

- `usageCount`
- `lastUsedAt`
- Kullanım geçmişi
- Dashboard
- Prompt performans analitiği
- AI usage log
- Cost tracking

### 7.5 Version / Delete Sızıntısı

Aşağıdakiler içeri girmiş mi?

- Version history
- Prompt diff
- Snapshot geçmişi
- Kalıcı delete
- Trash
- Restore
- `deletedAt`
- `isDeleted`

### 7.6 Monetization Sızıntısı

Aşağıdakiler içeri girmiş mi?

- Payment
- Subscription
- Play Store Billing
- Premium paket
- AI kredi
- Ek kredi
- Kota ekranı
- Abonelik yenileme kontrolü

### 7.7 Collaboration / Public Sızıntısı

Aşağıdakiler içeri girmiş mi?

- Team
- Workspace
- Role/permission matrix
- Shared library
- Public sharing
- Marketplace
- Community prompts
- Public profile

### 7.8 Infrastructure Sızıntısı

Aşağıdakiler içeri girmiş mi?

- Cloud Functions
- Custom backend
- AI Gateway
- Search backend
- Public API
- Queue/job system
- Notification backend
- Admin backend

## 8. Karar Sınıflandırması

AI’dan her öneriyi şu sınıflardan birine koymasını iste:

```md
Karar sınıfları:
- V1’e uygun
- V1’e uygun ama sadeleştirilmeli
- V1.5 parking lot
- V2 parking lot
- V2.5 / V3 parking lot
- Reddedilmeli
- ADR adayı
- Checklist’e eklenmeli
- Development notes’a açık soru olarak yazılmalı
```

## 9. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Scope Guard Review Sonucu

## 1. Genel Değerlendirme
V1 kapsamı korunuyor mu?

## 2. V1’e Uygun Olanlar
- ...

## 3. V1’e Uygun Ama Sadeleştirilmesi Gerekenler
- ...

## 4. V1 Scope Leak Riskleri
Her risk için:
- Risk:
- Neden V1 dışı:
- Hedef park alanı:
- Önerilen aksiyon:

## 5. AI Sızıntısı Kontrolü
- ...

## 6. Search / Semantic Sızıntısı Kontrolü
- ...

## 7. Analytics / Usage Sızıntısı Kontrolü
- ...

## 8. Version / Delete Sızıntısı Kontrolü
- ...

## 9. Payment / Quota Sızıntısı Kontrolü
- ...

## 10. Team / Public / Marketplace Sızıntısı Kontrolü
- ...

## 11. Infrastructure Sızıntısı Kontrolü
- ...

## 12. Parking Lot’a Taşınması Gerekenler
V1.5:
- ...
V2:
- ...
V2.5 / V3:
- ...

## 13. Reddedilmesi Gerekenler
- ...

## 14. Docs / Checklist / ADR Güncelleme Önerileri
- ...

## 15. Sonuç
Kapsam güvenli / Şartlı güvenli / Scope leak var
```

## 10. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- “Bunu da eklemek iyi olur” yaklaşımıyla V1’i büyütmeyin.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription önermeyin.
- V1’e team/workspace önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete/trash önermeyin.
- V1’e Cloud Functions/custom backend önermeyin.
- Değerli ama erken fikirleri parking lot olarak işaretleyin.
- V1 ana akışını doğrudan tamamlamayan her şeyi sorgulayın.
```

## 11. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir ürün kapsamı ve teknik scope reviewer gibi davran.

Aşağıdaki Prompt Yönetim Aracı V1 önerisini/kodunu/milestone çıktısını incele. Amacın yeni özellik önermek değil; V1 kapsamının korunup korunmadığını, V1.5/V2/V3’e ait fikirlerin erkenden içeri sızıp sızmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. Temel problem “prompt değer kaybı”dır.

V1 KAPSAMI:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1’DE OLACAKLAR:
- Firebase Auth ile kullanıcı hesabı
- Cloud Firestore ile kullanıcıya bağlı veri saklama
- Hızlı Ekle
- Detaylı Ekle
- Prompt Kartı
- Prompt Kütüphanesi
- Basit metin arama
- Kategori filtresi
- Etiket filtresi
- Durum filtresi
- Normal Kopyala
- Değişkenli Kopyala-Doldur
- Prompt Düzenleme
- Status sistemi: raw, needs_edit, ready, archived
- Arşivleme: status: archived
- Basit Ayarlar / Hesap

V1’DE OLMAYACAKLAR:
- AI başlık/açıklama/kategori/etiket önerisi
- AI prompt iyileştirme
- AI değişken önerisi
- AI Prompt Health Check
- AI Gateway / AI API entegrasyonu
- AI quota / kredi ekranı
- Payment / subscription
- Semantik arama / embedding
- Search backend
- Usage analytics / usageCount / lastUsedAt
- Version history / prompt diff
- Kalıcı delete / trash / restore
- Browser extension
- Import / export
- Team / workspace
- Public sharing
- Marketplace
- Admin panel
- Cloud Functions

İNCELEME GÖREVİ:
Sana verdiğim içeriği şu açılardan incele:
1. V1 ana akışına doğrudan hizmet ediyor mu?
2. V1’in minimum çekirdeği için şart mı?
3. AI/V2 özelliği V1’e sızmış mı?
4. Payment/quota/monetization V1’e sızmış mı?
5. Team/public/marketplace V1’e sızmış mı?
6. Semantic search/embedding V1’e sızmış mı?
7. Analytics/version history/delete V1’e sızmış mı?
8. Infrastructure gereksiz büyümüş mü?
9. Hangi maddeler parking lot’a taşınmalı?
10. Hangi maddeler reddedilmeli?

ÇIKTI FORMATIN:
# Scope Guard Review Sonucu

## 1. Genel Değerlendirme
## 2. V1’e Uygun Olanlar
## 3. V1’e Uygun Ama Sadeleştirilmesi Gerekenler
## 4. V1 Scope Leak Riskleri
## 5. AI Sızıntısı Kontrolü
## 6. Search / Semantic Sızıntısı Kontrolü
## 7. Analytics / Usage Sızıntısı Kontrolü
## 8. Version / Delete Sızıntısı Kontrolü
## 9. Payment / Quota Sızıntısı Kontrolü
## 10. Team / Public / Marketplace Sızıntısı Kontrolü
## 11. Infrastructure Sızıntısı Kontrolü
## 12. Parking Lot’a Taşınması Gerekenler
## 13. Reddedilmesi Gerekenler
## 14. Docs / Checklist / ADR Güncelleme Önerileri
## 15. Sonuç: Kapsam güvenli / Şartlı güvenli / Scope leak var

KIRMIZI KURALLAR:
- “Bunu da eklemek iyi olur” yaklaşımıyla V1’i büyütmeyin.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription önermeyin.
- V1’e team/workspace önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete/trash önermeyin.
- V1’e Cloud Functions/custom backend önermeyin.
- Değerli ama erken fikirleri parking lot olarak işaretleyin.
- V1 ana akışını doğrudan tamamlamayan her şeyi sorgulayın.

İNCELEYECEĞİN İÇERİK:
[Buraya özellik önerisi, milestone çıktısı, kod, dosya listesi veya dış AI’dan gelen öneri eklenecek.]
```

## 12. Review Sonrası İşleme

Review cevabı geldikten sonra:

- V1’e uygun maddeler mevcut milestone ile eşleştirilir.
- V1 dışı ama değerli maddeler `08_parking_lot_v1_5_v2.md` içine taşınır.
- Reddedilecek maddeler gerekçesiyle `09_development_notes.md` içine yazılır.
- Scope leak gerçekse kod veya plan sadeleştirilir.
- Checklist’e yeni kontrol maddesi gerekiyorsa eklenir.
- ADR gerektiren kapsam kararı varsa ADR adayı açılır.

## 13. Kapanış Notu

Bu prompt, V1’in küçük kalması için değil, doğru zamanda doğru büyümesi için vardır. Ürün fikri bahçe gibi; her tohumu aynı gün ekersen orman değil, karmaşa çıkar.
