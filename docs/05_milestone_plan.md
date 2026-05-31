# Prompt Yönetim Aracı — V1 Milestone Plan

## 1. Belge Bilgisi

**Belge tipi:** V1 geliştirme milestone planı  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmış kodlama öncesi kaynak belge  
**Kapsam:** Prompt Yönetim Aracı V1 geliştirme sırası, milestone hedefleri, çıktılar ve geçiş kontrolleri  
**Son güncelleme:** 2026-05-31

Bu belge, Prompt Yönetim Aracı V1 geliştirme sürecinin M0’dan M10’a kadar hangi sırayla ilerleyeceğini tanımlar. Amaç, kodlama başladıktan sonra geliştirme yönünün dağılmasını önlemek ve her milestone sonunda neyin tamamlanmış sayılacağını netleştirmektir.

---

## 2. Milestone Planının Amacı

Bu belge şu sorulara cevap verir:

- V1 hangi sırayla geliştirilecek?
- Her milestone’un amacı nedir?
- Her milestone sonunda hangi somut çıktı oluşmalıdır?
- Hangi işler ilgili milestone kapsamına dahil değildir?
- Bir sonraki milestone’a geçmek için minimum şart nedir?
- Test, güvenlik, mimari sınır ve scope leak kontrolleri geliştirme sürecinde nereye yerleşir?

Bu belge bir sprint panosu veya ayrıntılı görev yönetimi dokümanı değildir. Ana görevi V1’in geliştirme rotasını korumaktır.

---

## 3. V1 Geliştirme Stratejisi

V1 geliştirme stratejisi, önce çalışan dikey çekirdek akışı kurmak üzerine kuruludur.

İlk hedef, kullanıcının şu temel akışı uçtan uca yaşayabilmesidir:

```text
Login/Register/AuthGate → Kütüphane → Hızlı Ekle → Firestore’a kullanıcıya bağlı kayıt → Kütüphanede Gör → Prompt Detay → Normal Kopyala
```

Bu strateji, tüm sistemi baştan kusursuz ve geniş hâle getirmek yerine, ürünün çekirdek değerini erken çalıştırmayı hedefler.

V1’in ana ürün akışı:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

---

## 4. Milestone Geçiş Kuralı

Bir milestone tamamlandı sayılmadan önce şu başlıklar kontrol edilmelidir:

- Çalışan akış
- Doğru veri davranışı
- Mimari sınır
- Hata durumları
- Güvenlik
- V1 kapsam dışı sızıntı kontrolü
- Sonraki milestone’a güvenli geçiş

Bir milestone’da açık kalan kritik konu varsa, konu `09_development_notes.md` içine yazılmalı ve gerekiyorsa ilgili checklist veya ADR güncellenmelidir.

---

## 5. M0-M10 Genel Tablo

| Milestone | Ana amaç | Beklenen çıktı |
|---|---|---|
| M0 | Proje zemini | Flutter/Firebase hazır, klasör yapısı kurulmuş |
| M1 | Auth ve routing | Login/Register/AuthGate çalışıyor; temel tema ve UI standardı hazır |
| M2 | Domain model | Firebase’den bağımsız PromptCard modeli hazır |
| M3 | Firestore data layer | DTO/Mapper/Repository/Service hazır |
| M4 | İlk çekirdek akış | Hızlı Ekle → Firestore → Kütüphane akışı çalışıyor |
| M5 | Detay ve kopyalama | Prompt Detay + Normal Kopyala çalışıyor |
| M6 | Düzenleme ve arşiv | Edit/status/archive çalışıyor |
| M7 | Detaylı ekle | Zengin Prompt Kartı oluşturma çalışıyor |
| M8 | Arama/filtreleme | Kütüphane bulunabilirlik sistemi çalışıyor |
| M9 | Değişkenli kullanım | Değişkenli Kopyala-Doldur çalışıyor |
| M10 | Kapanış | Güvenlik, test ve V1 kontrolü tamamlanıyor |

---

## Güncel Durum — 2026-05-31

**Son tamamlanan milestone:** M7 — Detaylı Ekle  
**Aktif / sıradaki milestone:** M8 — Arama / Filtreleme

M7 kapanışıyla kullanıcı, promptu hızlı ekleme dışında temel PromptCard alanlarını doldurarak detaylı şekilde oluşturabilir hale geldi. M8 başlatılmadı; yalnızca sıradaki milestone olarak işaretlendi.

