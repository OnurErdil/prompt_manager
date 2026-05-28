# Prompt Yönetim Aracı — Development Notes

## 1. Belge Bilgisi

**Belge tipi:** Canlı geliştirme günlüğü / çalışma notları  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında oluşturuldu  
**Kapsam:** V1 geliştirme süreci boyunca milestone notları, hata kayıtları, karar adayları, AI review sonuçları, cihaz/platform test gözlemleri ve açık sorular  
**Son güncelleme:** 2026-05-28

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

**Aktif milestone:** M1 — App Shell, Routing ve Auth  
**Son tamamlanan milestone:** M0 — Proje Hazırlığı ve Teknik Zemin  
**Sonraki ana çalışma:** M1 başlangıç planı, paket ekleme sırası, app shell, routing ve Auth hazırlığı
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

Henüz not yok.

Beklenen not alanları:

- App root,
- Routing,
- Login,
- Register,
- Logout,
- AuthGate,
- Auth state davranışı,
- Auth hata mesajları,
- Login/Register ekranlarının merkezi yönlendirme kararlarını bozup bozmadığı.

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

Henüz not yok.

Beklenen not alanları:

- Firestore service,
- DTO,
- Mapper,
- Repository implementation,
- `users/{uid}/prompts/{promptId}` path kullanımı,
- `ownerId` davranışı,
- İlk Firestore security rules taslağı,
- Cross-user read/create ilk kontrolü.

---

### M4 — İlk Çekirdek Akış

Henüz not yok.

Beklenen not alanları:

- Kütüphane boş hâli,
- Hızlı Ekle,
- Firestore’a kullanıcıya bağlı kayıt,
- Kütüphanede görme,
- Kullanıcı izolasyonu,
- İlk uçtan uca dikey akış.

---

### M5 — Prompt Detay ve Normal Kopyala

Henüz not yok.

Beklenen not alanları:

- Prompt detay ekranı,
- Prompt metni görüntüleme,
- Normal Kopyala,
- Clipboard davranışı,
- `updatedAt` değişmeme kontrolü.

---

### M6 — Prompt Düzenleme, Status ve Arşiv

Henüz not yok.

Beklenen not alanları:

- Prompt düzenleme,
- Status değiştirme,
- Arşivleme,
- `status: archived`,
- `ownerId` değiştirilememe,
- `createdAt` korunması,
- `updatedAt` güncellenmesi,
- Kalıcı delete’in V1’e sızmaması.

---

### M7 — Detaylı Ekle

Henüz not yok.

Beklenen not alanları:

- Başlık,
- Açıklama,
- Notlar,
- Kategori,
- Etiketler,
- Status seçimi,
- Değişken algılama,
- Boş / tekrar eden etiket davranışı.

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
- ADR-007 — AI Gateway / Adapter V2,
- ADR-008 — AI kredi / kota modeli,
- ADR-009 — Firestore kullanıcı alt koleksiyonu,
- ADR-010 — V1’de arşivleme kalıcı delete yerine status.

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