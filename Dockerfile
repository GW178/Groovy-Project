FROM groovy:3.0.9-jdk11

WORKDIR /app

COPY vars/ /app/vars/

CMD ["groovy", "vars/hello.groovy"]


