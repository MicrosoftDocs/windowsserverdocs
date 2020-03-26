---
title: Manage Resources in Multiple Active Directory Forests
description: This topic is part of the IP Address Management (IPAM) Management guide in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ipam
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82f8f382-246e-4164-8306-437f7a019e0f
ms.author: lizross
author: eross-msft
---
# Manage Resources in Multiple Active Directory Forests

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to use IPAM to manage domain controllers, DHCP servers, and DNS servers in multiple Active Directory forests.  
  
To use IPAM to manage resources in remote Active Directory forests, each forest that you want to manage must have a two way trust with the forest where IPAM is installed.  
  
To start the discovery process for different Active Directory forests, open Server Manager and click IPAM. In the IPAM client console, click **Configure Server Discovery**, and then click **Get forests**. This initiates a background task that discovers trusted forests and their domains. After the discovery process completes, click **Configure Server Discovery**, which opens the following dialog box.  
  
![Configure Server Discovery](../../media/Manage-Resources-in-Multiple-Active-Directory-Forests/ipam_serverdiscovery.jpg)  

>[!NOTE]
>For Group Policy\-based provisioning for an Active Directory Cross Forest scenario, ensure that you run the following Windows PowerShell cmdlet on the IPAM server and not on the trusting domain DCs. As an example, if your IPAM server is joined to the forest corp.contoso.com and the trusting forest is fabrikam.com, you can run the following Windows PowerShell cmdlet on the IPAM server in corp.contoso.com for Group Policy\-based provisioning on the fabrikam.com forest. To run this cmdlet, you must be a member of the Domain Admins group in the fabrikam.com forest.

    
    Invoke-IpamGpoProvisioning -Domain fabrikam.COM -GpoPrefixName IPAMSERVER -IpamServerFqdn IPAM.CORP.CONTOSO.COM
    

In the **Configure Server Discovery** dialog box, click **Select the forest**, and then choose the forest that you want to manage with IPAM. Also select the domains that you want to manage, and then click **Add**.

In **Select the server roles to discover**, for each domain that you want to manage, specify the type of servers to discover. The options are **Domain controller**, **DHCP server**, and **DNS server**.

By default, domain controllers, DHCP servers, and DNS servers are discovered - so if you do not want to discover one of these types of servers, ensure that you deselect the checkbox for that option.

In the example illustration above, the IPAM server is installed in the contoso.com forest, and the root domain of the fabrikam.com forest is added for IPAM management. The selected server roles allow IPAM to discover and manage domain controllers, DHCP servers, and DNS servers in the fabrikam.com root domain and the contoso.com root domain.

After you have specified forests, domains, and server roles, click **OK**. IPAM performs discovery, and when discovery completes, you can manage resources in both the local and remote forest.
