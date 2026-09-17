# GitHub Repo Settings

Settings to apply when creating this repo on GitHub. Configured through the GitHub UI (or the publish helper), not committed as repo files.

## Repo name

`how-to-set-up-switchyomega-in-chrome-or-firefox`

## Description (max 350 chars)

SwitchyOmega setup for Chrome and Firefox: profiles, auto switch rules by domain, and the PAC limit that breaks configs on Firefox.

## Topics (GitHub tags)

Measured against GitHub's own topic pages (star barrier method, checked 2026-09-17):

- switchyomega (barrier: top competing repo has 1,400 stars, only 23 repos carry this topic)
- proxy-switcher (barrier: 35 stars for a top 3 spot)
- proxy-management (barrier: 39 stars for a top 3 spot)
- chrome-proxy (barrier: 1 star, only 4 repos carry this topic)
- firefox-proxy (barrier: none, zero repos currently carry this topic)
- proxy-settings (barrier: 37 stars for a top 3 spot)

Relevance only, no traffic data pulled:

- how-to-set-up-switchyomega-in-chrome-or-firefox
- omega-proxy
- proxy-omega
- proxy-configuration
- proxy-authentication
- proxy-profile
- auto-switch
- ip-rotation
- residential-proxy
- datacenter-proxy
- mobile-proxy
- isp-proxy
- qa-automation
- ad-verification

## Website link (in the repo "About" sidebar)

Leave empty. This is a third party documentation repo, not an official Proxy-Cheap or SwitchyOmega project. A direct product link in the About sidebar reads as promotional and undermines that framing. The README body links to the relevant product pages where they add context.

## Repo visibility

Public

## Features to enable

- Issues
- Discussions (optional)

## Features to disable

- Wiki, Projects, Sponsorships, Releases

## Branch protection

Default branch `main`. No protection rules needed for a single author docs repo.

## SEO relevant notes

- Repo name and description appear in Google's search snippet for the repo URL.
- README.md is what Google indexes for content ranking.
- The first paragraph is what GitHub uses for the OpenGraph preview card.
- Target keywords and measured US volume (Ahrefs, checked 2026-09-17): proxy switchyomega (2,700/mo, difficulty 0), switchyomega (1,800/mo, difficulty 43), omega proxy (600/mo, difficulty 43), proxy omega (350/mo, difficulty 36), switchyomega chrome (100/mo, difficulty 43), switchyomega firefox (50/mo, difficulty 28).
- Source article rephrased: https://www.proxy-cheap.com/blog/how-to-set-up-switchyomega-in-chrome-or-firefox

## Facts verified beyond the source article

The source blog post covers Chrome installation only and does not mention Firefox setup, the PAC script limitation on Firefox, or the project's maintenance status. All three were added here after direct verification:

- Chrome Web Store listing confirmed live (HTTP 200) at the extension id `padekgcemlokbadohgkifijomclgjgif`, referenced directly by the project's own README.
- Firefox listing confirmed live at addons.mozilla.org/en-US/firefox/addon/switchyomega/, slug `switchyomega`, roughly 12,000 average daily users, version 2.5.10, last shipped 2018-01-28.
- The upstream repository FelisCatus/SwitchyOmega on GitHub carries the repo description "No longer maintained, see pinned issues," 22,608 stars, and a last push of 2024-12-27 (checked live via the GitHub API, not the source article).
- The PAC profile restriction on Firefox ("PAC Profiles DO NOT work on Firefox due to AMO review policies") is stated verbatim in the upstream project's own README, not in the Proxy-Cheap source article.

## Suggested initial commit message

```
Initial commit: SwitchyOmega setup guide for Chrome and Firefox

Covers profile creation, auto switch rules by domain, the PAC script
limitation on Firefox, testing, and product picks for a SwitchyOmega
workflow, with working cURL, Python, and Node examples.
```

## After publishing

- Submit the GitHub URL to Google Search Console (if you have access) for faster indexing.
- Add the hero screenshot: drag the image into the README editor on GitHub and replace `REPLACE_WITH_SCREENSHOT_URL`.
- Share the repo once from a real account to kick GitHub's internal indexing.
