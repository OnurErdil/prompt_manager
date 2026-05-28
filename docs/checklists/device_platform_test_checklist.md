# G06 — Device / Platform Test Checklist

## 1. Amaç

Bu checklist, Prompt Yönetim Aracı V1’in farklı cihaz ve ekran koşullarında temel kullanıcı akışlarını sorunsuz çalıştırıp çalıştırmadığını kontrol etmek için kullanılır.

V1’in ana cihaz odağı:

```text
Android mobil
```

Bu checklist özellikle şu riskleri yakalamak için kullanılır:

- Küçük ekranda overflow,
- Klavye açılınca formun bozulması,
- Uzun prompt metninin okunamaması,
- Kopyalama davranışının gerçek cihazda çalışmaması,
- Geri tuşu / navigation sorunları,
- Değişkenli formda çok sayıda input ile ekranın taşması,
- Emülatörde çalışan akışın gerçek cihazda bozulması.

## 2. Ne Zaman Kullanılır?

Bu checklist şu zamanlarda kullanılır:

- M1 sonunda Login/Register ekranları için,
- M4 sonunda Hızlı Ekle ve Kütüphane için,
- M5 sonunda Prompt Detay ve Normal Kopyala için,
- M7 sonunda Detaylı Ekle formu için,
- M8 sonunda Arama/Filtreleme için,
- M9 sonunda Değişkenli Kopyala-Doldur için,
- M10 final V1 kapanışında.

## 3. Bağlı Belgeler

- `07_test_security_plan.md`
- `06_acceptance_criteria.md`
- `05_milestone_plan.md`
- `01_v1_scope.md`
- `g01_security_checklist.md`
- `g02_architecture_boundary_checklist.md`
- `g03_scope_leak_checklist.md`

## 4. Test Kapsam Kararı

V1 ana kabul odağı:

- [ ] Android mobil emülatör.
- [ ] En az bir gerçek Android cihaz, mümkünse.
- [ ] Küçük / orta / büyük ekran davranışı.
- [ ] Klavye ve form davranışları.
- [ ] Uzun metin ve scroll davranışı.
- [ ] Clipboard / kopyalama davranışı.
- [ ] Geri tuşu ve navigation davranışı.

V1 için opsiyonel smoke test:

- [ ] Tablet / geniş ekran.
- [ ] Web.
- [ ] Desktop.

Bu opsiyonel testler V1’in ana kabul şartı değildir; ancak uygulama tamamen kırılmamalıdır.

## 5. Test Ortamı Kontrolü

- [ ] Android emülatör hazır.
- [ ] En az bir gerçek Android cihaz test için hazır veya planlandı.
- [ ] Test cihazında internet bağlantısı var.
- [ ] Test cihazında Google/Firebase bağlantısı çalışıyor.
- [ ] Uygulama debug build olarak cihaza kurulabiliyor.
- [ ] Uygulama ilk açılışta çökmeden çalışıyor.
- [ ] Test kullanıcı hesabı hazır.
- [ ] İkinci test kullanıcı hesabı kullanıcı izolasyonu için hazır.
- [ ] Test sonuçları `09_development_notes.md` içine yazılacak şekilde planlandı.

## 6. Ekran Boyutu Kontrolü

Test edilmesi önerilen ekran türleri:

| Ekran tipi | Amaç |
|---|---|
| Küçük Android telefon | Overflow ve form sıkışması |
| Orta boy Android telefon | Ana kullanım senaryosu |
| Büyük ekran telefon | Liste/detay yerleşimi |
| Tablet / geniş ekran | Opsiyonel smoke test |
| Web | Opsiyonel smoke test |

Kontrol maddeleri:

- [ ] Küçük ekranda ana ekranlar taşmıyor.
- [ ] Orta boy ekranda ana akış rahat kullanılabiliyor.
- [ ] Büyük ekranda içerik aşırı dağılmıyor.
- [ ] Tablet/gelişmiş ekran test edildiyse kritik kırılma yok.
- [ ] Ekran döndürme davranışı V1 için desteklenmiyorsa sorun olarak değil, not olarak işaretlendi.
- [ ] Responsive davranış V1 kapsamını aşacak kadar büyütülmedi.

