FROM openjdk:11-jdk

WORKDIR /app

COPY vars/ /app/vars/

COPY install_dependencies.sh /tmp/install_dependencies.sh

RUN chmod +x /tmp/install_dependencies.sh && /tmp/install_dependencies.sh

CMD ["groovy", "vars/hello.groovy"]

