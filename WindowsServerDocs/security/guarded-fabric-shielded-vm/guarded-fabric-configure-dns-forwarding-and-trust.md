---
title: Configure DNS forwarding and domain trust 
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Configure DNS forwarding in the HGS domain and a one-way trust with the fabric domain

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!IMPORTANT]
>AD mode is deprecated beginning with Windows Server 2019. For environments where TPM attestation is not possible, configure [host key attestation](guarded-fabric-initialize-hgs-key-mode.md). Host key attestation provides similar assurance to AD mode and is simpler to set up. 

Use the following steps to set up DNS forwarding and establish a one-way trust with the fabric domain. These steps allow the HGS to locate the fabric domain controllers and validate group membership of the Hyper-V hosts.

1.  Run the following command in an elevated PowerShell session to configure DNS forwarding. Replace fabrikam.com with the name of the fabric domain and type the IP addresses of DNS servers in the fabric domain. For higher availability, point to more than one DNS server.

    ```powershell
    Add-DnsServerConditionalForwarderZone -Name "fabrikam.com" -ReplicationScope "Forest" -MasterServers <DNSserverAddress1>, <DNSserverAddress2>
    ```

2.  To create a one-way forest trust, run the following command in an elevated Command Prompt:

    Replace `bastion.local` with the name of the HGS domain and `fabrikam.com` with the name of the fabric domain. Provide the password for an admin of the fabric domain.

        netdom trust bastion.local /domain:fabrikam.com /userD:fabrikam.com\Administrator /passwordD:<password> /add

## Next step 

> [!div class="nextstepaction"]
> [Configure HTTPS](guarded-fabric-configure-hgs-https.md)
