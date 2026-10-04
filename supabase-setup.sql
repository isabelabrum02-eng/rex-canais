-- Execute este script uma vez no SQL Editor do seu projeto Supabase.
-- O RLS limita todas as consultas aos clientes pertencentes ao usuário conectado.

create table if not exists public.clientes (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references auth.users (id) on delete cascade,
    nome text not null,
    telefone text not null,
    valor numeric(10, 2) not null check (valor >= 0),
    vencimento text not null check (vencimento in ('07', '09', '15', '20', '26', '29')),
    app text not null,
    qtd_tv integer not null check (qtd_tv >= 1),
    created_at timestamptz not null default now()
);

create index if not exists clientes_user_id_created_at_idx
    on public.clientes (user_id, created_at);

alter table public.clientes enable row level security;

revoke all on table public.clientes from public, anon, authenticated;
grant select, insert, update, delete on table public.clientes to authenticated;

drop policy if exists "Users can read their own clients" on public.clientes;
create policy "Users can read their own clients"
    on public.clientes for select
    to authenticated
    using (auth.uid() = user_id);

drop policy if exists "Users can insert their own clients" on public.clientes;
create policy "Users can insert their own clients"
    on public.clientes for insert
    to authenticated
    with check (auth.uid() = user_id);

drop policy if exists "Users can update their own clients" on public.clientes;
create policy "Users can update their own clients"
    on public.clientes for update
    to authenticated
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own clients" on public.clientes;
create policy "Users can delete their own clients"
    on public.clientes for delete
    to authenticated
    using (auth.uid() = user_id);
