# Use rocker/verse with platform specification
FROM --platform=linux/amd64 rocker/verse:latest

# Maintainer information
LABEL maintainer="Trevor Mileur"

# Create a new user 'tmileur' with a home directory
RUN useradd -m tmileur

# Set the password for 'tmileur'
RUN echo 'tmileur:bios611' | chpasswd

# Install additional system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    libmagick++-dev \
    libudunits2-dev \
    libavfilter-dev \
    libgdal-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    cargo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages
RUN R -e "install.packages(c('tidyverse', 'cluster', 'factoextra', 'pheatmap', 'dendextend', 'openxlsx', 'ggplot2', 'readxl'), repos = 'https://cloud.r-project.org', dependencies = TRUE)"

# Set the working directory inside the container
WORKDIR /home/rstudio/BIOS611_Project

# Copy the project directory into the container
# Add .dockerignore to avoid unnecessary files like .git or temp data
COPY . /home/rstudio/BIOS611_Project

# Ensure proper ownership for non-root users
RUN chown -R rstudio:rstudio /home/rstudio/BIOS611_Project

# Expose port 8787 for RStudio Server
EXPOSE 8787

# Set R_LIBS_USER environment variable for user-level R libraries
ENV R_LIBS_USER=/home/rstudio/R/library

# Set permissions for R library path
RUN mkdir -p /home/rstudio/R/library && chown -R rstudio:rstudio /home/rstudio/R/library

# Initialize the Git repository inside the container
RUN git init /home/rstudio/BIOS611_Project

# Default command to start the container with RStudio
CMD ["/init"]