FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make build

FROM busybox
WORKDIR /go/src/app
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot, "start"]
