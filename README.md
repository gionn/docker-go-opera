# Docker compose for go-opera

This a Dockerfile + Docker-compose I am using to run a single Fantom node (for API, not staking) in production for a few months.

It will setup an Opera node with a Letsencrypt HTTPS endpoint in front.

Latest snapshot URL can be found [here](https://docs.fantom.foundation/node/snapshot-download#pruned-datadir)

## How to run

Copy the .env template:

```bash
cp .env.template .env
```

and fill your variables.

Run with docker-compose:

```bash
docker-compose up -d --build
```

## Node maintenance

Node will eat your disk space from time to time. You have two options:

* wipe the data so restarting the container will redownload latest snapshot:

  ```bash
  rm -fr data/*
  ```

* restart in prune mode (usually faster than redownloading latest snapshot) by setting .env:

  ```bash
  STARTUP_ACTION=prune
  ```
