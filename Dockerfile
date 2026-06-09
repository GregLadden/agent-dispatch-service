# Build stage
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Copy dependency manifests
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build static binary
RUN CGO_ENABLED=0 GOOS=linux go build -o agent-dispatch-service main.go

# Production stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy binary from builder
COPY --from=builder /app/agent-dispatch-service .

ENV PORT=8081
EXPOSE 8081

CMD ["./agent-dispatch-service"]
