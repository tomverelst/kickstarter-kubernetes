docker create network fakenet

docker run -d -P \
--network fakenet \
--name rabbitmq \
-v rabbit-data:/var/lib/rabbitmq \
rabbitmq:3.7.4-management

docker run -d -p 8080:8080
 -e SPRING_RABBIT_HOST=rabbitmq 
 --network fakenet --name fakecoin-server 
 fakecoin-server


docker run -d -p 3000:3000 \
-e RABBIT_URL=amqp://rabbitmq \
-e FAKECOIN_HOST=fakecoin-server \
--name fakecoin-ui \
--network=fakenet \fakecoin-ui