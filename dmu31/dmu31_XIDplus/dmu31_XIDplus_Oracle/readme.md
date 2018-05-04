xid+ on Oracle with Docker
==========================


## Installing Docker
Installing docker on the Oracle bare metal instance was eventually carried out using the instructions from this
 blog: [https://blog.dbi-services.com/docker-ce-on-oracle-enterprise-linux-7/](https://blog.dbi-services.com/docker-ce-on-oracle-enterprise-linux-7/)

Once installed, docker needs to be started:

`sudo systemctl enable docker`

`sudo systemctl start docker`

To test docker is working, run the following example:

`docker run hello-world`

## Docker swarm
Docker swarm allows the running and managment of many containers doing the same job. The tutorial 
[https://docs.docker.com/engine/swarm/swarm-tutorial/](https://docs.docker.com/engine/swarm/swarm-tutorial/) is a good place to get going


First, docker needs to be initiated:
`docker swarm init`

If running over numerous nodes, you can add other nodes or 'workers' to this swarm. As I have access to one bare 
metal instance, this isn't necessary.

This next step is to create a service. 
`docker service create --reserve-memory 13G --reserve-cpu 4 \
--mount type=bind,src=/mnt/raid1/Lockman-SWIRE/,dst=/scratch \
-w /scratch --name xidplus pdh21/xidplus:v2 python XIDp_run_script_spire_tile.py`


oracle help cloud password: Iamnumber1inhelp