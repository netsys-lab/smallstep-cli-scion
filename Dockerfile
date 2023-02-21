FROM golang:1.18-alpine
WORKDIR /src
COPY . .
WORKDIR /src/cmd/step
RUN CGO_ENABLED=0 go build

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=0 /src/cmd/step/step /bin/step
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
# ENTRYPOINT ["sleep"]
ENTRYPOINT ["/startup.sh"]
# CMD [ "sleep", "infinity" ]