# azure-dyndns
bash script to operate as DynDNS with Azure-DNS-zone

------------------------------------------------------------

## Usage and Env
> works on debian and ubuntu \
> tested on raspberry Pi - Raspbian (original goal of that project)

download `dyndns.sh` and make it executable
```sh
chmod +x ./dyndns.sh
```
Cron it (e.g twice a day or every hour)
```sh
sudo crontab -e
```
------------------------------------------------------------

## Dependencies
This script require `python3`, `azure-cli`, `curl`, and `jq` 
* python
```sh
sudo apt install python3
```
* azure-cli 
>following method is used with raspian because of no package available in sources repository
>however on linux or debian use `sudo apt install azure-cli`
```sh
  curl https://azurecliprod.blob.core.windows.net/install.py >> installAzureCliPython.py
  sudo chmod +x installAzureCliPython.py
  python3 installAzureCliPython.py
  exec -l $SHELL
  az --version
```
* curl (if not installed)
```sh
sudo apt install curl
```

* jq (json processor)
[jq website](https://stedolan.github.io/jq/)
```sh
sudo apt install jq
```

---------------------------------------------------------------

## External services

* Azure tenant with existing azureDNSzone
* External echo/mirror ip service
In order to get current ip address you need a echo/miror ip service \
you can use third party service as the excellent [ifconfig.co](http://ifconfig.co) \
or use you own based on works already present on GitHub. \
In my case i use [Greenstatic/echo-ip](https://github.com/greenstatic/echo-ip) dev in `Go` that fits very well with a [microk8s](https://microk8s.io/) deploy.  \


>[Greenstatic/echo-ip](https://github.com/greenstatic/echo-ip) is a good tool for docker/k8s env because it's able to recover X-Forwarded source ip through proxy/ingress.
