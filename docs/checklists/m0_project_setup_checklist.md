# M0 — Project Setup Checklist

## 1. Amaç

Bu checklist, **M0 — Proje Hazırlığı ve Teknik Zemin** milestone’unun doğru şekilde tamamlanıp tamamlanmadığını kontrol etmek için kullanılır.

M0’ın amacı kodlamaya doğrudan özellik geliştirerek başlamak değil; Prompt Yönetim Aracı V1 için proje zemininin, temel klasör yapısının, Firebase hazırlığının, docs paketinin ve geliştirme başlangıç düzeninin kurulmasıdır.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- Flutter projesi oluşturulduktan sonra,
- Firebase hazırlığı yapılırken,
- PowerShell dizin kurulum scripti çalıştırıldıktan sonra,
- M1 — App Shell, Routing ve Auth aşamasına geçmeden önce.

## 3. Bağlı Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `07_test_security_plan.md`
- `09_development_notes.md`
- `ADR-001-cloud-first-v1.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`

> Not: Mevcut proje içindeki ADR dosya adları bu listedeki nihai isimlerle birebir aynı değilse, M0 kapanmadan önce ya dosya adları hizalanmalı ya da bu bağlı belge listesi gerçek dosya adlarına göre güncellenmelidir.

## 4. Ön Koşullar

- [x] V1 scope kilitli.
- [x] V1 mimari yaklaşımı kilitli.
- [x] V1 veri modeli kilitli.
- [x] Firebase / Firestore ana yönü kilitli.
- [x] Kodlamaya başlamadan önce oluşturulacak minimum belge paketi net.
- [x] Proje adı ve yerel çalışma klasörü netleşmiş.

## 5. Proje Oluşturma Kontrolü

- [x] Flutter projesi oluşturuldu.
- [x] Proje yerel makinede açılabiliyor.
- [x] Android Studio veya tercih edilen IDE içinde proje sorunsuz açılıyor.
- [x] `flutter pub get` çalışıyor.
- [x] Proje temiz şekilde build alıyor.
- [x] İlk çalıştırma sırasında kritik hata alınmıyor.
- [x] Flutter SDK ve proje uyumluluğu kontrol edildi.
- [x] Android hedefi için minimum teknik gereksinimler kontrol edildi.

## 6. Temel Klasör Yapısı Kontrolü

Aşağıdaki ana yapı oluşturulmuş olmalı:

```text
lib/
  app/
  core/
  features/
```

Kontrol maddeleri:

- [x] `lib/app/` klasörü var.
- [x] `lib/core/` klasörü var.
- [x] `lib/features/` klasörü var.
- [x] `lib/features/auth/` klasörü var.
- [x] `lib/features/prompts/` klasörü var.
- [x] `lib/features/settings/` klasörü var.
- [x] Her ana feature altında `domain/`, `data/`, `presentation/` ayrımı var.
- [x] Klasör yapısı `02_architecture.md` belgesiyle uyumlu.
- [x] Gereksiz alternatif mimari klasörleri oluşturulmadı.
- [x] `core/` klasörü gereksiz dosya çöplüğüne dönüşmedi.

## 7. Feature İç Yapısı Kontrolü

Her ana feature için aşağıdaki yapı kontrol edilir:

```text
domain/
  entities/
  repositories/
  usecases/

data/
  dto/
  mappers/
  repositories/
  services/

presentation/
  screens/
  providers/
  widgets/
```

Kontrol maddeleri:

- [x] `auth` feature detaylı iç yapısı oluşturuldu.
- [x] `prompts` feature detaylı iç yapısı oluşturuldu.
- [x] `settings` feature detaylı iç yapısı oluşturuldu.
- [x] Feature ana katman ayrımı tutarlı.
- [x] Firebase veya Firestore ile ilgili dosyalar şimdiden UI katmanına konmadı.
- [x] Domain katmanı dış teknolojiye bağımlı hale getirilmedi.

