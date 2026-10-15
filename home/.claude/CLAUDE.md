# Machine-wide instructions

Applies everywhere. Repo-level `CLAUDE.md` files load after this and win on conflict.

## Writing: write for people

Write technical prose for humans, not for length. Applies to PR titles and descriptions, commit messages, docs, ADRs, and code comments — not to marketing/page copy.

- **Compress.** “Bumped dependencies”, not “Performed a scheduled dependency refresh as part of ongoing maintenance practices. Minor and patch-level version bumps were applied across the dependency graph…” Same information, one read.
- **Cut padding.** Delete phrases that carry no fact: “as part of ongoing efforts”, “in order to ensure”, “it is worth noting that”, “comprehensive”, “robust”.
- **Say the plain thing.** State the concept directly instead of in inflated jargon; the underlying idea is usually small.
- **Don’t pad over a gap.** If it won’t compress, that usually means the problem isn’t understood well enough yet. Say the part that is understood and name the part that isn’t.

Brevity in a PR description isn’t laziness — it’s evidence the change was understood. Source: Vicki Boykis, [“Write for People”](https://newsletter.vickiboykis.com/archive/write-for-people/).

## PR comments posted by an agent

When asked to post a comment on a PR, open it with one byline, then the content:

> Posted by Claude (<model name>), on behalf of @<GitHub handle>, answering: <the question or task, restated in one line>.

Readers see at a glance that an agent wrote it, who it speaks for, and what prompted it.
