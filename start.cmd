REM docker-compose -f .\samples\docker-compose.yml up -d --scale consul=3 --scale redis=1 --scale redis-sentinel=3
REM timeout 15 > NUL
docker-compose -f .\samples\docker-compose.yml up -d  --scale consul=3 --scale sentinel-eu=3 --scale cache-eu=3 --scale sentinel-as=3 --scale cache-as=3 --build
REM timeout 15 > NUL
REM docker-compose -f .\samples\docker-compose.yml scale redis=3 redis-sentinel=3
