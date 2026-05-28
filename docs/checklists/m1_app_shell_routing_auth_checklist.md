# M1 — Auth / Routing Checklist

## 1. Amaç

Bu checklist, **M1 — App Shell, Routing ve Auth** milestone’unun doğru şekilde tamamlanıp tamamlanmadığını kontrol etmek için kullanılır.

M1’in amacı, Prompt Yönetim Aracı V1 için uygulama kabuğunu, temel routing yapısını ve kullanıcı kayıt/giriş/çıkış akışını kurmaktır.

Bu milestone sonunda kullanıcı:

- Kayıt olabilmeli,
- Giriş yapabilmeli,
- Çıkış yapabilmeli,
- AuthGate üzerinden doğru ekrana yönlendirilebilmelidir.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- M1 geliştirmesi sırasında,
- Login/Register/AuthGate akışı tamamlandığında,
- Firebase Auth bağlantısı kurulduktan sonra,
- M2 — PromptCard Domain Model aşamasına geçmeden önce.

## 3. Bağlı Belgeler

- `00_project_overview.md`
- `01_v1_scope.md`
- `02_architecture.md`
- `04_firebase_firestore_plan.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `07_test_security_plan.md`
- `ADR-002-firebase-auth-firestore-v1.md`
- `ADR-004-feature-first-light-clean-architecture.md`
- `ADR-005-ui-does-not-access-firebase-directly.md`
- `architecture_boundary_checklist.md`
- `security_checklist.md`
- `scope_leak_checklist.md`

## 4. Ön Koşullar

- [ ] M0 — Proje Hazırlığı ve Teknik Zemin tamamlandı.
- [ ] Flutter proje yapısı hazır.
- [ ] Temel `app / core / features` klasör yapısı hazır.
- [ ] `features/auth` yapısı hazır.
- [ ] Firebase hazırlığı yapılmış veya M1 içinde yapılacak şekilde planlandı.
- [ ] V1’de email/password Auth kullanılacağı doğrulandı.

## 5. App Shell Kontrolü

- [ ] Uygulama ana root yapısı oluşturuldu.
- [ ] App başlangıç noktası düzenli.
- [ ] Theme başlangıç yapısı varsa `app/theme` altında konumlandı.
- [ ] Routing başlangıç yapısı varsa `app/routing` altında konumlandı.
- [ ] App root içinde gereksiz iş mantığı birikmedi.
- [ ] App root Firebase data operasyonları yapmıyor.
- [ ] App root yalnızca uygulama kabuğu ve yönlendirme başlangıcı görevini üstleniyor.

## 6. Routing Kontrolü

- [ ] Merkezi routing yapısı kuruldu.
- [ ] Login rotası tanımlandı.
- [ ] Register rotası tanımlandı.
- [ ] AuthGate / Splash rotası tanımlandı.
- [ ] Prompt Kütüphanesi için geçici veya hedef rota hazırlandı.
- [ ] Settings veya hesap rotası gerekiyorsa temel yer ayrıldı.
- [ ] Routing kararları dağınık şekilde ekranların içine yazılmadı.
- [ ] Auth durumuna bağlı kalıcı yönlendirme AuthGate üzerinden yönetiliyor.
- [ ] Giriş yapmamış kullanıcı korumalı ekrana yönlendirilirse Login/Register tarafına alınır.

## 7. AuthGate Kontrolü

AuthGate M1’in en kritik parçasıdır.

- [ ] AuthGate oluşturuldu.
- [ ] AuthGate kullanıcı giriş durumunu izliyor.
- [ ] Giriş yapmamış kullanıcı Login/Register akışına yönlendiriliyor.
- [ ] Giriş yapmış kullanıcı ana kütüphane alanına yönlendiriliyor.
- [ ] AuthGate loading / başlangıç kontrol durumunu yönetiyor.
- [ ] Login ekranı kalıcı yönlendirme kararını tek başına vermiyor.
- [ ] Register ekranı kalıcı yönlendirme kararını tek başına vermiyor.
- [ ] Logout sonrası kullanıcı tekrar AuthGate üzerinden doğru ekrana yönlendiriliyor.
- [ ] AuthGate içinde gereksiz UI veya business logic birikmiyor.

## 8. Login Ekranı Kontrolü

- [ ] Login ekranı oluşturuldu.
- [ ] E-posta alanı var.
- [ ] Şifre alanı var.
- [ ] Login butonu var.
- [ ] Register ekranına geçiş bağlantısı var.
- [ ] Boş e-posta ile giriş denemesi engelleniyor veya hata gösteriliyor.
- [ ] Boş şifre ile giriş denemesi engelleniyor veya hata gösteriliyor.
- [ ] Geçersiz e-posta formatı için uygun hata gösteriliyor.
- [ ] Firebase Auth hataları kullanıcıya anlaşılır mesajla gösteriliyor.
- [ ] Login sırasında loading state gösteriliyor.
- [ ] Başarılı login sonrası yönlendirmeyi AuthGate yönetiyor.
- [ ] Login ekranı doğrudan FirebaseAuth çağırmıyor.

## 9. Register Ekranı Kontrolü

- [ ] Register ekranı oluşturuldu.
- [ ] E-posta alanı var.
- [ ] Şifre alanı var.
- [ ] Şifre doğrulama alanı varsa doğru çalışıyor.
- [ ] Register butonu var.
- [ ] Login ekranına dönüş bağlantısı var.
- [ ] Boş e-posta ile kayıt denemesi engelleniyor veya hata gösteriliyor.
- [ ] Boş şifre ile kayıt denemesi engelleniyor veya hata gösteriliyor.
- [ ] Zayıf şifre için uygun hata gösteriliyor.
- [ ] Şifre eşleşmeme durumu varsa kullanıcıya gösteriliyor.
- [ ] Mevcut e-posta ile kayıt denemesi kullanıcıya anlaşılır gösteriliyor.
- [ ] Register sırasında loading state gösteriliyor.
- [ ] Başarılı kayıt sonrası yönlendirmeyi AuthGate yönetiyor.
- [ ] Register ekranı doğrudan FirebaseAuth çağırmıyor.

## 10. Logout Kontrolü

- [ ] Kullanıcı çıkış yapabiliyor.
- [ ] Logout işlemi auth repository / provider akışı üzerinden yapılıyor.
- [ ] Logout sonrası AuthGate kullanıcıyı giriş akışına yönlendiriyor.
- [ ] Logout sırasında hata olursa kullanıcıya anlaşılır mesaj gösteriliyor.
- [ ] Logout doğrudan screen içinde FirebaseAuth çağrısı ile yapılmıyor.

## 11. Auth Data / Repository Kontrolü

- [ ] Auth işlemleri için repository veya service yapısı kuruldu.
- [ ] Firebase Auth çağrıları data/service katmanında tutuluyor.
- [ ] Presentation katmanı Firebase Auth detaylarını bilmiyor.
- [ ] Auth provider/notifier kullanıcı aksiyonlarını yönetiyor.
- [ ] Auth state provider üzerinden izleniyor.
- [ ] Auth hataları UI’a uygun state veya mesaj olarak taşınıyor.
- [ ] Firebase Auth exception’ları UI’a ham teknik metin olarak sızmıyor.

## 12. Mimari Sınır Kontrolü

- [ ] Screen içinde `FirebaseAuth.instance` kullanılmıyor.
- [ ] Screen içinde Firebase Auth exception handling yapılmıyor.
- [ ] Auth service data katmanında.
- [ ] Auth repository interface/implementation ayrımı korunuyor veya V1 için sade ama yönü doğru bir yapı kullanılıyor.
- [ ] Provider/Notifier UI state yönetiyor.
- [ ] UI sadece provider/notifier üzerinden işlem yapıyor.
- [ ] Auth feature dışına gereksiz bağımlılık taşmadı.
- [ ] `core/` içine auth’a özel kod atılmadı.

## 13. Hata Durumu Kontrolü

- [ ] Yanlış şifre hatası kullanıcıya anlaşılır gösteriliyor.
- [ ] Kullanıcı bulunamadı hatası kullanıcıya anlaşılır gösteriliyor.
- [ ] Geçersiz e-posta hatası kullanıcıya anlaşılır gösteriliyor.
- [ ] Zayıf şifre hatası kullanıcıya anlaşılır gösteriliyor.
- [ ] Network hatası kullanıcıya anlaşılır gösteriliyor.
- [ ] Loading sırasında tekrar tekrar butona basma davranışı kontrol edildi.
- [ ] Başarısız login/register sonrası ekran çökmeden kalıyor.
- [ ] Auth state beklenirken boş/beyaz ekran kalmıyor.

## 14. Cihaz / Platform Kontrolü

M1’de temel cihaz kontrolü yapılmalıdır.

- [ ] Login ekranı Android emülatörde düzgün görünüyor.
- [ ] Login ekranı gerçek Android cihazda mümkünse kontrol edildi.
- [ ] Klavye açılınca login formu taşmıyor.
- [ ] Register ekranı küçük ekranda taşmıyor.
- [ ] Şifre alanları klavye davranışında bozulmuyor.
- [ ] Geri tuşu davranışı kontrol edildi.
- [ ] Loading/error mesajları küçük ekranda okunabilir.
- [ ] Tablet veya web smoke test opsiyonel olarak not edildi.

## 15. Güvenlik Kontrolü

- [ ] Giriş yapmamış kullanıcı korumalı ana alana erişemiyor.
- [ ] Auth olmayan kullanıcı prompt verisi okumaya çalışmıyor.
- [ ] Auth işlemleri Firebase Auth üzerinden yapılıyor.
- [ ] Client tarafında AI API key veya secret yok.
- [ ] Local dosyalara secret yazılmadı.
- [ ] Auth hata mesajlarında hassas teknik bilgi gösterilmiyor.
- [ ] Email/password dışı auth yöntemi V1’e plansız eklenmedi.

## 16. Test Kontrolü

- [ ] Login manuel test edildi.
- [ ] Register manuel test edildi.
- [ ] Logout manuel test edildi.
- [ ] AuthGate manuel test edildi.
- [ ] Yanlış şifre senaryosu denendi.
- [ ] Boş form senaryosu denendi.
- [ ] Giriş yapmış kullanıcı uygulama açınca doğru yere gidiyor.
- [ ] Giriş yapmamış kullanıcı uygulama açınca doğru yere gidiyor.
- [ ] Önemli test notları `09_development_notes.md` içine yazıldı.

## 17. V1 Scope Leak Kontrolü

M1’de aşağıdakiler eklenmemiş olmalı:

- [ ] Sosyal giriş zorunlu hale getirilmedi.
- [ ] Takım / workspace auth yapısı eklenmedi.
- [ ] Role-based access control eklenmedi.
- [ ] Admin panel eklenmedi.
- [ ] Payment / subscription eklenmedi.
- [ ] AI quota ekranı eklenmedi.
- [ ] AI Gateway veya AI API entegrasyonu eklenmedi.
- [ ] Prompt feature kodlamasına erken ve dağınık şekilde başlanmadı.

## 18. AI Review Hatırlatma

M1 sonunda dış AI review almak istenirse şu promptlar kullanılabilir:

- `architecture_review_prompt.md`
- `milestone_review_prompt.md`
- Gerekirse `flutter_code_review_prompt.md`

Kontrol maddeleri:

- [ ] M1 sonunda dış AI review gerekip gerekmediği değerlendirildi.
- [ ] Review alınırsa sonuçlar otomatik karar sayılmadı.
- [ ] Kabul/ret/parking lot ayrımı yapıldı.
- [ ] Gerekli notlar `09_development_notes.md` içine yazıldı.

## 19. Development Notes Kontrolü

- [ ] M1 sırasında çıkan önemli AuthGate notları yazıldı.
- [ ] Auth hataları veya cihaz test sorunları yazıldı.
- [ ] Checklist’e taşınacak yeni madde varsa not edildi.
- [ ] ADR’ye dönüşmesi gereken yeni karar adayı varsa not edildi.
- [ ] M1 kapanış notu eklendi veya eklenecek.

## 20. M1 Kapanış Kararı

M1 tamamlandı sayılabilmesi için:

- [ ] App shell çalışıyor.
- [ ] Routing temel yapısı çalışıyor.
- [ ] Login çalışıyor.
- [ ] Register çalışıyor.
- [ ] Logout çalışıyor.
- [ ] AuthGate merkezi yönlendirme yapıyor.
- [ ] Giriş yapmamış kullanıcı korumalı alana erişemiyor.
- [ ] UI doğrudan Firebase Auth çağırmıyor.
- [ ] Hata/loading durumları temel düzeyde yönetiliyor.
- [ ] M2 — PromptCard Domain Model aşamasına geçilebilir.

## 21. Kapanış Notu

M1’in ana başarı ölçütü, kullanıcının güvenli ve düzenli bir Auth akışından geçebilmesi ve uygulama yönlendirmesinin AuthGate üzerinden merkezi biçimde yönetilmesidir. Login/Register ekranları kapı zili olabilir; kapıyı kimin açacağına AuthGate karar verir.
