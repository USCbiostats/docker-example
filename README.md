# Dockerfile

Here is an example of a simple [Docker file](https://docs.docker.com/engine/reference/builder/).
In this case, we are reusing the [`r-base` image with tag `latest`](https://hub.docker.com/_/r-base);
we then copy a bash script `checkit.sh`; and finalize with `Rscript` installing
the [**igraph**](https://cran.r-project.org/package=igraph) R package.

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

To build the docker container, named `docker-example`, use:

```
sudo docker build --compress -t docker-example .
```

This image is now available to be used in your computer. In case you want it
to release it to https://hub.docker.com, you'd need to do the following:

```bash
sudo docker login # follow the prompts
sudo docker tag docker-example:latest uscbiostats/docker-example:latest
sudo docker push uscbiostats/docker-example:latest
```

Where `uscbiostats` is the name of the account to which you will be pushing this
image. This way, users who have access to docker can simply type

```bash
sudo docker pull uscbiostats/docker-example:latest
```

To have access to this image that contains R with igraph installed.

# Usage

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

# Running Docker in rootless-mode

https://docs.docker.com/engine/security/rootless/ while installing the rootless
mode, I encountered a problem regarding a missing binary in Ubuntu 18.04. This
repository had an issue with the problem:

https://github.com/moby/moby/issues/41781#issuecomment-743267936

In my case, I ran the following steps:

1. cd /usr/bin
2. sudo curl -o slirp4netns --fail -L https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.10/slirp4netns-$(uname -m)
3. chmod +x slirp4netns

