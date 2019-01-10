FROM golang:1.11

WORKDIR /go/src/github.com/percona/mongodb_exporter

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o mongodb_exporter .

FROM quay.io/prometheus/busybox:latest

COPY --from=0 /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /bin/mongodb_exporter

ENTRYPOINT [ "/bin/mongodb_exporter" ]
