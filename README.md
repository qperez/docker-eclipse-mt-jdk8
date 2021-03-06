# docker-eclipse-mt-jdk8

Run [Eclipse Oxygen 2 Modeling Tools ](https://www.eclipse.org/downloads/packages/release/Oxygen/2) with Acceleo, ATL and Papyrus plugins inside a container :whale: !

## Available tags
```shell
oxygen
```
```shell
latest
```

## Prerequisites
* [Docker](https://www.docker.com/community-edition)
* On Mac : [XQuartz](https://www.xquartz.org/)

## Image configuration :
* Based on Ubuntu 14.04
* JDK 8
* Eclipse Oxygen 2 Modeling Tools 
    * Acceleo plugin
    * ATL plugin
    * Papyrus plugins
        * Papyrus SysML 1.4
        * Papyrus SDK 
        * Papyrus BPMN
        * Papyrus ToolSmiths
        
    
## How to start ? 
I have simplified the startup as much as possible with a script. :ok_hand: 

### Linux 
For the first startup you have to execute the following command to authorize 
the connexion of the X server between your machine and the container : 
```shell
$ xhost +local:docker
```
After that, all you have to do is start the container with script provided for LINUX : 
```shell
$ chmod +x run-eclipse-mt-jdk8.sh
$ ./run-eclipse-mt-jdk8.sh [tag_name]
```
You can precise the version of Eclipse with the parameter '_[tag_name]_', by default without the param, the tag name is 
the latest image built.
```shell
$ ./run-eclipse-mt-jdk8.sh oxygen
```

### Mac
To use this image, you must have XQuartz installed on your machine.
To install and launch XQuartz, see here : [https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc](https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc)

![XQuartz configuration](https://cdn-images-1.medium.com/max/800/1*t9RTn9w0PwQAMtK1yrq1GQ.png)

After that, all you have to do is start the container with script provided for MAC: 
```shell
$ chmod +x run-eclipse-mt-jdk8-mac.sh
$ ./run-eclipse-mt-jdk8-mac.sh [tag_name] <IP_XQUARTZ>
```
You can precise the version of Eclipse with the parameter '_[tag_name]_', by default without the param, the tag name is 
the latest image built.
```shell
$ ./run-eclipse-mt-jdk8.sh oxygen 192.168.0.80
```

## How it works ?  
File sharing is done with volumes between your machine and the container, the '_docker run_' command present in the script '_run-eclipse-mt-jdk8.sh_' is in charge of that.
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
   --rm -it --net=host qperez/eclipse-mt-jdk8:${TAG}
 ```


## How to create my own image ? 
You can create your own image of docker eclipse with these two files : 
* Dockerfile
* build_install_eclipse.sh :arrow_right: Install Eclipse in the /opt directory, it's a workaround about the both
behaviors of 'ADD' command with local and remote compressed file : [https://github.com/moby/moby/issues/2369](https://github.com/moby/moby/issues/2369)

You can build your own image with a your local Eclipse (.tar.gz format) or with an URL to download
Eclipse (.tar.gz).

#### Default build with Eclipse Modeling Oxygen 2
The command is the following : 
 ```shell
$ docker build -t [image_name]:[tag_name] .
 ```

#### Build with a local image Eclipse
The command is the following : 
 ```shell
$ docker build -t [image_name]:[tag_name] --build-arg URL_ECLIPSE=[directory .tar.gz eclipse] .
 ```

#### Build with an URL to download Eclipse
The command is the following : 
 ```shell
$ docker build -t [image_name]:[tag_name] --build-arg URL_ECLIPSE=[url to download eclipse] .
 ```

## End's memes :trollface:
![Meme container](http://blog.cloud66.com/content/images/2015/05/56291573.jpg)
![Meme_container](https://thinkwhere1.files.wordpress.com/2016/07/docker_future-e1468491725978.jpg?w=613&h=345)