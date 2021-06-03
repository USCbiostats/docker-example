# Dockerfile

```Dockerfile
FROM r-base:latest
COPY checkit.sh .
RUN Rscript -e 'install.packages("igraph")'
CMD ["bash"]
```

Where `checkit.sh` has the following contents:

```bash
cd /home/docker/
R CMD check netplot
```

# Usage

To build the docker container, named `docker-example`, use:

```
sudo docker build --compress -t docker-example .
```

To execute it interactively (with R), type:

```
sudo docker run -i docker-example R
```

Or if you want to run Rscript:

```
sudo docker run -i docker-example Rscript -e '1 + 1'
```

If you want to run it while having access to the current directory:

```
sudo docker run -i -v$(pwd):/home/ -w/home/ docker-example Rscript -e '1 + 1'
```


