# Prompt Yönetim Aracı — V1.5 / V2 Parking Lot

## 1. Belge Bilgisi

**Belge tipi:** Parking lot / gelecek kapsam kayıt belgesi  
**Sürüm:** v0.1  
**Durum:** 0.9 kapsamında hazırlanmıştır  
**Kapsam:** V1 dışında bırakılan ancak ileride değerlendirilecek V1.5, V2, V2.5, V3 ve teknik park alanı fikirleri  
**Son güncelleme:** 2026-05-25

Bu belge, Prompt Yönetim Aracı projesinde V1 kapsamına alınmayan ancak ileride değerlendirilebilecek özellikleri, teknik fikirleri, AI katmanlarını, monetization / kota karar adaylarını ve uzun vadeli büyüme alanlarını düzenli biçimde tutmak için kullanılır.

---

## 2. Belgenin Amacı

Bu belgenin amacı, V1 geliştirme kapsamını korurken değerli fikirleri kaybetmemektir.

Parking Lot şu işlere yarar:

- V1 scope şişmesini önler.
- V1 için erken olan fikirleri doğru gelecek rafına taşır.
- V1.5, V2, V2.5 ve V3 ayrımını net tutar.
- AI, monetization, entegrasyon, teknik altyapı ve büyüme fikirlerini kontrollü biçimde saklar.
- Kodlama sırasında “bunu da ekleyelim” riskini azaltır.
- V1 Scope belgesiyle birlikte kapsam dışı sızıntıyı engeller.

**Ana kural:**

> Parking Lot’a alınan fikir otomatik olarak yapılacak kabul edilmez. Sadece kayda alınır ve ileride uygun zamanda yeniden değerlendirilir.

---

## 3. Kullanım Kuralları

- V1 ana akışına doğrudan hizmet etmeyen fikirler Parking Lot’a alınır.
- Parking Lot’a alınan fikir V1’e gizlice eklenmez.
- Her fikir hedef sürüm rafına yerleştirilir.
- Her fikir için “neden V1’de değil?” notu tutulur.
- AI destekli özellikler V1’e alınmaz; V2 veya sonrası için değerlendirilir.
- Ödeme, abonelik, AI kota, kullanım analitiği ve büyük backend işleri V1’e alınmaz.
- Değerli ama erken fikirler reddedilmez; doğru zamana park edilir.
- Bir fikir tekrar gündeme geldiğinde V1 Scope, Architecture, Data Model ve Acceptance Criteria belgelerine göre değerlendirilir.

---

## 4. Sürüm Rafları

### 4.1 V1.5 — Kullanım Rahatlatma ve Destekleyici Özellikler

V1 çalıştıktan sonra kullanıcı deneyimini kolaylaştıracak, ama ürünün temel mimarisini dramatik biçimde değiştirmeyecek özellikler bu rafta tutulur.

**V1.5 ruhu:**

> V1 çalışıyor. Şimdi kullanımı daha rahat, daha hızlı ve daha düzenli hâle getirelim.

---

### 4.2 V2 — AI Destekli Akıllı Katman

V1’in manuel çekirdeğinin üstüne gelen, kullanıcı onaylı ve isteğe bağlı AI destek özellikleri bu rafta tutulur.

**V2 ruhu:**

> Kullanıcı kontrolü kaybetmeden, AI prompt bakımını hızlandırsın.

---

### 4.3 V2.5 — Gelişmiş AI / Kota / Büyük İşlemler

V2’den daha ağır, maliyetli, toplu veya kota / preflight gerektiren AI işlemleri bu rafta tutulur.

**V2.5 ruhu:**

> AI sadece tek promptu değil, kütüphaneyi yönetmeye başlıyor.

---

### 4.4 V3 — Kişisel AI Çalışma Hafızası

Ürünün uzun vadeli kişisel AI çalışma hafızası vizyonuna yaklaşan gelişmiş sistem katmanları bu rafta tutulur.

**V3 ruhu:**

> Ürün promptları yönetmekten, kullanıcının AI ile çalışma biçimini taşıyan kişisel çalışma hafızasına evriliyor.

---

## 5. Parking Lot Kayıt Şablonu

Her park kaydı mümkünse şu formatla tutulmalıdır:

