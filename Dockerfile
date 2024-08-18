FROM groovy:3.0.9-jdk11

WORKDIR /app

COPY vars/ /app/vars/

RUN apt-get update && apt-get install -y \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

CMD ["groovy", "vars/hello.groovy"]
