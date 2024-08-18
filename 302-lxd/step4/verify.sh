#!/bin/bash
if ! lxc info debian12-test | grep -q debian12-test-1; then exit 0; fi