# Prompt Yönetim Aracı — Development Notes

## 1. Belge Bilgisi

**Belge tipi:** Canlı geliştirme günlüğü / çalışma notları  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında oluşturuldu  
**Kapsam:** V1 geliştirme süreci boyunca milestone notları, hata kayıtları, karar adayları, AI review sonuçları, cihaz/platform test gözlemleri ve açık sorular  
**Son güncelleme:** 2026-05-31

Bu belge, Prompt Yönetim Aracı V1 geliştirme sürecinde ortaya çıkan operasyonel notları, ara kararları, hata ve çözüm kayıtlarını, test gözlemlerini ve başka belgelere taşınması gereken maddeleri izlemek için kullanılır.

Bu belge canon belgesi değildir. Kalıcı ürün kararları ilgili ana kaynak belgelere, mimari kararlar ADR kayıtlarına, tekrar kontrol edilecek maddeler checklist’lere, V1 dışı fikirler parking lot belgesine taşınır.

---

## 2. Kullanım Amacı

`09_development_notes.md`, geliştirme sırasında şu amaçlarla kullanılacaktır:

- Milestone ilerleyişini kısa notlarla takip etmek,
- Kodlama sırasında ortaya çıkan anlamlı hata ve çözüm kayıtlarını tutmak,
- Geçici kararları ve izlenecek noktaları kaydetmek,
- ADR’ye dönüşebilecek karar adaylarını yakalamak,
- Checklist’e taşınması gereken yeni kontrol maddelerini toplamak,
- Parking lot’a gönderilecek V1 dışı fikirleri işaretlemek,
- Dış AI review sonuçlarını değerlendirme notlarıyla saklamak,
- Cihaz / platform test gözlemlerini kaydetmek,
- Açık soruları görünür tutmak,
- Milestone kapanışlarında kısa durum özeti oluşturmak.

Ana ilke:

> Development notes, geliştirme sırasında kaybolmaması gereken çalışma hafızasıdır; canon karar deposu değildir.

---

## 3. Not Yazım Kuralları

### 3.1. Ne zaman not düşülür?

Aşağıdaki durumlarda development notes güncellenir:

- Milestone başlarken veya kapanırken,
- Önemli teknik sorun çıktığında,
- Geçici çözüm kullanıldığında,
- Mimari sınırı etkileyen bir karar adayı doğduğunda,
- Firestore / Auth / ownerId / security rules tarafında dikkat gerektiren bir durum oluştuğunda,
- Cihaz / ekran / klavye / overflow problemi görüldüğünde,
- Dış AI review’dan uygulanabilir öneri geldiğinde,
- Bir madde checklist’e taşınacaksa,
- V1 dışı bir fikir parking lot’a gönderilecekse,
- Açık soru veya karar bekleyen konu oluştuğunda.

### 3.2. Ne yazılmaz?

Bu belgeye şunlar yığılmamalıdır:

- Her küçük commit detayı,
- Her satır kod değişikliği,
- Zaten canon’a işlenmiş büyük kararların uzun tekrarları,
- Ham sohbet dökümleri,
- Önemsiz geçici denemeler,
- Bağlamı olmayan kısa notlar,
- “Biraz kod yazıldı” gibi iz bırakmayan kayıtlar.

Kural:

> Not kısa, bağlamlı ve aksiyona dönüştürülebilir olmalıdır.

---

## 4. Not Kayıt Formatı

Her not mümkün olduğunca şu formatla tutulmalıdır:

```md
## [YYYY-MM-DD] — Kısa Not Başlığı

Milestone: Mx  
Kategori: Karar / Hata / Test / Güvenlik / Mimari / Scope / AI Review / Cihaz Testi / ADR Adayı / Checklist / Parking Lot  
Durum: Açık / İzlenecek / Çözüldü / ADR’ye taşınacak / Checklist’e taşınacak / Parking Lot’a taşınacak / Kapanmış

### Not
Kısa açıklama.

### Etki
Bu not projeyi nasıl etkiliyor?

### Aksiyon
Ne yapılacak veya nereye taşınacak?
```

---

## 5. Kategori Sistemi

| Kategori | Kullanım amacı |
|---|---|
| Karar | Küçük geliştirme kararı |
| Hata | Karşılaşılan sorun |
| Test | Test sonucu veya eksik test |
| Güvenlik | Rules, ownerId, erişim riski |
| Mimari | Katman, repository, provider, routing sınırı |
| Scope | V1 kapsam dışı sızıntı riski |
| AI Review | Dış AI değerlendirme sonucu |
| Cihaz Testi | Gerçek cihaz / emülatör / ekran testi |
| ADR Adayı | Kalıcı mimari karar adayı |
| Checklist | Checklist’e taşınacak kontrol maddesi |
| Parking Lot | V1 dışına taşınacak fikir |

---

## 6. Aktif Milestone Durumu

**Aktif milestone:** M8 — Arama ve Filtreleme  
**Son tamamlanan milestone:** M7 — Detaylı Ekle  
**Sonraki ana çalışma:** M8 başlangıç planı, kütüphane içinde arama ve filtreleme akışı
---

## 7. Milestone Bazlı Notlar

### M0 — Proje Hazırlığı ve Teknik Zemin

Henüz aktif geliştirme notu yok.

Beklenen not alanları:

- Flutter proje oluşturma,
- Firebase project hazırlığı,
- FlutterFire yapılandırması,
- Paket kurulumları,
- PowerShell dizin scripti kullanımı,
- İlk build / run kontrolü,
- `docs/` paketinin projeye eklenmesi,
- Git başlangıç düzeni.

#### M0 Kapanış Notu Şablonu

