FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache nginx

#Allows container to use port 443
EXPOSE 443

#Launches nginx with daemon off(runs in the foreground, keeping the container alive depending of nginx)
CMD ["nginx", "-g", "daemon off;"]
