set -e

TARGET=$1

if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: ./deploy_blue_green.sh [blue|green]"
  exit 1
fi

echo "Switching auth deployment to: $TARGET"

cp ./nginx/conf.d/upstreams.$TARGET.conf ./nginx/conf.d/upstreams.conf

docker compose exec nginx nginx -t
docker compose exec nginx nginx -s reload

echo "Deployment switched to: $TARGET"