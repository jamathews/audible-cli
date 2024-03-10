FROM python:alpine

ARG DOCKER_UID

# Create a user to run the application
RUN adduser -D -u ${DOCKER_UID} audible-cli
RUN apk add bash ffmpeg
COPY . /audible-cli
WORKDIR /audible-cli
RUN  pip3 install .
USER  audible-cli

CMD ["./start.sh"]