---

# 6. Milestone Detayları

## M0 — Proje Hazırlığı ve Teknik Zemin

### Amaç

Kodlamaya başlamadan önce Flutter projesinin, Firebase hazırlığının, temel klasör yapısının ve proje belgelerinin hazır hâle getirilmesi.

### Kapsam

- Flutter projesi oluşturma
- Firebase project hazırlığı
- FlutterFire yapılandırması
- Temel paketlerin eklenmesi
- `lib/app`, `lib/core`, `lib/features` yapısının kurulması
- `auth`, `prompts`, `settings` feature klasörlerinin açılması
- `docs/`, `adr/`, `checklists/`, `ai_review_prompts/` klasörlerinin hazırlanması
- `setup_project_structure.ps1` scriptinin kullanılması veya hazır tutulması
- Git başlangıç düzeninin kurulması

### Ana çıktılar

- Proje açılıyor ve build alıyor.
- Firebase yapılandırması hazır.
- `firebase_options.dart` oluşmuş.
- Temel klasör yapısı kurulmuş.
- Kodlama öncesi docs paketi projeye eklenmiş.

### Dahil olmayanlar

- Auth ekranları
- Prompt modeli
- Firestore prompt kayıt işlemleri
- UI detay geliştirmeleri

### Kabul kontrolü

- [ ] Proje temiz şekilde açılıyor.
- [ ] Build alınabiliyor.
- [ ] Firebase bağlantı dosyaları oluşmuş.
- [ ] Klasör yapısı V1 mimarisine uygun.
- [ ] V1 dışı özellik kodu eklenmemiş.

### Sonraki milestone’a geçiş şartı

Proje zemini temiz şekilde hazır olmalı ve M1 Auth/Routing geliştirmesine başlanabilecek durumda olmalıdır.

---

## M1 — App Shell, Routing ve Auth

### Amaç

Uygulama kabuğu, routing ve temel kullanıcı hesabı akışını kurmak.

### Kapsam

- App root
- Temel theme başlangıcı
- Merkezi routing
- Login ekranı
- Register ekranı
- Logout davranışı
- AuthGate / Splash davranışı
- Firebase Auth bağlantısı
- M1.10 — İlk Tema, UI Temel Standartları ve V1 Görsel Kalite Planı

### Ana çıktılar

- Kullanıcı kayıt olabilir.
- Kullanıcı giriş yapabilir.
- Kullanıcı çıkış yapabilir.
- AuthGate giriş durumuna göre kullanıcıyı doğru ekrana yönlendirir.
- Temel Material 3 tema, spacing, typography, button/input/appbar standardı uygulanır.
- Auth ve placeholder ekranları minimum ürün hissi verecek şekilde toparlanır.

### M1.10 — İlk Tema, UI Temel Standartları ve V1 Görsel Kalite Planı

Amaç: Uygulamanın teknik olarak çalışan ama görsel olarak düz/ruhsuz kalmasını önlemek için V1’i şişirmeden temel tema, spacing, typography, button/input/appbar standardı ve auth/placeholder ekranlarında minimum ürün hissi oluşturmak.

Kapsam:

- Material 3 uyumlu temel `AppTheme`
- Login/Register ekranlarında daha düzenli spacing, başlık, açıklama ve form görünümü
- Prompt Library ve Settings placeholder ekranlarında minimum ürün hissi
- AppBar, FilledButton, OutlinedButton, TextButton ve InputDecoration için ortak temel stil

### Dahil olmayanlar

- Prompt ekleme
- Firestore prompt verisi
- Sosyal giriş
- Takım hesabı
- Gelişmiş profil yönetimi
- Logo, app icon, onboarding, animasyon, premium polish, tam marka sistemi
- Tüm ekranların final tasarımı
- PromptCard / Firestore / prompt ekleme özellikleri

### Kabul kontrolü

- [ ] Login çalışıyor.
- [ ] Register çalışıyor.
- [ ] Logout çalışıyor.
- [ ] AuthGate merkezi yönlendirme noktası olarak çalışıyor.
- [ ] Giriş yapmamış kullanıcı kütüphaneye erişemiyor.
- [ ] Login/Register ekranları kalıcı rota kararlarını tek başına yönetmiyor.
- [ ] Auth akışı bozulmadan, UI Firebase’e doğrudan erişmeden, temel tema ve UI standartları uygulanmış.

