# Publishing checklist

How to take this repository from private to a public GitHub Pages site on **GitHub Free**.
`docs/` is excluded from the Jekyll build, so this file is never published as a page.

## 0. Already done (2026-11-17/18)

- Audit of all files and the full Git history (all branches): no passwords, tokens, keys, `.env` files,
  deploy keys, webhooks, Actions secrets or variables. Sole collaborator: the owner.
- Personal data found and removed from **all history** with `git filter-repo` (old résumé PDFs and a phone
  number in old `_config.yml` commits); cleaned branches were force-pushed.
- Stale 2018 Pages deployment records (which referenced pre-rewrite commits) deleted.
- Remaining, intentionally public: the Gmail address and name used on the site. Low-risk leftovers in old
  history: a former university email address and an old Google Analytics property ID.

## 1. Purge GitHub's copies of the old commits (before going public)

Rewriting history does not delete the old commits from GitHub immediately: they stay reachable by SHA
(and through PR #1's force-push events) until GitHub garbage-collects them. Pick one:

- **Keep this repo:** open a request at <https://support.github.com/contact> asking GitHub to purge cached
  views and unreachable commits after a history rewrite. The commit list is kept locally, outside the repo,
  in `~/workspace/site-history-purge-request.txt`. Wait for confirmation before step 2.
- **Fastest, guaranteed:** recreate the repository. Delete it on GitHub, create a new empty
  `johnny5550822.github.io`, push the cleaned branches (`git push origin master site/modern-research-redesign`)
  and reopen the PR. PR #1's discussion and old CI runs are lost.

## 2. Make the repository public

Settings → General → Danger Zone → **Change visibility** → Public
(or `gh repo edit --visibility public --accept-visibility-change-consequences`).

## 3. Protect `master` (immediately after step 2)

Rulesets are free for public repositories. Apply the ruleset in `.github/rulesets/master-protection.json`:

```bash
scripts/apply-branch-protection.sh
```

It enforces on the default branch:

| Rule | Effect |
|---|---|
| Require a pull request | No direct pushes to `master`; 0 approvals needed (single maintainer) |
| Required status check `build` | The CI build + HTML/link check must pass before merging |
| Block force pushes | History on `master` cannot be rewritten |
| Restrict deletions | `master` cannot be deleted |

No bypass actors are configured. To change a rule later: edit the JSON and re-run the script, or use
Settings → Rules → Rulesets.

## 4. Enable GitHub Pages

Settings → Pages → Build and deployment → **Source: GitHub Actions**
(or `gh api -X POST repos/johnny5550822/johnny5550822.github.io/pages -f build_type=workflow`).
The `github-pages` environment already restricts deployments to `master`.

## 5. Merge and deploy

1. PR #1 → **Ready for review** → wait for the `build` check → **Merge**.
2. Actions → workflow **Site** on `master`: `build` (Jekyll build, draft-leak check, html-proofer, Pages
   artifact) then `deploy` (`actions/deploy-pages`).
3. Check <https://johnny5550822.github.io>: home, `/blog/`, a post, `/feed.xml`, `/sitemap.xml`, `/404.html`,
   light/dark toggle, phone layout.

## 6. Later: custom domain

See the README section "Custom domain (king.ai)".

## How the workflow behaves

| Event | `build` | `deploy` |
|---|---|---|
| Pull request | Build + checks, uploads `site-preview` artifact | Skipped |
| Push to `master` | Build + checks, uploads Pages artifact | Deploys to GitHub Pages |
| Manual run on `master` | Same as push | Deploys |

PR builds cancel superseded runs; `master` deployments are never cancelled mid-flight.