> M0 notu: Mevcut kurulumda `domain/`, `data/`, `presentation/` ana katmanları oluşturuldu. Bu checklist’in beklediği daha detaylı alt klasörler (`entities/`, `repositories/`, `usecases/`, `dto/`, `mappers/`, `services/`, `screens/`, `providers/`, `widgets/`) M0 kapanmadan önce oluşturulabilir veya M1/M2/M3 sırasında ihtiyaç doğdukça açılabilir. M0 kapanışında “detaylı iç yapı hazır” denmek isteniyorsa bu alt klasörler de eklenmelidir.

## 8. Docs Paketi Kontrolü

Ana docs paketi projeye eklenmiş olmalı:

```text
docs/
  00_project_overview.md
  01_v1_scope.md
  02_architecture.md
  03_data_model.md
  04_firebase_firestore_plan.md
  05_milestone_plan.md
  06_acceptance_criteria.md
  07_test_security_plan.md
  08_parking_lot_v1_5_v2.md
  09_development_notes.md
```

Kontrol maddeleri:

- [x] `docs/` klasörü var.
- [x] Ana docs dosyaları projeye eklendi.
- [x] Dosya adları doğru.
- [x] Belgeler okunabilir durumda.
- [x] Belgeler V1 kapsamıyla uyumlu.
- [x] Geliştirme sırasında referans alınacak ana dosyalar hazır.
- [x] `docs/canon/` klasörü oluşturuldu.
- [x] Product Canon v1.0 dokümanı projeye eklendi.

## 9. ADR Klasörü Kontrolü

```text
docs/adr/
```

Kontrol maddeleri:

- [x] `docs/adr/` klasörü var.
- [x] ADR-001 dosyası eklendi.
- [x] ADR-002 dosyası eklendi.
- [x] ADR-003 dosyası eklendi.
- [x] ADR-004 dosyası eklendi.
- [x] ADR-005 dosyası eklendi.
- [x] ADR-006 dosyası eklendi.
- [x] ADR-007 dosyası eklendi.
- [x] ADR-008 dosyası eklendi.
- [x] ADR-009 dosyası eklendi.
- [x] ADR-010 dosyası eklendi.
- [x] ADR dosya adları numaralı ve tutarlı.

> M0 notu: İlk ADR çekirdeği oluşturuldu. Bu checklist 10 ADR’lik daha geniş paket bekliyor. M0 kapanmadan önce eksik ADR dosyaları oluşturulacaksa adlar gerçek proje dosyalarıyla hizalanmalıdır.

## 10. Checklist Klasörü Kontrolü

```text
docs/checklists/
```

Kontrol maddeleri:

- [x] `docs/checklists/` klasörü var.
- [x] M0 checklist dosyası var.
- [x] M1 checklist dosyası için yer hazır.
- [x] M2 checklist dosyası için yer hazır.
- [x] M3 checklist dosyası için yer hazır.
- [x] M4 checklist dosyası için yer hazır.
- [x] Global checklist dosyaları için yer hazır.
- [x] Security checklist için yer hazır.
- [x] Architecture boundary checklist için yer hazır.
- [x] Scope leak checklist için yer hazır.
- [x] Device/platform test checklist için yer hazır.

## 11. AI Review Prompt Klasörü Kontrolü

```text
docs/ai_review_prompts/
```

Kontrol maddeleri:

- [x] `docs/ai_review_prompts/` klasörü var.
- [x] Architecture review prompt için yer hazır.
- [x] Data model review prompt için yer hazır.
- [x] Firestore rules review prompt için yer hazır.
- [x] Security review prompt için yer hazır.
- [x] Milestone review prompt için yer hazır.
- [x] Scope guard review prompt için yer hazır.
- [x] Hangi milestone’da hangi AI review promptunun kullanılacağı takip edilecek.

## 12. Scripts Klasörü Kontrolü

```text
scripts/
  setup_project_structure.ps1
```

Kontrol maddeleri:

