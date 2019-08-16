---
title: Plan a Multi-Forest Deployment
description: This topic is part of the guide Deploy Remote Access in a Multi-Forest Environment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8acc260f-d6d1-4d32-9e3a-1fd0b2a71586
ms.author: pashort
author: shortpatti
---
# Plan a Multi-Forest Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the planning steps required when configuring Remote Access in a multi-forest deployment.  
  
## Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  
  
-   Two-way trust is required.  
  
## Plan trust between forests  
When you decide to enable access to resources from a new forest, allow clients from the new forest to use DirectAccess, or add Remote Access servers from the new forest as entry points to the Remote Access deployment, you must make sure that a full trust; that is, a two-way transitive trust, is configured between the two forests, see [Trust types](https://technet.microsoft.com/library/cc775736.aspx). Full trust between forests is a prerequisite for a multi-forest deployment to allow administrators to perform operations such as editing GPOs in the new forest, using security groups from new forest as the client security group, performing remote calls (WinRM, RPC) to computers in the new forest, and authenticating remote clients from the new forest.  
  
## Plan Remote Access administrator permissions  
When you configure Remote Access it updates and sometimes creates GPOs in each of the domains that contain Remote Access servers or clients. In a multi-forest environment, as in single-forest environments, the Remote Access administrator must have permissions to write and modify DirectAccess GPOs and their security filters and optionally have permissions to create links for the DirectAccess GPOs in all involved forests. These permissions are required regardless of the forest to which the Remote Access administrator belongs.  
  
In addition, the Remote Access administrator must be a local administrator on all Remote Access servers including on the Remote Access servers from the new forest that are added as entry points to the original Remote Access deployment.  
  
## <a name="ClientSG"></a>Plan client security groups  
You must configure at least one security group in the new forest for DirectAccess client machines in the new forest. This is because a single security group cannot contain accounts from several forests.  
  
> [!NOTE]  
> -   DirectAccess requires at least one Windows 10&reg; or Windows&reg; 8 client security group for each forest. However, it is recommended to have one Windows 10 or Windows 8 client security group for each domain that contains Windows 10 or Windows 8 clients.  
> -   When multisite is enabled, DirectAccess requires at least one  Windows 7&reg;  client security group per forest for each DirectAccess entry point in which  Windows 7  client computers are supported. However, it is recommended to have a separate  Windows 7  client security group for each entry point for each domain that contains  Windows 7  clients.  
>   
> For DirectAccess to be applied on client computers in additional domains, client GPOs must be created in those domains. Adding security groups triggers writing new client GPOs for the new domains; therefore, if you add a new security group from a new domain to the list of DirectAccess client security groups, a client GPO will be automatically created on the new domain and client computers from the new domain will get the DirectAccess settings via the client GPO.  
>   
> Note that if you add a client from a new domain to an existing security group that is already configured as a DirectAccess client security group, the client GPO will not be created automatically by DirectAccess on the new domain. The client in the new domain will not receive the DirectAccess settings and will not be able to connect using DirectAcecss.  
  
## Plan certification authorities  
If the DirectAccess deployment is configured to use One-Time Password (OTP) authentication, each forest contains the same signing certificate templates but with different Oid values. This results in the forests not being able to be configured as a single configuration unit. To resolve this issue and configure OTP in a multi-forest environment, see the section " Configure OTP in a multi-forest deployment" in the topic [Configure a Multi-Forest Deployment](Configure-a-Multi-Forest-Deployment.md).  
  
When using IPsec machine certificate authentication, all client and server computers must have a computer certificate issued by the same root or intermediate certification authority, regardless of the forest to which they belong.  
  
## Plan OTP exemptions  
If you are using DirectAccess OTP authentication, note that the OTP exemption security group is limited to users of a single forest. This is because each security group can contain only users from a single forest and only one such security group can be configured.  
  


