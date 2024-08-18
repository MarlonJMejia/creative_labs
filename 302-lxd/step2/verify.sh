#!/bin/bash
if [ $(lxc list | grep -c test) -eq 3 ]; then echo /bin/true; else /bin/false; fi