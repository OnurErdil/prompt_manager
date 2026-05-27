# Architecture Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 geliştirme sürecinde Flutter mimarisinin kilitli mimari kararlara uygun olup olmadığını dış AI’a inceletmek için kullanılır.

Bu review özellikle şu soruya cevap arar:

> Kod yapısı V1 için belirlenen feature-first + hafif clean architecture yaklaşımına uygun mu, yoksa UI/data/domain sınırları karışmaya mı başladı?

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M1 — App Shell, Routing ve Auth sonrası
- M3 — Data Layer ve Firestore Bağlantısı sonrası
- M4 — İlk Çekirdek Akış sonrası
- Büyük refactor öncesi veya sonrası
- UI’ın Firebase’e doğrudan eriştiğinden şüphelenildiğinde
- `core/` klasörünün kontrolsüz büyüdüğü düşünüldüğünde
- M10 final V1 kapanış review sürecinde

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için geliştirilen kişisel prompt yaşam döngüsü yönetim aracıdır.

Ürünün temel problemi:
Prompt değer kaybı. Yani iyi bir promptun zamanla bulunabilir, anlaşılabilir, geliştirilebilir ve yeniden kullanılabilir olmaktan çıkması.

V1 kapsamı:
V1 AI’sız, manuel ama güçlü bir prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 teknik kararları:
- Flutter kullanılacak.
- V1 cloud-first olacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain model olacak, Firestore dokümanı olmayacak.
- Firestore detayları data/service katmanında kalacak.
```

## 4. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Klasör yapısı
- İlgili Dart dosyaları
- Provider/Notifier dosyaları
- Repository dosyaları
- Service dosyaları
- DTO / Mapper dosyaları
- Screen / Widget dosyaları
- İlgili checklist maddeleri
- Bilinen açıklar veya şüpheli noktalar
```

## 5. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 5.1 Genel Mimari

- `app / core / features` yapısı korunuyor mu?
- Feature-first yaklaşım uygulanmış mı?
- `auth`, `prompts`, `settings` feature ayrımı mantıklı mı?
- Her feature içinde `domain / data / presentation` ayrımı korunuyor mu?
- Kod gereksiz şekilde tek klasör altında toplanmış mı?
- Tam clean architecture’a kayıp V1’i yavaşlatacak aşırı soyutlama var mı?

### 5.2 UI / Firebase Sınırı

- Screen veya widget dosyalarında `FirebaseAuth.instance` var mı?
- Screen veya widget dosyalarında `FirebaseFirestore.instance` var mı?
- UI içinde Firestore collection path veya query logic var mı?
- UI doğrudan DTO kullanıyor mu?
- UI yalnızca provider/notifier üzerinden mi işlem başlatıyor?

### 5.3 Provider / Notifier

- Provider/Notifier UI state yönetiyor mu?
- Provider/Notifier repository çağırıyor mu?
- Provider/Notifier içinde gereksiz business logic birikmiş mi?
- Provider/Notifier doğrudan Firestore’a bağlanıyor mu?
- Loading/error/success state yeterli mi?

### 5.4 Repository / Service

- Repository interface ve implementation ayrımı mantıklı mı?
- Repository domain model döndürüyor mu?
- Repository UI’a Firestore snapshot veya DTO döndürüyor mu?
- Service Firebase ile konuşan katman olarak kalmış mı?
- Service UI state veya BuildContext biliyor mu?

### 5.5 DTO / Mapper

- DTO data katmanında mı?
- Mapper DTO ↔ Domain dönüşümünü merkezi yapıyor mu?
- Firestore Timestamp/date dönüşümleri mapper içinde mi?
- DTO presentation katmanına sızmış mı?
- PromptCard domain model Firestore DTO’suna dönüşmüş mü?

### 5.6 Domain Katmanı

- Domain model Firebase tiplerine bağımlı mı?
- Domain model UI veya data katmanını biliyor mu?
- PromptCard canonical model olarak korunuyor mu?
- Domain katmanında V1 dışı AI/analytics/team alanları var mı?

### 5.7 Core Klasörü

- `core/` gerçekten ortak kodları mı içeriyor?
- Feature’a özel kod yanlışlıkla core’a taşınmış mı?
- Core klasörü “nereye koyacağımı bilemedim” klasörüne dönüşmüş mü?

### 5.8 Scope Leak

V1’e şu katmanlar sızmış mı?

- AI Gateway
- AI provider client
- Payment/subscription
- Team/workspace
- Marketplace/public sharing
- Usage analytics
- Version history
- Semantic search/embedding
- Permanent delete/trash system

## 6. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Architecture Review Sonucu

