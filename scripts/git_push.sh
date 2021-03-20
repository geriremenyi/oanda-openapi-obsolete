#!/bin/sh

# Parameter to named parameter
git_commit_message=$1
git_author_email=$2
git_author_name=$3

# Check that all parameters are given
if [ "$git_commit_message" = "" ]; then
    if [ -z "$GIT_PUSH_COMMIT_MESSAGE" ]; then
        echo "[ERROR] No commit message given. Please pass a commit message to the script as the first parameter."
        exit 1
    else
        git_commit_message="$GIT_PUSH_COMMIT_MESSAGE"
    fi
fi

if [ "$git_author_email" = "" ]; then
    if [ -z "$GIT_PUSH_AUTHOR_EMAIL" ]; then
        echo "[ERROR] No author email given. Please pass an author email address to the script as the second parameter."
        exit 1
    else
        git_author_email="$GIT_PUSH_AUTHOR_EMAIL"
    fi
fi

if [ "$git_author_name" = "" ]; then
    if [ -z "$GIT_PUSH_AUTHOR_NAME" ]; then
        echo "[ERROR] No author name given. Please pass an author name to the script as the third parameter."
        exit 1
    else
        git_author_name="$GIT_PUSH_AUTHOR_NAME"
    fi
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

# Set author
git config --global user.email "$git_author_email"
git config --global user.name "$git_author_name"

# Add all changes
git add .

# Commit all changes
git commit -m "$git_commit_message"

# Push all changes
git_branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$git_branch"