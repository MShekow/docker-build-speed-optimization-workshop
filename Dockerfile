FROM --platform=$BUILDPLATFORM golang:1.22.4 as builder
ARG TARGETARCH

WORKDIR /app

COPY go.mod go.sum ./

ENV GOMODCACHE=/root/.go-mod-cache
RUN --mount=type=cache,id=gomodcache,target=$GOMODCACHE go mod download

COPY . .

# Build
ENV GOCACHE=/root/.go-build-cache
RUN --mount=type=cache,id=gobuildcache,target=$GOCACHE CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -o /go-server


FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /go-server /app/quotes.txt ./

EXPOSE 8001

CMD ["/go-server"]