## 7. Klavye Davranışı Kontrolü

- [ ] Login ekranında klavye açılınca e-posta/şifre alanları görünür kalıyor.
- [ ] Register ekranında klavye açılınca form kullanılabilir kalıyor.
- [ ] Hızlı Ekle ekranında klavye açılınca prompt metni alanı kullanılabilir kalıyor.
- [ ] Hızlı Ekle ekranında kaydet butonu klavye altında kaybolmuyor veya scroll ile ulaşılabiliyor.
- [ ] Detaylı Ekle ekranında klavye formu bozmayacak şekilde çalışıyor.
- [ ] Değişkenli Kopyala-Doldur ekranında çoklu input alanları klavye ile kullanılabiliyor.
- [ ] Text input alanlarında focus davranışı tutarlı.
- [ ] Form submit / next aksiyonları kullanıcıyı sıkıştırmıyor.
- [ ] Klavye kapandığında ekran doğru konuma dönüyor.

## 8. Overflow Kontrolü

- [ ] Login ekranında overflow yok.
- [ ] Register ekranında overflow yok.
- [ ] Kütüphane boş halinde overflow yok.
- [ ] Kütüphane listesinde uzun başlıklar overflow yaratmıyor.
- [ ] Hızlı Ekle ekranında uzun prompt yazarken overflow yok.
- [ ] Prompt Detay ekranında uzun prompt metni taşmıyor.
- [ ] Prompt Düzenle ekranında uzun metin ve klavye birlikte sorun çıkarmıyor.
- [ ] Detaylı Ekle ekranında uzun not/kategori/etiket alanları formu bozmuyor.
- [ ] Arama/filtreleme alanları küçük ekranda taşmıyor.
- [ ] Değişkenli Kopyala-Doldur ekranında çok sayıda değişken overflow yaratmıyor.
- [ ] Hata mesajları küçük ekranda okunabilir kalıyor.

## 9. Scroll Davranışı Kontrolü

- [ ] Uzun prompt metni Hızlı Ekle ekranında scroll edilebiliyor.
- [ ] Prompt Detay ekranında uzun metin scroll edilebiliyor.
- [ ] Prompt Düzenle ekranında uzun metin düzenlenebiliyor.
- [ ] Detaylı Ekle formu küçük ekranda scroll edilebiliyor.
- [ ] Değişkenli Kopyala-Doldur formu çok sayıda input ile scroll edilebiliyor.
- [ ] Kütüphane listesi çok sayıda prompt ile scroll edilebiliyor.
- [ ] Scroll davranışı klavye açıkken bozulmuyor.
- [ ] Scroll içinde butonlar erişilebilir kalıyor.

## 10. Login / Register Cihaz Testi

- [ ] Uygulama Android emülatörde açılıyor.
- [ ] Uygulama gerçek Android cihazda açılıyor veya test planına alındı.
- [ ] Login ekranı küçük ekranda düzgün.
- [ ] Register ekranı küçük ekranda düzgün.
- [ ] E-posta alanında doğru klavye tipi açılıyor.
- [ ] Şifre alanında şifre gizleme/gösterme davranışı varsa çalışıyor.
- [ ] Boş form hatası okunabilir.
- [ ] Yanlış şifre hatası okunabilir.
- [ ] Loading state cihazda görünür.
- [ ] Giriş sonrası AuthGate doğru yönlendiriyor.
- [ ] Çıkış sonrası geri tuşu ile korumalı alana dönülemiyor.

## 11. Kütüphane Cihaz Testi

- [ ] Boş kütüphane hali küçük ekranda düzgün.
- [ ] Boş durumdan Hızlı Ekle’ye geçiş yapılabiliyor.
- [ ] Prompt listesi orta boy ekranda düzgün.
- [ ] Prompt listesi küçük ekranda taşmıyor.
- [ ] Uzun başlıklar listede sorun yaratmıyor.
- [ ] Uzun prompt önizlemeleri listeyi bozmuyor.
- [ ] Status etiketi varsa küçük ekranda okunabilir.
- [ ] Son güncelleme bilgisi varsa küçük ekranda bozulmuyor.
- [ ] Liste scroll davranışı düzgün.
- [ ] Liste item’ına dokunma davranışı tutarlı.

