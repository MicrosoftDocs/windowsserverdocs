---
title: Configure DNS forwarding and domain trust 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Configure DNS forwarding in the HGS domain and a one-way trust with the fabric domain

Use the following steps to set up necessary DNS forwarding from the HGS domain to the fabric domain, and to establish a one-way forest trust to the fabric domain. These steps allow the HGS to locate the fabric domain's domain controllers and validate group membership of the Hyper-V hosts.

1.  To configure a DNS forwarder that allows HGS to resolve resources located in the fabric (host) domain, run the following command in an elevated PowerShell session. 

    Replace fabrikam.com with the name of the fabric domain and type the IP addresses of DNS servers in the fabric domain. For higher availability, point to more than one DNS server.

    ```powershell
    Add-DnsServerConditionalForwarderZone -Name "fabrikam.com" -ReplicationScope "Forest" -MasterServers <DNSserverAddress1>, <DNSserverAddress2>
    ```

2.  To create a one-way forest trust from the HGS domain to the fabric domain, run the following command in an elevated Command Prompt:

    Replace `relecloud.com` with the name of the HGS domain and `fabrikam.com` with the name of the fabric domain. Provide the password for and admin of the fabric domain.

        netdom trust relecloud.com /domain:fabrikam.com /userD:fabrikam.com\Administrator /passwordD:<password> /add

