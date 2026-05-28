# ADR-006 — V1 Manuel Çekirdek, V2 AI Katmanı

## Durum

Kabul edildi

## Tarih

2026-05-25

## Bağlam

Prompt Yönetim Aracı’nın uzun vadeli vizyonu, kullanıcının kişisel AI çalışma hafızasına dönüşebilecek bir prompt yaşam döngüsü yönetim sistemi kurmaktır.

Ürün fikrinde AI destekli başlık önerme, prompt iyileştirme, kategori/etiket önerme, semantik arama, prompt health check, toplu işleme ve ajan destekli bakım gibi güçlü özellikler uzun vadede değerlidir.

Ancak V1’in amacı bu akıllı katmanı kurmak değildir. V1’in amacı, ürünün temel manuel prompt yaşam döngüsü çekirdeğini kanıtlamaktır:

```text
Yakala → Kartlaştır → Değişkenleştir → Bul → Kullan → Güncelle
```

Bu nedenle AI özelliklerinin V1’e alınıp alınmayacağı mimari, maliyet, kapsam ve kullanıcı kontrolü açısından netleştirilmelidir.

## Karar

V1, AI’sız çalışan manuel prompt yaşam döngüsü çekirdeği olacaktır.

AI destekli özellikler V2 katmanı olarak ele alınacaktır.

V1’de kullanıcı:

- Promptu Hızlı Ekle veya Detaylı Ekle ile kaydeder,
- Prompt Kartı olarak saklar,
- Kategori, etiket, durum ve değişken alanlarla düzenler,
- Kütüphanede arar ve filtreler,
- Normal Kopyala veya Değişkenli Kopyala-Doldur ile yeniden kullanır,
- Promptu düzenler ve arşivler.

V1’de AI:

- Promptu iyileştirmeyecek,
- Başlık önermeyecek,
- Kategori / etiket önermeyecek,
- Prompt Kartı’nı kullanıcı onayıyla veya onaysız değiştirmeyecek,
- Semantik arama sunmayacak,
- AI kota / kredi ekranı göstermeyecek,
- AI API çağrısı yapmayacak.

## Alternatifler

### Alternatif 1 — V1’e AI özelliklerini dahil etmek

Örnek V1 AI özellikleri:

- AI başlık önerisi,
- AI kategori / etiket önerisi,
- AI prompt iyileştirme,
- AI değişken önerisi,
- Semantik arama.

Avantajları:

- Ürün daha “akıllı” görünür.
- İlk kullanıcı deneyimi daha etkileyici olabilir.
- Farklılaşma erken hissedilebilir.

Dezavantajları:

- V1 kapsamı büyür.
- AI maliyeti ve kota sistemi gerektirir.
- Backend / AI Gateway ihtiyacı doğar.
- API key güvenliği gündeme gelir.
- Model routing, usage log, maliyet ölçümü gibi konular erken gelir.
- Kullanıcı kontrolü ve veri güvenliği daha karmaşık hâle gelir.
- Manuel çekirdeğin gerçekten çalışıp çalışmadığı bulanıklaşır.

### Alternatif 2 — V1 tamamen manuel, AI uzun vadede belirsiz

Avantajları:

- V1 sade kalır.
- Maliyet yoktur.
- Teknik kapsam daha yönetilebilir olur.

Dezavantajları:

- AI katmanı uzun vadeli vizyonda belirsiz kalabilir.
- İleride AI eklemek için mimari hazırlık unutulabilir.
- Ürünün büyüme yönü yeterince kayıt altına alınmayabilir.

### Alternatif 3 — V1 manuel çekirdek, V2 isteğe bağlı AI katmanı

Avantajları:

- V1 çekirdeği net ve yönetilebilir kalır.
- AI maliyeti V1’e yük bindirmez.
- Kullanıcı kontrolü korunur.
- V2 için mimari hazırlık yapılabilir.
- AI özellikleri daha sağlam ölçüm, kota ve gateway altyapısıyla eklenebilir.
- V1’in ürün değer önerisi AI olmadan test edilir.

Dezavantajları:

- AI destekli “wow” etkisi V1’de olmayabilir.
- Bazı kullanıcılar erken akıllı özellik bekleyebilir.
- V2 için ek backend ve maliyet planı ayrıca gerekecektir.

## Gerekçe

Prompt Yönetim Aracı’nın temel problemi “prompt değer kaybı”dır. Bu problemi çözmek için ilk ihtiyaç AI değil; promptların bulunabilir, anlaşılabilir, düzenlenebilir, değişkenleştirilebilir ve yeniden kullanılabilir bilgi varlıklarına dönüştürülmesidir.