## 12. Hızlı Ekle Cihaz Testi

- [ ] Hızlı Ekle ekranı küçük ekranda açılıyor.
- [ ] Prompt metni alanı rahat yazılabiliyor.
- [ ] Klavye açıldığında alan kapanmıyor.
- [ ] Kaydet butonu erişilebilir.
- [ ] Çok uzun prompt yazıldığında scroll çalışıyor.
- [ ] Boş promptText hata mesajı düzgün gösteriliyor.
- [ ] Kayıt sırasında loading state görünür.
- [ ] Kayıt başarılı olduğunda kullanıcıya geri bildirim veriliyor.
- [ ] Kayıt sonrası kütüphanede yeni prompt görünüyor.
- [ ] Geri tuşu davranışı doğru.

## 13. Prompt Detay / Normal Kopyala Cihaz Testi

- [ ] Prompt Detay ekranı küçük ekranda açılıyor.
- [ ] Uzun prompt metni okunabilir.
- [ ] Prompt metni scroll edilebilir.
- [ ] Metadata alanları küçük ekranda bozulmuyor.
- [ ] Normal Kopyala butonu erişilebilir.
- [ ] Kopyalama gerçek Android cihazda çalışıyor.
- [ ] Kopyalama sonrası kullanıcıya bildirim gösteriliyor.
- [ ] Normal Kopyala `updatedAt` değiştirmiyor.
- [ ] Geri tuşu kütüphaneye doğru dönüyor.
- [ ] Clipboard davranışı kullanıcı aksiyonu ile tetikleniyor.

## 14. Prompt Düzenle Cihaz Testi

- [ ] Düzenleme ekranı küçük ekranda açılıyor.
- [ ] Prompt metni düzenlenebiliyor.
- [ ] Uzun prompt düzenlenirken scroll çalışıyor.
- [ ] Klavye kaydet butonunu erişilemez hale getirmiyor.
- [ ] Başlık/açıklama/not alanları düzenlenebiliyor.
- [ ] Kategori/etiket alanları küçük ekranda bozulmuyor.
- [ ] Status seçimi küçük ekranda kullanılabilir.
- [ ] Kaydetme loading state gösteriyor.
- [ ] Boş promptText hatası düzgün gösteriliyor.
- [ ] Geri tuşu / kaydetmeden çıkma davranışı kontrol edildi.

## 15. Detaylı Ekle Cihaz Testi

- [ ] Detaylı Ekle formu küçük ekranda kullanılabilir.
- [ ] Tüm alanlara scroll ile ulaşılabiliyor.
- [ ] PromptText alanı uzun metin için uygun.
- [ ] Başlık alanı düzgün.
- [ ] Açıklama alanı düzgün.
- [ ] Notlar alanı düzgün.
- [ ] Kategori alanı düzgün.
- [ ] Etiket giriş davranışı düzgün.
- [ ] Status seçimi düzgün.
- [ ] Klavye formu bozmuyor.
- [ ] Kayıt sonrası prompt kütüphanede doğru görünüyor.

## 16. Arama / Filtreleme Cihaz Testi

- [ ] Arama alanı küçük ekranda kullanılabilir.
- [ ] Arama klavyesi ekranı bozmuyor.
- [ ] Arama sonucu listesi düzgün gösteriliyor.
- [ ] Sonuç yok durumu düzgün gösteriliyor.
- [ ] Kategori filtresi küçük ekranda kullanılabilir.
- [ ] Etiket filtresi küçük ekranda kullanılabilir.
- [ ] Status filtresi küçük ekranda kullanılabilir.
- [ ] Arama + filtre birlikte çalışıyor.
- [ ] Filtre temizleme davranışı erişilebilir.
- [ ] Filtre UI’ı V1 kapsamını aşacak kadar karmaşıklaşmadı.

## 17. Değişkenli Kopyala-Doldur Cihaz Testi

