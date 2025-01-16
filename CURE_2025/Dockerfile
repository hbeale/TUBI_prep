FROM ubuntu:14.04
MAINTAINER holly beale

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  git \
  unzip \
  build-essential \
  zlib1g-dev \
  cmake \
  samtools \
  software-properties-common \
less \
&& rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get update && apt-get install -y --no-install-recommends \
  openjdk-8-jdk \
  && rm -rf /var/lib/apt/lists/*
# Install freebayes
RUN wget https://github.com/freebayes/freebayes/releases/download/v1.3.4/freebayes-1.3.4-linux-static-AMD64.gz
RUN gzip -d freebayes-1.3.4-linux-static-AMD64.gz 
RUN mv freebayes-1.3.4-linux-static-AMD64 bin
RUN chmod +x bin/freebayes-1.3.4-linux-static-AMD64 

# Install snpEFF
RUN wget -nv http://sourceforge.net/projects/snpeff/files/snpEff_v4_3r_core.zip \
  && unzip snpEff_v4_3r_core.zip && rm snpEff_v4_3r_core.zip
RUN java -jar ./snpEff/snpEff.jar download hg19

WORKDIR /app
ADD . /app

ENTRYPOINT ["/bin/bash", "run.sh"]
