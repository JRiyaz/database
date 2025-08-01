docker run --name redis -d -p 6379:6379 -v D:/database/Redis/container-data:/data redis:7.4.2 redis-server --save 60 1 --loglevel warning --requirepass Connect@4321 --user admin@localhost.com

