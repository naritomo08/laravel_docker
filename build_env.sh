#!/bin/sh

cp .env.example backend/.env
docker-compose build && docker-compose up -d
