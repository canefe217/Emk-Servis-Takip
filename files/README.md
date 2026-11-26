# Emk Servis Takip (Supabase + GitHub Pages sürümü)

Teknisyenlerin kendi aralarında arıza ve bakım takibi yaptığı, Android'e uygulama gibi kurulan web uygulaması (PWA).

- **Veri ve giriş:** Supabase (ücretsiz plan yeterli). Kullanıcı adı + şifre ile giriş.
- **Yayınlama:** GitHub Pages (ücretsiz). VS Code'dan `git push` ile güncellenir.

## Kurulum (yaklaşık 25 dakika)

### 1. Supabase projesi
https://supabase.com → **New project**. Bölge olarak **Central EU (Frankfurt)** seç, bir veritabanı şifresi belirle ve kaydet.

### 2. Tabloları oluştur
**SQL Editor → New query** aç, `schema.sql` dosyasının tamamını yapıştırıp **Run** de. Tablolar, güvenlik kuralları ve canlı güncelleme bu adımda kurulur.

### 3. Giriş ayarları (önemli)
**Authentication → Sign In / Providers** (eski panelde Settings) bölümünde:
1. **Email** sağlayıcısı açık kalsın.
2. **Confirm email** seçeneğini **kapat** (kullanıcı adları gerçek e-posta değil).
3. **Allow new users to sign up** seçeneğini **kapat**. Böylece dışarıdan kimse hesap açıp verilere ulaşamaz. Sadece senin eklediğin kişiler girer.

### 4. Teknisyen hesapları
**Authentication → Users → Add user → Create new user**:
- Email: `kullaniciadi@emk-servis.app` (ör. `ahmet@emk-servis.app`)
- Password: bir şifre belirle
- **Auto Confirm User** kutusunu işaretle

Teknisyen uygulamada sadece `ahmet` yazar. Alan adını değiştirmek istersen `index.html` içindeki `DOMAIN` değerini de aynı yap.

### 5. Uygulamaya bağla
**Project Settings → API** sayfasından iki değeri `index.html` dosyasının başındaki alanlara yapıştır:
- **Project URL** → `SUPABASE_URL`
- **anon public** anahtarı → `SUPABASE_KEY`

`service_role` anahtarını **asla** koyma. `anon` anahtarı herkese açık olacak şekilde tasarlanmıştır, verileri `schema.sql` içindeki kurallar korur.

### 6. GitHub'a yükle ve yayınla
GitHub'da yeni bir depo aç (ör. `emk-servis`). Bu klasörde VS Code terminalinde:

```bash
git init
git add .
git commit -m "ilk sürüm"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADIN/emk-servis.git
git push -u origin main
```

Sonra GitHub'da **Settings → Pages → Build and deployment → Deploy from a branch → main / (root) → Save**.
Birkaç dakika sonra adres hazır olur: `https://KULLANICI_ADIN.github.io/emk-servis/`

Güncelleme yapmak için dosyayı değiştirip `git add . && git commit -m "güncelleme" && git push` yeterli.

### 7. Android'e kurulum
1. Telefonda Chrome ile adresi aç.
2. Menü (⋮) → **Uygulamayı yükle** (ya da **Ana ekrana ekle**).
3. Kullanıcı adın ve şifrenle giriş yap. İlk girişte adını yaz; ekipte bu isimle görünürsün.

## Nasıl çalışır
- Arıza: **İşi üstlen → Çözüldü yap**. Kimin açtığı ve kimin üstlendiği her kayıtta görünür. **Bende** filtresi sadece senin işlerini gösterir.
- Bakım: Tarih planla, geciken bakımlar kırmızı görünür, tamamlayanın adı kaydedilir.
- Liste herkeste canlı güncellenir. Kayıtları sadece açan kişi silebilir.
- Üstteki **Şifre** düğmesiyle herkes kendi şifresini değiştirebilir.

## Bilmen gerekenler
- **Çevrimdışı:** İnternet yokken son yüklenen liste görünür ama yeni kayıt/değişiklik yapılamaz (Firebase sürümünün aksine). Bağlantı gelince uygulama kendini yeniler.
- **Ücretsiz plan uyku modu:** Supabase ücretsiz projeleri 1 hafta hiç kullanılmazsa duraklatılır. Düzenli kullanılan ekipte sorun olmaz. Duraklarsa panelden **Restore** ile açılır.
- **Şifre unutulursa:** Adresler gerçek e-posta olmadığı için "şifremi unuttum" e-postası çalışmaz. Hesabı panelden silip aynı kullanıcı adıyla yeniden oluştur. Hesap yenilenince eski kayıtlarda adı "Teknisyen" görünür.
- **Veri:** Kayıtlar Supabase sunucularında (Frankfurt) tutulur. Müşteri bilgisi (otel adı, oda no) içerdiği için firmanın veri politikasını kontrol edin.
- **GitHub deposu:** Depo herkese açık olabilir, içinde gizli bilgi yoktur. Gizli kalmasını istersen özel depo da olur ama GitHub Pages özel depoda ücretli plan ister.
