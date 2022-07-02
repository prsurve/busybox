FROM alpine:latest
RUN apk add --no-cache python3 py3-pip bash
COPY run-io.sh /
COPY write_metadata.py /
RUN chmod 755 /run-io.sh
