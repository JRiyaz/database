docker run -d --init \
  --name bytebase \
  --publish 8080:8080 --pull alway \
  --volume D:/database/bytebase/container-data:/var/opt/bytebase \
  bytebase/bytebase:3.5.2

docker run -d --init --name bytebase --publish 8080:8080 --volume D:/database/bytebase/container-data:/var/opt/bytebase -e PG_URL=postgresql://admin:admin@host.docker.internal:5432/employees bytebase/bytebase:3.5.2