```md
## [KAYIT_ID] — Fikir Başlığı

Durum: Park edildi / Aday / İncelenecek / Reddedildi / Sonra değerlendirilecek  
Hedef sürüm: V1.5 / V2 / V2.5 / V3  
Kategori: UX / AI / Data / Search / Monetization / Infrastructure / Security / Dev Tooling  
Öncelik: Düşük / Orta / Yüksek  
Kaynak: Hangi konuşma, karar veya ihtiyaçtan doğdu?

### Kısa Açıklama
Fikir nedir?

### Kullanıcı Değeri
Kullanıcıya ne kazandırır?

### Neden V1’de Değil?
V1’e neden alınmıyor?

### Bağımlılıklar
Hangi altyapı, karar veya önceki özellik gerekir?

### Riskler
Kapsam, maliyet, karmaşıklık veya güvenlik riski var mı?

### Yeniden Değerlendirme Zamanı
Ne zaman tekrar bakılacak?

### Notlar
Ek düşünceler.
```

---

## 6. V1.5 Park Alanı

### V15-001 — Browser Extension

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** UX / Capture  
**Öncelik:** Orta

#### Kısa Açıklama
Kullanıcının ChatGPT, Claude, Gemini veya benzeri AI araçlarında kullandığı değerli promptları hızlıca yakalayıp Prompt Yönetim Aracı’na aktarmasını sağlayacak tarayıcı uzantısı.

#### Kullanıcı Değeri
Prompt yakalama sürtünmesini azaltır ve ürünün “değerli promptu kaçırmama” vaadini güçlendirir.

#### Neden V1’de Değil?
Ek platform, izinler, tarayıcı uyumluluğu ve dağıtım karmaşıklığı getirir. V1 önce manuel çekirdeği kanıtlamalıdır.

#### Yeniden Değerlendirme Zamanı
V1 ana akışı tamamlandıktan ve kullanıcıların prompt yakalama sürtünmesi gözlemlendikten sonra.

---

### V15-002 — Basit Import / Export

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** Data / Portability  
**Öncelik:** Orta

#### Kısa Açıklama
Kullanıcının promptlarını dışa alması veya mevcut prompt listesini uygulamaya aktarması.

#### Kullanıcı Değeri
Veri sahipliği ve taşınabilirlik hissini artırır. Mevcut Prompt Kasası / Obsidian / Notion benzeri sistemlerden geçişi kolaylaştırabilir.

#### Neden V1’de Değil?
Veri formatı, hata yönetimi, schemaVersion, migration ve çakışma davranışları ekstra karmaşıklık getirir.

#### Yeniden Değerlendirme Zamanı
PromptCard modeli V1’de gerçek kullanımla oturduktan sonra.

---

### V15-003 — Koleksiyonlar / Gruplar

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** Information Architecture  
**Öncelik:** Orta

#### Kısa Açıklama
Promptları proje, tema, iş akışı veya kullanım bağlamına göre koleksiyonlar altında toplama.

#### Kullanıcı Değeri
Çok sayıda prompt biriktiğinde düzeni güçlendirir.

#### Neden V1’de Değil?
V1’de kategori + etiket yapısı yeterli kabul edilmiştir. Koleksiyon sistemi bilgi mimarisini erken karmaşıklaştırabilir.

#### Yeniden Değerlendirme Zamanı
Kullanıcı başına prompt sayısı arttığında veya kategori/etiket yapısı yetersiz kaldığında.

---

### V15-004 — Kullanım Sayısı

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** Analytics / Usage  
**Öncelik:** Düşük-Orta

#### Kısa Açıklama
Promptların kaç kez kopyalandığını veya kullanıldığını izleme.

#### Kullanıcı Değeri
Kullanıcının en faydalı promptlarını görmesini sağlar.

#### Neden V1’de Değil?
V1’de kullanım analitiği yoktur. Normal Kopyala `updatedAt` veya `usageCount` davranışı üretmeyecektir.

#### Yeniden Değerlendirme Zamanı
V1 kullanım alışkanlıkları gözlemlendikten sonra.

---

### V15-005 — Onboarding

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** UX  
**Öncelik:** Orta

#### Kısa Açıklama
Yeni kullanıcıya ilk promptunu ekleten, V1 ana akışını hızlıca gösteren hafif başlangıç deneyimi.

