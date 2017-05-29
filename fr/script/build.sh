#!/usr/bin/env bash

echo "--- Running script/refresh_data.sh"
./script/refresh_data.sh

echo "--- Running script/directory_users.rb"
bundle exec ruby ./script/directory_users.rb

echo "--- Running Jekyll"
bundle exec jekyll build

