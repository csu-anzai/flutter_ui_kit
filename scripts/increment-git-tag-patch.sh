#!/bin/sh

#Update local tags
git fetch --tags

#Get the highest tag number
VERSION=`git describe --tags`
VERSION=${VERSION:-'0.0.0'}
echo $VERSION

#Get number parts
MAJOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
MINOR="${VERSION%%.*}"; VERSION="${VERSION#*.}"
PATCH="${VERSION%%.*}"; VERSION="${VERSION#*.}"

#Increase version
PATCH=$((PATCH+1))

#Get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT`

#Create new tag
NEW_TAG="$MAJOR.$MINOR.$PATCH"

echo "Updating to $NEW_TAG"
git tag $NEW_TAG
echo "Pushing new tag $NEW_TAG"
git push --tags
