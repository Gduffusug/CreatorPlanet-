-- ============================================
-- CREATOR PLANET — SUPABASE DATABASE SCHEMA
-- Run this in Supabase SQL Editor
-- ============================================

-- USERS TABLE
create table if not exists public.users (
  id uuid references auth.users on delete cascade primary key,
  email text not null,
  full_name text,
  avatar text,
  role text default 'user' check (role in ('user', 'admin')),
  created_at timestamptz default now()
);

-- ADMINS WHITELIST TABLE
create table if not exists public.admins (
  id uuid default gen_random_uuid() primary key,
  email text unique not null,
  created_at timestamptz default now()
);

-- CATEGORIES TABLE
create table if not exists public.categories (
  id uuid default gen_random_uuid() primary key,
  name text unique not null,
  created_at timestamptz default now()
);

-- ASSETS TABLE
create table if not exists public.assets (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  description text,
  category text not null,
  tags text[] default '{}',
  file_url text,
  preview_image text,
  premium_status boolean default false,
  download_count integer default 0,
  created_at timestamptz default now()
);

-- DOWNLOADS TABLE
create table if not exists public.downloads (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users on delete cascade,
  asset_id uuid references public.assets on delete cascade,
  created_at timestamptz default now()
);

-- FAVORITES TABLE
create table if not exists public.favorites (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.users on delete cascade,
  asset_id uuid references public.assets on delete cascade,
  created_at timestamptz default now(),
  unique(user_id, asset_id)
);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

alter table public.users enable row level security;
alter table public.admins enable row level security;
alter table public.categories enable row level security;
alter table public.assets enable row level security;
alter table public.downloads enable row level security;
alter table public.favorites enable row level security;

-- USERS: Users can read their own profile
create policy "Users can read own profile" on public.users
  for select using (auth.uid() = id);

create policy "Users can update own profile" on public.users
  for update using (auth.uid() = id);

create policy "Insert on signup" on public.users
  for insert with check (auth.uid() = id);

-- ADMINS: Anyone can check if email is admin (for role assignment)
create policy "Anyone can check admin" on public.admins
  for select using (true);

-- CATEGORIES: Public read
create policy "Public read categories" on public.categories
  for select using (true);

-- ASSETS: Public read
create policy "Public read assets" on public.assets
  for select using (true);

-- DOWNLOADS: Users can see own, insert own
create policy "Users see own downloads" on public.downloads
  for select using (auth.uid() = user_id);

create policy "Users insert own downloads" on public.downloads
  for insert with check (auth.uid() = user_id);

-- FAVORITES: Users can manage own
create policy "Users manage own favorites" on public.favorites
  for all using (auth.uid() = user_id);

-- ============================================
-- SEED CATEGORIES
-- ============================================

insert into public.categories (name) values
  ('Meme Packs'),
  ('SFX Packs'),
  ('VFX Packs'),
  ('PNG Packs'),
  ('Thumbnail Packs'),
  ('Fonts'),
  ('Templates'),
  ('Editing Presets')
on conflict do nothing;

-- ============================================
-- ADD YOUR ADMIN EMAIL
-- Replace with your actual Gmail address
-- ============================================

insert into public.admins (email) values
  ('your-admin-email@gmail.com')
on conflict do nothing;

-- ============================================
-- STORAGE BUCKETS
-- Run these in Supabase Dashboard > Storage
-- OR via SQL:
-- ============================================

insert into storage.buckets (id, name, public) values
  ('assets', 'assets', true),
  ('previews', 'previews', true)
on conflict do nothing;

-- Storage policies (allow admin uploads)
create policy "Public read assets bucket" on storage.objects
  for select using (bucket_id in ('assets', 'previews'));

create policy "Authenticated upload" on storage.objects
  for insert with check (auth.role() = 'authenticated');