```md
## M0 Kapanış Notu — 2026-05-28

### Yapılanlar
- Flutter project: prompt_manager
- Android package: com.onurerdil.promptmanager
- Git / GitHub hazır
- lib/app, lib/core, lib/features yapısı hazır
- auth / prompts / settings feature klasörleri hazır
- docs paketi, Canon v1.0, ADR-001–010, checklist ve AI review prompt dosyaları eklendi
- Firebase temel config tamamlandı
- firebase_core eklendi
- firebase_options.dart ve google-services.json eklendi
- M0’da ürün feature kodu yazılmadı

### Kontrol edilenler
- Dosya adları gerçek proje yapısıyla hizalandı
- ADR dosyaları ADR-001’den ADR-010’a kadar düzenli tutuldu
- Checklist ve AI review prompt dosyaları mevcut isimleriyle kabul edildi
- M0 scope leak kontrolü temiz kaldı

### Açık kalanlar
- Cloud Firestore physical database creation billing gereksinimi nedeniyle M3 öncesine ertelendi
- Realtime Database kullanılmayacak; varsa rules kapalı tutulacak
- Android gerçek cihaz / emülatör run kontrolü M1 başlangıcında tekrar ele alınabilir

### Sonraki milestone’a taşınanlar
- M1 — App Shell / Routing / Auth

### Kapanış kararı
- [x] Bu milestone kapanabilir.
```

---

### M1 — App Shell, Routing ve Auth

## M1 Kapanış Notu — 2026-05-29

Milestone: M1  
Kategori: AI Review / Mimari / Güvenlik / Scope  
Durum: Kapanmış

### Not
M1 dış review tamamlandı. Bloklayıcı sorun bulunmadı. App shell, routing, AuthGate, Login/Register, logout ve M1.10 temel tema/UI standardı M1 kapsamına uygun şekilde tamamlandı.

### Kontrol edilenler
- Lokal grep kontrolünde UI/app katmanında Firebase’e doğrudan erişim bulunmadı.
- Kontrol edilen ifadeler: `FirebaseAuth.instance`, `FirebaseFirestore.instance`, `FirebaseDatabase.instance`, `Firebase.initializeApp`.
- Riverpod 3 nedeniyle `package:flutter_riverpod/legacy.dart` kullanımı M1 için kabul edildi.
- Firebase client config dosyaları (`lib/firebase_options.dart`, `android/app/google-services.json`) şu an repo’da tutuluyor.

### Park / İzlenecek Notlar
- Riverpod `legacy.dart` kullanımı ileride Notifier / AsyncNotifier geçişi için park notu olarak tutuluyor.
- Firebase client config dosyaları backend secret değildir. Güvenlik Firebase Security Rules, Auth ayarları, ileride App Check/API restriction değerlendirmesi ve Firestore rules ile yönetilecek.
- Firebase client config ve güvenlik sınırları M3 öncesi tekrar kontrol edilecek.

### Sonraki milestone’a taşınanlar
- M2 — PromptCard Domain Model.
- M2’de PromptCard domain modeli Firebase’den bağımsız kurulacak.
- M2’de Firestore data layer, prompt ekleme, repository/service Firestore bağlantısı yapılmayacak.

## M1 Resmi Checklist / Review Prompt Kontrol Notu — 2026-05-29

Milestone: M1  
Kategori: AI Review / Checklist / Mimari / Scope  
Durum: Kapanmış

### Not
M1 resmi checklist ve review prompt dosyalarıyla kontrol edildi. Kullanılan ana dosyalar:

- `docs/checklists/m1_app_shell_routing_auth_checklist.md`
- `docs/checklists/architecture_boundary_checklist.md`
- `docs/checklists/security_checklist.md`
- `docs/checklists/scope_leak_checklist.md`
- `docs/ai_review_prompts/architecture_review_prompt.md`
- `docs/ai_review_prompts/milestone_review_prompt.md`
- `docs/ai_review_prompts/code_review_prompt.md`

### Kontrol Sonucu
- App shell kurulmuş durumda.
- `go_router` merkezi routing kurulmuş durumda.
- AuthGate, Login, Register ve Logout akışı M1 kapsamına uygun.
- UI/app katmanında `FirebaseAuth.instance`, `FirebaseFirestore.instance`, `FirebaseDatabase.instance`, `Firebase.initializeApp` doğrudan kullanımı bulunmadı.
- Screen → Provider/Controller → Repository → Service → Firebase mimari sınırı korunuyor.
- PromptCard, Firestore data layer, prompt ekleme, AI, payment, semantic search, usage analytics veya benzeri M1 dışı özellik sızıntısı bulunmadı.
- M1.10 tema/UI standardı temel tema ve placeholder/auth ekran toparlaması sınırında kalmış; logo, onboarding, animasyon, premium polish veya tam marka sistemi kapsamına taşmamış.
- `flutter analyze` ve `flutter test` temiz geçti.

### Karar
Bloklayıcı sorun bulunmadı. M2 — PromptCard Domain Model aşamasına geçiş için engel yok.

Beklenen not alanları:

- App root,
- Routing,
- Login,
- Register,
- Logout,
- AuthGate,
- Auth state davranışı,
- Auth hata mesajları,
- Login/Register ekranlarının merkezi yönlendirme kararlarını bozup bozmadığı,
- M1.10 — İlk Tema, UI Temel Standartları ve V1 Görsel Kalite Planı,
- temel Material 3 tema, spacing, typography, button/input/appbar standardı,
- auth ve placeholder ekranlarında minimum ürün hissi,
- logo, app icon, onboarding, animasyon, premium polish, tam marka sistemi, final ekran tasarımları, PromptCard/Firestore/prompt ekleme özelliklerinin kapsam dışında kalması,
- Auth akışı bozulmadan ve UI Firebase’e doğrudan erişmeden temel tema/UI standartlarının uygulanıp uygulanmadığı.

---

### M2 — PromptCard Domain Model

Henüz not yok.

Beklenen not alanları:

- `PromptCard` domain modeli,
- Status teknik key’leri,
- `[DEĞİŞKEN_ADI]` değişken algılama,
- Repository interface,
- Domain validation,
- Firestore bağımsızlık kontrolü.

---

### M3 — Data Layer ve Firestore Bağlantısı

## M3 Kapanış Notu — 2026-05-29

Milestone: M3  
Kategori: Test / Güvenlik / Mimari / Scope  
Durum: Kapanmış

