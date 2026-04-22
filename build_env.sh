#!/bin/sh

cp backend/.env.example backend/.env
docker-compose build && docker-compose up -d
