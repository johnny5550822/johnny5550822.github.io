# Johnny's personal website

This is the source for **King Chung (Johnny) Ho's** minimalist research homepage and technical blog.

**Status:** redesign drafted on `site/modern-research-redesign` for review. The original site is preserved on `master` until this branch is merged.

## Where everything lives

- `index.html`: homepage (intro, timeline, selected publications, recent writing)
- `blog/index.html`: chronological list of writing
- `_posts/YYYY-MM-DD-title.md`: blog articles (Markdown)
- `_data/timeline.yml`: homepage career/research timeline
- `_data/publications.yml`: curated papers
- `_layouts/`: common site shell and article template
- `assets/css/site.css`: full responsive design, including dark mode
- `_config.yml`: Jekyll metadata and canonical URL

The project deliberately stays with **Jekyll**, since this existing GitHub Pages repository was already configured for it. No JS build chain, database, CMS, or paid hosting is required.

## Writing a new post

Create `_posts/2026-11-16-my-research-note.md` with:

```md
---
title: "My research note"
date: 2026-11-16
description: "A one-line summary"
site_post: true
tags:
  - Reinforcement Learning
---

Your content in Markdown goes here. Use fenced code blocks and Markdown tables for technical posts.
```

Only posts with `site_post: true` are listed. The previous 2016 Jekyll example post is excluded from the build via `_config.yml`.

## Local preview

With Ruby/Jekyll installed:

```bash
gem install bundler jekyll
jekyll serve --livereload
```

Then open http://localhost:4000/. If deploying using GitHub Pages, prefer its pinned Jekyll environment for parity.

## Publishing (after approving the redesign)

1. Merge the review PR into `master`.
2. Check your GitHub plan and Pages eligibility. GitHub Pages is included for public repositories on Free; private repository Pages requires an eligible paid GitHub plan.
3. In **Settings → Pages**, select **Deploy from a branch**, source `master` / `(root)`, unless you already have another publishing configuration to preserve.
4. The initial canonical URL is https://johnny5550822.github.io/ .
5. When `king.ai` is purchased, configure it under **Settings → Pages → Custom domain**, add the DNS records GitHub instructs, and update `url` in `_config.yml` to `https://king.ai`. Do not add a CNAME file before domain setup.

**Privacy note:** This repository contains legacy assets including an old `public/resume.pdf`. The new site excludes the `public/` folder from Jekyll publishing, but files and Git history would still be visible if the repository is made public. Audit or move legacy material before changing visibility.

## Research & paper attribution

Selected publication titles and links are stored as data so they can be refined without touching the UI. Citations link directly to Nature Portfolio publisher pages.

## Scope

Only `Hello world` is a new public-facing post in this draft. Pokémon research posts remain future writing; no work-in-progress results or unpublished project internals are automatically published.
