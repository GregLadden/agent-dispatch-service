# Agent Dispatch Service (Go)

This is a concurrent task dispatching and worker service built in Golang. It acts as an asynchronous job queue using Redis list brokers and streams real-time execution steps back to client nodes using Server-Sent Events (SSE).

## 🚀 Features

*   **REST Task API**: Post new job requests.
*   **Redis List Broker**: Queues incoming tasks via `LPush`.
*   **Concurrent Worker Pool**: Spawns multiple goroutines to dequeue and execute tasks concurrently.
*   **Real-time Event Streaming**: Broadcasts live worker updates over Redis Pub/Sub channels to client browsers via Server-Sent Events (SSE).
*   **Mock Fallback**: Runs in self-contained mock mode when Redis is not available.

## 🛠️ Tech Stack

*   **Language**: Go 1.25+
*   **Router**: Gin Web Framework
*   **Broker & Cache**: Redis (go-redis client)

## 💻 Getting Started

### Prerequisites

*   Go installed locally.
*   Redis running locally (optional, the service will auto-detect and use mock mode if Redis is offline).

### CLI Commands

```bash
# Set up and download dependencies
make setup

# Build the project
make build

# Start the server (default port 8081)
make start
```

## 🔌 API Endpoints

### 1. Health Check
*   **URL**: `GET /api/health`
*   **Response**:
    ```json
    {
      "status": "healthy",
      "redis": "connected",
      "time": "2026-06-02T04:00:00Z"
    }
    ```

### 2. Submit Task
*   **URL**: `POST /api/tasks`
*   **Payload**:
    ```json
    {
      "query": "Verify candidate experience and profile background.",
      "workflow": "recruit"
    }
    ```
*   **Response**:
    ```json
    {
      "task_id": "task_171727271928",
      "status": "queued",
      "created_at": "2026-06-02T04:00:00Z"
    }
    ```

### 3. Stream Task Logs (SSE)
*   **URL**: `GET /api/tasks/:id/stream`
*   **Stream Payload**:
    ```json
    {"timestamp":"11:00:01 PM","agent":"DetectAgent","message":"Analyzing query...","node":"detect"}
    ```