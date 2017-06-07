#!/bin/bash
docker push trose/sample-node

ssh -i ~/.ssh/ocean_rsa deploy@build.me << EOF
docker pull trose/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi trose/sample-node:current || true
docker tag trose/sample-node:latest trose/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 trose/sample-node:current
EOF
