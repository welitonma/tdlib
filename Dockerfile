FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    make git zlib1g-dev libssl-dev gperf cmake g++ \
    curl wget \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tdlib/telegram-bot-api.git /telegram-bot-api

WORKDIR /telegram-bot-api/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. 
RUN cmake --build . --target install

WORKDIR /var/lib/telegram-bot-api

EXPOSE 8081

CMD ["/telegram-bot-api/bin/telegram-bot-api", "--local", "--dir=/var/lib/telegram-bot-api", "--http-port=8081"]
