FROM nextcloud:latest
RUN apt update && apt install -y ffmpeg nano
