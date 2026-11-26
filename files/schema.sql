-- Supabase > SQL Editor'e yapıştırıp "Run" de.

-- Teknisyen adları
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null
);

-- Arıza (kind='f') ve bakım (kind='m') kayıtları
create table if not exists records (
  id text primary key,
  kind text not null check (kind in ('f','m')),
  data jsonb not null,
  by_id uuid not null default auth.uid() references auth.users(id) on delete cascade
);

alter table profiles enable row level security;
alter table records  enable row level security;

-- Adlar: giriş yapan herkes okur, herkes sadece kendi adını yazar
create policy "profiles_oku"  on profiles for select to authenticated using (true);
create policy "profiles_ekle" on profiles for insert to authenticated with check (id = auth.uid());
create policy "profiles_guncelle" on profiles for update to authenticated using (id = auth.uid()) with check (id = auth.uid());

-- Kayıtlar: giriş yapan herkes okur/ekler/günceller, silmeyi sadece kaydı açan yapar
create policy "records_oku"  on records for select to authenticated using (true);
create policy "records_ekle" on records for insert to authenticated with check (by_id = auth.uid());
create policy "records_guncelle" on records for update to authenticated using (true) with check (true);
create policy "records_sil"  on records for delete to authenticated using (by_id = auth.uid());

-- Canlı güncelleme (Realtime)
alter publication supabase_realtime add table records, profiles;
