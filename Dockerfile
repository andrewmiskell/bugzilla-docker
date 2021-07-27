FROM rockylinux/rockylinux:latest

ENV VERSION=5.0

RUN dnf -y install epel-release glibc-langpack-en && \
    sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/Rocky-PowerTools.repo && \
    dnf -y install  gcc gcc-c++ git mod_perl patchutils sudo vim-enhanced \
                    perl-App-cpanminus perl-Authen-Radius perl-Authen-SASL \
                    perl-CGI perl-Cache-Memcached perl-DBD-Pg perl-DBD-SQLite \
                    perl-DBD-mysql perl-DateTime perl-Digest-SHA perl-Email-Sender \
                    perl-Encode-Detect perl-File-Copy-Recursive perl-File-MimeInfo \
                    perl-File-Which perl-GD perl-GDGraph perl-GDTextUtil perl-HTML-Scrubber \
                    perl-JSON-RPC perl-JSON-RPC-CGI perl-JSON-XS perl-LDAP perl-List-MoreUtils \
                    perl-Math-Random-ISAAC perl-Memoize perl-Template-Toolkit \
                    perl-XML-Twig perl-XMLRPC-Lite perl-autodie && \
    dnf -y update && \
    dnf clean all && \
    cpanm --quiet --notest --skip-installed \
                    Chart::Lines Daemon::Generic Email::Reply HTML::FormatText::WithLinks \
                    PatchReader Template::Plugin::GD::Image Test::Taint TheSchwartz

RUN useradd -m -G wheel -u 1000 -s /bin/bash bugzilla && \
    git clone --branch ${VERSION} https://github.com/andrewmiskell/bugzilla.git /opt/bugzilla && \
    chown -R bugzilla:bugzilla /opt/bugzilla && \
    rm /etc/httpd/conf.d/welcome.conf

COPY files /

EXPOSE 80

CMD ["/usr/local/sbin/init-container"]
