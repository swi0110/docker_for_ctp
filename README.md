# **Docker for CTP**
You can execute the CTP in docker.

### Container construct
All users password was 1234.<br/>
| Container name | ip | User | Role | Tools |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| docker_for_ctp_01 | 172.200.1.2 | ctp | Controller & SQL, SQL_BY_CCI, MEDIUM, JDBC unit test | CTP, cubrid-testcases |
|  |  | ha_repl_01 | HA_REPL(Master), SHELL test | CTP |
| docker_for_ctp_02 | 172.200.1.3 | ctp | Controller & SQL, SQL_BY_CCI, MEDIUM, JDBC unit test | CTP, cubrid-testcases |
|  |  | ha_repl_01 | HA_REPL(Slave), SHELL test | CTP |

<br/><br/>

### How to create the container?
Execute the 'make_for_container.sh'.<br/>
It makes the 2 containers.<br/><br/>

The container name is 'docker_for_ctp_01', 'docker_for_ctp_02'.<br/>
And you can connect the container by SSH.<br/><br/>

### How to install the CUBRID?
If you download the 'CUBRID.sh' into the 'ctp_config/CUBRID_engine/', it is easy.<br/>
Execute the 'install_CUBRID.sh'.<br/><br/>

The normal way is please refer to the CUBRID manual.<br/>
https://www.cubrid.org/manual/en/10.2/install.html#installing-and-running-cubrid-on-linux <br/><br/>

### How to execute the ctp test?
If you want to change the 'test scenario path', open the 'CTP/conf/*.conf'.<br/>
and change the 'scenario' variable.<br/><br/>

The detail is followed to refer to this.<br/>
https://github.com/CUBRID/cubrid-testtools <br/><br/>

