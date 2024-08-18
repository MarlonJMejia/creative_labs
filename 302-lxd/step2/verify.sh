#!/bin/bash
if [ $(lxc list | grep -c test) -eq 3 ]; then 
    exit 0
else
    exit 1
fi
