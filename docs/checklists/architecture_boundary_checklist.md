# G02 — Architecture Boundary Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1’de mimari sınırların korunup korunmadığını kontrol etmek için kullanılır.

Ana mimari ilke:

```text
Screen → Provider/Notifier → Repository → Service → Firebase
```

Bu checklist’in amacı, UI katmanının Firebase’e doğrudan erişmesini, Firestore DTO’larının presentation katmanına sızmasını, domain modelin Firebase tiplerine bağımlı hale gelmesini ve `core/` klasörünün kontrolsüz büyümesini engellemektir.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- Her milestone sonunda,
- Özellikle M1, M3, M4, M6 ve M10 kapanışlarında,
- Yeni feature veya data layer eklenirken,
- Dış AI architecture review öncesi veya sonrası,
- Kod review sırasında.

## 3. Bağlı Belgeler

- `02_architecture.md`
- `03_data_model.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `07_test_security_plan.md`
- `ADR-003-canonical-promptcard-model.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `g01_security_checklist.md`
- `g03_scope_leak_checklist.md`

## 4. Ana Mimari Kararlar

- [ ] V1, feature-first + hafif clean architecture ile ilerliyor.
- [ ] Ana yapı `app / core / features` şeklinde korunuyor.
- [ ] Ana feature’lar `auth`, `prompts`, `settings` olarak ayrılmış.
- [ ] Her feature içinde `domain / data / presentation` ayrımı korunuyor.
- [ ] UI Firebase Auth veya Firestore’a doğrudan erişmiyor.
- [ ] Domain modeli Firestore’a bağımlı değil.
- [ ] Data layer Firestore detaylarını izole ediyor.
- [ ] Repository / Service / DTO / Mapper ayrımı korunuyor.

## 5. Ana Klasör Yapısı Kontrolü

Beklenen yapı:

```text
lib/
  app/
  core/
  features/
    auth/
    prompts/
    settings/
```

Kontrol maddeleri:

- [ ] `lib/app/` yalnızca uygulama kabuğu, routing, theme ve app-level yapı içeriyor.
- [ ] `lib/core/` yalnızca gerçekten ortak ve feature bağımsız kod içeriyor.
- [ ] `lib/features/` altında feature bazlı yapı korunuyor.
- [ ] `auth` feature kendi klasörü altında.
- [ ] `prompts` feature kendi klasörü altında.
- [ ] `settings` feature kendi klasörü altında.
- [ ] Feature’a özel kod yanlışlıkla `core/` içine atılmadı.
- [ ] Tüm ekranlar tek bir `screens/` klasöründe dağınık tutulmuyor.
- [ ] Data ve domain dosyaları feature dışına plansız taşınmadı.

## 6. Feature İç Yapısı Kontrolü

Her feature için beklenen yapı:

```text
domain/
data/
presentation/
```

Kontrol maddeleri:

- [ ] `domain/` katmanı var.
- [ ] `data/` katmanı var.
- [ ] `presentation/` katmanı var.
- [ ] Domain katmanı entity/model ve repository interface gibi bağımsız yapıları taşıyor.
- [ ] Data katmanı DTO, mapper, repository implementation ve service yapılarını taşıyor.
- [ ] Presentation katmanı screen, widget, provider/notifier ve UI state yapılarını taşıyor.
- [ ] Feature içi katmanlar birbirine rastgele bağımlı hale gelmedi.
- [ ] Presentation doğrudan data service çağırmıyor.
- [ ] Domain, presentation katmanını bilmiyor.

## 7. UI / Firebase Sınırı Kontrolü

Screen ve widget dosyalarında aşağıdakiler olmamalıdır:

```text
FirebaseAuth.instance
FirebaseFirestore.instance
```

Kontrol maddeleri:

- [ ] Screen içinde `FirebaseAuth.instance` yok.
- [ ] Screen içinde `FirebaseFirestore.instance` yok.
- [ ] Widget içinde doğrudan Firebase çağrısı yok.
- [ ] UI içinde Firestore collection path yok.
- [ ] UI içinde Firestore query logic yok.
- [ ] UI içinde Firebase exception parsing yok.
- [ ] UI yalnızca provider/notifier üzerinden işlem başlatıyor.
- [ ] UI loading/error/success state gösteriyor.
- [ ] UI teknik servis detaylarını bilmiyor.

## 8. Provider / Notifier Sınırı Kontrolü

- [ ] Provider/Notifier UI state yönetiyor.
- [ ] Provider/Notifier kullanıcı aksiyonlarını repository’ye iletiyor.
- [ ] Provider/Notifier doğrudan Firestore query yazmıyor.
- [ ] Provider/Notifier içinde ağır business logic birikmedi.
- [ ] Provider/Notifier içinde DTO dönüşümü yapılmıyor.
- [ ] Provider/Notifier domain model ile çalışıyor.
- [ ] Provider/Notifier hata durumlarını UI state’e çeviriyor.
- [ ] Provider/Notifier gereksiz şekilde büyürse parçalama notu development notes’a yazıldı.

