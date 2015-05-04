#!/bin/bash

env

CYAN='\033[1;36m'
NC='\033[0m'

cd /var/www/html
sed -i s/:8000/:$PUB_TABIX_PORT/ app/vcf.iobio.js
sed -i s/:8001/:$PUB_VCFDEPTHER_PORT/ app/vcf.iobio.js
sed -i s/:8002/:$PUB_VCFSTATSALIVE_PORT/ app/vcf.iobio.js

if [ ! -f /input/vcffile.vcf.gz ]; then
	echo -n "VCF COMPRESSION AND INDEXING IN PROGRESS ......"
	cd /input
	~iobio/iobio/bin/bgzip vcffile.vcf
	~iobio/iobio/bin/tabix vcffile.vcf.gz
	echo "DONE"
fi

echo ""
echo "Please point your browser to the following URL"
echo -e "${CYAN}VCF.IOBIO URL: http://${PUB_HOSTNAME}:${PUB_HTTP_PORT}/?vcf=http://${PUB_HOSTNAME}:${PUB_HTTP_PORT}/tmp/vcffile.vcf.gz${NC}"
echo ""
echo ""
echo "---- start of supervisor logs ----"
echo ""

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

