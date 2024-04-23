FROM golang:1.22.2 as builder

ARG GOARCH=amd64
ARG GOOS=linux

COPY . /src
WORKDIR /src
RUN GOOS=$GOOS GOARCH=$GOARCH CGO_ENABLED=0 go build main.go

FROM alpine:3.19.1
COPY --from=builder /src/main /tplink-plug-exporter
EXPOSE 9233
ENTRYPOINT ["/tplink-plug-exporter"]
