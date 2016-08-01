---
title: Understanding RDS roles
description: Provides an overview of the independent roles in Remote Desktop Services
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
author: ChristianMontoya
manager: scottman
---

# Understanding RDS roles
Remote Desktop Services (RDS) in Windows Server has the following independent roles/services that, combined, make up a full RDS solution:

##  Remote Desktop Connection Broker  
Remote Desktop Connection Broker (RD Connection Broker) manages incoming remote desktop connections to the servers in Remote Desktop Session Host (RD Session Host) server farms, known as collections. RD Connection Broker handles connections to collections of full desktops and to collections of RemoteApps. For new connections, RD Connection Broker can balance the load across the servers in the collection. For a session that was disconnected, RD Connection Broker reconnects the user to the correct RD Session Host server and the disconnected session, which already exists in the RD Session Host farm.   
  
To support single sign-on and application publishing, you must have matching digital certificates installed on the RD Connection broker server and the client. For development and testing purposes, you can create a self-generated and self-signed certificate. For a released service, you must obtain a digital certificate from a trusted certification authority. The name of the certificate must be the internal Fully Qualified Domain Name (FQDN) of the RD Connection Broker virtual machine.  
  
For tenants with small numbers of users, you can install the RD Connection Broker on the same virtual machine running Active Directory Domain Services, RD Licensing, and the file server to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, you can create additional RD Connection Broker virtual machines in the same availability set to create an RD Connection Broker cluster. To create an RD Connection Broker cluster, you must deploy an Azure SQL Database or a SQL Server Always On Availability Group.  
  
