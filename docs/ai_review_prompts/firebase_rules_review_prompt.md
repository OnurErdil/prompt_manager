# Firestore Rules Review Prompt

## 1. Amaç

Bu prompt, Prompt Yönetim Aracı V1’de Cloud Firestore security rules yapısının güvenli olup olmadığını dış AI’a inceletmek için kullanılır.

Bu review özellikle şu soruya cevap arar:

> Firestore rules, kullanıcı verisi izolasyonunu gerçekten sağlıyor mu, yoksa sadece giriş yapmış olmayı kontrol eden gevşek bir kapı mı bırakıyor?

## 2. Ne Zaman Kullanılır?

Bu prompt şu aşamalarda kullanılabilir:

- M3 — Firestore Data Layer sonrası ilk rules taslağı hazırlandığında
- M4 — Hızlı Ekle ve Kütüphane create/read akışı çalıştığında
- M6 — Update, status ve arşiv davranışı eklendiğinde
- M10 — Final güvenlik kapanışında
- Firestore rules değiştirildiğinde
- Cross-user erişim riski şüphesi olduğunda

## 3. AI’ya Verilecek Proje Bağlamı

Aşağıdaki bağlamı review yapacak AI’ya ver:

```md
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır.

V1 kapsamı:
V1 AI’sız, manuel prompt yaşam döngüsü çekirdeğidir.

V1 teknik kararları:
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Prompt verisi kullanıcıya bağlı saklanacak.
- Firestore path yapısı: users/{userId}/prompts/{promptId}
- Her PromptCard içinde ownerId alanı bulunacak.
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilmeli.
- V1’de kalıcı delete yok.
- Arşivleme status: archived ile yapılacak.
```

## 4. Kilit Güvenlik Kuralları

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kilit güvenlik kuralları:
- Auth olmayan kullanıcı prompt okuyamaz.
- Auth olmayan kullanıcı prompt oluşturamaz.
- Auth olmayan kullanıcı prompt güncelleyemez.
- Auth olmayan kullanıcı prompt silemez.
- Kullanıcı yalnızca kendi users/{uid}/prompts path’ine erişebilir.
- request.auth.uid == userId kontrolü olmalıdır.
- Create sırasında ownerId == request.auth.uid olmalıdır.
- Update sırasında ownerId değiştirilememelidir.
- promptText boş olmamalıdır.
- status yalnızca raw, needs_edit, ready, archived olabilir.
- V1’de delete kapalıdır.
- allow read, write: if request.auth != null; tek başına yeterli değildir.
```

## 5. İncelenecek İçerik

AI’ya şu içeriklerden ilgili olanları ver:

```md
İncelenecek içerik:
- Firestore security rules dosyası
- Firestore collection/path yapısı
- PromptCard örnek dokümanı
- Create/update payload örnekleri
- Repository/service path kullanımı
- Bilinen test senaryoları
- Security checklist maddeleri
```

## 6. Kontrol Kriterleri

AI’dan şu kriterlere göre inceleme yapmasını iste:

### 6.1 Auth Kontrolü

- Auth olmayan kullanıcı read yapabiliyor mu?
- Auth olmayan kullanıcı create yapabiliyor mu?
- Auth olmayan kullanıcı update yapabiliyor mu?
- Auth olmayan kullanıcı delete yapabiliyor mu?
- Her kuralda `request.auth != null` doğru yerde var mı?

### 6.2 Kullanıcı Path İzolasyonu

- `request.auth.uid == userId` kontrolü var mı?
- Kullanıcı başka UID path’ine erişebilir mi?
- Kullanıcı başka kullanıcının prompt listesini okuyabilir mi?
- Kullanıcı başka kullanıcının tekil promptunu okuyabilir mi?
- Kullanıcı başka kullanıcı path’ine create/update yapabilir mi?

### 6.3 ownerId Güvenliği

- Create sırasında `ownerId` auth UID ile eşleşiyor mu?
- Kullanıcı farklı `ownerId` ile kayıt oluşturabilir mi?
- Update sırasında `ownerId` değiştirilebilir mi?
- Rules hem path userId hem doküman ownerId ilkesini doğru kullanıyor mu?

### 6.4 Create Validation

- `promptText` boş kayıt engelleniyor mu?
- `status` geçerli değerlerden biri mi?
- `schemaVersion` varlığı kontrol ediliyor mu veya kontrol edilmeli mi?
- Create payload’ında V1 dışı/hassas alanlar risk yaratıyor mu?

### 6.5 Update Validation

- Kullanıcı sadece kendi promptunu update edebiliyor mu?
- `ownerId` değiştirilemiyor mu?
- `createdAt` değiştirilemiyor mu veya bu risk değerlendiriliyor mu?
- `promptText` boş bırakılamıyor mu?
- `status` geçerli değerlerle sınırlı mı?
- Arşivleme `status: archived` update’i olarak çalışabilir mi?

### 6.6 Delete Davranışı

- V1’de delete kapalı mı?
- Authenticated kullanıcı kendi promptunu bile kalıcı silebiliyor mu?
- Delete için yanlışlıkla açık bir genel rule var mı?
- Archive delete’e karıştırılmış mı?

### 6.7 Gevşek Rule Riski

Özellikle şu gibi rule risklerini ara:

```text
allow read, write: if request.auth != null;
allow read: if true;
allow write: if request.auth != null;
allow delete: if request.auth != null;
```

### 6.8 V1 Scope Leak

Rules içinde şu V1 dışı yapıların izi var mı?

- Public sharing
- Team/workspace permission
- Admin bypass
- Payment/subscription collection
- AI usage/quota collection
- Marketplace/public prompts
- Cloud Functions varsayımıyla gevşek client rules

## 7. AI’dan İstenen Çıktı Formatı

AI’dan cevabı şu formatta vermesini iste:

```md
# Firestore Rules Review Sonucu

