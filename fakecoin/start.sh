#!/usr/bin/env bash

docker volume create rabbit-data

docker network create fakenet

docker run -d -v rabbit-data:/var/lib/rabbitmq \
   -p 15672:15672 \
   --network fakenet \
   --name rabbitmq \
   rabbitmq:3.7.4-management


docker run -d -e SPRING_RABBIT_HOST=rabbitmq \
    --network fakenet \
    -p 8080:8080 \
    --name fakecoin-server \
    fakecoin-server

docker run -d \
-e RABBIT_URL=amqp://rabbitmq \
-e FAKECOIN_HOST=fakecoin-server \
-p 3000:3000 \
--network fakenet \
--name fakecoin-ui \
fakecoin-ui
