#!/bin/bash

echo "Killing off Centos7 container..."
docker rm --force centos7

echo "Killing off Debian9 container..."
docker rm --force debian9
