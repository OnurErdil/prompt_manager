# Security Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1 geliştirme sürecinde genel güvenlik duruşunu dış AI’a inceletmek için kullanılır.

Firestore rules review yalnızca rules tarafına odaklanırken, bu prompt daha geniş güvenlik çerçevesini kontrol eder:

- Auth akışı
- Kullanıcı izolasyonu
- `ownerId` güvenliği
- Firestore rules
- UI / Firebase mimari sınırı
- Client tarafında secret/API key bulunmaması
- Logout / geri tuşu davranışı
- Hata mesajları
- V1 dışı AI/payment/team/public güvenlik yüzeylerinin ürüne sızmaması

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M1 — Auth / Routing sonrası
- M3 — Firestore Data Layer sonrası
- M4 — İlk Çekirdek Akış sonrası
- M6 — Update / Archive sonrası
- M10 — Final V1 güvenlik kapanışı
- Firestore rules veya Auth akışı değiştirildiğinde
- Dış AI’dan genel güvenlik gözü almak istendiğinde

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

V1 kapsamı:
V1 AI’sız, manuel prompt yaşam döngüsü çekirdeğidir.

Ana akış:
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle

V1 teknik kararları:
- Flutter kullanılacak.
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Firestore path: users/{userId}/prompts/{promptId}
- Her PromptCard ownerId alanı taşıyacak.
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilecek.
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.
- V1’de AI Gateway, AI API key, payment, team/workspace, public sharing yok.
```

## 4. Kilit Güvenlik İlkeleri

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kilit güvenlik ilkeleri:
- Auth olmayan kullanıcı prompt verisi okuyamaz.
- Auth olmayan kullanıcı prompt oluşturamaz.
- Auth olmayan kullanıcı prompt güncelleyemez.
- Auth olmayan kullanıcı prompt silemez.
- Kullanıcı yalnızca kendi promptlarını okuyabilir.
- Kullanıcı yalnızca kendi promptlarını oluşturabilir.
- Kullanıcı yalnızca kendi promptlarını güncelleyebilir.
- Kullanıcı başka kullanıcının promptlarını göremez.
- Create sırasında ownerId auth UID ile eşleşmelidir.
- Update sırasında ownerId değiştirilememelidir.
- V1’de delete kapalıdır.
- Client tarafında AI API key veya secret bulunmamalıdır.
- UI güvenlik yerine geçmez; Firestore rules gerçek güvenlik kapısıdır.
```

