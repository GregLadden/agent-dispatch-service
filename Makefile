.PHONY: help setup build start dev clean test

help:
	@echo "Available commands:"
	@echo "  make setup   - Install Go module dependencies"
	@echo "  make build   - Build the server executable"
	@echo "  make start   - Run the server in production/normal mode"
	@echo "  make dev     - Run the server in development mode with hot-reload (Air)"
	@echo "  make test    - Run Go unit tests"
	@echo "  make clean   - Remove build binaries"

setup:
	@echo "Downloading dependencies..."
	go mod download
	@echo "Dependencies updated successfully."

build:
	@echo "Building executable..."
	CGO_ENABLED=0 go build -o server main.go
	@echo "Build complete."

start: build
	@echo "Starting Go Agent Orchestrator service on port 8001..."
	./server

dev:
	@echo "Starting Go Agent Orchestrator service with live-reload (Air)..."
	air

test:
	@echo "Running tests..."
	go test -v ./...

clean:
	@echo "Cleaning compiled binaries..."
	rm -f server
	@echo "Clean completed."
