#
# Stage 1: Build the Go binary from local source
#
FROM --platform=$BUILDPLATFORM golang:1.22-alpine AS builder

RUN apk add --no-cache \
    alpine-sdk \
        ca-certificates \
            git \
                tzdata

                WORKDIR /src

                # Cache dependencies first (faster rebuilds)
                COPY go.mod go.sum ./
                RUN go mod download

                # Copy full source and build
                COPY . .

                ARG VERSION=dev
                RUN CGO_ENABLED=0 GOOS=linux go build \
                    -a \
                        -ldflags "-extldflags '-static' -X github.com/containrrr/watchtower/internal/meta.Version=${VERSION}" \
                            -o /watchtower \
                                .

                                #
                                # Stage 2: Minimal runtime image
                                #
                                FROM --platform=$TARGETPLATFORM alpine:3.19.0 AS alpine

                                RUN apk add --no-cache \
                                    ca-certificates \
                                        tzdata

                                        FROM scratch

                                        LABEL "com.centurylinklabs.watchtower"="true"

                                        COPY --from=alpine \
                                            /etc/ssl/certs/ca-certificates.crt \
                                                /etc/ssl/certs/ca-certificates.crt
                                                COPY --from=alpine \
                                                    /usr/share/zoneinfo \
                                                        /usr/share/zoneinfo

                                                        COPY --from=builder /watchtower /watchtower

                                                        EXPOSE 8080

                                                        HEALTHCHECK CMD [ "/watchtower", "--health-check"]

                                                        ENTRYPOINT ["/watchtower"]
