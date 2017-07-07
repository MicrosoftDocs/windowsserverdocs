---
title: Add host information for Admin-trusted attestation
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 87089ebc-b953-4aa3-96b5-966cf91acb02
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 03/02/2017
---

>Applies To: Windows Server 2016

# Add host information for Admin-trusted attestation

The following two sections describe how to configure DNS forwarding, and add host information to HGS for AD mode:

- [Configuring DNS forwarding and domain trust](#configure-dns-forwarding-and-domain-trust)
- [Adding security group information to the HGS configuration](#add-security-group-information-to-the-hgs-configuration)

## Add security group information to the HGS configuration 

1.  Obtain the SID of the [security group](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md#create-a-security-group-and-add-hosts) for guarded hosts from the fabric administrator and run the following command to register the security group with HGS. Re-run the command if necessary for additional groups. Provide a friendly name for the group. It does not need to match the Active Directory security group name. 

    ```powershell
    Add-HgsAttestationHostGroup -Name "<GuardedHostGroup>" -Identifier "<SID>"
    ```

2.  To verify the group was added, run [Get-HgsAttestationHostGroup](https://technet.microsoft.com/library/mt652172.aspx). 

This completes the process of configuring an HGS cluster for AD mode. The fabric administrator might need you to provide two URLs from HGS before the configuration can be completed for the hosts. To obtain these URLs, on an HGS server, run [Get-HgsServer](https://technet.microsoft.com/library/mt652162.aspx).