### Sonraki milestone’a geçiş şartı

Auth ve routing akışı güvenilir şekilde çalışmalı; temel tema/UI standardı uygulanmış olmalı ve PromptCard domain modeline geçilebilmelidir.

### Durum Notu — 2026-05-29

M1 — App Shell / Routing / Auth ve M1.10 — İlk Tema, UI Temel Standartları ve V1 Görsel Kalite Planı tamamlandı. Sıradaki aşama M2 — PromptCard Domain Model’dir. M2’de PromptCard domain modeli Firebase’den bağımsız kurulacak; Firestore data layer, prompt ekleme ve repository/service Firestore bağlantısı yapılmayacaktır.

---

## M2 — PromptCard Domain Model

### Amaç

PromptCard modelini Firebase’den bağımsız canonical domain modeli olarak kurmak.

### Kapsam

- `PromptCard` entity/model
- Status teknik key’leri
- `[DEĞİŞKEN_ADI]` değişken algılama mantığı
- Temel validation kararları
- Repository interface tanımı

### Ana çıktılar

- Canonical PromptCard modeli hazır.
- Model Firestore tiplerine bağımlı değil.
- `promptText` tek zorunlu kullanıcı alanı olarak korunuyor.
- Değişken algılama helper’ı hazırlanmış.
- Repository interface tanımlanmış.

### Dahil olmayanlar

- Firestore DTO
- Firebase service
- Mapper implementation
- UI formu

### Kabul kontrolü

- [ ] PromptCard alanları canonical modele uygun.
- [ ] Domain modeli Firestore `Timestamp` veya doküman tiplerine bağımlı değil.
- [ ] Status değerleri `raw`, `needs_edit`, `ready`, `archived` olarak tanımlı.
- [ ] Değişken algılama temel durumlarda çalışıyor.
- [ ] V1 dışı alanlar modele eklenmemiş.

### Sonraki milestone’a geçiş şartı

PromptCard modeli tek başına test edilebilir ve Firestore data layer’a bağlanmaya hazır olmalıdır.

---

## M3 — Data Layer ve Firestore Bağlantısı

### Amaç

Canonical PromptCard modelini Firestore saklama katmanına DTO, Mapper, Repository ve Service üzerinden bağlamak.

### Kapsam

- Firestore service
- PromptCard DTO
- PromptCard Mapper
- Repository implementation
- Kullanıcıya bağlı Firestore path yapısı
- İlk security rules taslağı

### Ana çıktılar

- Domain model ↔ DTO dönüşümü çalışır.
- Repository üzerinden Firestore’a prompt kaydedilebilir.
- Repository üzerinden Firestore’dan prompt okunabilir.
- UI Firebase’e doğrudan erişmez.
- İlk security rules taslağı oluşmuştur.

### Dahil olmayanlar

- Tam kullanıcı akışı
- Arama / filtreleme
- Prompt detay ekranı
- Değişkenli kopyala-doldur

### Kabul kontrolü

- [ ] Firestore service oluşturuldu.
- [ ] DTO ve mapper çalışıyor.
- [ ] Repository implementation data katmanında.
- [ ] UI doğrudan Firestore’a erişmiyor.
- [ ] `ownerId` create sırasında doğru atanıyor.
- [ ] `schemaVersion: 1` atanıyor.
- [ ] İlk security rules taslağı yazıldı.

### Sonraki milestone’a geçiş şartı

Repository üzerinden create/read akışı teknik olarak çalışmalı ve M4 çekirdek akışına bağlanabilir durumda olmalıdır.

---

## M4 — İlk Çekirdek Akış

### Amaç

V1’in ilk çalışan dikey omurgasını kurmak.

Ana akış:

```text
Login/Register/AuthGate → Kütüphane → Hızlı Ekle → Firestore’a kullanıcıya bağlı kayıt → Kütüphanede Gör
```

### Kapsam

- Kütüphane boş hâli
- Hızlı Ekle ekranı
- Firestore’a kullanıcıya bağlı kayıt
- Prompt listeleme
- Kullanıcıya bağlı veri okuma
- Read/create güvenlik kontrolü

### Ana çıktılar

