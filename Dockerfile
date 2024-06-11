FROM golang:1.22.4

WORKDIR /app

COPY go.mod go.sum ./

ENV GOMODCACHE=/root/.go-mod-cache
RUN --mount=type=cache,id=gomodcache,target=$GOMODCACHE go mod download

COPY . .

# Build
ENV GOCACHE=/root/.go-build-cache
RUN --mount=type=cache,id=gobuildcache,target=$GOCACHE CGO_ENABLED=0 GOOS=linux go build -o /go-server

EXPOSE 8001

CMD ["/go-server"]
