
# JupyterHub container customized for DMaaS

FROM ubuntu:14.04

MAINTAINER Enric Tejedor Saavedra <lenric@gmail.com>

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    npm \
    nodejs-legacy \
    python3 \
    python3-pip

# Install JS dependencies
RUN npm install -g configurable-http-proxy

# Install JupyterHub
RUN pip3 install jupyterhub

# Install Docker Spawner
RUN mkdir -p /srv/jupyterhub/
WORKDIR /srv/jupyterhub/
RUN git clone https://github.com/jupyter/dockerspawner
WORKDIR /srv/jupyterhub/dockerspawner
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

WORKDIR /srv/jupyterhub/

EXPOSE 8000 

CMD ["jupyterhub"]
