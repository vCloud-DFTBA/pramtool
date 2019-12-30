FROM golang:1.12
ARG prom_version
ARG am_version

WORKDIR /tmp/build
RUN go mod init . \
    && GOFLAGS="-mod=vendor -mod=readonly" go get -d -v github.com/prometheus/prometheus/cmd/promtool@v${prom_version} \
    && GOFLAGS="-mod=vendor -mod=readonly" go get -d -v github.com/prometheus/alertmanager/cmd/amtool@v${am_version}
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /go/bin/promtool github.com/prometheus/prometheus/cmd/promtool \
    && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /go/bin/amtool github.com/prometheus/alertmanager/cmd/amtool

FROM alpine:3.9
COPY --from=0 /go/bin/promtool /go/bin/amtool /bin/
ENTRYPOINT ["/bin/sh"]