### Yapılanlar
- PromptCardDto oluşturuldu.
- PromptCardMapper oluşturuldu.
- PromptRepository domain contract oluşturuldu.
- PromptFirestoreService oluşturuldu.
- FirestorePromptRepository implementation oluşturuldu.
- cloud_firestore dependency eklendi.
- Firestore path standardı `users/{userId}/prompts/{promptId}` olarak korundu.
- PromptFirestoreService içinde path helperları merkezi tutuldu.
- watchPrompts `updatedAt` descending sıralama kullanacak şekilde hazırlandı.
- Timestamp / DateTime dönüşümü data/service katmanında tutuldu.
- Domain modeli Firestore’dan izole kaldı.
- FirestorePromptRepository doğrudan FirebaseFirestore kullanmadan mapper + service üzerinden çalışıyor.
- DTO / mapper / service / repository testleri eklendi.
- Firestore rules-readiness dokümantasyonu ve checklist güncellemeleri tamamlandı.
- Root `firestore.rules` oluşturulmadı.
- Rules deploy edilmedi.

### Kontrol edilenler
- `flutter analyze` temiz geçti.
- `flutter test` temiz geçti ve 41 test geçti.
- Git durumu temiz.
- Dış review ve Codex kapanış audit sonucunda blocker bulunmadı.

### Kapsam dışı bırakılanlar
- UI ekranı eklenmedi.
- Provider/Riverpod bağlantısı eklenmedi.
- Hızlı Ekle ekranı eklenmedi.
- Prompt kütüphanesi UI eklenmedi.
- Usecase eklenmedi.
- AI özelliği eklenmedi.
- deletePrompt eklenmedi.
- archivePrompt eklenmedi.
- usageCount eklenmedi.
- lastUsedAt eklenmedi.
- versionHistory eklenmedi.
- variable metadata eklenmedi.
- category koleksiyonu eklenmedi.

### Park notları
- M6/M10’da createdAt değişmezliği Firestore rules tarafında sıkılaştırılmalı.
- Final rules review’da tags ve variables eleman bazlı string kontrolü değerlendirilmeli.
- M4 sonrası veya V1.5’te watchPrompts için limit, pagination ve Firestore read cost konusu ele alınmalı.
- Root `firestore.rules` M4 veya güvenlik kapanışı sırasında ele alınacak şekilde park edildi.

### Kapanış kararı
- [x] M3 — Data Layer / Firestore aşaması kapanabilir.
- [x] M4 — İlk Çekirdek Akış aşamasına geçilebilir.

## M3.7 — Firestore Rules-Readiness Notu — 2026-05-29

Milestone: M3  
Kategori: Güvenlik / Checklist  
Durum: İzlenecek

### Not
M3.7 kapsamında Firestore rules-readiness dokümantasyonu hazırlandı. V1 path standardı `users/{userId}/prompts/{promptId}` olarak korunuyor. Rules taslağı docs içinde tutuldu; root `firestore.rules` dosyası oluşturulmadı ve deploy yapılmadı.

### Etki
M4 create/read akışına geçmeden önce kullanıcı izolasyonu, `ownerId`, valid status, `schemaVersion`, liste alanları ve delete yasağı için güvenlik beklentileri görünür hale geldi.

### Aksiyon
M4 sonunda create/read cross-user testleri yapılacak. M6 sonunda update/archive güvenliği tekrar kontrol edilecek. M10 final güvenlik kapanışında taslak rules dış review ve gerçek rules dosyası/deploy hazırlığıyla yeniden ele alınacak.

---

### M4 — İlk Çekirdek Akış

## M4 Kapanış Notu — 2026-05-30

Milestone: M4  
Kategori: Test / Güvenlik / Mimari / Scope  
Durum: Kapanmış

### Yapılanlar
- Prompt Library placeholder ekranı minimum gerçek kütüphane ekranına dönüştürüldü.
- Hızlı Ekle ekranı eklendi.
- Kullanıcının yalnızca `promptText` girerek prompt oluşturabilmesi sağlandı.
- PromptCard default alanları oluşturuldu.
- `variables` alanı `PromptVariableParser` ile prompt metninden çıkarıldı.
- Yeni promptlar `PromptStatus.raw` ile oluşturuldu.
- Yeni promptlar `schemaVersion: 1` ile oluşturuldu.
- `createdAt` ve `updatedAt` alanları oluşturuldu.
- Firestore create akışı bağlandı.
- `watchPrompts` ile promptların kütüphanede listelenmesi sağlandı.
- Prompt Library ekranında loading, error, empty ve data state davranışları eklendi.
- Hızlı Ekle ekranında boş prompt validation, loading state, error feedback ve başarılı kayıt sonrası kütüphaneye dönüş davranışı eklendi.
- Route yapısına Hızlı Ekle için `/library/quick-add` yolu eklendi.
- Provider/controller zinciri kuruldu.
- UI/app katmanında doğrudan Firebase erişimi yapılmadı.
- Veri akışı Screen → Provider/Controller → Repository → Service → Firebase çizgisinde korundu.

### Manuel test ve Firestore rules çözümü
- İlk manuel testte login/register çalıştı ve `/library` ekranı açıldı.
- Promptlar yüklenemedi ve Hızlı Ekle kayıt atamadı.
- Sorunun uygulama kodundan değil, Firebase Console’daki Firestore rules’un `allow read, write: if false;` ile read/create işlemlerini kapatmasından kaynaklandığı tespit edildi.
- Firebase Console’da M4 için user-scoped read/create rules elle yayınlandı.
- Sonrasında login → library → quick add → Firestore create → `watchPrompts` ile listede görme akışı başarıyla çalıştı.

### Rules kararı
- Root `firestore.rules` dosyası oluşturuldu.
- `firebase.json`, `firestore.rules` dosyasını tanıyacak şekilde güncellendi.
- `users/{userId}/prompts/{promptId}` path’i için read sadece owner kullanıcıya açık bırakıldı.
- Create sadece owner kullanıcıya açık bırakıldı.
- Create sırasında `ownerId`, `promptText`, `status == raw` ve `schemaVersion == 1` kontrolleri eklendi.
- Update/delete kapalı bırakıldı.
- Fallback deny korundu.

