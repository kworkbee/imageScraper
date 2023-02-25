FROM python:latest

WORKDIR /home

RUN apt-get -y update && apt install wget && apt install unzip

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/` && \
    curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip

RUN apt -y install ./google-chrome-stable_current_amd64.deb

RUN mkdir chrome && unzip /tmp/chromedriver.zip chromedriver -d /home/chrome

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

CMD [ "python", "app/collect.py" ]