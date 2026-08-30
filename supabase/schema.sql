create extension if not exists pgcrypto;

create table if not exists public.shared_history (
  code text primary key,
  name text not null default 'Riwayat',
  saved_at timestamptz not null default now(),
  payload jsonb not null,
  created_at timestamptz not null default now()
);

alter table public.shared_history enable row level security;

create policy "Public can read shared history"
on public.shared_history
for select
using (true);

create policy "Public can insert shared history"
on public.shared_history
for insert
with check (true);

create index if not exists idx_shared_history_saved_at
  on public.shared_history (saved_at desc);
