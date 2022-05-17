FROM golang:1.18 as builder

# Set the Current Working Directory inside the container
WORKDIR /build

# Copy everything from the current directory to the PWD (Present Working Directory) inside the container
COPY . .

# Download all the dependencies
RUN go mod tidy
RUN CGO_ENABLED=0 go build -o main

FROM alpine:latest

WORKDIR /app

COPY --from=builder /build/main main

EXPOSE 8080

# Run the executable
CMD ["./main"]