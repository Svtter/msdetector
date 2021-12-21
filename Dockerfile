FROM golang:1.17 as build-stage

WORKDIR /go/src

COPY go.mod go.sum ./
RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct && go mod download

COPY ./main.go  ./

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64
RUN go build \
    -o /go/bin/msdetector \
    -ldflags '-s -w' 

FROM scratch as runner
COPY --from=build-stage /go/bin/msdetector /app/msdetector

ENTRYPOINT [ "/app/msdetector" ]
