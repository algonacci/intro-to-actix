FROM rust:1.69.0 as build

WORKDIR /usr/src/intro-to-actix
COPY . .

RUN apt-get update && apt-get install libpq5 -y

RUN cargo install --path .

FROM gcr.io/distroless/cc-debian11

ARG ARCH=aarch64

COPY --from=build /usr/lib/${ARCH}-linux-gnu/libpq.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libgssapi_krb5.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libldap_r-2.4.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libkrb5.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libk5crypto.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libkrb5support.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/liblber-2.4.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libsasl2.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libgnutls.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libp11-kit.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libidn2.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libunistring.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libtasn1.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libnettle.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libhogweed.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libgmp.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /usr/lib/${ARCH}-linux-gnu/libffi.so* /usr/lib/${ARCH}-linux-gnu/
COPY --from=build /lib/${ARCH}-linux-gnu/libcom_err.so* /lib/${ARCH}-linux-gnu/
COPY --from=build /lib/${ARCH}-linux-gnu/libkeyutils.so* /lib/${ARCH}-linux-gnu/

COPY --from=build /usr/local/cargo/bin/intro-to-actix /usr/local/bin/intro-to-actix


CMD ["intro-to-actix"]
