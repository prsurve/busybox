FROM quay.io/prsurve/busybox:stable
COPY run-io.sh /
RUN chmod 755 /run-io.sh
ENTRYPOINT [ "/run-io.sh" ]
