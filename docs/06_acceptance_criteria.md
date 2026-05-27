# Prompt Yönetim Aracı — V1 Acceptance Criteria

## 1. Belge Bilgisi

**Belge tipi:** V1 kabul kriterleri belgesi  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmış başlangıç belgesi  
**Kapsam:** Prompt Yönetim Aracı V1 özellik, veri, güvenlik, mimari sınır ve kapanış kabul kriterleri  
**Son güncelleme:** 2026-05-25

Bu belge, Prompt Yönetim Aracı V1’in tamamlandı sayılabilmesi için hangi davranışların çalışması gerektiğini tanımlar.

Bu belge görev listesi değildir. Görevi, “bu özellik gerçekten tamamlandı mı?” sorusuna test edilebilir cevaplar vermektir.

---

## 2. Belgenin Amacı

Bu belgenin amacı, V1 geliştirme sürecinde özelliklerin, veri davranışlarının, güvenlik sınırlarının, mimari kararların ve kapsam sınırlarının kabul kriterlerini netleştirmektir.

V1 tamamlandı sayılabilmesi için yalnızca ekranların görünmesi yeterli değildir. Aşağıdaki unsurlar birlikte doğrulanmalıdır:

- Kullanıcı ana akışları çalışmalıdır.
- Prompt verisi doğru kullanıcıya bağlı saklanmalıdır.
- Firestore güvenlik sınırları korunmalıdır.
- UI doğrudan Firebase’e erişmemelidir.
- V1 dışı AI, ödeme, marketplace, takım/workspace gibi katmanlar ürüne sızmamalıdır.
- Android mobil cihazlarda temel kullanım akışları güvenilir çalışmalıdır.

---

## 3. V1 Genel Kabul Tanımı

V1, AI’sız ve manuel ama güçlü bir prompt yaşam döngüsü çekirdeği olarak tamamlanmalıdır.

V1’in ana akışı:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

Bu akışın kabul karşılıkları:

| Ana akış | V1 kabul karşılığı |
|---|---|
| Yakala | Kullanıcı promptu Hızlı Ekle veya Detaylı Ekle ile kaydedebilir. |
| Kartlaştır | Prompt, PromptCard alanlarıyla saklanır. |
| Değişkenleştir | `[DEĞİŞKEN_ADI]` alanları algılanır. |
| Bul | Kullanıcı kütüphanede arama ve filtreleme yapabilir. |
| Kullan | Normal Kopyala ve Değişkenli Kopyala-Doldur çalışır. |
| Güncelle | Kullanıcı promptu düzenleyebilir, status değiştirebilir, arşivleyebilir. |

---

## 4. Kabul Kriteri Yazım Standardı

Kabul kriterleri net, gözlenebilir ve test edilebilir olmalıdır.

Zayıf ifade:

```text
Auth düzgün çalışmalı.
```

Kabul edilebilir ifade:

```text
Kullanıcı geçerli e-posta ve şifreyle giriş yaptığında AuthGate kullanıcıyı kütüphane ekranına yönlendirir.
```

Belge içinde checkbox formatı ana yöntem olarak kullanılacaktır. Kritik akışlar gerektiğinde Given / When / Then formatıyla detaylandırılabilir.

---

## 5. Özellik Bazlı Kabul Kriterleri

## 5.1 Auth / Kullanıcı Hesabı

- [ ] Kullanıcı e-posta ve şifreyle kayıt olabilir.
- [ ] Kullanıcı e-posta ve şifreyle giriş yapabilir.
- [ ] Kullanıcı çıkış yapabilir.
- [ ] Giriş yapmamış kullanıcı kütüphane ekranına erişemez.
- [ ] Giriş yapmış kullanıcı AuthGate üzerinden kütüphaneye yönlendirilir.
- [ ] Login ve Register ekranları kalıcı yönlendirme kararını tek başına yönetmez.
- [ ] AuthGate merkezi yönlendirme noktası olarak çalışır.
- [ ] Auth hataları kullanıcıya anlaşılır şekilde gösterilir.
- [ ] Auth olmayan kullanıcı prompt verisi okuyamaz veya yazamaz.

V1 dışında:

- Google Sign-In zorunlu değildir.
- Sosyal giriş zorunlu değildir.
- Rol / yetki sistemi yoktur.
- Takım hesabı yoktur.

