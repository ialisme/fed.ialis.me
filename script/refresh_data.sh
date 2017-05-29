#!/usr/bin/env sh

echo "Downloading _data/instances_mastodon.json from instances.mastodon.xyz..."

curl -s -S https://instances.mastodon.xyz/instances.json > _data/instances_mastodon.json


