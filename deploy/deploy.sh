#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

THISPATH=`dirname $0`
SOURCE_BRANCH="master"
TARGET_REPO="git@github.com:awesomedata/awesome-public-datasets.git"

function doCompile {
    pip install -r $THISPATH/requirements.txt
    python $THISPATH/render.py
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

# Run our compile script
doCompile

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy/deploy_key.enc -out deploy/deploy_key -d
chmod 600 deploy/deploy_key
eval `ssh-agent -s`
ssh-add deploy/deploy_key

# Clone the target repo into target_repo
git clone --depth=50 --branch=master $TARGET_REPO target_repo

# Set useful signature info.
cd target_repo
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

# Update generated data file
cp ../deploy/index.rst README.rst

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if git diff --quiet; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add README.rst
git commit -m "Update README from APD2: ${SHA}"

# Now that we're all set up, we can push.
git push origin master
