---
layout: page
title: titles.mastodon
namespace: mastodon
permalink: /mastodon/
permalink_fr: /mastodon/
category: servers
see_also:
  - mastodon_tools
  - mastodon_apps
---

<div class="level is-small">
  <p class="level-item">
            <figure class="image is-48x48">
              <img src="/assets/images/servers/{{ page.namespace }}.png">
            </figure>
  </p>

  <p class="level-item">
  <a href="{{ server.link }}" class="card-footer-item">www</a>
  </p>

<p class="level-item">
  {% if server.source %}
    <a href="{{ server.source }}" class="card-footer-item">
    {% t global.opensource %}
    </a>
  {% else %}
  Closed source
  {% endif %}
  </p>

</div>

{% tf servers/mastodon/content.md %}