### Kontrol edilenler
- `flutter analyze` temiz geçti.
- `flutter test` temiz geçti ve 45 test geçti.
- M4 kapsam dışı özellik sızıntısı görülmedi.
- Mimari sınır korundu.
- Canlı manuel testte Firestore create/list akışı çalıştı.
- M4 kapanabilir kabul edildi.
- M5’e geçiş için blocker yok.

### Kapsam dışı bırakılanlar
- Prompt detay ekranı eklenmedi.
- Normal kopyala eklenmedi.
- Prompt düzenleme eklenmedi.
- Status değiştirme eklenmedi.
- Arşivleme eklenmedi.
- Detaylı Ekle eklenmedi.
- Arama / filtreleme eklenmedi.
- Değişkenli kopyala-doldur eklenmedi.
- AI özelliği eklenmedi.
- Import/export eklenmedi.
- Usage analytics eklenmedi.
- Kalıcı silme eklenmedi.

### Park notları
- Firebase CLI yerel makinede PATH’te olmadığı için `firebase deploy --only firestore:rules` çalışmadı.
- Console rules elle yayınlandı.
- Firebase CLI kurulumu ve deploy doğrulaması M4 sonrası operasyonel park notu olarak takip edilecek.
- M6’da update/archive rules ayrıca ele alınacak.
- M10’da final security review, cross-user testleri ve rules doğrulaması yapılacak.
- Controller içinde id üretimi M4 için kabul edildi; ileride repository/service sınırına taşınması değerlendirilebilir.
- Auth loading sırasında kısa empty-state flicker ihtimali M4 için blocker kabul edilmedi.
- Eski `prompt_library_placeholder_screen.dart` route’tan çıkarıldı ama dosya hâlâ duruyorsa ileride temizlik olarak kaldırılabilir.

### Kapanış kararı
- [x] M4 — İlk Çekirdek Akış aşaması kapanabilir.
- [x] M5 — Prompt Detay ve Normal Kopyala aşamasına geçilebilir.

---

### M5 — Prompt Detay ve Normal Kopyala

## M5 Kapanış Notu — 2026-05-30

Milestone: M5  
Kategori: AI Review / Mimari / Scope / Test  
Durum: Kapanmış

### Not
M5 kod audit'i tamamlandı. Prompt Detay ekranı, `/library/:promptId` route'u, kütüphane liste item'ından detaya geçiş ve Normal Kopyala akışı M5 kapsamına uygun şekilde eklendi.

### Yapılanlar
- Prompt Detay ekranı eklendi.
- `/library/:promptId` route'u eklendi.
- Kütüphane list item tap ile doğru `promptId` kullanılarak detay ekranına geçiş eklendi.
- Detay verisi `PromptRepository.getPromptById(userId, promptId)` ile okunuyor.
- User yoksa veya `promptId` boşsa Firestore sorgusu yapılmıyor.
- Loading, error, not found ve data state'leri ele alındı.
- Prompt metni okunabilir ve seçilebilir şekilde gösteriliyor.
- Normal Kopyala yalnızca `promptText` değerini Clipboard'a kopyalıyor.
- Kopyalama sonrası snackbar feedback gösteriliyor.

### Kontrol edilenler
- UI/app katmanında doğrudan `FirebaseFirestore` veya `FirebaseAuth` kullanımı görülmedi.
- Presentation tarafına DTO, snapshot, Firestore path veya `FirebaseFirestore.instance` sızmadı.
- Akış Screen → Provider → Repository → Service → Firebase çizgisinde korundu.
- Kopyalama sonrası Firestore write yapılmadığı doğrulandı.
- Normal Kopyala `updatedAt`, `usageCount` veya `lastUsedAt` değiştirmiyor.
- `schemaVersion` UI'da gösterilmiyor.
- Boş description, notes, category, tags ve variables alanları gizleniyor.
- `flutter analyze` temiz geçti.
- `flutter test` temiz geçti ve 53 test geçti.

### Kapsam dışı bırakılanlar
- Prompt düzenleme eklenmedi.
- Status değiştirme eklenmedi.
- Arşivleme eklenmedi.
- Kalıcı silme eklenmedi.
- Detaylı Ekle eklenmedi.
- Arama / filtreleme eklenmedi.
- Değişkenli kopyala-doldur eklenmedi.
- Usage analytics, `usageCount`, `lastUsedAt` ve version history eklenmedi.
- AI özelliği eklenmedi.
- Import/export eklenmedi.

### Manuel smoke test notu
- Login ol.
- Prompt ekle.
- Library list item'a dokun.
- Detail ekranının doğru prompt metniyle açıldığını kontrol et.
- Normal Kopyala'ya dokun.
- Başka yere yapıştır ve yalnızca `promptText` geldiğini doğrula.
- Firestore'da `updatedAt`, `usageCount` ve `lastUsedAt` değişmediğini kontrol et.

### Belge / checklist durumu
- `docs/checklists/m5_prompt_detail_copy_checklist.md` oluşturuldu.
- M5 checklist referansı `docs/05_milestone_plan.md` ile uyumlu.

### Kapanış kararı
- [x] Bu milestone kapanabilir.
- [x] M6 — Prompt Düzenleme, Status ve Arşiv aşamasına geçilebilir.


---

### M6 — Prompt Düzenleme, Status ve Arşiv

## M6 Kapanış Notu — 2026-05-31

Milestone: M6  
Kategori: Mimari / Scope / Güvenlik / Test / Cihaz Testi  
Durum: Kapanmış

### Not
M6 uygulaması ve kapanış öncesi audit tamamlandı. Prompt düzenleme, status değiştirme ve arşivleme davranışı V1 kapsamına uygun şekilde eklendi. Canlı Firestore rules publish sonrası edit kaydı başarıyla doğrulandı.

