#!/bin/sh
set -e

# Parameters to named parameters
git_host=$1
git_repo_owner_id=$2
git_repo_id=$3
git_branch_name=$4
git_user_id=$5
git_access_token=$6


# Check that all parameters are given
if [ "$git_host" = "" ]; then
    echo "[ERROR] No git host given. Please pass a git host (e.g.: github.com) to the script as the first parameter."
    exit 1
fi

if [ "$git_repo_owner_id" = "" ]; then
    echo "[ERROR] No repository owner id given. Please pass a repository owner id (the repository's owner user/organization id) to the script as the second parameter."
    exit 1
fi

if [ "$git_repo_id" = "" ]; then
    echo "[ERROR] No repository id given. Please pass a repository id (e.g.: octopus-repo) to the script as the third parameter."
    exit 1
fi

if [ "$git_branch_name" = "" ]; then
    echo "[ERROR] No branch name given. Please pass a branch name to the script as the fourth parameter."
    exit 1
fi

if [ "$git_user_id" = "" ]; then
    echo "[ERROR] No user id given. Please pass a user id to the script as the fifth parameter."
    exit 1
fi

if [ "$git_access_token" = "" ]; then
    echo "[ERROR] No access token given given. Please pass an access token to the script as the sixth parameter."
    exit 1
fi

# Clone the repository to the current working directory
git clone https://${git_user_id}:${git_access_token}@${git_host}/${git_repo_owner_id}/${git_repo_id}.git

# Checkout to the requested branch
git checkout ${git_branch_name}

# Pull latest changes just to be sure
git pull origin ${git_branch_name}