---

## 5.2 Hızlı Ekle

- [ ] Kullanıcı yalnızca `promptText` girerek prompt kaydedebilir.
- [ ] `promptText` boşsa kayıt yapılmaz.
- [ ] Sadece boşluklardan oluşan `promptText` geçersiz kabul edilir.
- [ ] Boş kayıt denemesinde kullanıcıya anlaşılır hata gösterilir.
- [ ] Kayıt sonrası prompt kullanıcının hesabına bağlı saklanır.
- [ ] Yeni prompt varsayılan olarak `status: raw` ile oluşturulabilir.
- [ ] `createdAt` ve `updatedAt` atanır.
- [ ] `schemaVersion: 1` atanır.
- [ ] Prompt metnindeki değişkenler varsa algılanır.
- [ ] Kayıt sonrası kullanıcı kütüphanede yeni promptu görebilir.

---

## 5.3 Detaylı Ekle

- [ ] Kullanıcı başlık ekleyebilir.
- [ ] Kullanıcı açıklama ekleyebilir.
- [ ] Kullanıcı not / bağlam ekleyebilir.
- [ ] Kullanıcı kategori ekleyebilir.
- [ ] Kullanıcı birden fazla etiket ekleyebilir.
- [ ] Kullanıcı status seçebilir.
- [ ] `promptText` tek zorunlu kullanıcı alanı olarak kalır.
- [ ] Boş etiketler kaydedilmez.
- [ ] Tekrarlanan etiketler tekilleştirilebilir.
- [ ] Prompt metnindeki `[DEĞİŞKEN_ADI]` alanları algılanır.
- [ ] Detaylı eklenen prompt kütüphanede doğru metadata ile görünür.
- [ ] Detaylı Ekle ekranına AI destekli başlık / kategori / etiket önerisi eklenmez.

---

## 5.4 Prompt Kartı

- [ ] Her prompt `PromptCard` olarak temsil edilir.
- [ ] PromptCard şu alanları taşır: `id`, `ownerId`, `title`, `promptText`, `description`, `notes`, `category`, `tags`, `status`, `variables`, `createdAt`, `updatedAt`, `schemaVersion`.
- [ ] `id` sistem tarafından oluşturulur.
- [ ] `ownerId` auth kullanıcısı ile ilişkilidir.
- [ ] `promptText` boş olamaz.
- [ ] `status` yalnızca izin verilen teknik key’lerden biri olabilir.
- [ ] `variables` promptText içinden algılanır.
- [ ] Domain modeli Firestore tiplerine bağımlı değildir.
- [ ] Firestore dokümanı doğrudan UI’a taşınmaz.

---

## 5.5 Kütüphane

- [ ] Kullanıcı kendi promptlarını liste halinde görebilir.
- [ ] Kütüphane boşsa anlaşılır boş durum gösterilir.
- [ ] Prompt kartları başlık veya fallback başlık gösterir.
- [ ] Prompt kartları kısa açıklama veya prompt önizlemesi gösterebilir.
- [ ] Prompt kartları status bilgisini gösterebilir.
- [ ] Prompt kartları son güncelleme bilgisini gösterebilir.
- [ ] Kullanıcı listeden prompt detayına geçebilir.
- [ ] Kullanıcı başka kullanıcıların promptlarını göremez.

---

## 5.6 Prompt Detay

- [ ] Kullanıcı bir promptun detayını açabilir.
- [ ] Detay ekranında prompt metni görüntülenir.
- [ ] Başlık, açıklama, notlar, kategori, etiketler, status ve değişkenler görüntülenebilir.
- [ ] Detay ekranından Normal Kopyala aksiyonuna erişilebilir.
- [ ] Detay ekranından düzenleme ekranına geçilebilir.
- [ ] Yetkisi olmayan kullanıcı başka kullanıcının prompt detayına erişemez.
- [ ] Uzun prompt metni kaydırılabilir ve ekran taşması oluşturmaz.

---

## 5.7 Normal Kopyala

