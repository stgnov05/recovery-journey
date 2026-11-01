# Recovery Journey — platform development plan

## Principles
- Recovery support first; no medical diagnosis or emergency response claims.
- Accessible, mobile-first, antique-silver and coastal-blue visual identity.
- No fabricated reviews, endorsements, treatment outcomes, or clinical quality claims.
- Collect the least personal data possible. Do not request diagnoses, patient records, or other patients' information.
- All community-generated content must have moderation and abuse reporting.
- Never publish Supabase secret/service_role keys or private credentials in GitHub.

## Phase 1 — Trustworthy treatment reviews (in progress)
1. [x] Public treatment-center directory backed by Supabase.
2. [x] Public reading of approved reviews only.
3. [x] Draft least-privilege SQL migration in `database/review-submissions-phase1.sql`.
4. [ ] Owner reviews and runs SQL in Supabase; test authenticated submission and anonymous visibility.
5. [ ] Configure Supabase Auth email verification, CAPTCHA, rate limiting and anti-spam controls.
6. [ ] Build accessible submission form requiring sign-in, consent, and clear review guidelines.
7. [ ] Document moderation queue, abuse reports, takedown, appeals, and privacy/deletion processes.
8. [ ] Test on iPhone and desktop before enabling public submission.

## Phase 2 — Recovery community
- Start with moderated story submissions and opt-in display names.
- Do not add public direct messaging or unmoderated chat until robust safety processes exist.
- Provide reporting, blocking, and content removal paths.

## Phase 3 — Learning center
- Evidence-informed educational articles and plain-language recovery tools.
- Clear source attribution, date of review, medical disclaimers and emergency resources.
- Separate personal faith reflections from universal treatment guidance.

## Phase 4 — Find support
- Searchable AA/NA and other support meeting links from official directories.
- Sober living and treatment information with source links and last-checked dates.
- Avoid presenting stale vacancies, prices, or availability as current.

## Phase 5 — Polish, accessibility, and launch
- Shared header/footer, compact Home + Directory, silver color system.
- Keyboard and screen-reader checks, WCAG contrast, mobile responsiveness.
- SEO, sitemap, broken links, privacy policy, performance and error monitoring.
- Launch only after security, moderation, and usability checks.

## Operational rule
Never treat an SQL migration committed to GitHub as already applied to Supabase. An administrator must run and verify it separately.
