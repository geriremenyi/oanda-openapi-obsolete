#!/bin/sh

git_user_id=$1
git_repo_owner_id=$2
git_repo_id=$3
git_pat=$4
git_commit_message=$5
git_branch_name=$6
git_host=$7

if [ "$git_user_id" = "" ]; then
    git_user_id="GIT_USER_ID"
    echo "[INFO] No command line input provided. Set \$git_user_id to $git_user_id"
fi

if [ "$git_repo_owner_id" = "" ]; then
    git_repo_owner_id="GIT_REPO_OWNER_ID"
    echo "[INFO] No command line input provided. Set \$git_repo_owner_id to $git_repo_owner_id"
fi

if [ "$git_repo_id" = "" ]; then
    git_repo_id="GIT_REPO_ID"
    echo "[INFO] No command line input provided. Set \$git_repo_id to $git_repo_id"
fi

if [ "$git_pat" = "" ]; then
    git_pat="$GIT_TOKEN"
    echo "[INFO] No command line input provided. Set \$git_pat to $git_pat"
fi

if [ "$git_commit_message" = "" ]; then
    git_commit_message="Minor update"
    echo "[INFO] No command line input provided. Set \$git_commit_message to $git_commit_message"
fi

if [ "$git_branch_name" = "" ]; then
    git_branch_name="master"
    echo "[INFO] No command line input provided. Set \$git_branch_name to $git_branch_name"
fi

if [ "$git_host" = "" ]; then
    git_host="github.com"
    echo "[INFO] No command line input provided. Set \$git_host to $git_host"
fi

# Initialize the local directory as a Git repository
git init

# Adds the files in the local repository and stages them for commit.
git add .

# Commits the tracked changes and prepares them to be pushed to a remote repository.
git commit -m "$git_commit_message"

# Sets the new remote
git_remote=`git remote`
if [ "$git_remote" = "" ]; then # git remote not defined

    if [ "$git_pat" = "" ]; then
        echo "[INFO] \$git_pat is not set. Using the git credential in your environment."
        git remote add origin https://${git_host}/${git_repo_owner_id}/${git_repo_id}.git
    else
        git remote add origin https://${git_user_id}:${git_pat}@${git_host}/${git_repo_owner_id}/${git_repo_id}.git
    fi

fi

git pull origin master

# Pushes (Forces) the changes in the local repository up to the remote repository
echo "Git pushing to https://${git_host}/${git_repo_owner_id}/${git_repo_id}.git"
git push origin master 2>&1 | grep -v 'To https'

