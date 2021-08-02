FROM bitnami/openresty:latest

ENV VERSION=5.0

USER 0
RUN install_packages libcgi-pm-perl libdatetime-perl libdbi-perl libtemplate-perl libemail-sender-perl \
libemail-mime-perl libmath-random-isaac-perl libjson-xs-perl libgd-perl libchart-perl \
libgd-text-perl libgd-graph-perl libwww-perl libxml-twig-perl libnet-ldap-perl \
libauthen-radius-perl libsoap-lite-perl libjson-rpc-perl libtest-taint-perl libhtml-scrubber-perl \
libemail-reply-perl libhtml-formattext-withlinks-perl libencode-detect-perl \
libtheschwartz-perl libdaemon-generic-perl libfile-mimeinfo-perl libcache-memcached-perl \
libdbd-mysql-perl libfile-copy-recursive-perl libfile-which-perl libtemplate-plugin-gd-perl \
libemail-address-perl patchutils git && \
PERL_MM_USE_DEFAULT=1 cpan install PatchReader && \
rm -rf /app

USER 1001
RUN git clone --branch ${VERSION} https://github.com/andrewmiskell/bugzilla.git /app

COPY files /

EXPOSE 80

CMD ["/usr/local/sbin/init-container"]