#### Kullanıcı Değeri
Ürünün “aha” anına daha hızlı ulaşılmasını sağlar.

#### Neden V1’de Değil?
V1 önce çekirdek akışı kanıtlamalıdır. Ağır onboarding kullanıcıyı yavaşlatabilir.

#### Yeniden Değerlendirme Zamanı
V1 kullanılabilir hâle geldikten ve ilk kullanıcı deneyimi gözlemlendikten sonra.

---

### V15-006 — Prompt Şablon Kütüphanesi

**Durum:** Park edildi  
**Hedef sürüm:** V1.5 / V2  
**Kategori:** Templates / UX  
**Öncelik:** Orta

#### Kısa Açıklama
Kullanıcının başlangıçta örnek prompt yapılarından faydalanmasını sağlayacak şablon kütüphanesi.

#### Kullanıcı Değeri
Yeni kullanıcıya ilham verir ve prompt kartı mantığını öğretir.

#### Neden V1’de Değil?
Ürün hazır prompt pazarı gibi algılanmamalıdır. Ana değer kullanıcının kendi prompt yaşam döngüsünü yönetmesidir.

#### Yeniden Değerlendirme Zamanı
V1 çekirdeği çalıştıktan ve onboarding ihtiyacı netleştikten sonra.

---

### V15-007 — Kullanım Sonrası Mini Review / Prompt Health Check

**Durum:** Park edildi  
**Hedef sürüm:** V1.5  
**Kategori:** Lifecycle / Quality  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
Kullanıcının promptu kullandıktan sonra kısa bir değerlendirme yapması veya promptun sağlık durumunu not etmesi.

#### Kullanıcı Değeri
Promptun zaman içinde gelişmesini ve gerçekten işe yarayan promptların ayrışmasını sağlar.

#### Neden V1’de Değil?
Yaşam döngüsü için değerli olsa da ilk çekirdek akışı büyütür. V1’de ana başarı akışı önceliklidir.

#### Yeniden Değerlendirme Zamanı
V1 kullanıcıları promptları tekrar kullanmaya başladıktan sonra.

---

## 7. V2 Park Alanı

### V2-001 — AI Başlık Önerisi

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Metadata  
**Öncelik:** Orta

#### Kısa Açıklama
AI, prompt metnine göre başlık önerir.

#### Kullanıcı Değeri
Kartlaştırma sürecini hızlandırır.

#### Neden V1’de Değil?
V1 manuel çekirdektir. AI destekli alan önerileri V2’ye ayrılmıştır.

#### Kritik Kural
AI önerisi kullanıcı onayı olmadan Prompt Kartı’na yazılmaz.

---

### V2-002 — AI Açıklama Önerisi

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Metadata  
**Öncelik:** Orta

#### Kısa Açıklama
AI, promptun amacını kısa açıklamaya dönüştürür.

#### Kullanıcı Değeri
Promptun sonradan anlaşılmasını kolaylaştırır.

#### Neden V1’de Değil?
V1 manuel veri girişiyle başlayacaktır.

#### Kritik Kural
Kullanıcı onayı olmadan kart verisi değişmez.

---

### V2-003 — AI Kategori / Etiket Önerisi

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Classification  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
AI, prompt metnine göre kategori ve etiket önerir.

#### Kullanıcı Değeri
Bulunabilirliği artırır ve düzenleme yükünü azaltır.

#### Neden V1’de Değil?
Otomatik sınıflandırma V2 akıllı katmanıdır.

#### Kritik Kural
AI yalnızca öneri sunar; kullanıcı seçer veya düzenler.

---

### V2-004 — AI Prompt İyileştirme

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Improvement  
**Öncelik:** Yüksek

#### Kısa Açıklama
AI, promptu daha net, yapılandırılmış, tekrar kullanılabilir veya değişkenli hâle getirmek için öneri üretir.

#### Kullanıcı Değeri
Prompt kalitesini artırır ve kullanıcıya çalışma bilgisini geliştirme desteği verir.

#### Neden V1’de Değil?
V1 önce manuel prompt yaşam döngüsü çekirdeğini kanıtlamalıdır. AI işlem maliyeti, kota ve kullanıcı onayı gibi sistemler gerektirir.

