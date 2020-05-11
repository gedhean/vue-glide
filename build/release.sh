#!/bin/bash

set -e
CURRENT=$(node -p "require('./package.json').version")
echo "Current $CURRENT"

VERSION=$(npm version patch)

read -p "Releasing $VERSION - are you sure? (y/n)" -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
  echo "Enter release version: "
  read VERSION

  read -p "Releasing $VERSION - are you sure? (y/n)" -n 1 -r
  echo
then
  npm run build:lib
  npm version $VERSION -m "Release $VERSION"
  git push origin master
  npm publish --access public
fi