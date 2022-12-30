# README

## Các bước cài project bằng docker:
- Run command `cp .env.example .env` để tạo file .env
- Chỉnh sửa các biến môi trường trong file .env

## Môi trường development
- Start docker containers: `docker-compose -f docker-compose-dev.yml up -d`
- Stop containers: `docker-compose -f docker-compose-dev.yml down` 

## Thêm thư viện javascript
- Thêm package vào `dependencies` trong file `pacakge.json`
- Run `yarn install`
#### hoặc
- Run `yarn add { package_name }`

- Import các package vào `application.js` và css file (nếu cần) vào `application.bootstrap.scss`

## Thêm file css
- Import vào file `application.bootstrap.scss`

## Naming convention
### Branch name
+ For a feature: feature/<feature_name>
+ For frontend: fe/<component>
+ For fixing bug: bug/fix_something
