#!/bin/bash

if [ ! -f "/nodekey" ]; then
  /bootnode --genkey=/nodekey --writeaddress
fi

/bootnode --nodekey=/nodekey
