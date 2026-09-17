# How to Set Up SwitchyOmega in Chrome or Firefox

<p align="center">
  <a href="https://www.proxy-cheap.com/">
    <img width="1661" height="931" alt="image" src="https://github.com/user-attachments/assets/13a8db72-5594-4f12-9258-8f832fee76f5" />

  </a>
</p>

A field tested setup guide for [SwitchyOmega](https://www.proxy-cheap.com/), the profile based proxy switcher for Chrome and Firefox. It covers installing the extension in both browsers, building a proxy profile, writing auto switch rules that change proxies by domain automatically, and a difference between the two browsers that most guides skip entirely: Firefox does not allow raw PAC script profiles, so the setup path is not identical on both sides.

The examples below use Proxy-Cheap as the reference proxy provider, since the profile fields (host, port, protocol, username and password) map directly onto values from its dashboard. The steps are standard SwitchyOmega configuration and work with any provider that gives you a host, a port, and credentials.

## Table of contents

- [What SwitchyOmega actually does](#what-switchyomega-actually-does)
- [Is SwitchyOmega still maintained](#is-switchyomega-still-maintained)
- [Installing in Chrome](#installing-in-chrome)
- [Installing in Firefox](#installing-in-firefox)
- [Creating a proxy profile](#creating-a-proxy-profile)
- [Auto switch rules: proxies by domain](#auto-switch-rules-proxies-by-domain)
- [The PAC limit on Firefox](#the-pac-limit-on-firefox)
- [Testing your setup](#testing-your-setup)
- [Picking a Proxy-Cheap product for a SwitchyOmega workflow](#picking-a-proxy-cheap-product-for-a-switchyomega-workflow)
- [Common issues and fixes](#common-issues-and-fixes)
- [FAQ](#faq)

---

## What SwitchyOmega actually does

SwitchyOmega is a browser extension that stores several proxy profiles and lets you switch between them from a toolbar icon, instead of opening your operating system's network settings every time. Each profile holds one proxy configuration: a protocol, a host, a port, and optional credentials. You can also build a rule based profile that reads the domain of the site you are visiting and picks a different underlying profile automatically, with no manual switching at all.

That combination, saved profiles plus automatic rule matching, is the entire reason people reach for it over typing proxy settings into the browser directly. Typical users are QA engineers testing region specific behavior, developers debugging API calls against different backends, and researchers who need one browser tab on a direct connection while another routes through a specific proxy.

## Is SwitchyOmega still maintained

Worth knowing before you install it. The project's own GitHub repository, [FelisCatus/SwitchyOmega](https://github.com/FelisCatus/SwitchyOmega), describes itself as no longer actively maintained, though it still carries over 22,000 stars and the last code changes landed in late 2024. The extension listings on both the Chrome Web Store and Mozilla's Firefox extension store are still live, and the Firefox listing alone shows close to 12,000 daily active users, so it is far from abandoned in practice.

What this means for you: core profile switching and rule based switching work as documented below. If you hit an edge case on a very recent browser build, check the project's issue tracker before assuming your own configuration is wrong.

## Installing in Chrome

1. Open the [SwitchyOmega listing on the Chrome Web Store](https://chromewebstore.google.com/detail/switchyomega/padekgcemlokbadohgkifijomclgjgif).
2. Click **Add to Chrome**, then confirm in the permissions prompt.
3. Once installed, click the puzzle piece icon in the toolbar and pin SwitchyOmega so it stays visible.
4. Click the SwitchyOmega icon. The options page opens on first launch.

Chrome is the primary platform for this extension. Every feature described in this guide, including raw PAC script profiles, works here.

## Installing in Firefox

1. Open the [Proxy SwitchyOmega listing on Mozilla's extension store](https://addons.mozilla.org/en-US/firefox/addon/switchyomega/).
2. Click **Add to Firefox**, then confirm the permission prompt.
3. Click the extension icon in the toolbar to open the options page.

The Firefox build is a separate port of the same codebase, and one capability is missing on this side. See [The PAC limit on Firefox](#the-pac-limit-on-firefox) before you build anything beyond a simple profile.

## Creating a proxy profile

The steps are the same in both browsers once the options page is open.

1. Click **New profile**.
2. Give it a name (for example `proxy-cheap-us`) and choose **Proxy Profile** as the type.
3. Select the protocol: **HTTP** for a standard web proxy, **SOCKS5** if your plan requires it or you need to route non browser traffic through the same tunnel.
4. Enter the **Server** address and **Port**. For a Proxy-Cheap rotating residential plan this is the gateway host from your dashboard, for example `proxy-us.proxy-cheap.com` on port `5959`. For static residential, ISP, datacenter, or static mobile plans, use the dedicated IP and port shown against that specific proxy in the dashboard.
5. If your plan authenticates by username and password, expand **Authentication** and fill both fields. Rotating residential proxies authenticate this way only. If you are on a static plan and prefer not to store credentials in the browser, register the machine's outbound IP as an allowed address in the dashboard instead and leave these fields blank.
6. Click **Apply changes** at the top of the page.
7. Click the SwitchyOmega toolbar icon and select the profile you just created to activate it.

## Auto switch rules: proxies by domain

Instead of switching profiles by hand, SwitchyOmega can pick one automatically based on the site you are on.

1. Create a **New profile** and choose **Switch Profile** as the type.
2. Under **Switch rules**, add a condition. A common one is **Host wildcard**, where you enter a pattern like `*.co.uk` or `*.example.com`.
3. For each condition, assign which existing profile it should route through, for example your UK residential profile for `*.co.uk` and a direct connection for internal or local domains.
4. Set a **Default** profile for anything that matches none of the rules.
5. Click **Apply changes**, then activate the switch profile from the toolbar the same way as a regular one.

From that point on, opening a `.co.uk` site routes through the UK profile automatically, and everything else follows the default, with no manual switching per tab.

## The PAC limit on Firefox

This is the detail that catches people who set up a profile on Chrome first and then try to reuse the same configuration on Firefox.

SwitchyOmega supports a second automation type, a **PAC Profile**, where you paste a raw proxy auto config script instead of building rules through the UI. This works in Chrome. It does not work in Firefox, because Mozilla's extension review policy for the Firefox store does not permit that capability, a restriction documented directly in the project's own repository.

The practical fix is straightforward: use a **Switch Profile** with UI built rules (as in the section above) instead of a **PAC Profile** on Firefox. The rule based switch profile covers the same domain matching logic that most PAC scripts are written for, just through a form instead of a script, and it works identically on both browsers.

## Testing your setup

Confirm the browser is actually routing through the proxy before you rely on it for anything.

With your SwitchyOmega profile active, visit an IP lookup page such as `ipinfo.io` or `whatismyipaddress.com`. The address shown should match your proxy's exit location, not your real connection.

For a faster check outside the browser, the same credentials work from a terminal:

```bash
curl -x proxy-us.proxy-cheap.com:5959 -U USERNAME:PASSWORD https://api.ipify.org; echo
```

If that returns a proxy IP but the browser still shows your real one, the extension is not active. Reopen the toolbar icon and confirm the correct profile is selected, not just saved. Full runnable examples in cURL, Python, and Node are in [examples/](examples/).

## Picking a Proxy-Cheap product for a SwitchyOmega workflow

SwitchyOmega profiles are protocol agnostic, so the right underlying product depends on what the profile needs to do, not on the extension itself.

| If your profile needs | Use | Why |
|---|---|---|
| A new IP on every request, for scale | [Rotating residential proxies](https://www.proxy-cheap.com/services/rotating-residential-proxies) | Gateway based, one profile handles rotation server side |
| A fixed IP for a long session or account bound task | [Static residential (ISP) proxies](https://www.proxy-cheap.com/services/isp-proxies) | One dedicated IP per profile, consistent across the session |
| Fast reads of open, public content | [Datacenter proxies](https://www.proxy-cheap.com/services/datacenter-proxies) | Lowest cost per IP, no residential identity needed |
| Carrier level trust for mobile only platforms | [Mobile proxies](https://www.proxy-cheap.com/services/mobile-proxies) | Real 3G, 4G, and 5G carrier IPs |

A common pattern is two profiles in an auto switch rule list: a rotating residential profile as the default, and a static residential profile pinned to a specific domain that needs one consistent identity across a session.

## Common issues and fixes

- **Profile saves but nothing changes.** Applying changes on the options page does not activate a profile. Click the toolbar icon and select it explicitly.
- **407 error or authentication failure.** Username or password is wrong, or you are on a rotating residential plan and tried to use IP whitelist auth, which that product line does not support.
- **Connection times out.** Wrong host or port, or (on a static plan using whitelist auth) your current outbound IP is not registered in the dashboard yet.
- **Switch rule never triggers.** Check the condition type. A host wildcard like `*.example.com` matches subdomains of `example.com`, not `example.com` itself unless you add both patterns.
- **PAC profile does nothing on Firefox.** Expected. See [The PAC limit on Firefox](#the-pac-limit-on-firefox) and rebuild it as a switch profile instead.
- **Works in one browser, not the other.** SwitchyOmega profiles do not sync between Chrome and Firefox. Each browser needs its own extension install and its own profiles, built separately.

## FAQ

### What is SwitchyOmega used for?

Storing multiple proxy configurations as named profiles and switching between them from the browser toolbar, either by hand or automatically through domain based rules, without opening operating system network settings.

### Does SwitchyOmega work on both Chrome and Firefox?

Yes, as separate installs with separate profiles. Most features match, with one exception: raw PAC script profiles work in Chrome but not in Firefox, where only the rule built switch profile type is available.

### Is SwitchyOmega free?

Yes, the extension itself is free in both browser stores. You still need a proxy service with its own plan to give the profile something to connect to.

### Can I use SwitchyOmega with SOCKS5?

Yes. The protocol dropdown when creating a profile includes SOCKS5 alongside HTTP, matching the protocols most proxy providers support.

### Why does my proxy work in cURL but not in the browser with SwitchyOmega installed?

Usually because the profile is saved but not selected as active. A cURL test does not go through the extension at all, so it confirms the proxy credentials are correct even when the browser side is misconfigured.

### Can I import or export my SwitchyOmega profiles?

Yes. The options page has an export function that saves all profiles to a file, and a matching import function, useful for moving a configuration between machines or backing it up before a browser update.

### Does SwitchyOmega work with IP whitelist authentication?

Yes, for any Proxy-Cheap product line that supports whitelist auth (static residential, datacenter, static mobile, and unlimited bandwidth plans). Register your outbound IP in the dashboard and leave the profile's username and password fields blank.

## Further reading

- [Proxy-Cheap Chrome proxy extension](https://www.proxy-cheap.com/chrome-proxy-extension)
- [Proxy-Cheap support knowledge base](https://support.proxy-cheap.com)
- [SwitchyOmega source and issue tracker](https://github.com/FelisCatus/SwitchyOmega)

## License

MIT

---

*This is a personal documentation repo, not an official Proxy-Cheap or SwitchyOmega project. SwitchyOmega is an independent, community maintained browser extension. Steps and code use standard proxy configuration and work with any provider that gives you a host, a port, and credentials. Verify current pricing, gateway addresses, and product availability on the live product page before relying on them.*