## 5. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Auth akışı kodları
- AuthGate / routing yapısı
- Firestore security rules
- Repository / service path kullanımı
- Prompt create/read/update/archive kodları
- PromptCard model / DTO / mapper
- Logout davranışı
- Hata mesajları
- .gitignore / config notları
- İlgili checklist maddeleri
```

## 6. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 6.1 Auth Güvenliği

- Giriş yapmamış kullanıcı korumalı ekrana erişebilir mi?
- Logout sonrası geri tuşu ile korumalı ekrana dönülebilir mi?
- AuthGate merkezi karar noktası mı?
- Login/Register ekranları güvenlik kararlarını tek başına mı veriyor?
- Auth hataları fazla teknik bilgi sızdırıyor mu?

### 6.2 Kullanıcı İzolasyonu

- Kullanıcı A, Kullanıcı B’nin promptlarını okuyabilir mi?
- Kullanıcı A, Kullanıcı B’nin promptlarını güncelleyebilir mi?
- Kullanıcı A, Kullanıcı B path’ine create yapabilir mi?
- Query path’i auth UID ile mi kuruluyor?
- Firestore rules bu izolasyonu gerçekten sağlıyor mu?

### 6.3 ownerId Güvenliği

- `ownerId` create sırasında auth UID ile atanıyor mu?
- Kullanıcı farklı ownerId gönderebilir mi?
- Update sırasında ownerId değiştirilebilir mi?
- `ownerId` kullanıcı tarafından düzenlenebilir alan olarak görünüyor mu?

### 6.4 Firestore Rules

- Rules yalnızca `request.auth != null` ile mi yetiniyor?
- `request.auth.uid == userId` kontrolü var mı?
- Delete kapalı mı?
- promptText ve status validation var mı?
- Public read/write açık mı?

### 6.5 Client Secret / API Key

- Client tarafında AI API key var mı?
- OpenAI/Gemini/Claude/Mistral key client tarafında var mı?
- Service account veya private key repo’ya girmiş mi?
- Keystore/secrets yanlışlıkla repo’ya dahil edilmiş mi?
- PowerShell script secret/config üretiyor mu?

### 6.6 Mimari Güvenlik Sınırı

- UI doğrudan Firebase’e erişiyor mu?
- Provider/Notifier doğrudan Firestore query yapıyor mu?
- Repository/service sınırı korunuyor mu?
- DTO presentation’a sızmış mı?
- Domain model Firebase tiplerine bağımlı mı?

### 6.7 Delete / Archive

- V1’de kalıcı delete açık mı?
- Archive `status: archived` olarak mı çalışıyor?
- Delete rules kapalı mı?
- UI kalıcı silme sunuyor mu?

### 6.8 Hata Mesajları / Logging

- Kullanıcıya fazla teknik hata gösteriliyor mu?
- Loglarda prompt içeriği veya secret sızıntısı var mı?
- Permission denied hatası çökme yaratıyor mu?
- Hata durumunda başka kullanıcı verisi gösteriliyor mu?

### 6.9 V1 Scope Security Leak

Şu yüzeyler V1’e sızmış mı?

- AI Gateway
- AI provider client
- Payment/subscription
- Team/workspace permission
- Public sharing
- Marketplace
- Admin panel
- Cloud Functions
- Public API
- Usage/cost backend

## 7. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Security Review Sonucu

## 1. Genel Güvenlik Değerlendirmesi
Kısa özet.

## 2. Kritik Güvenlik Sorunları
Her sorun için:
- Sorun:
- Sömürülebilecek senaryo:
- Neden kritik:
- Önerilen düzeltme:

## 3. Orta Öncelikli Sorunlar
- ...

## 4. Düşük Öncelikli İyileştirmeler
- ...

## 5. Auth Güvenliği
- ...

## 6. Kullanıcı İzolasyonu
- ...

## 7. ownerId Güvenliği
- ...

## 8. Firestore Rules Kontrolü
- ...

## 9. Client Secret / API Key Kontrolü
- ...

## 10. Mimari Güvenlik Sınırı
- ...

## 11. Delete / Archive Güvenliği
- ...

## 12. Hata Mesajları / Logging
- ...

## 13. V1 Scope Security Leak Kontrolü
- ...

## 14. Test Edilmesi Gereken Güvenlik Senaryoları
- ...

## 15. Önerilen Aksiyonlar
Kritik / Orta / Düşük olarak sırala.

## 16. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 8. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- UI’da buton gizlemeyi güvenlik olarak kabul etmeyin.
- allow read, write: if request.auth != null; kuralını yeterli kabul etmeyin.
- V1’de kalıcı delete açmayı önermeyin.
- V1’de public read/write önermeyin.
- V1’de team/workspace permission sistemi önermeyin.
- V1’de AI Gateway veya AI API entegrasyonu önermeyin.
- V1’de payment/subscription güvenlik modeli önermeyin.
- Client tarafında AI API key tutulmasını hiçbir şekilde önermeyin.
- Admin bypass veya public sharing gibi V1 dışı yapıları önermeyin.
- V1 dışı iyi fikirleri parking lot önerisi olarak işaretleyin.
```

## 9. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Flutter/Firebase security reviewer gibi davran.

Aşağıdaki Prompt Yönetim Aracı V1 kodunu ve güvenlik yapılarını incele. Amacın yeni özellik önermek değil; mevcut V1’in kullanıcı verisi izolasyonu, Auth güvenliği, Firestore rules, ownerId güvenliği, client secret güvenliği ve mimari güvenlik sınırları açısından güvenli olup olmadığını kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. V1 AI’sız manuel çekirdektir.

V1 TEKNİK KARARLARI:
- Flutter kullanılacak.
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Firestore path: users/{userId}/prompts/{promptId}
- Her PromptCard ownerId alanı taşıyacak.
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilecek.
- UI Firebase Auth veya Firestore’a doğrudan erişmeyecek.
- V1’de kalıcı delete yok, arşiv status: archived ile yapılacak.
- V1’de AI Gateway, AI API key, payment, team/workspace, public sharing yok.

