# fed.ialis.me — the guide to the fediverse

**WIP**

<img src="https://raw.githubusercontent.com/ialisme/fed.ialis.me/master/assets/images/header_outline.png" />

Content and sources are licensed in the public domain / [Unlicense](http://unlicense.org).

As the website is a work in progress right now we invite all repo collaborators to just work in `master` branch. Once
the site is done enough we'll work with feature branches and pull requests, but that's for another time.

Because the site needs custom code / plugins, it is not built by GitHub Pages. Instead it is built by
[travis-ci](https://travis-ci.org) and then committed back to the `gh-pages` branch. All commits done on `master` are
published two minutes after being committed.


## Contributing

This is **jekyll** static website. Unlink most Jekyll sites, this one is internationalized, which makes things a little
bit complicated:

* Most content is in the **_i18n/** folder ;
  * for most pages it's just **_i18n/{lang}/{page}/content.md**
  * some pages or small descriptions are in separated files in **_i18n/{lang}/{page}/{part}.md** (e.g.
      `_i18n/en/apps/mastodon.md` for the small description of Mastodon.
* Global translations are in **_i18n/{lang}.yml**.

Pages based on lists are mostly defined in **_data/** folder (e.g. the apps lists are in `_data/apps.yml`).

Creating new pages is a little bit more complicated and a guide will be written for that ASAP.

Most of the "lists" parts (tools, apps, servers) are mostly dynamic and seeded from the YML files in `_data`. Tools are not implemented yet so please don't
work on that parts for now.

### /instances/

Not done yet but the main idea is to provide a **curated** list of instances. I'm still thinking on the criterias (less
than X users; great connection with the wider fediverse; not strict moderation). That's the list that will be presented
for users but we will definitely link to non-curated lists such as instances.mastodon.xyz.

## Contact / Organization

The website was started by the soc.ialis.me collective ; but we're more than open to contributions from **everyone**.

Ping either [@admin@soc.ialis.me](https://soc.ialis.me/@admin) or come by to IRC at `irc.random.sh (SSL) 6667 #random`
for IM chat.

---
fed.ialis.me by the soc.ialis.me collective and contributors.

Site source and content is unlicensed in the public domain.

