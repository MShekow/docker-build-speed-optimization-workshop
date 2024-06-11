FROM golang:1.22.4

WORKDIR /app

COPY . .

RUN go mod download

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /go-server

EXPOSE 8001

CMD ["/go-server"]