KİLİT GÜVENLİK İLKELERİ:
- Auth olmayan kullanıcı prompt verisi okuyamaz.
- Auth olmayan kullanıcı prompt oluşturamaz.
- Auth olmayan kullanıcı prompt güncelleyemez.
- Auth olmayan kullanıcı prompt silemez.
- Kullanıcı yalnızca kendi promptlarını okuyabilir.
- Kullanıcı yalnızca kendi promptlarını oluşturabilir.
- Kullanıcı yalnızca kendi promptlarını güncelleyebilir.
- Kullanıcı başka kullanıcının promptlarını göremez.
- Create sırasında ownerId auth UID ile eşleşmelidir.
- Update sırasında ownerId değiştirilememelidir.
- V1’de delete kapalıdır.
- Client tarafında AI API key veya secret bulunmamalıdır.
- UI güvenlik yerine geçmez; Firestore rules gerçek güvenlik kapısıdır.

İNCELEME GÖREVİ:
Sana verdiğim kod/rules/belge parçalarını şu açılardan incele:
1. AuthGate ve routing güvenli mi?
2. Logout sonrası korumalı ekrana dönülebiliyor mu?
3. Kullanıcı A, Kullanıcı B’nin promptlarını okuyabilir mi?
4. Kullanıcı A, Kullanıcı B’nin promptlarını güncelleyebilir mi?
5. ownerId create/update sırasında güvenli mi?
6. Firestore rules kullanıcı izolasyonunu gerçekten sağlıyor mu?
7. Delete gerçekten kapalı mı?
8. Archive status update olarak güvenli mi?
9. Client tarafında secret/API key riski var mı?
10. UI doğrudan Firebase’e erişiyor mu?
11. Hata mesajları/loglar bilgi sızdırıyor mu?
12. V1 dışı AI/payment/team/public security yüzeyi sızmış mı?

ÇIKTI FORMATIN:
# Security Review Sonucu

## 1. Genel Güvenlik Değerlendirmesi
## 2. Kritik Güvenlik Sorunları
## 3. Orta Öncelikli Sorunlar
## 4. Düşük Öncelikli İyileştirmeler
## 5. Auth Güvenliği
## 6. Kullanıcı İzolasyonu
## 7. ownerId Güvenliği
## 8. Firestore Rules Kontrolü
## 9. Client Secret / API Key Kontrolü
## 10. Mimari Güvenlik Sınırı
## 11. Delete / Archive Güvenliği
## 12. Hata Mesajları / Logging
## 13. V1 Scope Security Leak Kontrolü
## 14. Test Edilmesi Gereken Güvenlik Senaryoları
## 15. Önerilen Aksiyonlar
## 16. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- UI’da buton gizlemeyi güvenlik olarak kabul etmeyin.
- allow read, write: if request.auth != null; kuralını yeterli kabul etmeyin.
- V1’de kalıcı delete açmayı önermeyin.
- V1’de public read/write önermeyin.
- V1’de team/workspace permission sistemi önermeyin.
- V1’de AI Gateway veya AI API entegrasyonu önermeyin.
- V1’de payment/subscription güvenlik modeli önermeyin.
- Client tarafında AI API key tutulmasını hiçbir şekilde önermeyin.
- Admin bypass veya public sharing gibi V1 dışı yapıları önermeyin.
- V1 dışı iyi fikirleri parking lot önerisi olarak işaretleyin.

İNCELEYECEĞİN İÇERİK:
[Buraya Auth kodları, Firestore rules, repository/service kodları, PromptCard model/DTO/mapper, ilgili dosyalar veya milestone özeti eklenecek.]
```

## 10. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kritik güvenlik sorunları önce ele alınır.
- V1 dışı öneriler reddedilir veya parking lot’a taşınır.
- Rules sorunu varsa `g04_firestore_rules_checklist.md` ile yeniden kontrol edilir.
- Mimari sınır sorunu varsa `g02_architecture_boundary_checklist.md` güncellenir.
- Scope leak varsa `g03_scope_leak_checklist.md` ile değerlendirilir.
- Notlar `09_development_notes.md` içine yazılır.
- Kalıcı karar gerekiyorsa ADR adayı açılır.

## 11. Kapanış Notu

Bu promptun amacı V1’i ağır bir kurumsal güvenlik sistemine çevirmek değil, kişisel kullanıcı verisinin yanlışlıkla açık pazar tezgâhına dönüşmesini önlemektir. Kapı sade olabilir; kilit ciddi olmalı.
