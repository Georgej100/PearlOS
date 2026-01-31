FROM debian:12

COPY setup.sh /tmp

RUN chmod 777 /tmp/setup.sh
RUN yes | /tmp/setup.sh

COPY . /pearlos
WORKDIR /pearlos

ENV PATH = "/opt/i386-elf/bin:$PATH"

CMD ["make", "dev"]
