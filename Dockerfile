FROM ubuntu:20.04 as build
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y \
    curl=7.68.0-1ubuntu2.1 \
    unzip=6.0-25ubuntu1 \
    ca-certificates=20190110ubuntu1
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.1.3
FROM ubuntu:20.04 as deno
RUN groupadd --gid 1000 deno && \
  useradd --uid 1000 --gid deno --shell /bin/bash --create-home deno
COPY --from=build /root/.deno /root/.deno
RUN ln -s /root/.deno/bin/deno /usr/local/bin/deno
CMD [ "deno" ]
