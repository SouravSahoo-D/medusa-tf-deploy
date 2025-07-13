#!/bin/bash

if [ ! -f "/app/my-medusa-store/package.json" ]; then
  npx create-medusa-app@latest my-medusa-store --seed
fi

cd my-medusa-store
npm install
npm run start
