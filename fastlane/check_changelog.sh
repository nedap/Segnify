#!/bin/bash 

SEARCH_STRING="Unreleased"

if grep -q $SEARCH_STRING ../CHANGELOG.md; then
    echo "Error: $SEARCH_STRING string in CHANGELOG.md" 1>&2
	exit 64
fi