- [ ] Kullanıcı prompt metnini olduğu gibi kopyalayabilir.
- [ ] Kopyalama sonrası kullanıcıya başarı bildirimi gösterilir.
- [ ] Normal Kopyala `updatedAt` alanını değiştirmez.
- [ ] Normal Kopyala `usageCount` artırmaz; çünkü V1’de kullanım sayısı yoktur.
- [ ] Değişkenli promptlarda Normal Kopyala değişkenleri doldurmadan metni olduğu gibi kopyalar.
- [ ] Gerçek Android cihazda kopyalama davranışı çalışır.

---

## 5.8 Prompt Düzenleme

- [ ] Kullanıcı kendi promptunu düzenleyebilir.
- [ ] Kullanıcı başlığı düzenleyebilir.
- [ ] Kullanıcı prompt metnini düzenleyebilir.
- [ ] Kullanıcı açıklamayı düzenleyebilir.
- [ ] Kullanıcı notları düzenleyebilir.
- [ ] Kullanıcı kategori ve etiketleri düzenleyebilir.
- [ ] Prompt metni boş bırakılırsa kayıt yapılmaz.
- [ ] Anlamlı değişiklikte `updatedAt` güncellenir.
- [ ] `createdAt` değişmez.
- [ ] `ownerId` değiştirilemez.
- [ ] Prompt metni değişirse değişken listesi yeniden hesaplanır.

---

## 5.9 Status ve Arşiv

- [ ] Kullanıcı prompt status değerini değiştirebilir.
- [ ] Geçerli status değerleri: `raw`, `needs_edit`, `ready`, `archived`.
- [ ] Kullanıcıya görünen karşılıklar: Ham, Düzenlenecek, Kullanıma Hazır, Arşiv.
- [ ] Arşivleme kalıcı silme değildir.
- [ ] Arşivlenen prompt `status: archived` ile saklanır.
- [ ] Arşivlenen prompt varsayılan listeden gizlenebilir.
- [ ] Arşiv filtresiyle arşivlenmiş promptlar görüntülenebilir.
- [ ] V1’de kalıcı delete yoktur.

---

## 5.10 Arama ve Filtreleme

- [ ] Kullanıcı metin araması yapabilir.
- [ ] Arama başlık içinde çalışır.
- [ ] Arama prompt metni içinde çalışır.
- [ ] Arama açıklama içinde çalışabilir.
- [ ] Arama notlar içinde çalışabilir.
- [ ] Kullanıcı kategoriye göre filtreleyebilir.
- [ ] Kullanıcı etikete göre filtreleyebilir.
- [ ] Kullanıcı status değerine göre filtreleyebilir.
- [ ] Arama ve filtreleme birlikte çalışabilir.
- [ ] Sonuç yoksa boş sonuç durumu gösterilir.
- [ ] V1’de semantik arama yoktur.
- [ ] V1’de embedding tabanlı arama yoktur.

---

## 5.11 Değişkenli Kopyala-Doldur

- [ ] Sistem `[DEĞİŞKEN_ADI]` formatındaki değişkenleri algılar.
- [ ] Aynı değişken birden fazla geçerse tek form alanı oluşturulur.
- [ ] Kullanıcı değişken değerlerini doldurabilir.
- [ ] Final prompt, girilen değerlerle oluşturulur.
- [ ] Final prompt kopyalanabilir.
- [ ] Eksik değişken değeri varsa kullanıcıya uyarı gösterilebilir.
- [ ] Değişken yoksa kullanıcıya uygun durum gösterilir.
- [ ] Uzun değişken listesinde ekran taşması oluşmaz.
- [ ] V1’de değişken tipi yoktur.
- [ ] V1’de varsayılan değer yoktur.
- [ ] V1’de koşullu blok yoktur.

---

## 5.12 Ayarlar / Hesap

- [ ] Kullanıcı hesap bilgilerini temel düzeyde görebilir.
- [ ] Kullanıcı çıkış yapabilir.
- [ ] Ayarlar ekranı V1’de sade tutulur.
- [ ] V1’de ödeme, abonelik, AI kota ekranı bulunmaz.
- [ ] V1’de gelişmiş profil yönetimi yoktur.

---

## 6. Veri Davranışı Kabul Kriterleri

