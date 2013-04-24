# NetMap Development Keys

This repository contains the SSL and API keys used in the
[NetMap development VMs](https://github.com/netmap/netmap-server-vm).

## Usage

The development VM contains a properly configured copy of this repository. The
rest of this section documents the setup of a similar repository to be used for
deploying forked versions of the game into production.

### SSL Keys

You will need your own `game.crt` and `game.pem` files for your DNS domain.
[This blog post](http://blog.costan.us/2012/12/free-ssl-for-your-web-application.html)
documents a reasonable method for getting free SSL certificates for a domain
that you already own.

### Metrics Server Keys

Create an application entry on the
[metrics server console](http://netmap-data.pwnb.us).

Use the application ID and key to generate `metrics.json`

```bash
script/metrics_key.sh 11223344 your-secret-key
```


## Copyright

The NetMap server keys setup instructions and scripts are (C) Copyright
Massachusetts Institute of Technology 2013, and are made available under the
MIT license.