- Kullanıcı prompt ekleyebilir.
- Eklenen prompt kütüphanede görünür.
- Kullanıcı yalnızca kendi promptlarını görür.

### Dahil olmayanlar

- Prompt detay ekranı
- Normal Kopyala
- Prompt düzenleme
- Detaylı Ekle
- Arama / filtreleme

### Kabul kontrolü

- [ ] Kütüphane boş hâli var.
- [ ] Hızlı Ekle çalışıyor.
- [ ] Boş `promptText` kaydedilemiyor.
- [ ] Prompt Firestore’a kullanıcıya bağlı kaydediliyor.
- [ ] Prompt kütüphanede görünüyor.
- [ ] Kullanıcı yalnızca kendi promptlarını görüyor.
- [ ] Cross-user read/create ilk güvenlik kontrolü yapıldı.

### Sonraki milestone’a geçiş şartı

İlk uçtan uca kayıt ve listeleme akışı çalışmalıdır.

---

## M5 — Prompt Detay ve Normal Kopyala

### Amaç

Promptu açıp yeniden kullanmanın ilk temel davranışını kurmak.

### Kapsam

- Prompt detay ekranı
- Prompt metni görüntüleme
- Metadata görüntüleme
- Normal Kopyala
- Kopyalama sonrası başarı bildirimi

### Ana çıktılar

- Kullanıcı prompt detayını açabilir.
- Prompt metnini olduğu gibi kopyalayabilir.

### Dahil olmayanlar

- Değişkenli kopyala-doldur
- Kullanım sayısı
- `lastUsedAt`
- Usage analytics

### Kabul kontrolü

- [ ] Prompt detay ekranı açılıyor.
- [ ] Prompt metni doğru görünüyor.
- [ ] Normal Kopyala çalışıyor.
- [ ] Kopyalama sonrası kullanıcıya bildirim veriliyor.
- [ ] Normal Kopyala `updatedAt` değiştirmiyor.
- [ ] Usage analytics veya `usageCount` eklenmedi.

### Sonraki milestone’a geçiş şartı

Prompt yeniden kullanımının en basit hali çalışmalıdır.

---

## M6 — Prompt Düzenleme, Status ve Arşiv

### Amaç

Prompt Kartı’nı yalnızca oluşturulan değil, güncellenebilen ve yaşam döngüsü yönetilebilen bir varlığa dönüştürmek.

### Kapsam

- Prompt düzenleme
- Status değiştirme
- Arşivleme
- `updatedAt` güncelleme
- Firestore update kuralları
- `ownerId` değiştirilememe kontrolü

### Ana çıktılar

- Kullanıcı promptu düzenleyebilir.
- Kullanıcı status değiştirebilir.
- Kullanıcı promptu arşivleyebilir.
- Arşiv kalıcı silme olarak çalışmaz.

### Dahil olmayanlar

- Version history
- Diff görüntüleme
- Kalıcı silme
- Geri alma sistemi

### Kabul kontrolü

- [ ] Prompt düzenlenebiliyor.
- [ ] `promptText` boş bırakılamıyor.
- [ ] Status değiştirilebiliyor.
- [ ] Arşivleme `status: archived` ile çalışıyor.
- [ ] Kalıcı delete yok.
- [ ] `ownerId` değiştirilemiyor.
- [ ] `createdAt` korunuyor.
- [ ] `updatedAt` anlamlı değişiklikte güncelleniyor.

### Sonraki milestone’a geçiş şartı

Prompt artık oluşturulabilen ve güncellenebilen bir çalışma varlığı olmalıdır.

---

## M7 — Detaylı Ekle

### Amaç

Promptu baştan zengin metadata ile Prompt Kartı olarak oluşturmak.

### Kapsam

- Detaylı Ekle ekranı
- Başlık
- Açıklama
- Notlar
- Kategori
- Etiketler
- Status seçimi
- Değişkenlerin algılanması

### Ana çıktılar

- Kullanıcı promptu zengin metadata ile oluşturabilir.
- `promptText` tek zorunlu kullanıcı alanı olarak kalır.
- Etiket / kategori davranışı çalışır.

### Dahil olmayanlar

- AI destekli alan önerisi
- Şablon kütüphanesi
- Gelişmiş onboarding

### Kabul kontrolü