- [ ] Değişkenli ekran küçük ekranda açılıyor.
- [ ] Algılanan değişkenler input olarak görünüyor.
- [ ] Çok sayıda değişken olduğunda form scroll edilebiliyor.
- [ ] Klavye input alanlarını kapatmıyor.
- [ ] Eksik değişken uyarısı okunabilir.
- [ ] Final prompt üretimi küçük ekranda okunabilir.
- [ ] Final prompt uzun ise scroll edilebilir.
- [ ] Final prompt kopyalanabiliyor.
- [ ] Kopyalama gerçek cihazda çalışıyor.
- [ ] Değişken yok durumunda uygun mesaj gösteriliyor.

## 18. Navigation / Geri Tuşu Kontrolü

- [ ] Login/Register arası geçiş doğru.
- [ ] Login sonrası AuthGate doğru yönlendiriyor.
- [ ] Logout sonrası geri tuşu korumalı ekrana döndürmüyor.
- [ ] Kütüphane → Hızlı Ekle → geri davranışı doğru.
- [ ] Kütüphane → Detay → geri davranışı doğru.
- [ ] Detay → Düzenle → geri/kaydet davranışı doğru.
- [ ] Detay → Değişkenli Kopyala-Doldur → geri davranışı doğru.
- [ ] Kayıt sonrası navigation tutarlı.
- [ ] Android fiziksel/sistem geri tuşu test edildi.
- [ ] Beklenmeyen çift navigation oluşmuyor.

## 19. Loading / Error / Empty State Cihaz Kontrolü

- [ ] Loading state küçük ekranda görünür.
- [ ] Error state küçük ekranda okunabilir.
- [ ] Empty state küçük ekranda anlaşılır.
- [ ] Permission error uygulamayı çökertmiyor.
- [ ] Network error uygulamayı çökertmiyor.
- [ ] Form validation hataları klavye açıkken görünür.
- [ ] Uzun hata mesajları ekranı bozmuyor.
- [ ] Retry aksiyonu varsa erişilebilir.
- [ ] Hata durumunda kullanıcı başka kullanıcı verisi görmüyor.

## 20. Performans / Kullanılabilirlik Smoke Test

V1’de gelişmiş performans testi şart değildir; temel kullanım kontrolü yeterlidir.

- [ ] Kütüphane makul sayıda promptla akıcı.
- [ ] Liste scroll ederken belirgin takılma yok.
- [ ] Prompt Detay uzun metinde kullanılabilir.
- [ ] Hızlı Ekle kaydetme süresi kabul edilebilir.
- [ ] Arama küçük/orta veri setinde kabul edilebilir hızda.
- [ ] Filtreleme küçük/orta veri setinde kabul edilebilir hızda.
- [ ] Gereksiz rebuild veya bariz UI donması gözlenirse not edildi.
- [ ] Büyük veri / pagination V1 dışıysa parking lot’a not edildi.

## 21. Android Sürüm Kontrolü

V1 için minimum kararlar kodlama aşamasında netleşebilir.

- [ ] Güncel Android sürümde test edildi.
- [ ] Mümkünse bir önceki yaygın Android sürümde test edildi.
- [ ] Android minimum SDK davranışı kontrol edildi veya planlandı.
- [ ] Firebase Auth/Firestore Android cihazda çalışıyor.
- [ ] Clipboard davranışı Android cihazda çalışıyor.
- [ ] Klavye davranışı Android cihazda çalışıyor.
- [ ] Android permission gerektiren beklenmeyen bir durum yok.
- [ ] Play Store öncesi daha geniş cihaz testi gerektiği not edildi.

## 22. Web / Desktop / Tablet Smoke Test

V1 ana kabul şartı Android mobil olsa da opsiyonel smoke testler not edilebilir.

- [ ] Web build denenirse uygulama tamamen kırılmıyor.
- [ ] Web’de Auth akışı opsiyonel olarak kontrol edildi.
- [ ] Desktop build V1 için zorunlu değil.
- [ ] Tablet görünümü opsiyonel olarak kontrol edildi.
- [ ] Tablet küçük kırılımlar varsa V1 bloklayıcı değil, development notes’a yazıldı.
- [ ] Web/desktop/tablet desteği V1 scope’u şişirecek şekilde büyütülmedi.

## 23. Security ile İlgili Cihaz Kontrolü

