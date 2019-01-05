#!/usr/bin/env bash

# Exit if any subcommand fails.
set -e

echo "Started deploying"

git stash

# Checkout gh-pages branch.
if [ `git branch | grep gh-pages` ]
then
  git branch -D gh-pages
fi
git checkout -b gh-pages

# Build site.
bundle exec jekyll build

# Delete and move files.
find . -maxdepth 1 ! -name '.' ! -name '..' ! -name '_site' ! -name '.git' ! -name '.gitignore' -exec rm -rf {} \;
mv _site/* .
rm -R _site/

git add -fA
git commit --allow-empty -m "$(git log -1 --pretty=%B)"
git push origin gh-pages --force

# Move back to previous branch.
git checkout -
git submodule update

git stash pop

echo "Deployed Successfully!"

exit 0
