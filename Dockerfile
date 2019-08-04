FROM rocker/shiny:3.5.1

RUN apt-get update && apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev libv8-3.14-dev -y --no-install-recommends &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

RUN R -e "install.packages('shiny')"

## ADD files from repo to path 
COPY global.R  server.R ui.R /srv/shiny-server/
RUN chmod -R 755 /srv/shiny-server/

## Add config files
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh

EXPOSE 80

CMD ["/usr/bin/shiny-server.sh"]