- [ ] Logout sonrası geri tuşu ile veri ekranına dönülemiyor.
- [ ] Kullanıcı A çıkış yaptıktan sonra Kullanıcı B giriş yapınca A’nın verisi görünmüyor.
- [ ] Uygulama yeniden açıldığında doğru kullanıcı durumu gösteriliyor.
- [ ] Auth olmayan kullanıcı kütüphaneye gidemiyor.
- [ ] Kopyalanan prompt kullanıcı aksiyonuyla clipboard’a gidiyor.
- [ ] Clipboard davranışı hassas veri beklentisi açısından development notes’a gerekirse not edildi.

## 24. Milestone Bazlı Cihaz Test Hatırlatması

### M1

- [ ] Login/Register/AuthGate cihaz testi.

### M4

- [ ] Kütüphane + Hızlı Ekle + Firestore kayıt cihaz testi.

### M5

- [ ] Prompt Detay + Normal Kopyala cihaz testi.

### M6

- [ ] Düzenleme + Status + Arşiv cihaz testi.

### M7

- [ ] Detaylı Ekle uzun form cihaz testi.

### M8

- [ ] Arama / filtreleme cihaz testi.

### M9

- [ ] Değişkenli Kopyala-Doldur cihaz testi.

### M10

- [ ] Tüm ana akış gerçek cihaz / emülatör final test.

## 25. AI Review Hatırlatma

Cihaz ve UI davranışı için önerilen prompt:

- `device_ui_review_prompt.md`
- Gerekirse `milestone_review_prompt.md`

Kontrol maddeleri:

- [ ] M4 sonrası cihaz/UI review değerlendirildi.
- [ ] M7 sonrası uzun form review değerlendirildi.
- [ ] M9 sonrası değişkenli form review değerlendirildi.
- [ ] M10 final cihaz/UI review değerlendirildi.
- [ ] Gelen öneriler otomatik karar sayılmadı.
- [ ] V1 dışı UI büyütme önerileri parking lot’a taşındı veya reddedildi.
- [ ] Kabul edilen cihaz/UI iyileştirmeleri development notes’a yazıldı.

## 26. Development Notes Kontrolü

Her cihaz testi sonrası not tutulmalıdır.

- [ ] Test edilen cihaz/platform yazıldı.
- [ ] Test edilen akış yazıldı.
- [ ] Gözlenen sorun varsa yazıldı.
- [ ] Overflow/klavye/navigation sorunu varsa yazıldı.
- [ ] Çözüm aksiyonu yazıldı.
- [ ] V1’i bloklayan sorunlar işaretlendi.
- [ ] Opsiyonel tablet/web sorunları V1 dışıysa not edildi.

Önerilen not formatı:

```md
## [TARİH] — Cihaz Test Notu

Milestone: Mx
Cihaz / Platform:
Kategori: Cihaz Testi
Durum: Sorunsuz / Sorun var / İzlenecek

### Test edilen akış
...

### Gözlem
...

### Sorun
...

### Aksiyon
...
```

## 27. Kapanış Kararı

Bu checklist tamamlandı sayılabilmesi için:

- [ ] Android emülatörde ana akışlar çalışıyor.
- [ ] En az bir gerçek Android cihazda kritik akışlar test edildi veya planlandı.
- [ ] Küçük ekranda kritik overflow yok.
- [ ] Klavye formları kullanılamaz hale getirmiyor.
- [ ] Uzun prompt metinleri scroll edilebiliyor.
- [ ] Normal Kopyala gerçek cihazda çalışıyor.
- [ ] Geri tuşu davranışı temel akışlarda doğru.
- [ ] Değişkenli form uzun input listesinde bozulmuyor.
- [ ] Cihaz test notları development notes’a yazıldı.
- [ ] Web/tablet/desktop opsiyonel testler V1 scope’u büyütmedi.

## 28. Kapanış Notu

Cihaz testi, “kod doğru mu?” sorusundan çok “insan bunu gerçekten telefonda kullanabilir mi?” sorusunu cevaplar. Emülatörde pırıl pırıl görünen bir ekran, küçük telefonda klavye açılınca origamiye dönüşebilir. Bu checklist o origamiyi erken yakalamak içindir.
