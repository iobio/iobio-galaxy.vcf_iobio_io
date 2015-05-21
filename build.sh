#!/bin/bash

branch=$(git branch | grep \* | cut -f2 -d' ')
if [ x$branch == "xmaster" ]; then branch="latest"; fi

docker build --no-cache -t qiaoy/iobio-galaxy.vcf_iobio_io:$branch .
