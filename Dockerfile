FROM golang:1.17 as build-stage

WORKDIR /app
COPY go.mod go.sum ./
RUN go env -w GO111MODULE=on && go env -w GOPROXY=https://goproxy.cn,direct && go mod download

COPY ./main.go  ./

RUN go build 


FROM scratch as runner
COPY --from=build-stage /app/msdetector /app/msdetector

ENTRYPOINT [ "/app/msdetector" ]
