# 🚀 Creator Planet — Complete Publish Guide

## Step 1: Supabase Setup (5 min)

1. Go to **https://supabase.com** → Create free account
2. Click **"New Project"** → name it `creator-planet`
3. Copy your **Project URL** and **Anon Key** from:
   `Settings → API → Project URL & anon public key`

4. Go to **SQL Editor** → paste entire `SUPABASE_SCHEMA.sql` → Run
5. In the SQL, replace `your-admin-email@gmail.com` with YOUR Gmail

6. Go to **Authentication → Providers → Google** → Enable it
   - You'll need Google OAuth credentials (see Step 1b)

### Step 1b: Google OAuth Setup (10 min)
1. Go to https://console.cloud.google.com
2. Create new project → "Creator Planet"
3. APIs & Services → Credentials → Create OAuth 2.0 Client
4. Authorized redirect URIs: `https://YOUR-PROJECT.supabase.co/auth/v1/callback`
5. Copy Client ID + Secret → paste in Supabase Auth → Google provider

---

## Step 2: Local Setup

```bash
# Clone/download the project folder
cd creator-planet

# Install dependencies
npm install

# Create .env file
cp .env.example .env
```

Edit `.env`:
```
VITE_SUPABASE_URL=https://xxxxx.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

```bash
# Run locally
npm run dev
# Opens at http://localhost:5173
```

---

## Step 3: Deploy to Vercel (Free — 5 min)

1. Push code to GitHub:
   ```bash
   git init
   git add .
   git commit -m "Creator Planet launch"
   git remote add origin https://github.com/YOUR_USERNAME/creator-planet.git
   git push -u origin main
   ```

2. Go to **https://vercel.com** → Login with GitHub
3. Click **"New Project"** → Import your repo
4. Add Environment Variables:
   - `VITE_SUPABASE_URL` = your supabase URL
   - `VITE_SUPABASE_ANON_KEY` = your anon key
5. Click **Deploy** → Live in 2 minutes!

Your site will be at: `https://creator-planet.vercel.app`

---

## Step 4: Custom Domain (Optional)

1. Buy domain from **GoDaddy** or **Namecheap** (~₹500-800/year)
   - Suggested: `creatorplanet.in` or `creatorplanet.io`
2. In Vercel → Project Settings → Domains → Add your domain
3. Follow DNS setup instructions

---

## Step 5: Google AdSense Setup

1. Go to **https://adsense.google.com**
2. Sign up with your Google account
3. Add your website URL
4. Paste the verification code in your `index.html` `<head>`:
   ```html
   <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-XXXXXXXXXX" crossorigin="anonymous"></script>
   ```
5. Wait for approval (2-4 weeks)
6. After approval, add ad units in your pages

**AdSense Requirements:**
- Original content ✅ (your uploaded assets)
- Privacy Policy page ✅ (add /privacy route)
- Terms of Service page ✅ (add /terms route)
- Minimum 15-20 pages of content ✅

---

## Step 6: Upload Your First Assets (Admin)

1. Login to your site with your admin Gmail
2. Go to `/admin` 
3. Click "Upload Asset"
4. Fill form → Upload files → Done!

Assets instantly appear on the website.

---

## Summary

| Step | Tool | Cost |
|------|------|------|
| Database | Supabase | Free |
| Hosting | Vercel | Free |
| Domain | GoDaddy/Namecheap | ~₹600/yr |
| Google OAuth | Google Cloud | Free |
| AdSense | Google | Free (% revenue share) |

**Total startup cost: ~₹600/year** 🎉
