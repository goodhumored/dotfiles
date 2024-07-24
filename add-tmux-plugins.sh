pwd
ls .tmux/plugins
for repo in .tmux/plugins/* ; do
    if [ -d "$repo/.git" ]; then
        # Remove trailing slash from the directory name
        repo=${repo%/}

        # Get the origin URL of the repository
	url=$(git -C "$repo" remote get-url origin)

        if [ -n "$url" ]; then
	    echo "adding repo $repo: $url"
            # Add the repository as a submodule using its origin URL
	    git rm --cached -f "$repo"
            git submodule add "$url" "$repo"
        else
            echo "No origin URL found for $repo"
        fi
    fi
done