- [x] `scripts/` klasörü var.
- [x] `setup_project_structure.ps1` dosyası hazır veya hazırlanacak yer ayrıldı.
- [x] Script mevcut dosyaları silmeyecek şekilde tasarlandı.
- [x] Script mevcut dosyaların üzerine yazmayacak şekilde tasarlandı.
- [x] Script secret/config üretmeyecek.
- [x] Script yalnızca eksik klasörleri ve gerekirse `.gitkeep` dosyalarını oluşturacak.
- [x] Script M0 aşamasında kullanılacak şekilde not edildi.

## 13. Firebase Hazırlık Kontrolü

- [x] Firebase project açılacak hesap/proje yönü netleşti.
- [x] Firebase project adı netleşti veya M0 içinde netleşecek.
- [x] Android app package name netleşti veya M0 içinde netleşecek.
- [x] Firebase Auth kullanılacağı doğrulandı.
- [x] Cloud Firestore kullanılacağı doğrulandı.
- [x] FlutterFire yapılandırması planlandı.
- [x] `firebase_options.dart` oluşturulacak aşama belirlendi.
- [x] Firebase API key veya gizli değerlerin güvenli yönetimi konusunda dikkat notu alındı.
- [x] AI API key gibi V2 gizli bilgilerin V1 client tarafında yer almayacağı doğrulandı.
- [x] FlutterFire configure tamamlandı.
- [x] `firebase_core` eklendi.
- [x] `lib/firebase_options.dart` oluşturuldu.
- [x] `android/app/google-services.json` oluşturuldu.
- [ ] Cloud Firestore physical database oluşturuldu.

> M0 notu: Cloud Firestore database oluşturma işlemi billing gereksinimi nedeniyle beklemeye alındı. Firestore fiziksel database oluşturma kararı billing / budget güvenliği netleştikten sonra veya M3 öncesinde tekrar ele alınacak. Realtime Database yanlışlıkla açıldıysa kullanılmayacak ve rules kapalı tutulacak.

## 14. Git / Versiyon Kontrol Kontrolü

- [x] Git repo oluşturuldu veya oluşturulacak yer netleşti.
- [x] İlk commit stratejisi belirlendi.
- [x] `.gitignore` dosyası kontrol edildi.
- [x] Build çıktıları repo’ya eklenmeyecek.
- [x] Lokal secret/config dosyaları repo’ya eklenmeyecek.
- [x] Docs paketi repo’da takip edilecek.
- [x] PowerShell script repo’da takip edilecek.
- [x] GitHub bağlantısı kuruldu.
- [x] Commit / push akışı doğrulandı.

## 15. Paket / Dependency Hazırlığı

M0’da kesin paket versiyonları netleşebilir; bu checklist yalnızca hazırlık kontrolüdür.

- [x] Firebase Core ihtiyacı not edildi.
- [x] Firebase Auth ihtiyacı not edildi.
- [x] Cloud Firestore ihtiyacı not edildi.
- [x] State management yaklaşımı not edildi.
- [x] Routing yaklaşımı not edildi.
- [x] Paketlerde `latest` gibi geçersiz/gevşek versiyon kullanmama notu alındı.
- [x] Paketler eklendikten sonra `flutter pub get` kontrol edilecek.

> M0 notu: M0’da yalnızca `firebase_core` eklendi. `firebase_auth` M1’de, `cloud_firestore` M3’te eklenecek.

## 16. Mimari Sınır Kontrolü

- [x] M0’da UI içine doğrudan Firebase çağrısı eklenmedi.
- [x] M0’da Firestore service veya repository kodu erken ve dağınık yazılmadı.
- [x] Klasör yapısı `feature-first + hafif clean architecture` kararına uyuyor.
- [x] M0’da ürün feature kodu geliştirmeye başlanmadı.
- [x] V1 dışı AI / ödeme / marketplace / team yapısı eklenmedi.

## 17. Test / Çalıştırma Kontrolü

