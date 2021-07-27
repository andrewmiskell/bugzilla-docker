# Bugzilla Docker Image

Based on the work of https://github.com/nasqueron/docker-bugzilla but updated to run a RockyLinux 8 base image and cleaned up packages / build depenancies to produce a smaller container image.

Grabs a slightly customized version of Bugzilla with options to relax perl::DBD::MySQL's strict SSL checks. If the customization is merged into 
the core Bugzilla code (https://github.com/bugzilla/bugzilla/pull/104), then we'll move back to git cloning from bugzilla offical repositories.

&nbsp;
# Basic Usage

To start the container against an already standing MySQL instance:

```bash
$ docker run -dt -p 8080:80 \
  -e DB_HOST=mysql \
  -e DB_USER=bugs \
  -e DB_PASSWORD=bugs \
  -e DB_DATABASE=bugs \
  -e BUGZILLA_URL=https://bugzilla.domain.tld
  andrewmiskell/bugzilla
```

&nbsp;
# Environment Variables

| Variable | Description | Required | Default Value |
|----------|-------------|----------|---------------|
| DB_HOST | Hostname/IP of the MySQL/MariaDB server | Yes | N/A
| DB_USER | Username of Bugzilla database user | Yes | N/A
| DB_PASSWORD | Password of Bugzilla database user | Yes | N/A
| DB_DATABASE | Name of MySQL/MariaDB database for Bugzilla | Yes | N/A
| BUGZILLA_URL | URL for Bugzilla instance | Yes | N/A
| ADMIN_EMAIL | E-Mail address for Administrative User | No | admin@domain.tld
| ADMIN_PASSWORD | Password for the Administrative User | No | Randomly Generated and Output to Logs
| ADMIN_REALNAME | Real Name of the Administrator User | No | Admin
| MYSQL_SSL_OPTIONAL | If set to 1, relaxes strict SSL checks on MySQL connections | No | 0


&nbsp;
# Credits

The dependencies and the configuration variables to provide are partially based on Dave Lawrence (dklawren) work. Init scripts reused and slightly modified from nasqueron source repo.
