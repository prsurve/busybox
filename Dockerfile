FROM alpine:latest
RUN apk add --no-cache python3 py3-pip bash coreutils git automake autoconf build-base
COPY run-io.sh /
COPY write_metadata.py /
RUN git clone https://github.com/avati/arequal.git
WORKDIR arequal
RUN ./autogen.sh ; ./configure ; make ; make install
WORKDIR /
RUN apk del git automake autoconf build-base python3 python3 --no-cache 
RUN rm -rf arequal
RUN chmod 755 /run-io.sh