- [ ] Başlık girilebiliyor.
- [ ] Açıklama girilebiliyor.
- [ ] Notlar girilebiliyor.
- [ ] Kategori girilebiliyor.
- [ ] Etiketler eklenebiliyor.
- [ ] Boş etiketler temizleniyor.
- [ ] Tekrarlanan etiketler tekilleştiriliyor.
- [ ] Status seçilebiliyor.
- [ ] Değişkenler algılanıyor.
- [ ] AI öneri özelliği eklenmedi.

### Sonraki milestone’a geçiş şartı

Prompt Kartı baştan bağlamlı ve sınıflandırılmış şekilde oluşturulabilmelidir.

---

## M8 — Arama ve Filtreleme

### Amaç

Kütüphaneyi pasif bir liste olmaktan çıkarıp bulunabilirlik merkezine dönüştürmek.

### Kapsam

- Metin arama
- Kategori filtresi
- Etiket filtresi
- Status filtresi
- Arşiv görünürlüğü davranışı
- Basit sıralama
- Boş sonuç durumu

### Ana çıktılar

- Kullanıcı doğru promptu arayarak bulabilir.
- Kullanıcı kategori / etiket / status ile filtreleyebilir.
- Arşivlenmiş promptların görünürlüğü kontrollüdür.

### Dahil olmayanlar

- Semantik arama
- Embedding
- AI destekli arama
- Gelişmiş full-text search altyapısı

### Kabul kontrolü

- [ ] Metin arama çalışıyor.
- [ ] Başlık içinde arama çalışıyor.
- [ ] Prompt metni içinde arama çalışıyor.
- [ ] Açıklama / not araması çalışıyor.
- [ ] Kategori filtresi çalışıyor.
- [ ] Etiket filtresi çalışıyor.
- [ ] Status filtresi çalışıyor.
- [ ] Arama + filtre birlikte çalışıyor.
- [ ] Boş sonuç durumu var.
- [ ] Semantik arama / embedding eklenmedi.

### Sonraki milestone’a geçiş şartı

Kütüphane aktif bulunabilirlik alanı olarak çalışmalıdır.

---

## M9 — Değişkenli Kopyala-Doldur

### Amaç

Promptu tekrar kullanılabilir mini araca dönüştürmek.

### Kapsam

- `[DEĞİŞKEN_ADI]` alanlarını form input’una dönüştürme
- Kullanıcıdan değişken değerleri alma
- Final prompt üretme
- Final promptu kopyalama
- Değişken yoksa uygun durum gösterme

### Ana çıktılar

- Kullanıcı değişkenli promptu doldurabilir.
- Final prompt oluşur.
- Final prompt kopyalanabilir.

### Dahil olmayanlar

- Değişken tipleri
- Varsayılan değerler
- Koşullu bloklar
- AI destekli değişken önerisi

### Kabul kontrolü

- [ ] Değişkenler form input’una dönüşüyor.
- [ ] Aynı değişken için tek input oluşuyor.
- [ ] Kullanıcı değerleri doldurabiliyor.
- [ ] Final prompt doğru üretiliyor.
- [ ] Final prompt kopyalanabiliyor.
- [ ] Değişken yoksa uygun mesaj gösteriliyor.
- [ ] V1 dışı değişken karmaşıklığı eklenmedi.

### Sonraki milestone’a geçiş şartı

Değişkenli promptlar pratik şekilde yeniden kullanılabilir olmalıdır.

---

## M10 — Güvenlik, Test ve V1 Kapanış

### Amaç

V1’in güvenli, test edilmiş ve kapsamı korunmuş şekilde kapanması.

### Kapsam

- Final manuel test turu
- Firestore rules final kontrolü
- Cross-user erişim testleri
- Mimari sınır kontrolü
- Scope leak kontrolü
- Cihaz / platform testleri
- V1 acceptance criteria kapanışı
- V1 kapanış notu

### Ana çıktılar

- V1 ana akışı uçtan uca çalışır.
- Kullanıcı izolasyonu sağlanır.
- UI Firebase’e doğrudan erişmez.
- V1 dışı özellikler sızmamıştır.
- Kritik hatalar kapatılmıştır.
- V1 kapanış checklist’i tamamlanmıştır.

### Dahil olmayanlar

- V2 AI
- Ödeme sistemi
- Marketplace
- Takım yapısı
- Public sharing
- Cloud Functions

### Kabul kontrolü

