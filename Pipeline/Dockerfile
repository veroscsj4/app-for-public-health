FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    bowtie2 \
    fastp \
    samtools \
    freebayes \
    wget \
    unzip \
    build-essential \
    zlib1g-dev \
    python3 \
    python3-pip

RUN pip3 install pandas

# Download and install wgsim
RUN wget https://github.com/lh3/wgsim/archive/master.zip && \
    unzip master.zip && \
    gcc -g -O2 -Wall -o /usr/local/bin/wgsim wgsim-master/wgsim.c -lz -lm && \
    rm -rf wgsim-master master.zip

# Copy the wrapper script into the container
COPY pipline_wrapper.sh /usr/local/bin/pipeline_wrapper.sh
COPY ./script/genome_comparison.py /usr/local/bin/genome_comparison.py

RUN chmod +x /usr/local/bin/pipeline_wrapper.sh

# Set working directory
WORKDIR /data

# Set the wrapper script as the entrypoint
ENTRYPOINT ["/usr/local/bin/pipeline_wrapper.sh"]
