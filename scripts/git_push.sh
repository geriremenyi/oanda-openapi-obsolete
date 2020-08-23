#!/bin/sh

# Parameter to named parameter
git_commit_message=$1

# Check that all parameters are given
if [ "$git_commit_message" = "" ]; then
    echo "[ERROR] No commit message given. Please pass a commit message to the script as the first parameter."
    exit 1
fi

# Check that the current working directory is a root directory of a git repo
if ! [ -d .git ]; then
    echo "[ERROR] Current working directory is not a root directory of a git repository."
    exit 1
fi

# Check that the current working directory has a remote set
git_remote=`git remote`
if [ "$git_remote" = "" ]; then
    echo "[ERROR] No remote repository found for the git repository."
    exit 1
fi

# Add all changes
git add .

# Commit all changes
git commit -m "$git_commit_message"

# Push all changes
git_branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$git_branch"