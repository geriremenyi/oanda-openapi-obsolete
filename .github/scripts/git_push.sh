#!/bin/sh

# Parameter to named parameter
git_commit_message=`[ ! -z "$1" ] && echo "$1" || [ ! -z "$GIT_PUSH_COMMIT_MESSAGE" ] && echo "$GIT_PUSH_COMMIT_MESSAGE" || echo ""`
git_author_email=`[ ! -z "$2" ] && echo "$2" || [ ! -z "$GIT_PUSH_AUTHOR_EMAIL" ] && echo "$GIT_PUSH_AUTHOR_EMAIL" || echo ""`
git_author_name=`[ ! -z "$3" ] && echo "$3" || [ ! -z "$GIT_PUSH_AUTHOR_NAME" ] && echo "$GIT_PUSH_AUTHOR_NAME" || echo ""`

# Check that all parameters are given
if [ -z "$git_commit_message" ]; then
    echo "::error file=git_push.sh::The commit message is not given. Either pass the commit message as the first parameter to the script or set the GIT_PUSH_COMMIT_MESSAGE environment variable."
    exit 1
fi
if [ -z "$git_author_email" ]; then
    echo "::error file=git_push.sh::The author email is not given. Either pass the author email as the second parameter to the script or set the GIT_PUSH_AUTHOR_EMAIL environment variable."
    exit 1
fi
if [ -z "$git_author_name" ]; then
    echo "::error file=git_push.sh::The author name is not given. Either pass the author name as the third parameter to the script or set the GIT_PUSH_AUTHOR_NAME environment variable."
    exit 1
fi

# Check that the current working directory is a root directory of a git repo
if [ ! -d .git ]; then
    echo "::error file=git_push.sh::Current working directory is not a root directory of a git repository."
    exit 1
fi

# Check that the current working directory has a remote set
git_remote=`git remote`
if [ -z "$git_remote" ]; then
    echo "::error file=git_push.sh::No remote repository found for the git repository."
    exit 1
fi

# Set author
echo "Setting the git author email to '***'."
git config --global user.email "$git_author_email"
echo "Setting the git author name to '***'."
git config --global user.name "$git_author_name"

# Add all changes
echo "Adding all changes from the root."
git add .

# Commit all changes
echo "Commiting the change with the commit message: '$git_commit_message'."
git commit -m "$git_commit_message"

# Push all changes
echo "Pushing all changes."
git push 