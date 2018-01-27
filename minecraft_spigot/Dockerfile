FROM openjdk

RUN apt-get update && apt-get upgrade -y && apt-get install wget && apt-get autoremove --purge

#Download last version of spigot
RUN mkdir -p /webserver \
	&& wget https://cdn.getbukkit.org/spigot/spigot-1.12.jar -O /webserver/minecraft_server.jar

EXPOSE 25565


# /data contains static files and database
VOLUME ["/data"]

WORKDIR /data
# start the server
#CMD ["java","-Xms512M","-Xmx3G","-Dcom.mojang.eula.agree=true","-Dfile.encoding=UTF-8","-jar","/webserver/minecraft_server.jar","nogui"]
