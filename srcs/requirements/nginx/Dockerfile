FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

#daemon Prevents the container from exiting after starting, allowing the container to keep running