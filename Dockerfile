# Public demo of the submitted stage-4 build. The service code is fetched unchanged from the
# submission repository at a pinned commit; this wrapper only adds a proxy and demo data.
FROM golang:1.24-alpine AS build
RUN apk add --no-cache git
ARG REPO=https://github.com/Whom-m0rty/revived-pocketful-dark-factory
ARG COMMIT=3f718caef57e1c3c02cc02e6ada3c16ffeaffe74
RUN git clone "$REPO" /src && cd /src && git checkout "$COMMIT"
WORKDIR /src/stage-4
RUN CGO_ENABLED=0 go build -o /pocketful .

FROM alpine:3.20
RUN apk add --no-cache nginx curl coreutils
COPY --from=build /pocketful /app/pocketful
COPY nginx.conf /etc/nginx/http.d/default.conf
COPY start.sh seed.json /app/
RUN chmod +x /app/start.sh
EXPOSE 7860
CMD ["/app/start.sh"]
