# Exercises

In this exercise you will need to deploy 3 components for an application.

- rabbitmq
- fakecoin-ui
- fakecoin-server

Label everything with `app=fakecoin` and a label `component`

## Rabbitmq

Create the following resources for the rabbitmq service:

- A **Deployment** named `rabbitmq` with image `rabbitmq:3.7.4-management`
- A **Service** named `rabbitmq`
- A **Persistent Volume** named `rabbitmq-pv`
- A **Persistent Volume Claim** named `rabbitmq-pvc`, 
which claims the `rabbitmq-pv`. 
The disk path should be `/data/rabbitmq`.
Mount this to`/var/lib/rabbitmq` in the pod.


Make the following service ports available:
- 5672 (internal)
- 15672 (per node)

## Server

Create the following resources for the fakecoin-server application:

- A **Deployment** named `fakecoin-server` with image `tomverelst/fakecoin-server`
- A **Service** named `fakecoin-server`
- A **Config Map** named `fakecoin-server`
- A **Secret** named `rabbitmq-credentials`

Put the following key values in the config map: 

- SPRING_RABBITMQ_HOST=rabbitmq
- SPRING_RABBITMQ_PORT=5672

Load these values into the environment variables

Put the following key values in the secret `rabbitmq-credentials`

- username: guest
- password: guest

Bind these values to the environment variables SPRING_RABBITMQ_USER and SPRING_RABBITMQ_PASSWORD respectively.

Make the following ports available to the pod and service
- 8080 (internal)

## UI

Create the following resources for the fakecoin-ui application:

- A **Deployment** named `fakecoin-ui`  with image `tomverelst/fakecoin-ui`
- A **Service** named `fakecoin-ui`

Configure the application through environment variables:
- RABBIT_URL=amqp://rabbitmq:5672
- FAKECOIN_HOST=fakecoin-server

Make the following ports available to the pods and service:
- 3000 (internal)

## Ingress

Create the following resources: 

- An `Ingress` named `fakecoin` that routes traffic to the fakecoin-ui service port 3000 from the root (`/`)
