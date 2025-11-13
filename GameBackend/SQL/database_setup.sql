-- Create the profiles table
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  username text unique not null,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

-- Enable Row Level Security
alter table public.profiles enable row level security;

-- Policy: users can view their own profile
create policy "Users can view their own profile"
on public.profiles
for select
using (auth.uid() = id);

-- Policy: users can insert their own profile
create policy "Users can insert their own profile"
on public.profiles
for insert
with check (auth.uid() = id);

-- Policy: users can update their own profile
create policy "Users can update their own profile"
on public.profiles
for update
using (auth.uid() = id);

-- Create the scores table
create table public.scores (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade not null,
  value int not null,
  mode text default 'classic',
  lives_remaining int default 3,
  duration_seconds int default 0,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

-- Enable Row Level Security
alter table public.scores enable row level security;

-- Policy: users can insert their own scores
create policy "Users can insert their own scores"
on public.scores
for insert
with check (auth.uid() = user_id);

-- Policy: users can view their own scores
create policy "Users can view their own scores"
on public.scores
for select
using (auth.uid() = user_id);

-- Allow everyone to read leaderboard data
create policy "Leaderboard public read"
on public.scores
for select
using (true);

-- Create profile after sign up
create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, username)
  values (new.id, new.raw_user_meta_data->>'username');
  return new;
end;
$$;

-- Create the trigger
create trigger on_auth_user_created
after insert on auth.users
for each row
execute procedure public.handle_new_user();

-- Create leaderboard view
create view public.leaderboard as
select
  s.user_id,
  p.username,
  max(s.value) as top_score,
  max(s.lives_remaining) as best_lives,
  min(s.duration_seconds) as fastest_time
from public.scores s
join public.profiles p on p.id = s.user_id
group by s.user_id, p.username
order by top_score desc;

-- Enable public read access to the leaderboard view
alter view public.leaderboard owner to postgres;

grant select on public.leaderboard to anon;
grant select on public.leaderboard to authenticated;
