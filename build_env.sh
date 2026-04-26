#!/bin/sh

if [ ! -f backend/.env ]; then
  cp backend/.env.example backend/.env
fi
docker-compose build && docker-compose up -d
