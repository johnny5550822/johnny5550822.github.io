# johnny5550822.github.io

Source for King Chung (Johnny) Ho's research homepage and technical blog. Built with Jekyll 4 and deployed to GitHub Pages by GitHub Actions.

## Writing a post

Add a Markdown file to `_posts/` named `YYYY-MM-DD-short-title.md`:

```md
---
title: "My research note"
description: "One-line summary (used on social cards and in search results)."
tags: [Reinforcement learning]
---

Markdown goes here.
```

The post appears on `/blog/`, in "Recent writing" on the homepage, in `feed.xml` and in `sitemap.xml`. Its URL is `/blog/short-title/`.

`docs/markdown-style-guide.md` (reference only, never built) shows every supported element: code with syntax highlighting, `$$…$$` equations (rendered by KaTeX, which loads only on pages that contain math), tables, figures with captions, footnotes and task lists. Unfinished posts can live in `_drafts/`; they are never published. Put images in `assets/img/posts/`.

## Editing the homepage

- Intro, quote and photo: `index.html` (photo: `assets/img/profile.webp`)
- Experience timeline: `_data/experience.yml` (logos in `assets/img/logos/`, sources in `SOURCES.md`)
- Selected publications: `_data/publications.yml` (thumbnails in `assets/img/pubs/`, 480×360 WebP; respect each article's licence, NC-ND figures must not be cropped)
- Links, name and site URL: `_config.yml`
- Styles: `assets/css/site.css` (colours are CSS variables at the top; dark mode is `:root[data-theme="dark"]`)

## Local preview

Requires Ruby 3.x or newer (`brew install ruby`).

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --livereload            # http://localhost:4000
bundle exec jekyll serve --livereload --drafts   # also renders _drafts/, if any (local only)
```

Production check (what CI runs):

```bash
JEKYLL_ENV=production bundle exec jekyll build
bundle exec htmlproofer _site --disable-external
```

## Deployment

Going public for the first time: follow `docs/PUBLISHING.md`.


`.github/workflows/pages.yml` builds the site and checks its HTML and internal links on every pull request, then uploads the built site as a downloadable `site-preview` artifact. On a push to `master` it deploys to GitHub Pages.

One-time setup after merging: **Settings → Pages → Build and deployment → Source: GitHub Actions**. Pages on a **private** repository needs a paid GitHub plan, and the published site is public either way.

## Custom domain (king.ai), when ready

1. Set `url: "https://king.ai"` in `_config.yml`. Canonical URLs, the feed and the sitemap all follow it.
2. Settings → Pages → Custom domain: `king.ai`. With the Actions source, no `CNAME` file is needed.
3. At the registrar, add apex `A` records to 185.199.108.153, .109.153, .110.153 and .111.153 (and/or the AAAA equivalents), plus `www CNAME johnny5550822.github.io`. Check GitHub's current docs before doing this.
4. Verify the domain under the account's Pages settings, then enable **Enforce HTTPS**.

## Notes

- `public/` holds legacy files, including an old résumé. It is excluded from the build but remains in the Git history.
- The previous Poole/Hyde site is preserved on `master` (and in its history) until this redesign is merged.
