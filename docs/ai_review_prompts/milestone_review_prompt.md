# Milestone Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 geliştirme sürecinde her milestone sonunda dış AI’dan yapılandırılmış değerlendirme almak için kullanılır.

Bu review özellikle şu soruya cevap arar:

> Bu milestone gerçekten kapanabilir mi, yoksa güvenlik, mimari, veri davranışı, test veya V1 scope açısından açık kalan kritik noktalar var mı?

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- Her milestone sonunda
- Özellikle M1, M2, M3, M4, M6, M9 ve M10 kapanışlarında
- Bir milestone’dan sonraki milestone’a geçmeden önce
- Dış AI’dan genel ama kontrollü bir “geçiş kapısı” değerlendirmesi almak istendiğinde
- Checklist tamamlandıktan sonra ikinci göz kontrolü için

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

V1 teknik kararları:
- Flutter kullanılacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- V1 cloud-first olacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain model olacak.
- Firestore path: users/{userId}/prompts/{promptId}
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.
- V1’de AI, payment, marketplace, team/workspace, analytics, semantic search ve version history yok.
```

## 4. Milestone Bilgisi Şablonu

Review’a başlamadan önce dış AI’ya şu bilgileri ver:

```md
## İncelenen Milestone
Milestone: [M0 / M1 / M2 / ...]
Milestone adı: [...]
Milestone amacı: [...]

## Yapılan işler
- ...

## Değişen / oluşturulan dosyalar
- ...

## Test edilenler
- ...

## Bilinen açıklar
- ...

## Kullanılan checklist’ler
- ...

