FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

#required. tools
RUN apt-get update && apt-get install -y  --no-install-recommends apt-utils\
    python3 \
    python3-pip \
    tar \
    wget \
    unzip \
    && \
    rm -rf /var/lib/apt/lists/*

# plink
     
RUN  wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200616.zip && \
     unzip -j plink_linux_x86_64_20200616.zip && \
     rm -rf plink_linux_x86_64_20200616.zip     
     
   
#COPY mostest_demo.tar.gz  /

#RUN tar xvfz  mostest_demo.tar.gz  -C /

# dataset
    
 RUN wget https://5c2d08d4-17d1-4dd8-bb49-f9593683e642.filesusr.com/archives/e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip

RUN unzip -j  e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip 

    
# PRSice    

RUN wget https://github.com/choishingwan/PRSice/releases/download/2.3.3/PRSice_linux.zip  && \
          unzip PRSice_linux.zip  && \
          rm -rf PRSice_linux.zip
          
          
 # RUN  wget  https://cran.r-project.org/src/base/R-4/R-4.0.0.tar.gz && \
 #           tar   xvfz  R-4.0.0.tar.gz    && \   
  #          rm   R-4.0.0.tar.gz 
 
 
        
RUN apt-get update && apt-get install -y r-base &&  apt-get install -y r-cran-ggplot2  &&  apt-get install -y  r-cran-data.table &&  apt-get install -y r-cran-optparse