### Yapılanlar
- `/library/:promptId/edit` route'u eklendi.
- Detay ekranından düzenleme ekranına geçiş eklendi.
- Prompt edit ekranı eklendi.
- Başlık, prompt metni, açıklama, notlar, kategori, tags ve status düzenlenebilir hale getirildi.
- Tags virgül ayrımlı input olarak çalışıyor.
- `promptText` boşsa kayıt engelleniyor.
- `promptText` değişince `variables` alanı `PromptVariableParser` ile yeniden parse ediliyor.
- `updatedAt` kayıt sırasında yenileniyor.
- `id`, `ownerId`, `createdAt` ve `schemaVersion` korunuyor.
- Arşiv ayrı delete aksiyonu değildir; status dropdown içindeki `archived` seçeneğiyle yapılıyor.
- Archived promptlar M8 filtreleme gelene kadar kütüphanede görünmeye devam ediyor.
- Kalıcı delete kapalı tutuldu.

### Firestore rules ve güvenlik
- Firestore rules update/create canonical key kontrolüyle güçlendirildi.
- Canonical PromptCard alanları dışındaki extra alanlar engelleniyor.
- Legacy extra alanlı eski dokümanlar edit sırasında canonical `set()` ile temizleniyor.
- Update yalnızca authenticated owner için açık.
- `ownerId`, `createdAt` ve `schemaVersion` değiştirilemiyor.
- `schemaVersion` `1` kalıyor.
- `promptText` non-empty string olmak zorunda.
- Status yalnızca `raw`, `needs_edit`, `ready`, `archived` olabilir.
- `delete` kapalı ve global fallback deny korunuyor.
- Rules Firebase Console üzerinden publish edildi ve canlı edit testi başarılı oldu.

### Kontrol edilenler
- UI/app katmanında doğrudan `FirebaseFirestore` veya `FirebaseAuth` kullanımı görülmedi.
- Presentation tarafına DTO, snapshot, Firestore path veya `FirebaseFirestore.instance` sızmadı.
- Akış Screen → Provider/Controller → Repository → Service → Firebase çizgisinde korundu.
- Edit sonrası detay ve liste provider cache'i invalidate ediliyor.
- `flutter analyze` temiz geçti.
- `flutter test` temiz geçti ve 62 test geçti.

### Kapsam dışı bırakılanlar
- Kalıcı silme eklenmedi.
- Version history eklenmedi.
- Usage analytics, `usageCount` ve `lastUsedAt` eklenmedi.
- Değişkenli kopyala-doldur eklenmedi.
- Detaylı Ekle eklenmedi.
- Arama / filtreleme eklenmedi.
- AI özelliği eklenmedi.
- Import/export eklenmedi.
- Koleksiyonlar, gelişmiş tag yönetimi, gelişmiş kategori koleksiyonu ve Prompt Health Check eklenmedi.

### Manuel smoke test notu
- Login olundu.
- Prompt detayından düzenleme ekranına geçiş kontrol edildi.
- Prompt alanları güncellendi ve kaydedildi.
- Firestore rules Firebase Console'da publish edildikten sonra canlı edit kaydı başarılı oldu.
- Yeni ve eski prompt dokümanlarında canonical update davranışı ayrıca M10 final security review içinde tekrar gözden geçirilecek.

### Park notları
- Firebase CLI/PATH ve rules deploy komutu hâlâ operasyonel olarak çözülmeli. Şimdilik rules Firebase Console üzerinden publish edildi.
- M10'da final security review sırasında rules tekrar gözden geçirilmeli.
- V1.5/V2'de server-owned alanlar eklenirse `set()` ile canonical replace davranışı tekrar değerlendirilmeli.

### Belge / checklist durumu
- `docs/checklists/m6_prompt_edit_status_archive_checklist.md` oluşturuldu.

### Kapanış kararı
- [x] Bu milestone kapanabilir.
- [x] M7 — Detaylı Ekle aşamasına geçilebilir.


---

### M7 — Detaylı Ekle

## M7 Kapanış Notu — 2026-05-31

Milestone: M7  
Kategori: Mimari / Scope / Güvenlik / Test / Cihaz Testi  
Durum: Kapanmış

### Not
M7 uygulaması, canlı rules publish doğrulaması ve kapanış kontrolü tamamlandı. Kullanıcı artık promptu yalnızca hızlı ekleme ile değil, temel PromptCard alanlarını doldurarak detaylı şekilde oluşturabiliyor.

### Yapılanlar
- `/library/detailed-add` route'u eklendi.
- Detaylı Ekle ekranı eklendi.
- Kütüphane ekranından Detaylı Ekle'ye geçiş eklendi.
- Hızlı Ekle FAB davranışı korundu.
- Detaylı Ekle ekranı `title`, `promptText`, `description`, `notes`, `category`, `tags` ve `status` alanlarını destekliyor.
- `promptText` zorunlu tutuldu.
- `promptText.trim()` boşsa kayıt engelleniyor.
- `title`, `description`, `notes` ve `category` trim ediliyor.
- Tags virgülle split / trim / empty filter davranışıyla `string[]` haline getiriliyor.
- `variables`, `PromptVariableParser` ile `promptText` üzerinden otomatik çıkarılıyor.
- `createdAt` ve `updatedAt` kayıt anında oluşturuluyor.
- `schemaVersion` `1` olarak set ediliyor.
- `ownerId` authenticated user'dan geliyor.
- Status seçilebilir hale geldi: `raw`, `needs_edit`, `ready`, `archived`.

### Firestore rules ve güvenlik
- Firestore create rule, `status == "raw"` yerine `isValidStatus(request.resource.data.status)` olacak şekilde güncellendi.
- Status create sırasında herhangi bir string olarak serbest bırakılmadı; allowlist korunuyor.
- Canonical key kontrolü korunuyor.
- Extra alanlar engellenmeye devam ediyor.
- Delete kapalı ve global fallback deny korunuyor.
- Firestore rules Firebase Console üzerinden publish edildi.
- Canlı create testi başarılı oldu.

### Kontrol edilenler
- UI doğrudan Firebase Auth / Firestore kullanmıyor.
- Mimari akış Screen → Provider/Controller → Repository → Service → Firebase çizgisinde korunuyor.
- `flutter analyze` başarılı.
- `flutter test` başarılı.
- Commit/push tamamlandı.
- `git status --short` boş.