- [ ] Her prompt bir kullanıcıya bağlıdır.
- [ ] `ownerId`, auth kullanıcısının uid değeriyle uyumludur.
- [ ] `createdAt` oluşturma anında atanır.
- [ ] `updatedAt` anlamlı güncellemede yenilenir.
- [ ] Normal Kopyala `updatedAt` değiştirmez.
- [ ] `schemaVersion` yeni kayıtlarda `1` olur.
- [ ] `tags` string listesi olarak saklanır.
- [ ] `variables` string listesi olarak saklanır.
- [ ] `status` teknik key olarak saklanır.
- [ ] Kullanıcıya görünen status metni UI katmanında çevrilir.
- [ ] Firestore verisi DTO / Mapper üzerinden domain modeline çevrilir.
- [ ] Firestore dokümanı doğrudan UI’a taşınmaz.

---

## 7. Güvenlik Kabul Kriterleri

- [ ] Auth olmayan kullanıcı prompt verisi okuyamaz.
- [ ] Auth olmayan kullanıcı prompt oluşturamaz.
- [ ] Kullanıcı yalnızca kendi promptlarını okuyabilir.
- [ ] Kullanıcı yalnızca kendi promptlarını oluşturabilir.
- [ ] Kullanıcı yalnızca kendi promptlarını güncelleyebilir.
- [ ] Kullanıcı başka bir kullanıcının promptunu okuyamaz.
- [ ] Kullanıcı başka bir kullanıcının promptunu güncelleyemez.
- [ ] Create sırasında `ownerId`, `request.auth.uid` ile eşleşmelidir.
- [ ] Update sırasında `ownerId` değiştirilemez.
- [ ] Kalıcı delete V1’de kapalıdır.
- [ ] AI API key client tarafında yoktur.
- [ ] V1’de Cloud Functions / AI Gateway bulunmaz.
- [ ] Firestore rules `allow read, write: if request.auth != null;` gibi gevşek bir kuraldan ibaret değildir.

---

## 8. Mimari Sınır Kabul Kriterleri

- [ ] UI Firebase Auth’a doğrudan erişmez.
- [ ] UI Firestore’a doğrudan erişmez.
- [ ] Screen → Provider/Notifier → Repository → Service → Firebase akışı korunur.
- [ ] Domain modeli Firestore tiplerine bağımlı değildir.
- [ ] Firestore DTO’su UI katmanına sızmaz.
- [ ] Repository interface ve implementation ayrımı korunur.
- [ ] Mapper dönüşümleri merkezi yapılır.
- [ ] Ortak kod gereksiz yere `core/` içine atılmaz.
- [ ] Feature sınırları korunur.
- [ ] V1 dışı AI / payment / analytics mimariye sızmaz.

---

## 9. Hata Durumu ve Boş Durum Kabul Kriterleri

## 9.1 Boş Durumlar

- [ ] Kütüphane boşsa kullanıcıya anlaşılır boş durum gösterilir.
- [ ] Arama sonucu yoksa kullanıcıya sonuç bulunamadı durumu gösterilir.
- [ ] Değişken yoksa Değişkenli Kopyala-Doldur ekranı uygun mesaj gösterir.
- [ ] Arşiv boşsa uygun boş durum gösterilir.
- [ ] Filtre sonucu yoksa uygun boş sonuç durumu gösterilir.

## 9.2 Hatalar

- [ ] Auth hatası kullanıcıya anlaşılır gösterilir.
- [ ] Firestore permission hatası çökme yaratmaz.
- [ ] Network hatası kullanıcıya anlaşılır gösterilir.
- [ ] Kayıt başarısız olursa kullanıcı bilgilendirilir.
- [ ] Güncelleme başarısız olursa kullanıcı bilgilendirilir.
- [ ] Boş `promptText` kaydetme denemesi engellenir.

---

## 10. Cihaz / Platform Kabul Kriterleri

V1 ana cihaz odağı Android mobil olacaktır.

- [ ] Uygulama Android gerçek cihazda açılır.
- [ ] Uygulama Android emülatörde açılır.
- [ ] Küçük Android ekranda temel formlar taşma oluşturmaz.
- [ ] Klavye açıldığında Login, Register, Hızlı Ekle ve Detaylı Ekle ekranları kullanılabilir kalır.
- [ ] Uzun prompt metinleri kaydırılabilir.
- [ ] Prompt Detay ekranında uzun metin okunabilir kalır.
- [ ] Değişkenli Kopyala-Doldur ekranında çoklu input alanları ekranı bozmaz.
- [ ] Android geri tuşu temel akışlarda beklenen davranışı gösterir.
- [ ] Kopyalama gerçek cihazda çalışır.
- [ ] Tablet / web / desktop testleri V1 için opsiyonel smoke test olarak değerlendirilebilir; ana kabul şartı Android mobil çekirdektir.

