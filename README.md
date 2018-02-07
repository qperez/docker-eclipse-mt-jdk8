# docker-eclipse-mt-jdk8

Run [Eclipse Oxygen 2 Modeling Tools ](https://www.eclipse.org/downloads/packages/release/Oxygen/2) with Acceleo and ATL plugins inside a container :D !


## Image configuration :
* Based on Ubuntu 14.04
* JDK 8
* Eclipse Oxygen 2 Modeling Tools 
    * Acceleo plugin
    * ATL plugin
    
## How to start ? 
I have simplified the startup as much as possible,
for the first startup you have to execute the following command to authorize 
the connexion of the X server between your machine and the container : 
```shell
$ xhost +local:docker
```

After that, all you have to do is start the container with script provided : 
```shell
$ chmod +x run-eclipse-mt-jdk8.sh
$ ./run-eclipse-mt-jdk8.sh
```

## How it works ?  
File sharing is done with volumes between your machine and the container, 
the '_docker run_' command present in the script '_run-eclipse-mt-jdk8.sh_' is in charge of that.
The script create two directories inside your home to save your project workspace and the settings of Eclipse.
```shell
###################                              #####################
# User home local #                              #  Docker container #
###################                              #####################
/home/user/                                      /home/developer/
|-- eclipse-mt-jdk8-config/    <==shared with==> |-- .eclipse/ AND /opt/eclipse/configuration 
|-- eclipse-mt-jdk8-workspace/ <==shared with==> |-- eclipse-workspace/
|                                                |
...                                              ...
```
The docker run command used in the script is the following :
 ```shell
 $ docker run \
   -e DISPLAY \
   -v  "$CONFIG_DIR /opt/eclipse/configuration" \
   -v  "$CONFIG_DIR /home/developer/.eclipse" \
   -v  "${HOME}/.Xauthority:/home/developer/.Xauthority" \
   -v  "$WORKSPACE_DIR:/home/developer/eclipse-workspace" \
   --rm -it --net=host qperez/eclipse-mt-jdk8
 ```


## How to create my own image ? 
You can create your own image of docker eclipse with these two files : 
* Dockerfile
* build_install_eclipse --> Install Eclipse in the /opt directory, it's a workaround about the both
behaviors of 'ADD' command with local and remote compressed file : [https://github.com/moby/moby/issues/2369](https://github.com/moby/moby/issues/2369)

You can build your own image with a your local Eclipse (.tar.gz format) or with an URL to download
Eclipse (.tar.gz).

### Default build with Eclipse Modeling Oxygen 2
 ```shell
$ docker build -t [image_name]:[tag_name] .
 ```

### Build with a local image Eclipse
 ```shell
$ docker build -t [image_name]:[tag_name] --build-arg URL_ECLIPSE=[directory .tar.gz eclipse] .
 ```

### Build with an URL to download Eclipse
 ```shell
$ docker build -t [image_name]:[tag_name] --build-arg URL_ECLIPSE=[url to download eclipse] .
 ```

## End's meme
![alt text](http://blog.cloud66.com/content/images/2015/05/56291573.jpg)