### Kapsam dışı bırakılanlar
- AI öneri eklenmedi.
- Import/export eklenmedi.
- Koleksiyon eklenmedi.
- Version history eklenmedi.
- `usageCount` / `lastUsedAt` eklenmedi.
- Kalıcı delete eklenmedi.
- Arama / filtreleme eklenmedi.
- Değişkenli kopyala-doldur eklenmedi.
- Gelişmiş tag/category yönetimi eklenmedi.

### Belge / checklist durumu
- `docs/checklists/m7_detailed_add_checklist.md` oluşturuldu.

### Kapanış kararı
- [x] Bu milestone kapanabilir.
- [x] M8 — Arama ve Filtreleme aşamasına geçilebilir.

---

### M8 — Arama ve Filtreleme

Henüz not yok.

Beklenen not alanları:

- Metin arama,
- Kategori filtresi,
- Etiket filtresi,
- Status filtresi,
- Arama + filtre birlikte davranışı,
- Boş sonuç durumu,
- Client-side arama performansı.

---

### M9 — Değişkenli Kopyala-Doldur

Henüz not yok.

Beklenen not alanları:

- Değişken form alanları,
- Tekrarlanan değişkenlerin tek input’a düşmesi,
- Final prompt üretimi,
- Final prompt kopyalama,
- Değişken yok durumu,
- Uzun değişken listesinde cihaz davranışı.

---

### M10 — Güvenlik, Test ve V1 Kapanış

Henüz not yok.

Beklenen not alanları:

- Final manuel test,
- Firestore rules final kontrol,
- Cross-user read/write testleri,
- Mimari sınır kontrolü,
- Scope leak kontrolü,
- Cihaz/platform testleri,
- V1 kapanış acceptance criteria kontrolü.

---

## 8. Hata / Sorun Notları

Bu bölüm tekrar etme ihtimali olan veya proje dersine dönüşebilecek hatalar için kullanılacaktır.

### Hata Not Formatı

```md
## [YYYY-MM-DD] — Hata Başlığı

Milestone: Mx  
Kategori: Hata  
Durum: Açık / Çözüldü / İzlenecek

### Belirti
Ne oldu?

### Muhtemel neden
Neden oldu?

### Çözüm
Nasıl çözüldü?

### Ders
Bundan sonra neye dikkat edilecek?

### Taşınacak yer
Checklist / ADR / Ortak Flutter Çözümleri Kütüphanesi / Yok
```

Henüz kayıt yok.

---

## 9. Geçici Çözüm Notları

Bu bölüm hızlı ilerlemek için kullanılan ama sonradan temizlenmesi gerekebilecek geçici çözümler için tutulur.

Örnek durumlar:

- Geçici dummy veri,
- Geçici UI fallback,
- Henüz final olmayan routing kararı,
- Geçici mock repository,
- Test için eklenen ama kaldırılması gereken yardımcı kod.

Henüz kayıt yok.

---

## 10. ADR Adayları

Her mimari karar hemen ADR olmak zorunda değildir. Önce burada aday olarak izlenebilir.

### ADR Adayı Formatı

```md
## ADR Adayı — Karar Başlığı

Milestone: Mx  
Kategori: ADR Adayı  
Durum: İncelenecek / ADR’ye taşınacak / Kapanmış

### Karar adayı
Hangi karar?

### Neden önemli?
Uzun vadeli etkisi ne?

### Alternatifler
Başka seçenekler neler?

### ADR’ye dönüşme şartı
Bu karar ne zaman kalıcı ADR olur?
```

İlk ADR seti zaten 0.9 kapsamında planlanmıştır:

- ADR-001 — Cloud-first V1,
- ADR-002 — Firebase Auth + Cloud Firestore V1,
- ADR-003 — Canonical PromptCard modeli,
- ADR-004 — Feature-first + hafif clean architecture,
- ADR-005 — UI Firebase’e doğrudan erişmeyecek,
- ADR-006 — V1 manuel çekirdek / V2 AI katmanı,
- ADR-007 — Firestore User-Scoped Path,
- ADR-008 — Variable Standard and Storage,
- ADR-009 — No Permanent Delete in V1,
- ADR-010 — Single App, Multilingual-Ready.

Henüz ek aday yok.

---

## 11. Checklist’e Taşınacak Maddeler

Geliştirme sırasında yeni kontrol ihtiyacı doğarsa önce buraya yazılır, sonra ilgili checklist’e taşınır.

### Checklist Maddesi Formatı

```md
## [YYYY-MM-DD] — Checklist Maddesi Başlığı

Milestone: Mx  
Kategori: Checklist  
Durum: Checklist’e taşınacak / Taşındı / Kapanmış

### Not
Hangi kontrol maddesi gerekli?

### Etki
Hangi hatayı önler?

### Taşınacak checklist
Dosya adı.
```

Henüz kayıt yok.

---

## 12. Parking Lot’a Taşınacak Fikirler

V1 kapsamına doğrudan girmeyen ama ileride değerlendirilebilecek fikirler önce burada yakalanabilir, sonra `08_parking_lot_v1_5_v2.md` belgesine taşınır.

### Parking Lot Not Formatı

```md
## [YYYY-MM-DD] — Fikir Başlığı

Milestone: Mx  
Kategori: Parking Lot  
Hedef sürüm: V1.5 / V2 / V2.5 / V3 / Teknik Park  
Durum: Parking Lot’a taşınacak / Taşındı / Reddedildi

### Fikir
Kısa açıklama.

### Neden V1’de değil?
Gerekçe.

### Aksiyon
Hangi park alanına taşınacak?
```

İlk park kararları 0.9 kapsamında belirlenmiştir:

- Browser extension,
- Import / export,
- Koleksiyonlar / gruplar,
- Kullanım sayısı,
- Onboarding,
- Prompt şablon kütüphanesi,
- Prompt Health Check,
- V2 AI destekli işleme,
- Semantik arama,
- AI Gateway / Adapter,
- AI kredi / kota sistemi,
- Mason brick uzun vadeli teknik park alternatifi.

Henüz ek kayıt yok.

---

## 13. AI Review Notları

Dış AI review sonuçları burada kısa değerlendirme notlarıyla tutulacaktır.

Kural:

> AI review önerisi karar değildir. Öneriler canon, V1 scope, architecture ve checklist’lere göre süzülür.

### AI Review Not Formatı

```md
## [YYYY-MM-DD] — AI Review Notu

Kaynak: ChatGPT / Claude / Gemini / Grok / Diğer  
Milestone: Mx  
Kategori: AI Review  
Durum: Kabul / Reddedildi / Park edildi / İncelenecek

### Öneri
AI ne önerdi?

### Değerlendirme
Bu öneri projeye uyuyor mu?

### Karar
Kabul edildi mi, reddedildi mi, parking lot’a mı taşındı?

### Aksiyon
İlgili belge / checklist / ADR güncellenecek mi?
```

### Hatırlatma Kuralı

Geliştirme sırasında hangi milestone’da hangi AI review promptunun kullanılacağını asistan kullanıcıya hatırlatacaktır. Kullanıcı tek başına zamanlama kararı vermek zorunda kalmayacaktır.

Örnek:

- M2 sonrası: `data_model_review_prompt.md`,
- M3 sonrası: `firestore_rules_review_prompt.md` ve `security_review_prompt.md`,
- Her milestone sonunda: `milestone_review_prompt.md`,
- Scope riski oluşursa: `scope_guard_review_prompt.md`,
- UI / cihaz davranışı kritik olduğunda: `device_ui_review_prompt.md`.

Henüz review kaydı yok.

---

## 14. Cihaz / Platform Test Notları

V1 test odağı Android mobil olacaktır. Web, desktop ve tablet testleri V1 için opsiyonel smoke test olarak değerlendirilecektir.

### Cihaz Test Not Formatı

```md
## [YYYY-MM-DD] — Cihaz Test Notu

Milestone: Mx  
Cihaz / Platform: Android gerçek cihaz / Android emülatör / Tablet / Web smoke test  
Kategori: Cihaz Testi  
Durum: Sorunsuz / Sorun var / İzlenecek / Çözüldü

### Test edilen akış
Hangi ekran veya akış test edildi?

### Gözlem
Ne oldu?

### Sorun
Varsa sorun ne?

### Aksiyon
Düzeltme veya checklist maddesi.
```

### İzlenecek Cihaz Test Başlıkları

- Gerçek Android cihazda uygulama açılışı,
- Android emülatörde uygulama açılışı,
- Küçük ekranda overflow kontrolü,
- Klavye açılınca form davranışı,
- Uzun prompt metni scroll davranışı,
- Prompt detay ekranında uzun metin okunabilirliği,
- Kopyalama davranışı,
- Geri tuşu davranışı,
- Değişkenli formda uzun input listesi,
- Tablet / web opsiyonel smoke test.

Henüz kayıt yok.

---

## 15. Açık Sorular

Açık sorular karar verilene kadar burada tutulur.

Başlangıç açık soru adayları:

- Detaylı Ekle ekranında varsayılan status `raw` mı olmalı?
- Kategori boşsa UI’da “Kategorisiz” mi gösterilecek?
- Başlık boşsa UI fallback olarak promptun ilk satırını mı gösterecek?
- Arşivlenen promptlar varsayılan kütüphane görünümünde tamamen gizlenecek mi?
- Etiketler küçük harfe normalize edilecek mi, yoksa kullanıcının yazdığı biçim korunacak mı?
- Email verification V1’e dahil olacak mı, yoksa V1 sonrası mı değerlendirilecek?
- Firebase Auth için sadece email/password yeterli mi, Google Sign-In V1 dışında mı kalacak?

Bu sorular ilgili milestone’da netleşirse ilgili belgeye veya checklist’e taşınacaktır.

---

## 16. Kapanan Notlar

Çözülen ve ilgili belgeye taşınan notlar burada kısa kayıt olarak tutulur.

### Kapanan Not Formatı

```md
## [YYYY-MM-DD] — Not Başlığı

Durum: Kapanmış  
Taşındı: İlgili belge / ADR / checklist / parking lot

### Kapanış notu
Kısa açıklama.
```

Henüz kapanan not yok.

---

## 17. Milestone Kapanış Şablonu

Her milestone sonunda şu şablon kullanılacaktır:

```md
## Mx Kapanış Notu — [TARİH]

### Yapılanlar
- 

### Kontrol edilenler
- 

### Açık kalanlar
- 

### Sonraki milestone’a taşınanlar
- 

### Belge / checklist / ADR güncelleme ihtiyacı
- 

### AI review ihtiyacı
- 

### Cihaz / platform test notu
- 

### Kapanış kararı
- [ ] Bu milestone kapanabilir.
- [ ] Kapanış için ek çalışma gerekiyor.
```

---

## 18. Referans Belgeler

