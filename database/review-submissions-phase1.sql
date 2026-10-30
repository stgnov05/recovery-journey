-- Recovery Journey: phase 1, moderated review submissions
-- Run in Supabase SQL Editor as the project database owner.
-- Do not use the service_role key in GitHub Pages.
begin;
alter table public.treatment_reviews
  add column if not exists reviewer_id uuid references auth.users(id) on delete set null;
create index if not exists treatment_reviews_center_status_idx
  on public.treatment_reviews(center_id, status, created_at desc);
create index if not exists treatment_reviews_reviewer_idx
  on public.treatment_reviews(reviewer_id);
alter table public.treatment_centers enable row level security;
alter table public.treatment_reviews enable row level security;
-- Explicit least-privilege grants. RLS alone does not grant SQL privileges.
grant usage on schema public to anon, authenticated;
grant select on public.treatment_centers to anon, authenticated;
grant select on public.treatment_reviews to anon, authenticated;
revoke insert, update, delete on public.treatment_centers from anon, authenticated;
revoke insert, update, delete on public.treatment_reviews from anon;
revoke update, delete on public.treatment_reviews from authenticated;
-- Limit signed-in reviewers to the fields they may submit.
revoke insert on public.treatment_reviews from authenticated;
grant insert (center_id, display_name, rating, review_text, treatment_period, reviewer_id)
  on public.treatment_reviews to authenticated;
drop policy if exists "Authenticated users submit pending reviews" on public.treatment_reviews;
create policy "Authenticated users submit pending reviews"
  on public.treatment_reviews for insert to authenticated
  with check (reviewer_id = (select auth.uid()) and status = 'pending');
-- Existing policy restricts public reads to approved reviews.
-- Explicitly prevent status manipulation through insert or direct client updates.
create or replace function public.enforce_review_submission()
returns trigger language plpgsql set search_path = ''
as $$
begin
  if current_user in ('authenticated', 'anon') then
    new.status := 'pending';
    new.reviewer_id := (select auth.uid());
  end if;
  return new;
end;
$$;
drop trigger if exists enforce_review_submission_trigger on public.treatment_reviews;
create trigger enforce_review_submission_trigger
  before insert on public.treatment_reviews
  for each row execute function public.enforce_review_submission();
commit;
-- After applying: test anon SELECT and authenticated INSERT in a test account.
-- Moderation: approve/reject only from the Supabase dashboard (trusted admin).
-- Before public launch: configure CAPTCHA, abuse monitoring, and moderation procedures.