## 9. Repository Sınırı Kontrolü

- [ ] Repository interface domain tarafında veya domain’e uygun yerde tutuluyor.
- [ ] Repository implementation data katmanında.
- [ ] Repository UI’a Firestore document/snapshot döndürmüyor.
- [ ] Repository domain model döndürüyor.
- [ ] Repository service üzerinden Firebase’e erişiyor.
- [ ] Repository DTO/Mapper dönüşümünü doğru kullanıyor.
- [ ] Repository delete yerine V1’de archive davranışını kullanıyor.
- [ ] Repository, UI state veya BuildContext bilmiyor.

## 10. Service Sınırı Kontrolü

- [ ] Service data katmanında.
- [ ] Service Firebase ile konuşan katman.
- [ ] Service Firestore path ve query logic’i içeriyor.
- [ ] Service UI state bilmiyor.
- [ ] Service domain business logic ile şişirilmedi.
- [ ] Service DTO veya raw data ile çalışıyor.
- [ ] Service hata durumlarını repository’nin ele alabileceği şekilde iletiyor.
- [ ] Service doğrudan screen/widget tarafından çağrılmıyor.

## 11. DTO / Mapper Sınırı Kontrolü

- [ ] DTO data katmanında.
- [ ] Mapper data katmanında.
- [ ] DTO presentation katmanında kullanılmıyor.
- [ ] DTO domain model yerine geçmiyor.
- [ ] Mapper DTO → Domain dönüşümü yapıyor.
- [ ] Mapper Domain → DTO dönüşümü yapıyor.
- [ ] Firestore Timestamp / date dönüşümü mapper içinde yönetiliyor.
- [ ] Eksik alan fallback davranışı mapper içinde yönetiliyor.
- [ ] UI DTO alanlarına doğrudan bağlı değil.

## 12. Domain Model Sınırı Kontrolü

- [ ] Domain model Firebase tiplerine bağımlı değil.
- [ ] Domain model Firestore Timestamp kullanmıyor.
- [ ] Domain model Firestore DocumentSnapshot bilmiyor.
- [ ] Domain model UI widget veya BuildContext bilmiyor.
- [ ] Domain model DTO değildir.
- [ ] Domain model canonical PromptCard kararına uygun.
- [ ] Domain modelde V1 dışı AI/analytics/team alanları yok.
- [ ] Domain logic test edilebilir durumda.

## 13. Auth Feature Mimari Kontrolü

- [ ] Auth ekranları doğrudan FirebaseAuth çağırmıyor.
- [ ] Auth işlemleri repository/service üzerinden ilerliyor.
- [ ] AuthGate merkezi yönlendirme noktası olarak çalışıyor.
- [ ] Login/Register ekranları kalıcı rota kararını tek başına vermiyor.
- [ ] Logout işlemi UI’dan doğrudan FirebaseAuth çağrısı ile yapılmıyor.
- [ ] Auth hata yönetimi provider/notifier üzerinden UI’a taşınıyor.
- [ ] Auth feature kodu prompts feature ile gereksiz bağımlılık kurmuyor.

## 14. Prompts Feature Mimari Kontrolü

- [ ] Prompt ekleme repository/service üzerinden yapılıyor.
- [ ] Prompt listeleme repository/service üzerinden yapılıyor.
- [ ] Prompt detay domain model ile çalışıyor.
- [ ] Prompt düzenleme doğrudan Firestore çağırmıyor.
- [ ] Arşivleme delete değil status update olarak repository’de yönetiliyor.
- [ ] Variable extraction domain/helper düzeyinde.
- [ ] PromptCard domain modeli data DTO’sundan ayrı.
- [ ] Prompts feature, settings feature’a gereksiz bağımlı değil.

## 15. Settings Feature Mimari Kontrolü

- [ ] Settings feature V1’de sade tutuluyor.
- [ ] Çıkış yap gibi hesap aksiyonları auth akışıyla uyumlu.
- [ ] Settings içinde payment/AI quota gibi V1 dışı ekranlar yok.
- [ ] Settings feature core veya auth kodunu kontrolsüz büyütmüyor.
- [ ] Settings feature ileride genişleyebilecek ama V1’de şişmemiş durumda.

## 16. Core Klasörü Kontrolü

`core/` yalnızca gerçekten ortak yapılar için kullanılmalıdır.

