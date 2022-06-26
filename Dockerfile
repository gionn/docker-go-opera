FROM golang:1.15.15-alpine as build

RUN apk add git alpine-sdk linux-headers

RUN git clone --single-branch --branch release/1.1.0-rc.5 https://github.com/Fantom-foundation/go-opera

WORKDIR /go/go-opera

RUN make

FROM alpine:3.15 as runtime
COPY --from=build /go/go-opera/build/opera /usr/local/bin/opera

VOLUME [ "/genesis" ]
VOLUME [ "/root/.opera" ]

ADD run.sh /run.sh

CMD [ "/run.sh" ]

EXPOSE 5050 18545 18546 18547 19090

ENV FANTOM_NETWORK=opera
ENV FANTOM_GENESIS="mainnet.g"
ENV FANTOM_SNAPSHOT_URL="https://ftmbootstraps.ultimatenodes.io/ftm_opera_pruned_22-06-26_06-36-26.tar.gz"
ENV FANTOM_API=eth,ftm,net,web3
ENV FANTOM_VERBOSITY=2
ENV FANTOM_CACHE=4096
ENV STARTUP_ACTION=run
