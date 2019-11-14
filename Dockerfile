FROM alpine:latest as provider
RUN apk add curl

ENV VERSION 0.8.2
WORKDIR /workspace
RUN curl -L https://github.com/nats-io/nats-account-server/releases/download/v${VERSION}/nats-account-server-v${VERSION}-linux-amd64.zip \
    -o accounts-server.zip && unzip -j accounts-server.zip

FROM scratch

COPY --from=provider /workspace/nats-account-server /bin/nats-account-server
USER 10001
ENTRYPOINT ["/bin/nats-account-server"]
