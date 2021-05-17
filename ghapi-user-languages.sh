#!/bin/bash


curl --header "Authorization: token xxx" -H "Accept: application/vnd.github.v3+json" https://api.github.com/users/shred22/repos | jq '.[].languages_url' > repoList.json


sed 's/\"//g' repoList.json > changed.json
mv changed.json repoList.json
while read repo_language_url
do curl --header "Authorization: token xxx" -H "Accept: application/vnd.github.v3+json" $repo_language_url >> repo_languages.json

done < repoList.json

echo
echo "Initiating Language analysis from Repo now >>>"

groovy repoLanguageCounter.groovy

echo
echo "Clearing Files now."

rm repo_languages.json
rm repoList.json




