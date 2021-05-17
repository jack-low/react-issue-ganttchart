FROM node

# install some packages to use electron
RUN apt-get update \
    && apt-get -y install libgtkextra-dev libgconf2-dev libnss3 libasound2 libxtst-dev libxss1 libgtk-3-0

RUN apt-get update \
    && apt-get install -y curl sudo

# 日本語が使えるようにする
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y locales
RUN locale-gen ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

# install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash \
    && export PATH="$PATH:`yarn global bin`"

# set workdir
WORKDIR /var/src/app
COPY . .

EXPOSE 3000
RUN yarn upgrade --network-timeout 600000
RUN yarn install
CMD [ "yarn","start" ]
