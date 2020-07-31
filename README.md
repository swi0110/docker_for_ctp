# **Docker for CTP**
You can execute the CTP in docker.

###### How to create the container?
Execute the 'make_for_container.sh'.
It makes the 2 containers.

The container name is 'docker_for_ctp_01', 'docker_for_ctp_02'.
And you can connect the container by SSH.

###### How to install the CUBRID?
If you download the 'CUBRID.sh' into the 'ctp_config/CUBRID_engine/', it is easy.
Execute the 'install_CUBRID.sh'.

The normal way is please refer to the CUBRID manual.
https://www.cubrid.org/manual/en/10.2/install.html#installing-and-running-cubrid-on-linux

###### How to execute the ctp test?
If you want to change the 'test scenario path', open the 'CTP/conf/*.conf'.
and change the 'scenario' variable.

The detail is followed to refer to this.
https://github.com/CUBRID/cubrid-testtools