#### Kritik Kural
Orijinal prompt korunmalı; AI değişikliği kullanıcı onayı olmadan uygulanmamalıdır.

---

### V2-005 — AI Değişken Önerisi

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Reusability  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
AI, prompt içindeki değişebilecek alanları `[DEĞİŞKEN_ADI]` formatına dönüştürmeyi önerir.

#### Kullanıcı Değeri
Promptu tekrar kullanılabilir mini araca dönüştürme sürecini hızlandırır.

#### Neden V1’de Değil?
V1’de değişkenler manuel standartla çalışacak; AI destekli öneri V2’ye ayrılmıştır.

---

### V2-006 — Semantik Arama

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** Search / AI  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
Kullanıcı birebir kelimeyi hatırlamasa da anlamca ilgili promptları bulabilir.

#### Kullanıcı Değeri
Prompt kütüphanesi büyüdükçe bulunabilirliği ciddi şekilde artırır.

#### Neden V1’de Değil?
Embedding, search backend, maliyet ve veri işleme karmaşıklığı getirir. V1’de basit client-side arama yeterlidir.

---

### V2-007 — AI Destekli Import / Export

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** AI / Data Portability  
**Öncelik:** Orta

#### Kısa Açıklama
Dağınık prompt arşivlerini AI yardımıyla analiz edip PromptCard yapısına dönüştürme.

#### Kullanıcı Değeri
Mevcut prompt arşivinden ürüne geçişi hızlandırır.

#### Neden V1’de Değil?
Büyük veri işleme, hata yönetimi, AI maliyeti ve kullanıcı onayı gerektirir.

---

### V2-008 — AI Gateway / Adapter

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** Infrastructure / AI  
**Öncelik:** Yüksek

#### Kısa Açıklama
AI işlemlerini client’tan değil backend tarafındaki sağlayıcı bağımsız AI Gateway / Adapter üzerinden yönetme.

#### Kullanıcı Değeri
Model değiştirilebilirliğini, güvenliği, kota ve maliyet takibini mümkün kılar.

#### Neden V1’de Değil?
V1’de AI yoktur. Bu altyapı V2 AI katmanının omurgasıdır.

#### Kritik Kural
Flutter istemcisi OpenAI, Gemini, Claude, Mistral veya başka sağlayıcıyı doğrudan bilmez. AI API key client tarafında tutulmaz.

---

## 8. V2.5 Park Alanı

### V25-001 — Toplu Prompt İyileştirme

**Durum:** Park edildi  
**Hedef sürüm:** V2.5  
**Kategori:** AI / Bulk Operations  
**Öncelik:** Orta

#### Kısa Açıklama
Birden fazla promptu aynı anda iyileştirme, yeniden yapılandırma veya metadata açısından zenginleştirme.

#### Kullanıcı Değeri
Büyük prompt kütüphanelerinin bakımını hızlandırır.

#### Neden V1/V2 Başında Değil?
Maliyet, kota, kullanıcı onayı, preflight tahmin ve geri alma davranışı gerektirir.

---

### V25-002 — Kütüphane Sağlık Taraması

**Durum:** Park edildi  
**Hedef sürüm:** V2.5  
**Kategori:** AI / Quality  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
Kullanıcının prompt kütüphanesindeki eksik açıklama, zayıf başlık, gereksiz tekrar, arşiv adayı veya değişkenleştirme adayı promptları bulma.

#### Kullanıcı Değeri
Prompt kütüphanesinin kalitesini zaman içinde artırır.

#### Neden V1/V2 Başında Değil?
Toplu analiz ve AI maliyeti içerir.

---

### V25-003 — Preflight Maliyet / Kota Tahmini

**Durum:** Park edildi  
**Hedef sürüm:** V2.5  
**Kategori:** Monetization / AI Cost  
**Öncelik:** Yüksek

#### Kısa Açıklama
Büyük AI işlemleri öncesinde tahmini AI hakkı / kredi maliyetini kullanıcıya gösterme.

#### Kullanıcı Değeri
Kullanıcı, büyük işlemden önce maliyeti görür ve bilinçli onay verir.

#### Neden V1’de Değil?
V1’de AI yoktur. Bu yapı V2.5 büyük AI işlemleriyle anlam kazanır.

---

## 9. V3 Park Alanı