Additional information:  
[Use an Azure SQL database to enable high availability for your Connection Broker](Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md)
[Getting Started with Always On Availability Groups (SQL Server)](https://msdn.microsoft.com/library/gg509118.aspx)

##  Remote Desktop Gateway  
  
The Remote Desktop Gateway (RD Gateway) component enables end-users who are using client devices on the public Internet to securely access Windows desktops and applications that are hosted in Microsoft Azure.  
  
The RD Gateway component uses Secure Sockets Layer (SSL) to provide an encrypted communications channel between the clients and the server. You must be able to access the RD Gateway virtual machine through a public IP address that allows inbound TCP connections to port 443 to allow the end-users to connect from the Internet using the HTTPS communications transport protocol. You should also be able to access the RD Gateway virtual machine through a public IP address that allows inbound UDP connections to port 3391 to allow end-users to connect using the UDP protocol for improved performance. You must install matching digital certificates on the server and client. For development and testing purposes, you can create a self-generated and self-signed certificate. For a released service, you must obtain a digital certificate from a trusted certification authority. The name of the certificate must match the Fully Qualified Domain Name (FQDN) that is used to access RD Gateway, which may be the DNS name label of an Azure public IP address or the CNAME DNS record pointing to the public IP address.  
  
For tenants with small number of users, you can install the RD Gateway role on the same virtual machine running RD Gateway to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, you can create additional RD Gateway virtual machines in the same availability set to create an RD Gateway farm. When implementing an RD Gateway farm, you must configure load balancing for the HTTPS and UDP traffic. With the RD Gateway virtual machines running on Windows Server 2016 and connecting clients using Windows 10, you do not need to configure IP affinity on the load balancer, while other configurations will require you to.  
  
[//]: <> (Additional information:  
[Deploying and Configuring RD Gateway](http://social.technet.microsoft.com/wiki/contents/articles/10974.deploying-and-configuring-rd-gateway-in-windows-server-2012.aspx  
[What's New In Windows Server 2012 R2 RD Gateway?](https://blogs.technet.microsoft.com/enterprisemobility/2013/03/14/whats-new-in-windows-server-2012-remote-desktop-gateway/#loadbalancing )


##  Remote Desktop Licensing  
Each tenant's environment includes an activated Remote Desktop Licensing server to allow users to connect to the Remote Desktop Session Host (RD Session Host) servers that host the tenant's desktops and applications. For hosted environments, the licensing server is configured in "per user" mode.   
  
The service provider must acquire the proper number of RDS Subscriber Access Licenses (SALs) based on the number of unique (not concurrent) users authorized to log on to the service each month. Service providers who offer hosted desktops must purchase Microsoft Azure Infrastructure Services directly and the SALs through the Microsoft Service Provider Licensing Agreement (SPLA) program.  End customers who purchase a hosted desktop solution from a service provider must purchase the complete hosted solution (Azure and RDS) from the service provider.  
  
For small tenants, the cost can be reduced by combining the file server and RD Licensing components on a virtual machine in the tenant's environment. To provide a higher availability service, two RD License server virtual machines can be deployed in the same availability set. All the RD servers in the tenant's environment are associated with both RD license servers to ensure that users will be able to connect to new sessions even if one of the license servers is unavailable.  
  
Additional information:  
[Deploying Remote Desktop Licensing Step-by-Step Guide](https://technet.microsoft.com/library/dd983943(WS.10).aspx)  
[Managing RDS Licensing Using PowerShell on Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/13293.managing-rds-licensing-using-powershell-on-windows-server-2012.aspx)  
[Generate Per User CAL Report](https://gallery.technet.microsoft.com/ScriptCenter/9739eaee-fb8a-4cb8-8456-7f138d175934/)  
[Microsoft Volume Licensing: Licensing Options for Service Providers](https://www.microsoft.com/en-us/licensing/licensing-programs/spla-program.aspx#tab=1)  

  
##  Remote Desktop Session Host  
The Remote Desktop Session Host (RD Session Host) component provides end-users with session-based desktops and RemoteApp programs. End-users can access desktops and applications over the Internet from any device running a capable remote desktop connection client. For more information, see the Client section later in this document.   
  
You can organize the remote desktops and applications into collections of one or more RD Session Host servers, specifiying which groups can access specific collections. For example, you can configure collections such that users in the accounting group can access the accounting applications, while users in the engineering group cannot.   
  
You can install the required applications directly on the RD Session Host servers, or you can stream the applications to the RD Session Host from an App-V server, which helps reduce maintenance costs in larger deployments.   
  
To provide higher availability of the collections and to increase scale to support more users or applications that use more computer resources, each collection can be expanded by adding RD Session Host server virtual machines to a collection farm with each RDSH virtual machine within a collection assigned to same availability set.  

In most cases, the RD Session Host servers are shared by multiple users simultaneously. This is the most efficient way to utilize the Azure resources for a desktop hosting solution. In this configuration, users must sign in to collections by using non-administrative accounts. In certain cases, some users want full administrative access to their remote desktop; this can be achieved by creating personal session desktop collections.  
  
Additional customizations to desktops can be made by creating and uploading a virtual hard disk that contains the Windows Server operating system to be used as a template for creating RD Session Host virtual machines.  
  
Additional information:  
[Easier User Data Management with User Profile Disks in Windows Server 2012 R2  
Personal Session Desktops](http://blogs.msdn.com/b/rds/archive/2012/11/13/easier-user-data-management-with-user-profile-disks-in-windows-server-2012.aspx)  
[Getting started with App-V 5.0](https://technet.microsoft.com/itpro/mdop/appv-v5/getting-started-with-app-v-50--rtm)  
[Upload a Windows VM image to Microsoft Azure for Resource Manager deployments](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/)  

## Remote Desktop Virtualization Host
The Remote Desktop Virtualization Host (RDVH) component integrates with Hyper-V to host virtual machines that serve as desktops or RemoteApp programs. The desktops and applications can be accessed over the Internet from any device running a capable remote desktop connection client.

The collections hosted on the RDVH servers have the same capabilities as collections hosted on RD Session Host servers:
  1. Collections can be comprised of desktops or RemoteApp programs. 
  2. Collections can be set up in a pooled or personal (persistent) model.
  3. Applications can be installed directly on the RDVH servers or streamed from an App-V server.

Differences between the RDVH and RD Session Hosts are:
  1. RDVH servers typically host Windows client VMs for end-users to access, while RD Session Host servers use the RDSH role in Windows Server to allow multiple sessions on the Windows Server instance.
  2. RDVH technology is not compatible with Azure, so you will have to deploy RD Session Host and session-based desktops and applications if you plan on deploying in Azure.

When using RDVH collections in a pooled model, you can increase scale and availability by adding more RDVH servers and virtual machines to the collection farm.

Since the RDVH integrates with Hyper-V, we suggest you to take a look at the various features that the Hyper-V team has developed in [Windows Server 2016](https://technet.microsoft.com/windows-server-docs/compute/hyper-v/what-s-new-in-hyper-v-on-windows).

## Remote Desktop Web Access  
The Remote Desktop Web Access (RD Web Access) component allows the tenant's employees to have a single website where they can authenticate and then access Windows desktops and applications that are hosted in Microsoft Azure. By using RD Web Access, you can publish Windows desktops and applications to a variety of Windows and non-Windows client devices, and to specific users or groups.  
  
The RD Web Access component requires installation of Internet Information Services (IIS). A Hypertext Transfer Protocol Secure (HTTPS) connection is used to provide an encrypted communications channel between the clients and the RD Web server. The RD Web Access virtual machine must be accessible through a public IP address that allows inbound TCP connections to port 443 to allow the end-users to connect from the Internet using the HTTPS communications transport protocol.   
  
You must install matching digital certificates on the server and clients. For development and testing purposes, you can create a self-generated and self-signed certificate. For a released service, you must obtain a digital certificate from a trusted certification authority. The name of the certificate must match the Fully Qualified Domain Name (FQDN) that is used to access RD Web Access, which might be the DNS name label of an Azure public IP address or the CNAME DNS record pointing to the public IP address.  
  
For tenants with small numbers of users, you can install the RD Web Access role on the same virtual machine running RD Gateway to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, you can create additional RD Web virtual machines in the same availability set to create an RD Web Access farm. When implementing an RD Web Access farm, you must configure load balancing for HTTPS traffic.  
  
Additional information:  
[Windows Server 2012R2 RDS: Enabling the RD WebAccess Expired password reset option](http://social.technet.microsoft.com/wiki/contents/articles/10755.windows-server-2012-rds-enabling-the-rd-webaccess-expired-password-reset-option.aspx)  
[Deploy RemoteApp programs](deploy-remoteapp-programs.md)  
[Distribution of Remote Apps and Desktops in Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/14488.distribution-of-remote-apps-and-desktops-in-windows-server-2012.aspx)