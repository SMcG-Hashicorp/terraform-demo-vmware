#!/bin/sh

apt-get update
apt-get install -qy docker.io

sudo docker run -p 8080:80 -d --restart always nginxdemos/hello:latest