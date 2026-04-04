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

                # Cache dependency downloads (faster rebuilds when only code changes)
                COPY go.mod go.sum ./
                RUN go mod download

                # Regenerate go.sum to account for any dependency updates
                RUN go mod tidy

                # Copy full source and build
                COPY . .

                ARG VERSION=dev
                RUN CGO_ENABLED=0 GOOS=linux go build \
                    -a \
                        -ldflags "-extldflags '-static' -X github.com/containrrr/watchtower/internal/meta.Version=${VERSION}" \
                            -o /watchtower \
                                .

                                #
                                # Stage 2: Pull certs and timezone data from alpine
                                #
                                FROM alpine:3.19.0 AS alpine

                                RUN apk add --no-cache \
                                    ca-certificates \
                                        tzdata

                                        #
                                        # Stage 3: Minimal scratch runtime image
                                        #
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
