FROM golang:1.18-alpine
RUN apk add --no-cache git 
WORKDIR /src
COPY . .
WORKDIR / 
RUN git clone https://github.com/netsys-lab/smallstep-ca-scion.git
WORKDIR /src/cmd/step
RUN CGO_ENABLED=0 go build -buildvcs=false

FROM alpine
RUN apk add --no-cache ca-certificates bash 
COPY --from=0 /src/cmd/step/step /bin/step
COPY idle.sh /idle.sh
RUN chmod +x /idle.sh
# ENTRYPOINT ["sleep"]
# ENTRYPOINT ["/startup.sh"]
CMD [ "bash", "-c", "/idle.sh" ]

