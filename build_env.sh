#!/bin/sh

git submodule update --init --recursive
cp .env.example backend/.env
docker-compose up