Bu development notes belgesi şu kaynaklarla birlikte kullanılacaktır:

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`
- `docs/adr/`
- `docs/checklists/`
- `docs/ai_review_prompts/`

---

## 19. Kapanış Notu

`09_development_notes.md`, Prompt Yönetim Aracı V1 geliştirme sürecinde canlı çalışma hafızası olarak kullanılacaktır.

Belge; hataları, ara kararları, test gözlemlerini, AI review sonuçlarını ve taşınacak maddeleri kaydeder. Ancak kalıcı karar kaynağı değildir.

Ana kural:

> Geliştirme sırasında anlamlı bir not doğarsa buraya yazılır; kalıcılaşırsa doğru ana belgeye taşınır.

Karar:
M0’da feature alt klasörleri .gitkeep ile yer açılmış durumda kalacak.
Gerçek Dart dosyaları M1 / M2 / M3 içinde ihtiyaç oldukça eklenecek.

M0 kararı:
firebase_options.dart ve google-services.json şu an M0 Firebase config parçası olarak repoda kalabilir.
Ancak service account, private key, AI API key, Gemini/OpenAI key, keystore şifresi gibi gerçek gizli bilgiler asla repoya konmayacak.
Firebase güvenliği API key gizlemekle değil, Security Rules, App Check ve doğru erişim sınırlarıyla sağlanacak.

Realtime Database yanlışlıkla açıldıysa kullanılmayacak. Rules kapalı tutulacak. V1 veri yönü Firebase Auth + Cloud Firestore’dur. Firestore physical database billing nedeniyle M3 öncesine ertelenmiştir.

## M0 Documentation Inventory Note

M0 documentation package was finalized with the existing file names.

ADR files are numbered from ADR-001 to ADR-010 and kept as-is.

Checklist files use a mix of milestone-based and global naming:
- m0/m1/m2/m3/m4 milestone checklists
- g04/g05 global checklists
- security, architecture boundary, scope leak and device/platform checklists

AI review prompt files are kept with their existing descriptive names, including firebase_rules_review_prompt.md for Firestore/Firebase rules review.

## M0 Kapanış Notu

M0 — Proje Hazırlığı ve Teknik Zemin aşaması tamamlandı.

Tamamlananlar:
- Flutter project: prompt_manager
- Android package: com.onurerdil.promptmanager
- Git / GitHub hazır
- lib/app, lib/core, lib/features yapısı hazır
- auth / prompts / settings feature klasörleri hazır
- docs paketi, Canon v1.0, ADR-001–010, checklist ve AI review prompt dosyaları eklendi
- Firebase temel config tamamlandı
- firebase_core eklendi
- firebase_options.dart ve google-services.json eklendi
- M0’da ürün feature kodu yazılmadı

Bilinçli bekleyen konu:
- Cloud Firestore physical database creation billing gereksinimi nedeniyle M3 öncesine ertelendi.
- Realtime Database kullanılmayacak; varsa rules kapalı tutulacak.

M1 — App Shell / Routing / Auth aşamasına geçilebilir.

## M1 — App Shell / Routing / Auth Kapanış Notu

M1 kapsamında uygulamanın temel app shell, routing ve auth akışı tamamlandı.

Tamamlananlar:

* App shell kuruldu.
* go_router routing yapısı kuruldu.
* Firebase Auth ile login/register/logout akışı çalışır hale getirildi.
* AuthGate yönlendirme mantığı kuruldu.
* UI → Provider/Controller → Repository → Service → Firebase mimari sınırı korundu.
* UI/app katmanında doğrudan Firebase erişimi bulunmadı.
* Riverpod 3 nedeniyle StateNotifier/StateNotifierProvider için legacy.dart kullanımı M1 için kabul edildi.
* Riverpod 3 native Notifier/AsyncNotifier geçişi ileride değerlendirilecek teknik borç / park notu olarak tutuldu.
* M1.10 kapsamında ilk Material 3 tema/UI standardı eklendi.
* Login/Register ve placeholder ekranları minimum ürün hissi verecek şekilde toparlandı.
* M1 sonrası dış AI review alındı.
* Dış review sonucunda blocker bulunmadı.
* M1 post-review cleanup tamamlandı.

Kontroller:

* flutter analyze temiz geçti.
* flutter test temiz geçti.
* UI/app katmanında doğrudan Firebase erişimi bulunmadı.
* PromptCard, Firestore data layer, prompt ekleme, AI, payment, semantic search ve usage analytics gibi M1 dışı özellik sızıntısı bulunmadı.

Not:
M1 kapanışı sonrası proje M2 — PromptCard Domain Model aşamasına geçmeye hazır hale geldi.


## M2 — PromptCard Domain Model Kapanış Notu

M2 kapsamında PromptCard domain model çekirdeği saf Dart olarak eklendi ve dış AI review sonrası kapanışa uygun bulundu.

Tamamlananlar:
- PromptStatus enum oluşturuldu.
- Status teknik key dönüşümleri eklendi.
- Geçersiz status key için PromptStatus.raw fallback tanımlandı.
- PromptCard entity oluşturuldu.
- schemaVersion varsayılan değeri 1 olarak belirlendi.
- status varsayılan değeri PromptStatus.raw olarak belirlendi.
- promptText için boş / whitespace kontrolü eklendi.
- tags ve variables alanları boş liste varsayılanıyla güvenli hale getirildi.
- hasVariables, isArchived, effectiveTitle ve copyWith yardımcı davranışları eklendi.
- [DEĞİŞKEN_ADI] standardı için PromptVariableParser oluşturuldu.
- Parser davranışı:
    - Değişken sırası korunur.
    - Tekrar eden değişkenler tekilleştirilir.
    - Boş [] ifadeleri yok sayılır.
    - Eksik bracket ifadeleri yok sayılır.
    - Boşluklu invalid değişkenler yok sayılır.
    - Türkçe karakter, sayı ve alt çizgi desteklenir.
    - Değişken adı normalize edilmeden olduğu gibi saklanır.
- PromptCard, PromptStatus ve PromptVariableParser için domain testleri eklendi.

Kontroller:
- flutter analyze temiz geçti.
- flutter test temiz geçti.
- 26 test başarılı.
- Firebase, Firestore, DTO, mapper, repository, service, provider, Riverpod, UI veya yeni paket eklenmedi.
- usageCount, lastUsedAt ve versionHistory gibi V1 dışı alanlar eklenmedi.
- M2 domain katmanı Firestore data layer için hazır hale geldi.

Dış AI review sonucu:
- Gemini review: Blocker bulunmadı, M2 kapanışa uygun görüldü.
- Codex review: Blocker bulunmadı, M2 kapanışa uygun görüldü.
- Domain katmanında Firebase/Firestore veya mimari sınır sızıntısı görülmedi.
- M3 Data Layer / Firestore aşamasına geçiş uygun bulundu.

Park notları:
- PromptStatus.fromKey şu an strict key eşleşmesi yapıyor. İleride Firestore’dan veri okunurken trim veya tolerans gerekiyorsa bu davranış domain içinde değil, M3 data layer / mapper tarafında ele alınmalı.
- İleride domain eşitliği gerekiyorsa PromptCard için == / hashCode veya equatable benzeri yaklaşım ayrıca değerlendirilebilir.
- Parser regex optimizasyonu M2 blocker değildir; mevcut testler geçtiği için gerekirse ileride küçük temizlik olarak değerlendirilebilir.

Karar:
M2 — PromptCard Domain Model aşaması kapanışa uygundur. M3 — Data Layer / Firestore aşamasına geçilebilir.