### V3-001 — Proje Bazlı Prompt Sistemleri

**Durum:** Park edildi  
**Hedef sürüm:** V3  
**Kategori:** Knowledge Architecture  
**Öncelik:** Orta-Yüksek

#### Kısa Açıklama
Promptları tek tek kartlar yerine proje bazlı sistemler içinde yönetme.

#### Kullanıcı Değeri
Kullanıcının farklı projeler için ayrı AI çalışma sistemleri kurmasını sağlar.

#### Neden V1’de Değil?
V1 bireysel prompt yaşam döngüsü çekirdeğini kanıtlamalıdır. Proje bazlı sistemler daha gelişmiş bilgi mimarisi gerektirir.

---

### V3-002 — Workflow’lar

**Durum:** Park edildi  
**Hedef sürüm:** V3  
**Kategori:** Workflow / Automation  
**Öncelik:** Orta

#### Kısa Açıklama
Birden fazla promptu sıralı iş akışları hâline getirme.

#### Kullanıcı Değeri
Tekil promptların ötesinde tekrar eden AI iş süreçlerini yönetmeyi sağlar.

#### Neden V1’de Değil?
V1 prompt kartı ve yeniden kullanım çekirdeğine odaklanır.

---

### V3-003 — Ajan Destekli Bakım

**Durum:** Park edildi  
**Hedef sürüm:** V3  
**Kategori:** AI Agents / Maintenance  
**Öncelik:** Orta

#### Kısa Açıklama
Kullanıcının prompt kütüphanesini ajan benzeri sistemlerle düzenli olarak gözden geçirme, öneriler sunma ve bakım akışı oluşturma.

#### Kullanıcı Değeri
Prompt kütüphanesi büyüdükçe bakım yükünü azaltır.

#### Neden V1’de Değil?
AI Gateway, kota sistemi, kullanıcı onayı, güvenlik ve gelişmiş ürün olgunluğu gerektirir.

---

### V3-004 — Kişisel AI Çalışma Hafızası

**Durum:** Park edildi  
**Hedef sürüm:** V3  
**Kategori:** Long-term Vision  
**Öncelik:** Yüksek

#### Kısa Açıklama
Ürünün yalnızca promptları değil, kullanıcının AI ile çalışma biçimini, tercihlerini, sistemlerini ve çalışma bilgisini taşıyan kişisel AI çalışma hafızasına dönüşmesi.

#### Kullanıcı Değeri
Kullanıcının AI kullanımını uzun vadeli bir çalışma sermayesine dönüştürür.

#### Neden V1’de Değil?
Bu büyük vizyon ancak V1 prompt yaşam döngüsü çekirdeği ve V2 AI katmanı doğrulandıktan sonra anlamlıdır.

---

## 10. Teknik Park Alanı

### TECH-001 — Mason Brick ile Flutter Proje / Feature Şablonu

**Durum:** Park edildi  
**Hedef sürüm:** V1 sonrası / Teknik altyapı  
**Kategori:** Dev Tooling  
**Öncelik:** Düşük-Orta

#### Kısa Açıklama
Mason brick, ileride Flutter projeleri veya feature yapıları için tekrar kullanılabilir şablonlar oluşturmak amacıyla değerlendirilecek teknik park alternatifi olacaktır.

#### Kullanıcı / Geliştirici Değeri
- Proje başlangıcını hızlandırır.
- Klasör yapısı hatalarını azaltır.
- Feature oluşturma standardını korur.
- Aynı mimariyi farklı projelerde tekrar kullanmayı kolaylaştırır.
- Kod organizasyonunda tutarlılık sağlar.

#### Neden V1’de Değil?
- V1 için basit PowerShell script yeterlidir.
- Mason yeni araç öğrenme ve bakım yükü getirir.
- İlk hedef, ürün çekirdeğini geliştirmektir.
- V1’de şablon motoru kurmak, ürün geliştirme hızını gereksiz yavaşlatabilir.

#### Önemli Netleştirme
Mason ile tekrar kullanılacak şey ürünün kendisi değildir. Tekrar kullanılacak şey Flutter proje/feature iskeleti, klasör standardı, repository-service-provider ayrımı ve başlangıç dosya şablonlarıdır. Her projenin domain modeli, feature kapsamı, veri alanları ve ürün kuralları ayrı tasarlanacaktır.

