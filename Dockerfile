# syntax=docker/dockerfile:1.4

# First stage: build the Go application
FROM golang:1.21.6-bookworm AS builder

WORKDIR /app

# Enable Go modules
ENV GO111MODULE=on

# Copy and download dependencies
COPY --link go.mod .
COPY --link go.sum .
RUN go mod download

# Copy the application source
COPY --link ./cmd/operator/main.go ./main.go

# Build the application
RUN CGO_ENABLED=0 go build -o main .

# Second stage: copy the built binary to a distroless image
FROM gcr.io/distroless/static-debian12:nonroot

# Copy the built binary
COPY --link --chown=65532:65532 --from=builder /app/main /

# Execute the application command
CMD ["/main"]