## Özellikle kontrol edilmesini istediğim noktalar
- ...
```

## 5. M0-M10 Milestone Hatırlatma

AI’ya ilgili milestone’u şu plana göre değerlendirmesini iste:

```text
M0 — Proje Hazırlığı ve Teknik Zemin
M1 — App Shell, Routing ve Auth
M2 — PromptCard Domain Model
M3 — Data Layer ve Firestore Bağlantısı
M4 — İlk Çekirdek Akış
M5 — Prompt Detay ve Normal Kopyala
M6 — Prompt Düzenleme, Status ve Arşiv
M7 — Detaylı Ekle
M8 — Arama ve Filtreleme
M9 — Değişkenli Kopyala-Doldur
M10 — Güvenlik, Test ve V1 Kapanış
```

## 6. Genel Kontrol Kriterleri

AI’dan şu kriterlere göre review yapmasını iste:

### 6.1 Milestone Amacı

- Milestone’un ana amacı karşılanmış mı?
- Bu milestone’un çıktısı net mi?
- Bir sonraki milestone’a geçiş için minimum şartlar sağlanmış mı?
- Milestone gereksiz şekilde sonraki aşamaların işini içine almış mı?

### 6.2 Çalışan Akış

- Bu milestone’un ana kullanıcı/teknik akışı çalışıyor mu?
- Mutlu yol test edilmiş mi?
- Hata durumları düşünülmüş mü?
- Boş durumlar düşünülmüş mü?

### 6.3 Veri Davranışı

- Veri doğru oluşturuluyor/okunuyor/güncelleniyor mu?
- PromptCard canonical modele uygun mu?
- `ownerId`, `createdAt`, `updatedAt`, `schemaVersion` gibi alanlar doğru mu?
- V1 dışı veri alanları eklenmiş mi?

### 6.4 Mimari Sınır

- UI doğrudan Firebase’e erişiyor mu?
- Repository / Service ayrımı korunuyor mu?
- DTO / Mapper presentation’a sızmış mı?
- Domain model Firebase’den bağımsız mı?
- `core/` gereksiz büyümüş mü?

### 6.5 Güvenlik

- Auth olmayan kullanıcı erişimi kapalı mı?
- Kullanıcı izolasyonu korunuyor mu?
- Cross-user read/write riski var mı?
- `ownerId` güvenliği korunuyor mu?
- Delete kapalı mı?
- Client tarafında secret/API key riski var mı?

### 6.6 Test

- Manuel testler yeterli mi?
- Unit/widget/repository/mapper test adayları doğru mu?
- Firestore rules testleri düşünülmüş mü?
- Cihaz/platform testleri gerekli yerde yapılmış mı?
- Eksik testler bir sonraki milestone’a risk yaratıyor mu?

### 6.7 Scope Leak

V1’e şu alanlar sızmış mı?

- AI özellikleri
- AI Gateway / API key
- Payment/subscription
- Team/workspace
- Marketplace/public sharing
- Usage analytics
- Version history
- Semantic search/embedding
- Permanent delete/trash
- Browser extension
- Import/export

### 6.8 Sonraki Milestone’a Geçiş

- Bu milestone kapanabilir mi?
- Şartlı kapanmalı mı?
- Önce düzeltilmesi gereken bloklayıcı var mı?
- Açık kalanlar development notes’a taşınabilir mi?
- Checklist veya ADR güncellemesi gerekiyor mu?

## 7. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Milestone Review Sonucu

## 1. Genel Değerlendirme
Milestone kapanışa ne kadar hazır?

## 2. Tamamlanan Güçlü Noktalar
- ...

## 3. Bloklayıcı Sorunlar
Bu sorunlar çözülmeden milestone kapanmamalı.
- Sorun:
- Neden bloklayıcı:
- Önerilen düzeltme:

## 4. Kritik Ama Bloklayıcı Olmayabilecek Riskler
- ...

## 5. Orta Öncelikli İyileştirmeler
- ...

## 6. Mimari Sınır Kontrolü
- UI/Firebase sınırı:
- Repository/Service:
- DTO/Mapper:
- Domain model:
- Core klasörü:

## 7. Veri Modeli Kontrolü
- PromptCard uyumu:
- ownerId:
- status:
- variables:
- timestamps:
- schemaVersion:

## 8. Güvenlik Kontrolü
- Auth:
- Kullanıcı izolasyonu:
- Firestore rules:
- delete/archive:
- client secret:

## 9. Test Kontrolü
- Yapılan testler:
- Eksik testler:
- Cihaz/platform testleri:
- Önerilen ek testler:

## 10. Scope Leak Kontrolü
- V1 dışı bir şey sızmış mı?
- Parking lot’a taşınması gereken fikir var mı?

## 11. Checklist / ADR / Docs Güncelleme Önerileri
- ...

## 12. Sonraki Milestone’a Geçiş Kararı
Seçeneklerden biri:
- Geçilebilir
- Şartlı geçilebilir
- Geçilmemeli

## 13. Öncelikli Aksiyon Listesi
Kritik / Orta / Düşük olarak sırala.
```

