FROM crystallang/crystal:latest-alpine as builder
WORKDIR /src
COPY src/. .
RUN crystal build --release --static crystal_demo.cr -o /src/crystal_demo

FROM busybox
WORKDIR /app
COPY --from=builder /src/crystal_demo /app/crystal_demo
EXPOSE 8080
CMD /app/crystal_demo