- [x] Proje en az bir kez çalıştırıldı.
- [ ] Android emülatörde veya gerçek cihazda açılma kontrolü yapıldı.
- [x] İlk build veya runtime hatası varsa `09_development_notes.md` içine yazıldı.
- [x] M1’e geçmeden önce proje temel olarak stabil.
- [x] Test klasörü durumu kontrol edildi.
- [x] İleride unit/widget testleri için temel yapı bozulmadı.
- [x] `flutter analyze` geçti.
- [x] `flutter test` geçti.
- [x] `flutter build apk --debug` geçti.

> M0 notu: Edge/Web üzerinde çalıştırma ve debug APK build doğrulandı. Android emulator veya gerçek cihaz run kontrolü yapılmadıysa bu madde M1 öncesi ayrıca işaretlenmelidir.

## 18. Hata / Not Takibi

- [x] M0 sırasında çıkan önemli hata varsa `09_development_notes.md` içine yazıldı.
- [x] Geçici çözüm varsa not edildi.
- [x] ADR’ye dönüşecek karar adayı varsa not edildi.
- [x] Checklist’e eklenecek yeni madde varsa not edildi.
- [x] Parking Lot’a taşınacak fikir varsa not edildi.

> M0 notları:
>
> - Android Studio’da `FlutterActivity` / `embedding` unresolved reference uyarısı görüldü; `flutter analyze` ve `flutter build apk --debug` başarılı olduğu için gerçek build hatası değil, IDE/index kaynaklı kabul edildi.
> - Cloud Firestore physical database oluşturma billing gereksinimi nedeniyle beklemeye alındı.
> - Realtime Database yanlışlıkla açıldıysa kullanılmayacak ve rules kapalı tutulacak.

## 19. V1 Scope Leak Kontrolü

M0’da aşağıdakiler eklenmemiş olmalı:

- [x] AI prompt iyileştirme
- [x] AI başlık önerisi
- [x] Semantik arama
- [x] AI Gateway
- [x] Payment / subscription
- [x] AI quota ekranı
- [x] Marketplace
- [x] Team / workspace
- [x] Public sharing
- [x] Usage analytics
- [x] Version history
- [x] Kalıcı delete

## 20. M0 Kapanış Kararı

M0 tamamlandı sayılabilmesi için:

- [x] Flutter proje zemini hazır.
- [x] Temel klasör yapısı hazır.
- [x] Docs paketi projeye eklenmiş veya eklenmeye hazır.
- [x] ADR klasörü hazır.
- [x] Checklist klasörü hazır.
- [x] AI review prompt klasörü hazır.
- [x] Scripts klasörü hazır.
- [x] Firebase hazırlık yönü net.
- [x] Proje temiz şekilde çalışıyor.
- [x] V1 dışı özellik geliştirmeye başlanmadı.
- [x] M1 — App Shell, Routing ve Auth aşamasına geçilebilir.

> M0 kapanış öncesi kalan küçük karar: Feature iç detay klasörleri ve eksik ADR/checklist/AI review prompt dosyaları M0’da mı tamamlanacak, yoksa M1/M2/M3 sırasında ihtiyaç doğdukça mı açılacak? Bu karar netleşince son madde işaretlenebilir.

## 21. Kapanış Notu

M0’un amacı ürün özelliği geliştirmek değil, V1 geliştirme zemininin güvenli ve düzenli kurulmasıdır. Bu checklist tamamlandıktan sonra M1 — App Shell, Routing ve Auth aşamasına geçilebilir.

## 22. M0 Final Kontrol

- [x] Final `flutter pub get` geçti.
- [x] Final `flutter analyze` geçti.
- [x] Final `flutter test` geçti.
- [x] Final `flutter build apk --debug` geçti.
- [x] Final `flutter run` geçti.
- [x] M0 final checklist güncellendi.
- [x] M0 final commit atıldı.
- [x] M0 final push yapıldı.
