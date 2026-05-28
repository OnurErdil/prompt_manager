# G03 — Scope Leak Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1 geliştirme sürecinde kapsam dışı özelliklerin ürüne gizlice sızmasını önlemek için kullanılır.

V1’in amacı:

```text
Manuel ama güçlü prompt yaşam döngüsü çekirdeği kurmak.
```

V1 ana akışı:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

Bu checklist, bu çekirdek akışa doğrudan hizmet etmeyen fikirlerin V1’e eklenmesini engeller ve gerekirse `08_parking_lot_v1_5_v2.md` belgesine taşınmasını sağlar.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- Her milestone sonunda,
- Yeni bir özellik önerildiğinde,
- Dış AI review sonrası öneriler değerlendirilirken,
- Kodlama sırasında “bunu da ekleyelim” fikri doğduğunda,
- M10 V1 kapanış kontrolünde,
- V1 scope belgesiyle çelişki şüphesi oluştuğunda.

## 3. Bağlı Belgeler

- `01_v1_scope.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `08_parking_lot_v1_5_v2.md`
- `09_development_notes.md`
- `ADR-006-v1-manual-core-v2-ai-layer.md`
- `ADR-007-ai-gateway-adapter-v2.md`
- `ADR-008-ai-credit-quota-model-v2.md`
- `ADR-010-archive-instead-of-delete-v1.md`
- `g01_security_checklist.md`
- `g02_architecture_boundary_checklist.md`

## 4. V1 Ana Kapsam Hatırlatma

V1’de olacak çekirdek özellikler:

- [ ] Hızlı Ekle
- [ ] Detaylı Ekle
- [ ] Prompt Kartı
- [ ] Kütüphane
- [ ] Basit arama
- [ ] Kategori / etiket / durum filtreleme
- [ ] Normal Kopyala
- [ ] Değişkenli Kopyala-Doldur
- [ ] Prompt Düzenleme
- [ ] Status sistemi
- [ ] Arşiv
- [ ] Firebase Auth
- [ ] Cloud Firestore
- [ ] Kullanıcı izolasyonu

V1’in ana ölçütü:

```text
Kullanıcı değerli promptu yakalayıp kartlaştırabiliyor, sonra bulup tekrar kullanabiliyor ve güncelleyebiliyor mu?
```

## 5. Yeni Özellik İçin Scope Soruları

V1’e yeni bir özellik eklenmeden önce şu sorular sorulmalıdır:

- [ ] Bu özellik V1 ana akışına doğrudan hizmet ediyor mu?
- [ ] Bu özellik olmadan V1 kullanılamaz mı?
- [ ] Bu özellik manuel prompt yaşam döngüsü çekirdeğini kanıtlamak için şart mı?
- [ ] Bu özellik V1.5’e taşınsa ürünün çekirdeği bozulur mu?
- [ ] Bu özellik AI, ödeme, analitik, entegrasyon veya ekip katmanına mı ait?
- [ ] Bu özellik geliştirme süresini gereksiz uzatır mı?
- [ ] Bu özellik veri modelini V1 için gereksiz karmaşıklaştırır mı?
- [ ] Bu özellik M0-M10 milestone sırasını bozar mı?
- [ ] Bu özellik için yeni güvenlik riski doğuyor mu?
- [ ] Bu özellik için yeni backend altyapısı gerekiyor mu?

Karar kuralı:

> Cevap net değilse özellik V1’e alınmaz, parking lot’a taşınır.

## 6. AI Scope Leak Kontrolü

V1’de aşağıdaki AI özellikleri olmamalıdır:

- [ ] AI başlık önerisi yok.
- [ ] AI açıklama önerisi yok.
- [ ] AI kategori önerisi yok.
- [ ] AI etiket önerisi yok.
- [ ] AI prompt iyileştirme yok.
- [ ] AI prompt sadeleştirme yok.
- [ ] AI değişken önerisi yok.
- [ ] AI Prompt Health Check yok.
- [ ] AI destekli import/export yok.
- [ ] AI destekli toplu düzenleme yok.
- [ ] AI destekli kütüphane analizi yok.
- [ ] AI otomatik kart güncelleme yok.
- [ ] AI kullanıcı onayı olmadan veri değiştirmiyor.
- [ ] AI Gateway V1’e eklenmedi.
- [ ] OpenAI / Gemini / Claude / Mistral client entegrasyonu yok.
- [ ] Client tarafında AI API key yok.

AI ile ilgili değerli fikirler `08_parking_lot_v1_5_v2.md` içine V2 veya V2.5 adayı olarak taşınmalıdır.

## 7. Search / Semantic Scope Leak Kontrolü

V1’de arama basit olmalıdır.

Aşağıdakiler V1’e eklenmemelidir:

- [ ] Semantik arama yok.
- [ ] Embedding üretimi yok.
- [ ] Vector database yok.
- [ ] Algolia / Meilisearch / Typesense entegrasyonu yok.
- [ ] AI destekli arama yok.
- [ ] Karmaşık sorgu dili yok.
- [ ] Full-text search altyapısı zorunluluğu yok.
- [ ] Search ranking / relevance scoring yok.

V1’de kabul edilen:

- [ ] Başlık / prompt metni / açıklama / notlar içinde basit metin arama.
- [ ] Kategori filtresi.
- [ ] Etiket filtresi.
- [ ] Durum filtresi.

## 8. Analytics / Usage Scope Leak Kontrolü

V1’de kullanım analitiği yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] `usageCount` yok.
- [ ] `lastUsedAt` yok.
- [ ] Kullanım geçmişi yok.
- [ ] Prompt performans analitiği yok.
- [ ] En çok kullanılan promptlar ekranı yok.
- [ ] Dashboard istatistikleri yok.
- [ ] AI işlem log ekranı yok.
- [ ] Kullanıcı davranış analitiği yok.
- [ ] Growth analytics yok.

Normal Kopyala veya Değişkenli Kopyala-Doldur, V1’de kullanım sayısı artırmaz.

## 9. Versioning / History Scope Leak Kontrolü

V1’de gelişmiş sürümleme yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] Version history yok.
- [ ] Prompt diff görüntüleme yok.
- [ ] Geri alma sistemi yok.
- [ ] Değişiklik yorumları yok.
- [ ] Snapshot geçmişi yok.
- [ ] Otomatik versiyon oluşturma yok.
- [ ] `versionHistory` alanı yok.

V1’de kabul edilen:

- [ ] Prompt düzenlenebilir.
- [ ] Anlamlı değişiklikte `updatedAt` güncellenir.
- [ ] Eski sürüm saklanmaz.

## 10. Delete / Trash Scope Leak Kontrolü

V1’de kalıcı silme yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] Kalıcı delete yok.
- [ ] Çöp kutusu yok.
- [ ] `deletedAt` yok.
- [ ] `isDeleted` yok.
- [ ] Restore sistemi yok.
- [ ] Trash expiry yok.

V1’de kabul edilen:

```text
status: archived
```

Kontrol maddeleri:

- [ ] Arşivleme delete olarak çalışmıyor.
- [ ] Firestore rules delete’i reddediyor.
- [ ] UI’da kalıcı silme aksiyonu yok.
- [ ] Repository kalıcı delete operasyonu sunmuyor.

## 11. Payment / Subscription Scope Leak Kontrolü

V1’de ödeme sistemi yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] Payment ekranı yok.
- [ ] Subscription ekranı yok.
- [ ] Play Store billing entegrasyonu yok.
- [ ] Paket seçimi yok.
- [ ] Premium feature gate yok.
- [ ] AI kredi satın alma yok.
- [ ] Ek kredi sistemi yok.
- [ ] Abonelik yenileme kontrolü yok.
- [ ] Kullanıcı ödeme geçmişi yok.

Bu konular V2/V2.5 monetization ve AI kota sistemi kapsamında değerlendirilecektir.

## 12. AI Quota / Cost Scope Leak Kontrolü

V1’de AI kullanılmadığı için AI kota sistemi de yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] AI hakkı ekranı yok.
- [ ] AI kredi ekranı yok.
- [ ] Token ölçümü yok.
- [ ] AI usage log yok.
- [ ] Model maliyet takibi yok.
- [ ] Provider seçimi yok.
- [ ] Model routing yok.
- [ ] XS/S/M/L/XL işlem sınıfı UI’da yok.
- [ ] Preflight maliyet tahmini yok.

Bu kararlar ADR-008’de V2 için korunur, V1’e uygulanmaz.

## 13. Team / Workspace Scope Leak Kontrolü

V1 bireysel kullanıcı içindir.

Aşağıdakiler eklenmemelidir:

- [ ] Team yok.
- [ ] Workspace yok.
- [ ] Organization yok.
- [ ] Role/permission matrix yok.
- [ ] Shared prompt library yok.
- [ ] Team invite yok.
- [ ] Owner/admin/editor rolleri yok.
- [ ] Ortak prompt düzenleme yok.
- [ ] Multi-user collaboration yok.

İlk hedef kullanıcı bireysel AI power user’dır.

## 14. Marketplace / Public Sharing Scope Leak Kontrolü

V1 kişisel çalışma sistemi olarak kalmalıdır.

Aşağıdakiler eklenmemelidir:

- [ ] Prompt marketplace yok.
- [ ] Public prompt paylaşımı yok.
- [ ] Community prompt library yok.
- [ ] Hazır prompt mağazası yok.
- [ ] Public profile yok.
- [ ] Like/save/follow sistemi yok.
- [ ] Prompt satış sistemi yok.
- [ ] Moderation panel yok.

Ürün, V1’de hazır prompt pazarı değil kişisel prompt yaşam döngüsü aracıdır.

## 15. Browser Extension / Integration Scope Leak Kontrolü

V1’de extension veya dış entegrasyon yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] Browser extension yok.
- [ ] ChatGPT/Claude/Gemini otomatik yakalama yok.
- [ ] Web clipper yok.
- [ ] API entegrasyonu yok.
- [ ] Zapier/Make entegrasyonu yok.
- [ ] Shortcut/automation entegrasyonu yok.
- [ ] Promptu doğrudan başka AI aracına gönderme yok.
- [ ] AI çıktısını otomatik geri kaydetme yok.

Bu konular V1.5/V2 park alanında tutulabilir.

## 16. Import / Export Scope Leak Kontrolü

V1’de import/export yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] CSV import yok.
- [ ] JSON import yok.
- [ ] Markdown import yok.
- [ ] Obsidian import yok.
- [ ] Export yok.
- [ ] Backup/restore sistemi yok.
- [ ] Migration UI yok.

Veri modeli export/import için hazırlıklı tutulur, ancak özellik V1’e alınmaz.

## 17. Onboarding / Template Scope Leak Kontrolü

V1’de ağır onboarding veya hazır prompt kütüphanesi yoktur.

Aşağıdakiler eklenmemelidir:

- [ ] Zorunlu onboarding yok.
- [ ] Çok adımlı kullanıcı eğitimi yok.
- [ ] Hazır prompt şablon marketi yok.
- [ ] Geniş template library yok.
- [ ] AI destekli onboarding yok.
- [ ] Demo data sistemi yok.

Basit empty state ve yönlendirici metinler V1 için kabul edilebilir.

## 18. UI / Dashboard Scope Leak Kontrolü

V1’de sade ürün akışı korunmalıdır.

Aşağıdakiler eklenmemelidir:

- [ ] Büyük dashboard yok.
- [ ] Grafikler yok.
- [ ] Analytics kartları yok.
- [ ] Gelişmiş profil ekranı yok.
- [ ] Tema/language ayarları gelişmiş panel yok.
- [ ] Çoklu görünüm modu yok.
- [ ] Pin/favorite zorunlu değil.
- [ ] Sort sistemi V1’i bozacak kadar büyütülmedi.

V1 minimum ekranları korunmalıdır:

- [ ] AuthGate / Splash
- [ ] Login
- [ ] Register
- [ ] Prompt Kütüphanesi
- [ ] Hızlı Ekle
- [ ] Detaylı Ekle
- [ ] Prompt Detay
- [ ] Prompt Düzenle
- [ ] Değişkenli Kopyala-Doldur
- [ ] Basit Ayarlar / Hesap

## 19. Backend / Infrastructure Scope Leak Kontrolü

V1’de backend sade kalmalıdır.

Aşağıdakiler eklenmemelidir:

- [ ] Custom backend yok.
- [ ] Cloud Functions yok.
- [ ] AI Gateway yok.
- [ ] Payment backend yok.
- [ ] Admin backend yok.
- [ ] Public API yok.
- [ ] Search backend yok.
- [ ] Queue/job system yok.
- [ ] Usage/cost backend yok.
- [ ] Notification backend yok.

V1 backend kapsamı:

- [ ] Firebase Auth
- [ ] Cloud Firestore
- [ ] Firestore security rules

## 20. Yeni Fikir İçin Karar Sonucu

Yeni bir fikir scope kontrolünden sonra şu sonuçlardan birine alınmalıdır:

- [ ] V1’e alınır.
- [ ] V1.5 parking lot’a taşınır.
- [ ] V2 parking lot’a taşınır.
- [ ] V2.5/V3 parking lot’a taşınır.
- [ ] Reddedilir.
- [ ] Development notes’a açık soru olarak yazılır.
- [ ] ADR adayı olarak not edilir.

Hiçbir fikir kontrolsüz şekilde doğrudan koda eklenmemelidir.

## 21. AI Review Sonrası Scope Kontrolü

Dış AI review önerileri için:

- [ ] Öneri V1 scope ile uyumlu mu?
- [ ] Öneri V1’i gereksiz büyütüyor mu?
- [ ] Öneri AI/V2 özelliğini V1’e sokuyor mu?
- [ ] Öneri mimariyi gereksiz karmaşıklaştırıyor mu?
- [ ] Öneri güvenlik veya veri modeli riski doğuruyor mu?
- [ ] Öneri parking lot’a taşınmalı mı?
- [ ] Öneri kabul edilecekse ilgili belge/checklist güncellendi mi?

AI önerisi otomatik karar değildir.

## 22. Milestone Bazlı Scope Kontrolü

- [ ] M0’da ürün feature kodlamasına erken girilmedi.
- [ ] M1’de Auth dışı özellikler büyütülmedi.
- [ ] M2’de PromptCard modeline V1 dışı alanlar eklenmedi.
- [ ] M3’te AI/backend/payment altyapısı eklenmedi.
- [ ] M4’te ilk çekirdek akış dışında detaylara kayılmadı.
- [ ] M5’te Normal Kopyala usage analytics’e dönüşmedi.
- [ ] M6’da arşiv kalıcı delete’e dönüşmedi.
- [ ] M7’de Detaylı Ekle AI öneri sistemine dönüşmedi.
- [ ] M8’de basit arama semantik aramaya dönüşmedi.
- [ ] M9’da değişken sistemi koşullu template engine’e dönüşmedi.
- [ ] M10’da kapanış kontrolü yeni özellik ekleme sprintine dönüşmedi.

## 23. Development Notes Kontrolü

- [ ] Scope dışı yeni fikir varsa `09_development_notes.md` içine yazıldı.
- [ ] Parking lot’a taşınacak fikir varsa not edildi.
- [ ] Reddedilen öneri gerekçesiyle yazıldı.
- [ ] V1’e alınan yeni karar varsa ilgili docs güncellendi.
- [ ] Scope ihlali fark edildiyse düzeltme notu yazıldı.

## 24. Kapanış Kararı

Bu checklist tamamlandı sayılabilmesi için:

- [ ] V1 ana akışı korunuyor.
- [ ] AI özellikleri V1’e sızmadı.
- [ ] Payment/subscription V1’e sızmadı.
- [ ] Team/workspace V1’e sızmadı.
- [ ] Marketplace/public sharing V1’e sızmadı.
- [ ] Semantik arama/embedding V1’e sızmadı.
- [ ] Usage analytics/version history V1’e sızmadı.
- [ ] Kalıcı delete V1’e sızmadı.
- [ ] Değerli ama erken fikirler parking lot’a taşındı.
- [ ] Kapsam dışı öneriler development notes’a işlendi.

## 25. Kapanış Notu

Scope leak checklist, V1’in küçük kalması için değil, doğru büyümesi için vardır. Her güzel fikir bugünün işi değildir. Bazıları V1.5 park yerinde, bazıları V2 garajında, bazıları da V3 hangarında beklemelidir.
