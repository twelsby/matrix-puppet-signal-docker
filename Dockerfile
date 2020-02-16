FROM node:10.13.0 AS build
RUN git clone https://github.com/matrix-hacks/matrix-puppet-signal.git
WORKDIR /matrix-puppet-signal
RUN npm install

FROM node:10.13.0
COPY --from=build /matrix-puppet-signal /matrix-puppet-signal

RUN mkdir /conf /data && \
    ln -s /conf/config.json /matrix-puppet-signal/config.json && \
    ln -s /conf/signal-registration.yaml /matrix-puppet-signal/signal-registration.yaml && \
    ln -s /data/D_signal.sqlite /matrix-puppet-signal/D_signal.sqlite && \
    ln -s /data/__sysdb__.sqlite /matrix-puppet-signal/__sysdb__.sqlite && \
    ln -s /data /matrix-puppet-signal/data

ADD entry.sh /

ENTRYPOINT ["/bin/sh", "/entry.sh"]