## 8. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- Bu review yeni özellik önerme alanı değildir.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription sistemi önermeyin.
- V1’e team/workspace yapısı önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını domain model yapmayı önermeyin.
- Gereksiz büyük refactor önermeden önce milestone’a uygun küçük çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.
```

## 9. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter/Firebase milestone reviewer gibi davran.

Aşağıdaki milestone sonucunu Prompt Yönetim Aracı V1 kararlarına göre incele. Amacın yeni özellik önermek değil; bu milestone’un gerçekten kapanıp kapanamayacağını, bir sonraki milestone’a geçiş için risk olup olmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. Temel problem “prompt değer kaybı”dır.

V1 KAPSAMI:
V1 AI’sız, manuel ama güçlü prompt yaşam döngüsü çekirdeğidir.

ANA AKIŞ:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

KİLİTLİ TEKNİK KARARLAR:
- Flutter kullanılacak.
- Firebase Auth + Cloud Firestore kullanılacak.
- V1 cloud-first olacak.
- Feature-first + hafif clean architecture kullanılacak.
- Ana yapı: app / core / features
- Feature’lar: auth / prompts / settings
- Her feature: domain / data / presentation
- Veri akışı: Screen → Provider/Notifier → Repository → Service → Firebase
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- PromptCard canonical domain model olacak.
- Firestore path: users/{userId}/prompts/{promptId}
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.
- V1’de AI, payment, marketplace, team/workspace, analytics, semantic search ve version history yok.

İNCELEME GÖREVİ:
Aşağıda verdiğim milestone özetini ve dosyaları şu açılardan incele:
1. Milestone amacı karşılanmış mı?
2. Ana akış çalışıyor mu?
3. Veri davranışı doğru mu?
4. Mimari sınırlar korunuyor mu?
5. UI Firebase’e doğrudan erişiyor mu?
6. Domain model Firestore’dan bağımsız mı?
7. DTO/Mapper presentation’a sızmış mı?
8. Güvenlik ve kullanıcı izolasyonu korunuyor mu?
9. Testler yeterli mi?
10. Cihaz/platform riski var mı?
11. V1 scope dışı bir şey sızmış mı?
12. Bir sonraki milestone’a geçilebilir mi?

MILESTONE BİLGİSİ:
Milestone: [M0/M1/M2/...]
Milestone adı: [...]
Milestone amacı: [...]

YAPILAN İŞLER:
- ...

DEĞİŞEN / OLUŞTURULAN DOSYALAR:
- ...

TEST EDİLENLER:
- ...

BİLİNEN AÇIKLAR:
- ...

KULLANILAN CHECKLIST’LER:
- ...

ÖZELLİKLE KONTROL ETMENİ İSTEDİĞİM NOKTALAR:
- ...

ÇIKTI FORMATIN:
# Milestone Review Sonucu

## 1. Genel Değerlendirme
## 2. Tamamlanan Güçlü Noktalar
## 3. Bloklayıcı Sorunlar
## 4. Kritik Ama Bloklayıcı Olmayabilecek Riskler
## 5. Orta Öncelikli İyileştirmeler
## 6. Mimari Sınır Kontrolü
## 7. Veri Modeli Kontrolü
## 8. Güvenlik Kontrolü
## 9. Test Kontrolü
## 10. Scope Leak Kontrolü
## 11. Checklist / ADR / Docs Güncelleme Önerileri
## 12. Sonraki Milestone’a Geçiş Kararı
## 13. Öncelikli Aksiyon Listesi

KIRMIZI KURALLAR:
- Bu review yeni özellik önerme alanı değildir.
- V1’e AI özelliği önermeyin.
- V1’e payment/subscription sistemi önermeyin.
- V1’e team/workspace yapısı önermeyin.
- V1’e marketplace/public sharing önermeyin.
- V1’e semantic search/embedding önermeyin.
- V1’e usage analytics/version history önermeyin.
- V1’e kalıcı delete önermeyin.
- UI’ın Firebase’e doğrudan erişmesini önermeyin.
- Firestore dokümanını domain model yapmayı önermeyin.
- Gereksiz büyük refactor önermeden önce milestone’a uygun küçük çözüm önerin.
- Canon kararlarıyla çelişen önerileri ayrıca işaretleyin.

İNCELEYECEĞİN İÇERİK:
[Buraya milestone çıktısı, kod parçaları, klasör yapısı, checklist sonucu veya ilgili dosyalar eklenecek.]
```

## 10. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Bloklayıcı sorunlar önce ele alınır.
- Şartlı geçiş önerileri kullanıcıyla değerlendirilir.
- V1 dışı öneriler parking lot’a taşınır veya reddedilir.
- Checklist’e eklenecek maddeler ilgili dosyaya işlenir.
- Kalıcı karar gerekiyorsa ADR adayı açılır.
- Kapanış notu `09_development_notes.md` içine yazılır.
- Sonraki milestone’a geçiş kararı kullanıcı tarafından onaylanır.

## 11. Kapanış Notu

Bu prompt her milestone’un çıkış kapısındaki kontrol memurudur. Ama amacı işi yavaşlatmak değil; raydan çıkmadan bir sonraki istasyona geçmeyi sağlamaktır.
