output=$(curl -L -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$GITHUB_REPOSITORY/releases | jq -r '.[].tag_name')

github_tag=$GITHUB_REF_NAME

echo $github_tag
echo $output
match=false
# echo $match
for tag in $output; do
    if [ "$tag" == "$github_tag" ]; then
        match=true
        break
    fi
done
echo $match
# Output the result
if [ "$match" = true ]; then
    echo "The selected tag has a released version."
else
    echo "The selected tag has not been released yet."
    exit 1
fi
