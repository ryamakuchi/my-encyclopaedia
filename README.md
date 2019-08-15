# My 百科事典

## Requirements

- Ruby 2.6.3
- Postgresql 11.5

## Setup

```
docker-compose build
docker-compose up
docker ps # 現在立ち上がっているコンテナを確認
docker exec -it docker_web_1 /bin/bash
```

```
bin/rails db:create
bin/rails db:migrate
```

## Development

```
open http://localhost:3000
```

### Letter Opener Web

```
open http://localhost:3000/letter_opener
```

## Testing

```
bin/rails spec
```