---

## 11. Milestone Bazlı Kabul Özeti

| Milestone | Kabul odağı |
|---|---|
| M0 | Proje açılıyor, temel yapı hazır. |
| M1 | AuthGate, login, register, logout çalışıyor. |
| M2 | PromptCard domain modeli Firebase’den bağımsız. |
| M3 | Firestore data layer DTO/Mapper/Repository üzerinden çalışıyor. |
| M4 | Hızlı Ekle → Firestore → Kütüphane akışı çalışıyor. |
| M5 | Prompt Detay ve Normal Kopyala çalışıyor. |
| M6 | Düzenleme, status, arşiv çalışıyor. |
| M7 | Detaylı Ekle metadata ile kayıt oluşturuyor. |
| M8 | Arama ve filtreleme çalışıyor. |
| M9 | Değişkenli Kopyala-Doldur final prompt üretiyor. |
| M10 | Güvenlik, test, mimari sınır ve V1 kapanış tamam. |

---

## 12. V1 Kapanış Kabul Kriterleri

V1 tamamlandı sayılabilmesi için en az şu şartlar sağlanmalıdır:

- [ ] Kullanıcı kayıt olabilir.
- [ ] Kullanıcı giriş yapabilir.
- [ ] Kullanıcı çıkış yapabilir.
- [ ] AuthGate doğru çalışır.
- [ ] Kullanıcı promptu Hızlı Ekle ile kaydedebilir.
- [ ] Kullanıcı promptu Detaylı Ekle ile kaydedebilir.
- [ ] PromptCard canonical modele uygun oluşur.
- [ ] Prompt Firestore’da kullanıcıya bağlı saklanır.
- [ ] Kullanıcı yalnızca kendi promptlarını görür.
- [ ] Kütüphanede promptlar listelenir.
- [ ] Kullanıcı prompt detayına girebilir.
- [ ] Normal Kopyala çalışır.
- [ ] Prompt düzenlenebilir.
- [ ] Status değiştirilebilir.
- [ ] Prompt arşivlenebilir.
- [ ] Arama çalışır.
- [ ] Kategori filtresi çalışır.
- [ ] Etiket filtresi çalışır.
- [ ] Status filtresi çalışır.
- [ ] `[DEĞİŞKEN_ADI]` değişkenleri algılanır.
- [ ] Değişkenli Kopyala-Doldur final prompt üretir.
- [ ] `createdAt / updatedAt` doğru davranır.
- [ ] Firestore rules kullanıcı izolasyonunu sağlar.
- [ ] UI Firebase’e doğrudan erişmez.
- [ ] Android mobilde temel akışlar güvenilir çalışır.
- [ ] V1 dışı AI, ödeme, marketplace, takım, analytics katmanları eklenmemiştir.

---

## 13. V1 Dışı Sızıntı Kontrolü

Aşağıdakiler V1’e girerse scope leak sayılır:

- AI destekli prompt iyileştirme
- AI başlık önerisi
- AI kategori / etiket önerisi
- Semantik arama
- Embedding
- Browser extension
- Import / export
- Usage analytics
- Version history
- Payment / subscription
- AI credit / quota screen
- Team / workspace
- Marketplace
- Public sharing
- Cloud Functions
- AI Gateway
- Push notification
- Kalıcı delete

Karar kuralı:

> V1 ana akışını doğrudan tamamlamayan özellik, parking lot’a taşınır.

---

## 14. Referans Belgeler

Bu belge şu belgelerle birlikte kullanılmalıdır:

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `07_test_security_plan.md`
- `08_parking_lot_v1_5_v2.md`
- `docs/checklists/`

---

## 15. Kapanış Notu

Bu belge, Prompt Yönetim Aracı V1’in “tamamlandı” kabul edilebilmesi için gereken ana kalite ve davranış kriterlerini tanımlar.

Kriterler geliştirme sürecinde güncellenebilir; ancak V1’in manuel prompt yaşam döngüsü çekirdeği, güvenlik sınırları ve kapsam dışı sızıntı kontrolü korunmalıdır.
