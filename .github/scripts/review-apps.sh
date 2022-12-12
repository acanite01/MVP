set -e

echo "Review App Script"
# crete "unique" name for fly review app
app="mvp-pr-$PR_NUMBER"
secrets="AUTH_API_KEY=$AUTH_API_KEY ENCRYPTION_KEYS=$ENCRYPTION_KEYS"

if [ "$EVENT_ACTION" = "closed" ]; then
  flyctl apps destroy "$app" -y
  exit 0
elif ! flyctl status --app "$app"; then
  # create application
  flyctl launch --no-deploy --copy-config --name "$app" --region "$FLY_REGION" --org "$FLY_ORG"

  # attach existing posgres
  flyctl postgres attach "$FLY_POSTGRES_NAME"

  # add secrets
  echo $secrets | tr " " "\n" | flyctl secrets import --app "$app"

  # deploy
  flyctl deploy --app "$app" --region "$FLY_REGION" --image --strategy immediate

else
  flyctl deploy --app "$app" --region "$FLY_REGION" --image --strategy immediate
fi