- [ ] Ana V1 akışı uçtan uca çalışıyor.
- [ ] Firestore rules production’a uygun kontrol edildi.
- [ ] Cross-user read/write engellendi.
- [ ] Auth olmayan kullanıcı erişemiyor.
- [ ] Delete kapalı.
- [ ] Client tarafında secret/API key yok.
- [ ] Android gerçek cihaz / emülatör temel testleri yapıldı.
- [ ] Mimari sınır korunuyor.
- [ ] Scope leak yok.
- [ ] Acceptance criteria kapanış maddeleri tamamlandı.

### Sonraki milestone’a geçiş şartı

M10, V1 kapanış milestone’udur. Bu aşamadan sonra V1 release readiness veya V1.5 planlamasına geçilebilir.

---

# 7. Her Milestone Sonu Kontrol Şablonu

Her milestone sonunda şu kontrol şablonu kullanılmalıdır:

```md
## Milestone Sonu Kontrolü

### 1. Çalışan Akış
- [ ] Bu milestone’un ana akışı çalışıyor mu?

### 2. Doğru Veri Davranışı
- [ ] Veri doğru oluşturuluyor/güncelleniyor/okunuyor mu?

### 3. Mimari Sınır
- [ ] UI doğrudan Firebase’e erişmiyor mu?
- [ ] Repository / Service ayrımı korunuyor mu?

### 4. Hata Durumları
- [ ] Boş veri, network hatası, yetki hatası gibi durumlar düşünülmüş mü?

### 5. Güvenlik
- [ ] Kullanıcı izolasyonu bozulmadı mı?

### 6. V1 Kapsam Dışı Sızıntı
- [ ] AI, analytics, ödeme, marketplace gibi V1 dışı alanlar eklenmedi mi?

### 7. Sonraki Adıma Geçiş
- [ ] Bu milestone bir sonraki adıma güvenle devredilebilir mi?
```

---

# 8. Kapsam Dışı Sızıntı Kontrolü

Her milestone sonunda şu V1 dışı başlıkların sızıp sızmadığı kontrol edilmelidir:

- AI destekli prompt iyileştirme
- AI başlık / açıklama önerisi
- Semantik arama
- Embedding
- Payment / subscription
- AI kota ekranı
- Usage analytics
- Version history
- Team / workspace
- Marketplace
- Public sharing
- Browser extension
- Cloud Functions
- AI Gateway
- Kalıcı delete

V1 ana akışına doğrudan hizmet etmeyen özellikler `08_parking_lot_v1_5_v2.md` içine taşınmalıdır.

---

# 9. İlgili Checklist Bağlantıları

Milestone planı şu checklist’lerle birlikte kullanılacaktır:

```text
docs/checklists/m0_project_setup_checklist.md
docs/checklists/m1_auth_routing_checklist.md
docs/checklists/m2_domain_model_checklist.md
docs/checklists/m3_firestore_data_layer_checklist.md
docs/checklists/m4_core_flow_checklist.md
docs/checklists/m5_prompt_detail_copy_checklist.md
docs/checklists/m6_edit_status_archive_checklist.md
docs/checklists/m7_detailed_add_checklist.md
docs/checklists/m8_search_filter_checklist.md
docs/checklists/m9_variable_fill_checklist.md
docs/checklists/m10_v1_release_readiness_checklist.md
docs/checklists/security_checklist.md
docs/checklists/architecture_boundary_checklist.md
docs/checklists/scope_leak_checklist.md
```

---

# 10. Referans Belgeler

Bu belge aşağıdaki kaynaklarla birlikte kullanılmalıdır:

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`
- `09_development_notes.md`

---

# 11. Kapanış Notu

`05_milestone_plan.md`, Prompt Yönetim Aracı V1’in M0’dan M10’a kadar izlenecek geliştirme rotasını belirler. Bu belge kodlama sırasında ana rota referansı olarak kullanılacaktır.

V1 geliştirme sırası şu şekilde kilitlenmiştir:

```text
M0 → M1 → M2 → M3 → M4 → M5 → M6 → M7 → M8 → M9 → M10
```

Bu sıranın amacı, önce çalışan çekirdek akışı kurmak; ardından detay, düzenleme, bulunabilirlik, değişkenli kullanım, güvenlik ve kapanış kontrolleriyle V1’i sağlamlaştırmaktır.
