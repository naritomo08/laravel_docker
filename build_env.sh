#!/bin/sh

cp .env.example backend/.env
docker-compose up -d
