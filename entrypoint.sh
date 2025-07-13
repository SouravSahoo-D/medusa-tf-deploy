#!/bin/sh

set -e  # Stop script if any command fails

# Wait for Postgres
echo "Waiting for Postgres..."
until nc -z localhost 5432; do
  sleep 1
done

# Wait for Redis
echo "Waiting for Redis..."
until nc -z localhost 6379; do
  sleep 1
done

# Create app only if not already created
if [ ! -f "/app/my-medusa-store/package.json" ]; then
  echo "Creating Medusa app..."
  npx create-medusa-app@latest my-medusa-store --seed
fi

cd my-medusa-store
npm install

echo "Starting Medusa backend..."
npm run start
