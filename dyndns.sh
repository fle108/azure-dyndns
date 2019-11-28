#!/bin/bash
#####################################
#   DynDNS Script - AzureDNSservice #
#-----------------------------------#
#   .use with    : crontab          #
#                                   #
#   .deps       : azurecli (python) #
#                 jq (json proc)    #
#-----------------------------------#
# fle108 2019                       #
#####################################


# az cli vars
applicationid="<your_app_id>"
tenantId="<your_tenant_id>"
passwd="<your_app_secret>"

# connect to tenant
az login --service-principal -u $applicationid -p $passwd --tenant $tenantId

# ask dns zone and parse result with jq to obtain ip vlue only
zone="<zone_name>"
rg="<resource_group>"
rc="<DNSrecord_name>"
#possible to get it from hostname file by: $(cat /etc/hostname)
azdnsvalue=$(az network dns record-set a show -g $rg -n $rc -z $zone |jq -r '.arecords[0].ipv4Address')

# check public ip
ip=$(curl -sS ifconfig.co/ip)
#if using own echo-ip service: ip=$(curl -sS echo-ip.yourdomain.ext |jq -r '.ip')

# compare values $ip and $azdnsvalue
if [ $azdnsvalue = $ip ]
then 
    echo "Same Ip - Nothing to do"
else
    az network dns record-set a add-record --resource-group $rg --zone-name $zone --record-set-name $rc --ipv4-address $ip
    az network dns record-set a remove-record --resource-group $rg --zone-name $zone --record-set-name $rc --ipv4-address $azdnsvalue
    echo " Record $rc updated with Ip $ip"
fi