#### Yeniden Değerlendirme Zamanı
- Aynı mimari başka Flutter projelerinde tekrar kullanılmaya başlanırsa,
- Yeni feature yapıları elle tekrar eden yük hâline gelirse,
- Ortak Flutter proje başlangıç şablonu istenirse,
- Ortak Flutter Çözümleri Kütüphanesi ile proje şablonları birleştirilmek istenirse.

---

### TECH-002 — Supabase / PostgreSQL Alternatifi

**Durum:** Park edildi  
**Hedef sürüm:** V2 / V3 teknik değerlendirme  
**Kategori:** Backend / Data  
**Öncelik:** Düşük-Orta

#### Kısa Açıklama
İlişkisel veri, SQL sorguları, gelişmiş raporlama veya daha kontrollü backend ihtiyacı doğarsa Supabase / PostgreSQL alternatifi değerlendirilebilir.

#### Neden V1’de Değil?
V1 için Firebase Auth + Cloud Firestore yeterli ve daha hızlı başlatılabilir kabul edilmiştir.

---

### TECH-003 — SQLite / Local-first Alternatifi

**Durum:** Park edildi  
**Hedef sürüm:** V2 / V3 teknik değerlendirme  
**Kategori:** Local Data / Offline  
**Öncelik:** Düşük

#### Kısa Açıklama
Offline-first veya local-first çalışma güçlü ihtiyaç hâline gelirse SQLite veya benzeri local database yaklaşımı değerlendirilebilir.

#### Neden V1’de Değil?
V1 cloud-first olarak kilitlenmiştir. Local-first + cloud sync V1 için fazla karmaşıktır.

---

### TECH-004 — Search Backend

**Durum:** Park edildi  
**Hedef sürüm:** V2 / V3  
**Kategori:** Search Infrastructure  
**Öncelik:** Orta

#### Kısa Açıklama
Algolia, Meilisearch, Typesense veya embedding tabanlı semantik arama gibi search altyapıları ileride değerlendirilebilir.

#### Neden V1’de Değil?
V1’de basit client-side arama yeterlidir.

---

## 11. Monetization / Kota / Paket Park Alanı

### MON-001 — AI Hakkı / AI Kredi Sistemi

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** Monetization / AI Cost  
**Öncelik:** Yüksek

#### Kısa Açıklama
Kullanıcıya token yerine AI hakkı / AI kredi gösterilmesi.

#### Kullanıcı Değeri
Daha anlaşılır ve paketlenebilir kullanım deneyimi sağlar.

#### Neden V1’de Değil?
V1’de AI kullanılmayacaktır.

---

### MON-002 — Paket Bazlı Kota Modeli

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** Subscription / Quota  
**Öncelik:** Orta-Yüksek

#### Başlangıç Kota Önerisi
- Free: 10 AI hakkı
- Starter: 100 AI hakkı
- Premium: 500 AI hakkı

#### Neden V1’de Değil?
V1 manuel çekirdektir. Abonelik ve AI kota sistemi V2 AI katmanıyla birlikte anlam kazanır.

---

### MON-003 — Ek Kredi Sistemi

**Durum:** Park edildi  
**Hedef sürüm:** V2 / V2.5  
**Kategori:** Monetization / Credits  
**Öncelik:** Orta

#### Kısa Açıklama
Kullanıcının paket kotası dışında ek AI hakkı satın alabilmesi.

#### Neden V1’de Değil?
AI işlemleri ve kota sistemi V1 dışıdır.

---

### MON-004 — Abonelik Yenilenmeyince AI Kotası Kapanması

**Durum:** Park edildi  
**Hedef sürüm:** V2  
**Kategori:** Subscription / Access Control  
**Öncelik:** Yüksek

#### Kısa Açıklama
Premium abonelik yenilenmediğinde premium AI hakkı kapanır, ancak kullanıcının prompt verileri silinmez.

#### Kullanıcı Değeri
Veri sahipliği korunur, ödeme durumu yalnızca AI kullanım haklarını etkiler.

#### Neden V1’de Değil?
V1’de abonelik ve AI hakkı bulunmaz.

---

## 12. Reddedilen veya Bilinçli Ertelenen Fikirler

