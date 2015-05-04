FROM qiaoy/iobio-galaxy.vcf_iobio_io.base
MAINTAINER Yi Qiao <atrusqiao@gmail.com>

COPY url_fix.sed /tmp/

RUN cd /var/www/html && \
	sed -f /tmp/url_fix.sed -i app/vcf.iobio.js && \
	rm /tmp/url_fix.sed

COPY supervisord.conf /etc/supervisor/
COPY nginx-sites-default /etc/nginx/sites-available/default
COPY app.conf /etc/supervisor/conf.d/
COPY entrypoint.sh /
COPY watchdog.sh /
RUN chmod +x /entrypoint.sh && \
	chmod +x /watchdog.sh && \
	mkdir /input && \
	mkdir /var/www/html/tmp && \
	ln -s /input/vcffile.vcf.gz /var/www/html/tmp/vcffile.vcf.gz && \
	ln -s /input/vcffile.vcf.gz.tbi /var/www/html/tmp/vcffile.vcf.gz.tbi && \
	ln -s /input/vcffile.vcf.gz.tbi /home/iobio/workdir/vcffile.vcf.gz.tbi

EXPOSE 80 8000 8001 8002

CMD ["/bin/sh", "-c", "/entrypoint.sh"]
