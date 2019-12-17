---
ms.assetid: 02580b2f-a339-4470-947c-d700b2d55f3f
title: When to Create a Federation Server Farm
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# When to Create a Federation Server Farm

Consider creating a federation server farm in Active Directory Federation Services \(AD FS\) when you have a larger AD FS deployment and you want to provide fault tolerance, load\-balancing, or scalability to your organization's Federation Service. The act of creating two or more federation servers in the same network, configuring each of them to use the same Federation Service, and adding the public key of each server's token\-signing certificates to the AD FS Management snap\-in creates a federation server farm.  
  
You can create a federation server farm or install additional federation servers to an existing farm by using the AD FS Federation Server Configuration Wizard. For more information, see [When to Create a Federation Server](When-to-Create-a-Federation-Server.md).  
  
> [!NOTE]  
> When you choose the option to create a **New federation server farm** using the AD FS Federation Server Configuration Wizard, the wizard will attempt to create a container object \(for sharing certificates\) in Active Directory. Therefore, it is important that you first log on to the computer, where you are setting up the federation server role, with an account that has sufficient permissions in Active Directory to create this container object.  
  
Before federation servers can be grouped as a farm, they must first be clustered so that requests that arrive at a single fully qualified domain name \(FQDN\) are routed to the various federation servers in the server farm. You can create the server cluster by deploying Network Load Balancing \(NLB\) inside the corporate network. This guide assumes that NLB has been configured appropriately to cluster each of the federation servers in the farm.  
  
For more information about how to configure a cluster FQDN using Microsoft NLB technology, see [Specifying the Cluster Parameters](https://go.microsoft.com/fwlink/?LinkID=74651).  
  
## Best practices for deploying a federation server farm  
We recommend the following best practices for deploying a federation server in a production environment:  
  
-   If you will be deploying multiple federation servers at the same time or you know that you will be adding more servers to the farm over time, consider creating a server image of an existing federation server in the farm and then installing from that image when you need to create additional federation servers quickly.  
  
    > [!NOTE]  
    > If you do decide to use the server image method for deploying additional federation servers, you do not have to complete the tasks in [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md) every time that you want to add a new server to the farm.  
  
-   Use NLB or some other form of clustering to allocate a single IP address for many federation server computers.  
  
-   Reserve a static IP address for each federation server in the farm and, depending on your Domain Name System \(DNS\) configuration, insert an exclusion for each IP address in Dynamic Host Configuration Protocol \(DHCP\). Microsoft NLB technology requires that each server that participates in the NLB cluster be assigned a static IP address.  
  
-   If the AD FS configuration database will be stored in a SQL database, avoid editing the SQL database from multiple federation servers at the same time.  
  
## Configuring federation servers for a farm  
The following table describes the tasks that must be completed so that each federation server can participate in a farmed environment.  
  
|Task|Description|  
|--------|---------------|  
|If you are using SQL Server to store the AD FS configuration database|A federation server farm consists of two or more federation servers that share the same AD FS configuration database and token\-signing certificates. The configuration database can be stored in either Windows Internal Database or in a SQL Server database. If you plan to store the configuration database in a SQL database, make sure that the configuration database is accessible so that it can be accessed by all new federation servers that participate in the farm. **Note:** For farm scenarios, it is important that the configuration database be located on a computer that does not also participate as a federation server in that farm. Microsoft NLB does not allow any of the computers that participate in a farm to communicate with one another. **Note:** Ensure that the identity of the AD FS AppPool in Internet Information Services \(IIS\)\) on every federation server that participates in the farm has Read access to the configuration database.|  
|Obtain and share certificates|You can obtain a single server authentication certificate from a public certification authority \(CA\)—for example, VeriSign. You can then configure the certificate so that all federation servers share the same private key portion of the certificate. For more information about how to share the same certificate, see [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md). **Note:** The AD FS Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.<br /><br />For more information, see [Certificate Requirements for Federation Servers](Certificate-Requirements-for-Federation-Servers.md).|  
|Point to the same SQL Server instance|If the AD FS configuration database will be stored in a SQL database, the new federation server must point to the same SQL Server instance that is used by other federation servers in the farm so that the new server can participate in the farm.|  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
