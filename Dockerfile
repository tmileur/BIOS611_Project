# Use rocker/verse with platform specification
FROM --platform=linux/amd64 rocker/verse:latest

RUN apt-get update && apt-get install -y \
	man-db \
	git \
	
RUN yes | unminimize

RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install pandas \
	numpy \ 
	scikit-learn \
	seaborn \

RUN rm -rf /var/lib/apt/lists/*