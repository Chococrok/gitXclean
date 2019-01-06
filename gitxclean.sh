#!/usr/bin/env bash

printf '\nWARNING your going to delete every branches apart from master and develop\n\n';
read -p 'proceed ? y/n ' answer

if [ "x$answer" != "xy" ]; then
    exit 0
fi

if [ "x$1" = "x-f" ]; then
    force=true
fi

branches=$(git for-each-ref --format='%(refname:short)')

for branch in $branches; do
    if [ ! $(echo "$branch" | grep -e "master" -e "develop" -e "origin") ]; then
        if [ "$force" = true ]; then
            git branch -d $branch
            git push --delete origin $branch
        else
            read -p "branch \"$branch\" wil be deleted, proceed ? y/n " proceed

            if [ "x$proceed" = "xy" ]; then
                git branch -d $branch
                git push --delete origin $branch
            fi
        fi
    fi
done
