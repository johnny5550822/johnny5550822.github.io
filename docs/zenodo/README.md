# Archiving a post on Zenodo (DOI)

> **Status (2026-11-21):** DOI **10.5281/zenodo.24435628** is reserved for the LittleStar Pokémon post and is already in the post (front matter, `citation_doi`, BibTeX). The final PDF is `littlestar-pokemon-ai-blog-v1.0.0.pdf` in this folder. Steps 3–5 below are done; what remains is steps 6–7, which Johnny does on Zenodo.

A Zenodo DOI gives a post a permanent, citable identifier. Google Scholar and Semantic Scholar track citations to DOIs much
better than to bare URLs. `docs/` is excluded from the build, so nothing here is published on the site.

**Files for the LittleStar Pokémon post**
- `pokemon-ai-on-a-macbook.metadata.json`: all record fields, in the Zenodo deposit-API format. Each field maps 1:1 to the web form.
- `../../scripts/print-post-pdf.sh`: prints the rendered post to PDF, which is the file you upload.

## Steps

1. **Publish the post first.**
   - Merge the post PR and this PR, then make the site live (`docs/PUBLISHING.md`).
   - The record links back to `https://johnny5550822.github.io/blog/pokemon-ai-on-a-macbook/`, so that URL should resolve.
2. **Make a Zenodo account** at <https://zenodo.org>. Signing in with GitHub or ORCID works.
   - If you have an ORCID iD, add it to the creator. In the JSON: `{"name": "Ho, King Chung (Johnny)", "orcid": "0000-…"}`.
3. **Start a new upload and reserve the DOI.** Zenodo → **New upload** → **Reserve DOI**. You get `10.5281/zenodo.NNNNNNN` before anything is published.
4. **Put the DOI on the site** before printing the PDF, so the archived copy carries it:
   - Add `doi: 10.5281/zenodo.NNNNNNN` to the post's front matter. The post header then shows a DOI link, and a `citation_doi` meta tag is emitted for Google Scholar.
   - In the post's BibTeX block, add `doi = {10.5281/zenodo.NNNNNNN},`.
   - Merge and deploy.
5. **Print the PDF:** `scripts/print-post-pdf.sh /blog/pokemon-ai-on-a-macbook/ littlestar-pokemon-ai-blog-v1.0.0.pdf`
6. **Fill in the form** from the JSON, then upload the PDF:
   - Resource type: Publication → Other.
   - Title, creator, description, version `1.0.0`, language English, publication date, keywords.
   - License: **CC BY 4.0**.
   - Related identifier: the post URL, relation *is identical to*.
   - Additional notes: the third-party image note.
7. **Publish.**
   - The DOI resolves within minutes, and the record is permanent.
   - Files cannot be changed afterwards. For a revised post, use **New version** on the record (for example 1.1.0). Zenodo then also gives a "concept DOI" that always points to the latest version.

**License choice.** CC BY 4.0 covers the text and your own figures. The Pokémon Showdown screenshots and Pokémon sprites are
third-party material, so the notes field excludes them. If you prefer a different license (for example CC BY-NC 4.0), change
`license` before publishing.