### REJ-001 — Hazır Prompt Marketplace

**Durum:** Bilinçli ertelendi  
**Hedef sürüm:** V3 veya sonrası, gerekirse hiç  
**Kategori:** Marketplace

#### Gerekçe
Ürünün kişisel prompt yaşam döngüsü odağını bulanıklaştırabilir. Ürün hazır prompt pazarı olarak konumlanmamalıdır.

---

### REJ-002 — Takım / Workspace Sistemi

**Durum:** Bilinçli ertelendi  
**Hedef sürüm:** V3 veya sonrası  
**Kategori:** Collaboration

#### Gerekçe
İlk hedef kullanıcı bireysel AI power user’dır. V1 bireysel kullanım çekirdeğine odaklanacaktır.

---

### REJ-003 — V1’de AI Otomatik Düzenleme

**Durum:** Reddedildi  
**Hedef sürüm:** V2’de kullanıcı onaylı öneri olarak değerlendirilebilir  
**Kategori:** AI / Automation

#### Gerekçe
V1 manuel çekirdek olacak. AI kullanıcı onayı olmadan Prompt Kartı’nı değiştirmeyecektir.

---

### REJ-004 — V1’de Kalıcı Delete

**Durum:** Reddedildi  
**Hedef sürüm:** V1.5 / V2’de yeniden değerlendirilebilir  
**Kategori:** Data Lifecycle

#### Gerekçe
V1’de veri kaybı riskini azaltmak için arşivleme `status: archived` ile yapılacaktır. Kalıcı silme V1 kabul kriteri değildir.

---

## 13. Revisit Kuralları

Parking Lot maddeleri şu durumlarda yeniden değerlendirilir:

- V1 tamamlandıktan sonra,
- M10 kapanış kontrolünden sonra,
- İlk kullanıcı testleri sonrası,
- Kullanıcıdan tekrar eden ihtiyaç gelirse,
- Teknik altyapı hazır hâle gelirse,
- AI maliyet / kota modeli netleşirse,
- Bir fikir V1 ana akışındaki gerçek darboğazı çözüyorsa,
- Mevcut V1 çözümü belirgin şekilde yetersiz kalıyorsa.

Yeniden değerlendirme soruları:

1. Bu fikir hangi problemi çözüyor?
2. Kullanıcı değeri net mi?
3. V1 çekirdeği tamamlanmadan gerekli mi?
4. Teknik maliyeti ne?
5. AI maliyeti var mı?
6. Güvenlik riski var mı?
7. Veri modelini değiştiriyor mu?
8. Basit versiyonu yapılabilir mi?
9. Hangi sürüme ait?
10. Hâlâ ürün vizyonuyla uyumlu mu?

---

## 14. V1 Scope Koruma Notu

Bu belge `01_v1_scope.md` ile birlikte kullanılmalıdır.

- `01_v1_scope.md`, V1’in sınırlarını belirler.
- `08_parking_lot_v1_5_v2.md`, V1 dışında kalan değerli fikirleri saklar.
- Bir fikir V1’e eklenmek istenirse önce scope kontrolünden geçer.
- Scope kontrolünden geçmeyen fikir Parking Lot’a alınır.
- Parking Lot’a alınan fikir V1’e gizlice eklenmez.

**Karar kuralı:**

> V1 ana akışını doğrudan tamamlamayan özellik, Parking Lot’a taşınır.

---

## 15. Referans Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `09_development_notes.md`
- `ADR-006-v1-manual-core-v2-ai-layer.md`
- `ADR-007-ai-gateway-adapter-v2.md`
- `ADR-008-ai-credit-quota-model-v2.md`

---

## 16. Kapanış Notu

Bu belge, Prompt Yönetim Aracı’nın V1 kapsamını korurken gelecek fikirleri kaybetmemesi için kullanılacaktır.

V1’in görevi manuel prompt yaşam döngüsü çekirdeğini kanıtlamaktır. V1.5, V2, V2.5 ve V3 fikirleri değerli olabilir; ancak doğru zamanda, doğru altyapıyla ve doğru karar kontrolünden geçerek ele alınmalıdır.

**Bu belge V1 için yapılacaklar listesi değil, V1 dışında tutulan fikirlerin kontrollü park alanıdır.**