V1’in bu manuel çekirdeği kanıtlaması gerekir. AI katmanı erken eklenirse ürünün özü bulanıklaşır ve V1, prompt yaşam döngüsü çekirdeği yerine AI destekli geniş bir platform denemesine dönüşebilir.

AI özellikleri değerlidir; ancak doğru zamanda, kullanıcı onayı, kota, maliyet, model routing ve güvenlik mimarisiyle birlikte eklenmelidir.

Bu nedenle V1 manuel çekirdek, V2 ise isteğe bağlı AI destek katmanı olarak ayrılmıştır.

## Sonuçlar

Bu karar sonucunda:

- V1’de AI API entegrasyonu yapılmayacaktır.
- V1’de AI Gateway / Adapter aktif olarak geliştirilmeyecektir.
- V1’de AI kredi / kota ekranı olmayacaktır.
- V1’de token, model, sağlayıcı, maliyet ve usage log tutulmayacaktır.
- AI fikirleri `08_parking_lot_v1_5_v2.md` içinde V2/V2.5/V3 raflarında tutulacaktır.
- V1 acceptance criteria AI olmadan tamamlanabilir olacaktır.
- V1 scope leak checklist içinde AI özellikleri özellikle kontrol edilecektir.
- V2’de AI kullanıcı onayı olmadan Prompt Kartı’nı değiştirmeyecektir.
- V2’de AI işlemleri backend tarafındaki AI Gateway / Adapter üzerinden tasarlanacaktır.

## V2 İçin Korunan AI İlkeleri

V2’de AI katmanı geldiğinde şu ilkeler korunacaktır:

- AI kullanıcı onayı olmadan Prompt Kartı’nı değiştirmeyecek.
- Kullanıcıya token değil AI hakkı / AI kredi gösterilecek.
- Gerçek token, model, sağlayıcı, maliyet ve kullanım logları backend’de tutulacak.
- AI işlem sınıfları XS, S, M, L, XL gibi maliyet sınıflarına ayrılabilecek.
- Flutter istemcisi AI sağlayıcısını bilmeyecek.
- AI API key client tarafında tutulmayacak.
- Model routing backend’de yapılacak.
- OpenAI / Gemini / Claude / Mistral gibi sağlayıcılar değiştirilebilir kalacak.

## Riskler

- V1 bazı kullanıcılara “yeterince akıllı” görünmeyebilir.
- AI destekli farklılaşma V2’ye kalır.
- V2’ye hazırlık yapılmazsa ileride AI katmanı eklemek zorlaşabilir.
- V1’de AI olmaması pazarlama mesajında doğru anlatılmalıdır.
- V2 için maliyet/kota sistemi ayrı ve dikkatli tasarlanmalıdır.

## Risk Azaltma

- V1 değer önerisi AI’dan bağımsız anlatılacaktır: iyi promptları kaybetmeden sistemli çalışma varlıklarına dönüştürmek.
- AI fikirleri parking lot’ta kaybolmadan tutulacaktır.
- `ADR-007-ai-gateway-adapter-v2.md` ile V2 AI mimarisi yönü korunacaktır.
- `ADR-008-ai-credit-quota-model-v2.md` ile AI maliyet/kota yaklaşımı kayıt altına alınacaktır.
- `scope_leak_checklist.md` içinde V1’e AI sızıntısı düzenli kontrol edilecektir.
- AI review promptlarında V1’e AI özelliği önerilmemesi kırmızı kural olarak belirtilecektir.

## Ne Zaman Tekrar Değerlendirilecek?

Bu karar şu durumlarda yeniden değerlendirilebilir:

- V1 manuel çekirdek tamamlandıktan sonra,
- V1 kullanıcı testlerinde AI destekli alan önerisi güçlü ihtiyaç olarak tekrar ederse,
- V1.5 sonrası kullanım verileri AI katmanına ihtiyaç gösterirse,
- AI Gateway / Adapter teknik planı hazır hâle gelirse,
- Kota, maliyet ve abonelik modeli uygulanabilir hâle gelirse,
- V2 planlama aşamasına geçilirse.

## İlgili Belgeler

- `01_v1_scope.md`
- `02_architecture.md`
- `05_milestone_plan.md`
- `06_acceptance_criteria.md`
- `08_parking_lot_v1_5_v2.md`
- `scope_leak_checklist.md`
- `ADR-007-ai-gateway-adapter-v2.md`
- `ADR-008-ai-credit-quota-model-v2.md`

## Kapanış Notu

Bu ADR ile Prompt Yönetim Aracı V1’in AI’sız manuel prompt yaşam döngüsü çekirdeği olarak geliştirileceği; AI destekli özelliklerin ise V2 ve sonrası için ayrı, kontrollü ve kullanıcı onaylı bir katman olarak ele alınacağı kararı kilitlenmiştir.
