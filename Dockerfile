FROM golang:1.14 as stage
WORKDIR /app
COPY . .
RUN env CGO_ENABLED=0 go build -tags netgo -ldflags '-w -s -extldflags "-static"' -o go_challenge

FROM scratch
COPY --from=stage /app/go_challenge .
CMD ["./go_challenge"]