- [ ] `core/` içine feature’a özel kod atılmadı.
- [ ] `core/` içine prompt-specific widget atılmadı.
- [ ] `core/` içine auth-specific service atılmadı.
- [ ] `core/` içinde ortak validation/helper yapıları mantıklı.
- [ ] `core/` içinde ortak error/failure yapıları mantıklı.
- [ ] `core/` içinde ortak widgets varsa gerçekten genel kullanıma uygun.
- [ ] `core/` klasörü “nereye koyacağımı bilemedim” çekmecesine dönüşmedi.
- [ ] Core’a taşınan her şeyin en az iki feature’da kullanılma potansiyeli var veya gerçekten app-level ortak.

## 17. App Klasörü Kontrolü

- [ ] Routing `app/` altında veya mimariye uygun merkezi yerde.
- [ ] Theme `app/` altında veya mimariye uygun merkezi yerde.
- [ ] App root sade.
- [ ] App root içinde feature business logic yok.
- [ ] App root içinde Firestore query yok.
- [ ] App root içinde AI/payment/team gibi V1 dışı yapı yok.
- [ ] AuthGate app/routing ile uyumlu konumda.

## 18. Hata Yönetimi Mimari Kontrolü

- [ ] Firebase exception doğrudan UI’a sızmıyor.
- [ ] Data katmanı teknik hataları yakalıyor veya dönüştürüyor.
- [ ] Repository domain’e uygun hata/state dönüşümü sağlıyor.
- [ ] Provider/Notifier hata durumunu UI state’e çeviriyor.
- [ ] Screen kullanıcıya okunabilir mesaj gösteriyor.
- [ ] Hata yönetimi her ekranda kopyala-yapıştır dağınık değil.
- [ ] Kritik hata davranışları `07_test_security_plan.md` ile uyumlu.

## 19. Test Edilebilirlik Kontrolü

- [ ] Domain model bağımsız test edilebilir.
- [ ] Variable extraction bağımsız test edilebilir.
- [ ] Mapper bağımsız test edilebilir.
- [ ] Repository mock service ile test edilebilir.
- [ ] Provider/Notifier test edilebilir.
- [ ] UI doğrudan Firebase’e bağlı olmadığı için widget testleri mümkün.
- [ ] Firestore rules testleri ayrı güvenlik planına bağlı.
- [ ] Test edilebilirliği bozan doğrudan statik bağımlılıklar azaltıldı.

## 20. Scope Leak Mimari Kontrolü

Mimariye aşağıdaki V1 dışı katmanlar sızmamış olmalıdır:

- [ ] AI Gateway
- [ ] AI provider client
- [ ] Model routing
- [ ] Token usage backend
- [ ] Payment/subscription layer
- [ ] Marketplace module
- [ ] Team/workspace permission system
- [ ] Public sharing system
- [ ] Analytics/usage tracking module
- [ ] Version history module
- [ ] Semantic search/embedding layer
- [ ] Permanent delete/trash system

## 21. AI Review Hatırlatma

Architecture boundary kontrolü için önerilen promptlar:

- `architecture_review_prompt.md`
- `flutter_code_review_prompt.md`
- `scope_guard_review_prompt.md`

Kontrol maddeleri:

- [ ] Büyük mimari değişiklik sonrası architecture review değerlendirildi.
- [ ] M3/M4 sonrası architecture review değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] Canon ve ADR kararlarıyla çelişen öneriler reddedildi veya tartışmaya açıldı.
- [ ] Gerekli notlar `09_development_notes.md` içine yazıldı.

## 22. Development Notes Kontrolü

- [ ] Mimari sınır ihlali varsa `09_development_notes.md` içine yazıldı.
- [ ] Core klasörüyle ilgili şüpheli durum varsa not edildi.
- [ ] Provider/Notifier fazla büyüdüyse not edildi.
- [ ] Yeni ADR adayı varsa not edildi.
- [ ] Checklist’e eklenmesi gereken yeni mimari madde varsa not edildi.

## 23. Kapanış Kararı

Bu checklist tamamlandı sayılabilmesi için:

- [ ] UI Firebase’e doğrudan erişmiyor.
- [ ] Domain modeli Firebase’den bağımsız.
- [ ] DTO presentation’a sızmadı.
- [ ] Repository / Service ayrımı korunuyor.
- [ ] Feature-first yapı korunuyor.
- [ ] `core/` kontrolsüz büyümüyor.
- [ ] V1 dışı teknik katmanlar mimariye sızmadı.
- [ ] Mimari ihlaller development notes’a yazıldı veya düzeltildi.

## 24. Kapanış Notu

Mimari sınır checklist’i, kodun sadece bugün çalışmasını değil, yarın da anlaşılır kalmasını sağlar. UI sahne önüdür; Firebase mutfaktır. Garsonun mutfağa koşup tencere karıştırdığı bir restoran istemiyoruz.
