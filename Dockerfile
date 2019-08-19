FROM rocker/shiny:3.5.1

RUN apt-get update && apt-get install libcurl4-openssl-dev libssl-dev libgmp-dev libmpfr-dev libxml2-dev libv8-3.14-dev -y --no-install-recommends &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

RUN R -e "install.packages(c('shiny', 'quantreg', 'NbClust', 'pvclust','MASS','ggpubr', 'magrittr', 'ggrepel', 'lme4', 'HH', 'Hmisc', 'splitstackshape', 'car', 'wesanderson', 'agricolae', 'splines', 'data.table', 'multcompView', 'gplots', 'RColorBrewer', 'colorRamps', 'multcomp', 'ggplot2', 'DT', 'shinythemes', 'plotly', 'doBy', 'reshape', 'reshape2', 'plotrix', 'corrplot', 'tidyverse', 'FactoMineR', 'devtools', 'factoextra', 'missMDA', 'dplyr', 'ggbeeswarm', 'ggridges', 'cowplot', 'forcats', 'gapminder'))"

## ADD files from repo to path 
COPY global.R server.R ui.R /srv/shiny-server/
RUN chmod -R 755 /srv/shiny-server/

## Add config files
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN apt update && apt install -y net-tools procps
EXPOSE 80

CMD ["/usr/bin/shiny-server.sh"]
