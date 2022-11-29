# README

## Các bước cài project bằng docker:
- Run command `cp .env.example .env` để tạo file .env
- Chỉnh sửa các biến môi trường trong file .env

## Môi trường development
- Start docker containers: `docker-compose -f docker-compose-dev.yml up -d`
- Stop containers: `docker-compose -f docker-compose-dev.yml down` 
