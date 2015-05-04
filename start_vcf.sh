#!/bin/bash
#
# Example script to launch the container while providing
# the to-be-visualized vcf file on the commandline

# The following env vars will be honored by the container startup script

export PUB_HOSTNAME=$(hostname -f)
export PUB_HTTP_PORT=8080
export PUB_TABIX_PORT=5000
export PUB_VCFDEPTHER_PORT=5001
export PUB_VCFSTATSALIVE_PORT=5002

docker run -it \
	-p $PUB_HTTP_PORT:80 \
	-p $PUB_TABIX_PORT:8000 \
	-p $PUB_VCFDEPTHER_PORT:8001 \
	-p $PUB_VCFSTATSALIVE_PORT:8002 \
	-v ${1}:/input/vcffile.vcf.gz:ro \
	-v ${1}.tbi:/input/vcffile.vcf.gz.tbi:ro \
	-e PUB_HOSTNAME \
	-e PUB_HTTP_PORT \
	-e PUB_TABIX_PORT \
	-e PUB_VCFDEPTHER_PORT \
	-e PUB_VCFSTATSALIVE_PORT \
	--rm qiaoy/iobio-galaxy.vcf_iobio_io
