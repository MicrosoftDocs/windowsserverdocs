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

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!div class="step-by-step"]
[« Configure fabrc DNS](guarded-fabric-configuring-fabric-dns-ad.md)
[Configure HTTPS »](guarded-fabric-configure-hgs-https.md)

Use the following steps to set up DNS forwarding and establish a one-way trust with the fabric domain. These steps allow the HGS to locate the fabric domain controllers and validate group membership of the Hyper-V hosts.

1.  Run the following command in an elevated PowerShell session to configure DNS forwarding. Replace fabrikam.com with the name of the fabric domain and type the IP addresses of DNS servers in the fabric domain. For higher availability, point to more than one DNS server.

    ```powershell
    Add-DnsServerConditionalForwarderZone -Name "fabrikam.com" -ReplicationScope "Forest" -MasterServers <DNSserverAddress1>, <DNSserverAddress2>
    ```

2.  To create a one-way forest trust, run the following command in an elevated Command Prompt:

    Replace `relecloud.com` with the name of the HGS domain and `fabrikam.com` with the name of the fabric domain. Provide the password for an admin of the fabric domain.

        netdom trust relecloud.com /domain:fabrikam.com /userD:fabrikam.com\Administrator /passwordD:<password> /add

