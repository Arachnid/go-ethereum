#!/bin/bash

if [ ! -f "/nodekey" ]; then
  /bootnode --genkey=/nodekey --writeaddress
fi

# Start an HTTPD that can be used to detect the node we're running on
busybox httpd -p 0.0.0.0:8301 -h /www

/bootnode --nodekey=/nodekey