## 1. Genel Değerlendirme
Rules genel olarak güvenli mi?

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

## 5. Auth Kontrolü
- Auth olmayan erişim gerçekten kapalı mı?

## 6. Kullanıcı İzolasyonu
- Kullanıcı A, Kullanıcı B’nin verisine erişebilir mi?

## 7. ownerId Kontrolü
- Create/update güvenli mi?

## 8. Create / Read / Update / Delete Değerlendirmesi
- Create:
- Read:
- Update:
- Delete:

## 9. Validation Kontrolü
- promptText:
- status:
- schemaVersion:
- createdAt/updatedAt:

## 10. V1 Scope Leak Kontrolü
Rules içinde V1 dışı yapı var mı?

## 11. Önerilen Rules Düzeltmeleri
Kod veya pseudo-code olarak öner.

## 12. Test Edilmesi Gereken Senaryolar
- ...

## 13. Sonuç
Kabul / Şartlı Kabul / Revizyon Gerekli
```

## 8. Kırmızı Kurallar

Review yapacak AI’ya şu kuralları açıkça ver:

```md
Kırmızı kurallar:
- allow read, write: if request.auth != null; kuralını güvenli kabul etmeyin.
- V1’de public read/write önermeyin.
- V1’de kalıcı delete açmayı önermeyin.
- V1’de team/workspace permission sistemi önermeyin.
- V1’de payment/subscription veya AI quota collection rules önermeyin.
- V1’de admin bypass rule önermeyin.
- UI’da gizleme davranışını güvenlik yerine koymayın.
- Rules önerilerini V1 path yapısı olan users/{userId}/prompts/{promptId} üzerinden düşünün.
```

## 9. Kullanıma Hazır Review Promptu

Aşağıdaki promptu dış AI’ya doğrudan verebilirsin:

```md
Sen deneyimli bir Firebase / Firestore security rules reviewer gibi davran.

Aşağıdaki Firestore rules yapısını Prompt Yönetim Aracı V1 kararlarına göre güvenlik açısından incele. Amacın yeni ürün özelliği önermek değil; kullanıcı verisi izolasyonu, ownerId güvenliği, create/read/update/delete davranışı ve V1 scope uyumunu kontrol etmek.

PROJE BAĞLAMI:
Prompt Yönetim Aracı, bireysel AI power user’lar için kişisel prompt yaşam döngüsü yönetim aracıdır. V1 AI’sız manuel çekirdektir.

