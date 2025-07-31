#!/usr/bin/env bash

docker run -d -p 8080:8080 -v $HOME/my-dashy-conf.yml:/app/user-data/conf.yml --name dashy --restart=always lissy93/dashy:latest 
