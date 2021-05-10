#!/usr/bin/env bash
#
# This script accepts the following parameters:
#
# * owner
# * repo
# * tag
# * github_api_token
# * release_notes
#
# Script to create anew release using the GitHub API v3.
#
# Example:
#
# release.sh owner=stefanbuck repo=playground tag=v0.1.0 github_api_token=1fd2327d23139e6cbd5f98f205c46d04b98f9d87 release_notes=release_notes

# Local variables
GH_API="https://api.github.com"

createReleaseNotes() {
    echo "Create Release Notes"

    cd ..

    changelogFile=CHANGELOG.md
    notesBody=''
    addLineToBody=false
    chapter=0
    while read line; do

        if [[ $line = \##\ * ]] && (( $chapter == 1 )); then
            addLineToBody=false
        fi

        if $addLineToBody && (( $chapter < 2 )); then
            notesBody="$notesBody $line"$"\n"
        fi

        if [[ $line = \##\ * ]]; then
            addLineToBody=true
            chapter=$(expr $chapter + 1)
        fi

    done <$changelogFile

    release_notes="$notesBody"
}

# Check dependencies.
set -e
xargs=$(which gxargs || which xargs)

# Validate settings.
[ "$TRACE" ] && set -x

CONFIG=$@

for line in $CONFIG; do
  eval "$line"
done

# Validate token.
curl -o /dev/null -sH "Authorization: token $github_api_token" "$GH_API/repos/$owner/$repo" || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

echo "Build and release Segnify framework version $tag"

createReleaseNotes
echo -e $release_notes

# Create the release
echo "Create release in GitHub"
curl -s -k -X POST -H "Content-Type: application/json" -H "Authorization: token $github_api_token" "$GH_API/repos/$owner/$repo/releases" -d '{"tag_name": "'"$tag"'","target_commitish": "master","name": "'"$tag"'","body": "'"$release_notes"'","draft": false,"prerelease": true}'
