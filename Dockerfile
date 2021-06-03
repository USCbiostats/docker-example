FROM r-base:latest
COPY checkit.sh .
RUN Rscript -e 'install.packages("igraph")'
CMD ["bash"]
