Simple installation (one-command installation):
```
yum install -y wget && wget -O install.sh https://raw.githubusercontent.com/hon4/centos7-lapm/main/install.sh && bash install.sh
```

Or you can split it to multiple commands in case you have problems executing the singleline command for the setup.
1. Needs `wget` so if you do not have it installed use this command.
```
yum -y install wget
```
2. Get the bash file.
```
wget -O install.sh https://raw.githubusercontent.com/hon4/centos7-lapm/main/install.sh
```
3. Execute it.
```
bash install.sh
```