## 1. Genel Değerlendirme
Kısa mimari durum özeti.

## 2. Güçlü Noktalar
- ...

## 3. Kritik Sorunlar
Her kritik sorun için:
- Sorun:
- Neden önemli:
- İlgili dosya/katman:
- Önerilen düzeltme:

## 4. Orta Öncelikli Sorunlar
- ...

## 5. Düşük Öncelikli İyileştirmeler
- ...

## 6. UI / Firebase Sınır Kontrolü
- UI doğrudan Firebase’e erişiyor mu?
- DTO presentation’a sızmış mı?
- Firestore path UI’da var mı?

## 7. Repository / Service / Mapper Kontrolü
- ...

## 8. Domain Model Kontrolü
- ...

## 9. Core Klasörü Kontrolü
- ...

## 10. Scope Leak Kontrolü
- V1 dışı bir şey sızmış mı?

## 11. Önerilen Aksiyonlar
Aksiyonları Kritik / Orta / Düşük olarak sırala.

## 12. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 7. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription sistemi önermeyin.
- V1’e team/workspace yapısı önermeyin.
- V1’e marketplace/public sharing önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını domain model olarak kullanmayı önermeyin.
- Kalıcı delete’i V1’e önermeyin.
- Gereksiz büyük refactor önermeden önce küçük ve V1’e uygun çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.
```

## 8. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter/Firebase mimari reviewer gibi davran.

Aşağıdaki projeyi, verilen kilit kararlara göre incele. Amacın yeni ürün fikri önermek değil; mevcut V1 mimarisinin doğru uygulanıp uygulanmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. Temel problem “prompt değer kaybı”dır. V1, AI’sız manuel prompt yaşam döngüsü çekirdeğidir.

V1 ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

KİLİTLİ TEKNİK KARARLAR:
- Flutter kullanılacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain modeldir, Firestore dokümanı değildir.
- Firestore detayları data/service katmanında kalmalıdır.
- DTO ve mapper presentation katmanına sızmamalıdır.
- V1’de AI, payment, marketplace, team/workspace, analytics, semantic search, version history ve kalıcı delete yoktur.

İNCELEME GÖREVİ:
Sana verdiğim klasör yapısını ve kodları şu açılardan incele:
1. Feature-first yapı doğru mu?
2. domain / data / presentation sınırları korunuyor mu?
3. UI doğrudan Firebase’e erişiyor mu?
4. Provider/Notifier doğru sorumlulukta mı?
5. Repository / Service ayrımı doğru mu?
6. DTO / Mapper ayrımı doğru mu?
7. Domain model Firebase’den bağımsız mı?
8. core/ klasörü gereksiz çöplüğe dönüşmüş mü?
9. V1 scope dışı bir özellik mimariye sızmış mı?
10. Bu mimari M0-M10 V1 geliştirme planına uygun mu?

ÇIKTI FORMATIN:
# Architecture Review Sonucu

## 1. Genel Değerlendirme
## 2. Güçlü Noktalar
## 3. Kritik Sorunlar
## 4. Orta Öncelikli Sorunlar
## 5. Düşük Öncelikli İyileştirmeler
## 6. UI / Firebase Sınır Kontrolü
## 7. Repository / Service / Mapper Kontrolü
## 8. Domain Model Kontrolü
## 9. Core Klasörü Kontrolü
## 10. Scope Leak Kontrolü
## 11. Önerilen Aksiyonlar
## 12. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription sistemi önermeyin.
- V1’e team/workspace yapısı önermeyin.
- V1’e marketplace/public sharing önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını domain model olarak kullanmayı önermeyin.
- Kalıcı delete’i V1’e önermeyin.
- Gereksiz büyük refactor önermeden önce küçük ve V1’e uygun çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.

İNCELEYECEĞİN İÇERİK:
[Buraya klasör yapısı, dosya listesi, kod parçaları veya milestone özeti eklenecek.]
```

## 9. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kabul edilecek önerileri ayır.
- V1 scope dışı önerileri reddet veya parking lot’a taşı.
- Mimari ihlal varsa ilgili checklist’e işle.
- Kalıcı karar gerekiyorsa ADR adayı aç.
- Notları `09_development_notes.md` içine yaz.
- Kod değişikliği gerekiyorsa milestone bağlamında uygula.

## 10. Kapanış Notu

Bu promptun amacı dış AI’dan yeni rota çizmesini istemek değil, bizim çizdiğimiz rotada kodun raydan çıkıp çıkmadığını kontrol ettirmektir. Direksiyon bizde, dış AI yan koltukta haritaya bakar.