V1 FIRESTORE KARARLARI:
- Firebase Auth kullanılacak.
- Cloud Firestore kullanılacak.
- Prompt path yapısı: users/{userId}/prompts/{promptId}
- Her PromptCard içinde ownerId alanı olacak.
- Kullanıcı yalnızca kendi promptlarını okuyup yazabilmeli.
- V1’de kalıcı delete yok.
- Arşivleme status: archived ile yapılacak.

KİLİT GÜVENLİK KURALLARI:
- Auth olmayan kullanıcı prompt okuyamaz.
- Auth olmayan kullanıcı prompt oluşturamaz.
- Auth olmayan kullanıcı prompt güncelleyemez.
- Auth olmayan kullanıcı prompt silemez.
- Kullanıcı yalnızca kendi users/{uid}/prompts path’ine erişebilir.
- request.auth.uid == userId kontrolü olmalıdır.
- Create sırasında ownerId == request.auth.uid olmalıdır.
- Update sırasında ownerId değiştirilememelidir.
- promptText boş olmamalıdır.
- status yalnızca raw, needs_edit, ready, archived olabilir.
- V1’de delete kapalıdır.
- allow read, write: if request.auth != null; tek başına yeterli değildir.

İNCELEME GÖREVİ:
Sana verdiğim Firestore rules dosyasını ve örnek payload’ları şu açılardan incele:
1. Auth olmayan erişim tamamen kapalı mı?
2. Kullanıcı A, Kullanıcı B’nin promptlarını okuyabilir mi?
3. Kullanıcı A, Kullanıcı B’nin path’ine create/update yapabilir mi?
4. Create sırasında ownerId auth UID ile eşleşiyor mu?
5. Update sırasında ownerId değiştirilebiliyor mu?
6. promptText boş kayıt engelleniyor mu?
7. status geçerli key’lerle sınırlı mı?
8. Delete gerçekten kapalı mı?
9. Arşivleme status update olarak güvenli mi?
10. Rules içinde public/team/payment/AI gibi V1 dışı yapı var mı?
11. Rules fazla gevşek mi?
12. Hangi kötü niyetli senaryolar test edilmeli?

ÇIKTI FORMATIN:
# Firestore Rules Review Sonucu

## 1. Genel Değerlendirme
## 2. Kritik Güvenlik Sorunları
## 3. Orta Öncelikli Sorunlar
## 4. Düşük Öncelikli İyileştirmeler
## 5. Auth Kontrolü
## 6. Kullanıcı İzolasyonu
## 7. ownerId Kontrolü
## 8. Create / Read / Update / Delete Değerlendirmesi
## 9. Validation Kontrolü
## 10. V1 Scope Leak Kontrolü
## 11. Önerilen Rules Düzeltmeleri
## 12. Test Edilmesi Gereken Senaryolar
## 13. Sonuç: Kabul / Şartlı Kabul / Revizyon Gerekli

KIRMIZI KURALLAR:
- allow read, write: if request.auth != null; kuralını güvenli kabul etmeyin.
- V1’de public read/write önermeyin.
- V1’de kalıcı delete açmayı önermeyin.
- V1’de team/workspace permission sistemi önermeyin.
- V1’de payment/subscription veya AI quota collection rules önermeyin.
- V1’de admin bypass rule önermeyin.
- UI’da gizleme davranışını güvenlik yerine koymayın.
- Rules önerilerini V1 path yapısı olan users/{userId}/prompts/{promptId} üzerinden düşünün.

İNCELEYECEĞİN İÇERİK:
[Buraya Firestore rules dosyası, örnek create/update payload’ları ve path yapısı eklenecek.]
```

## 10. Review Sonrası İşleme

Review cevabı geldikten sonra:

- Kritik güvenlik sorunlarını önce ele al.
- V1 dışı önerileri reddet veya parking lot’a taşı.
- Rules düzeltmelerini `g04_firestore_rules_checklist.md` ile tekrar kontrol et.
- Cross-user test senaryolarını `09_development_notes.md` içine yaz.
- Kalıcı mimari karar gerekiyorsa ADR adayı aç.
- M10 final güvenlik kapanışında aynı review’u tekrar kullan.

## 11. Kapanış Notu

Bu promptun görevi Firestore kapısının gerçekten kilitli olup olmadığını kontrol ettirmektir. “Giriş yapan herkes içeri girebilir” güvenlik değildir; herkes kendi odasına girebilmeli, komşunun çekmecesine değil.
