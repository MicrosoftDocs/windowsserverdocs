---
title: DirectAccess in Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 02448e64-d9d9-4943-b1e3-e66547e889ed
---
# DirectAccess in Windows Server
As a role service of the Remote Access server role, DirectAccess is a feature that allows connectivity to organization network resources without the need for traditional Virtual Private Network \(VPN\) connections. With DirectAccess, client computers are always connected to your organization – there is no need for remote users to start and stop connections, as is required with VPN connections. In addition, your IT administrators can manage DirectAccess client computers whenever they are running and Internet connected.  
  
DirectAccess provides support only for domain\-joined clients that include operating system support for DirectAccess.  
  
The following server operating systems support DirectAccess.  
  
-   You can deploy all versions of [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] as a DirectAccess client or a DirectAccess server.  
  
-   You can deploy all versions of [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] as a DirectAccess client or a DirectAccess server.  
  
-   You can deploy all versions of [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] as a DirectAccess client or a DirectAccess server.  
  
The following client operating systems support DirectAccess.  
  
-   [!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)] Enterprise  
  
-   [!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)] Enterprise 2015 Long Term Servicing Branch \(LTSB\)  
  
-   [!INCLUDE[win8_client_ent_1](../Token/win8_client_ent_1_md.md)]  
  
-   [!INCLUDE[firstref_client_7ult](../Token/firstref_client_7ult_md.md)]  
  
-   [!INCLUDE[firstref_client_7ent](../Token/firstref_client_7ent_md.md)]  
  
## DirectAccess Basic, Advanced, and Enterprise Deployment Paths  
DirectAccess provides multiple simplified deployment paths in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], including Basic, Advanced, and Enterprise.  
  
For an illustration of these paths and links to related documentation, see [DirectAccess Deployment Paths in Windows Server_1](../Topic/DirectAccess-Deployment-Paths-in-Windows-Server_1.md).  
  
## New Features in DirectAccess  
Learn about new features in DirectAccess.  
  
For more information, see [What's New in DirectAccess in Windows Server](../Topic/What-s-New-in-DirectAccess-in-Windows-Server.md).  
  
## DirectAccess in Windows Server 2012 Essentials  
DirectAccess is also available in Windows Server 2012 Essentials, and enables seamless connectivity to your organization’s network from any Internet\-equipped remote location without a virtual private network \(VPN\) connection.  
  
To learn more about DirectAccess in Windows Server 2012 Essentials, see [Configure DirectAccess in Windows Server Essentials](assetId:///c959b6fc-c67e-46cd-a9cb-cee71a42fa4c).  
  
## Deploying both DirectAccess and RRAS  
In [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], you can deploy both DirectAccess and Routing and Remote Access Service \(RRAS\) on the same server, allowing you to provide DirectAccess connectivity to supported clients as well as providing VPN access to remote clients that do not support DirectAccess.  
  
To learn more about using more than one role service of the Remote Access server role, see [Remote Access Server Role Documentation](../Topic/Remote-Access-Server-Role-Documentation.md).  
  
## DirectAccess Resources  
The following documentation is available for DirectAccess in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
### DirectAccess Prerequisites  
The topic [Prerequisites for Deploying DirectAccess](http://technet.microsoft.com/library/dn464273.aspx) provides the prerequisites that are necessary for using the DirectAccess configuration wizards to deploy DirectAccess.  
  
### DirectAccess Capacity Planning  
The topic [DirectAccess Capacity Planning](http://technet.microsoft.com/library/jj735301.aspx) is a report on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess server performance to provide you with the ability to design your DirectAccess deployment based on your capacity needs.  
  
### Add DirectAccess to an Existing Remote Access \(VPN\) Deployment  
The topic [Add DirectAccess to an Existing Remote Access \(VPN\) Deployment](http://technet.microsoft.com/library/jj574220.aspx) provides an introduction to the Enable DirectAccess Wizard, which you can use to set up a single DirectAccess server, with recommended settings, after you have already set up a virtual private network \(VPN\).  
  
### Deploy a Single DirectAccess Server  
The topic [Deploy a Single Remote Access Server using the Getting Started Wizard](http://technet.microsoft.com/library/hh831520.aspx) provides instructions for you to deploy a single computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as a DirectAccess server. This scenario allows you to configure the DirectAccess server in a few easy steps.  
  
### Deploy a Single DirectAccess Server with Advanced Settings  
The topic [Deploy a Single Remote Access Server with Advanced Settings](http://technet.microsoft.com/library/hh831436.aspx) allows you to set up a single DirectAccess server with advanced settings.  
  
### Deploy DirectAccess in an Enterprise  
The topic [Deploy Remote Access in an Enterprise](http://technet.microsoft.com/library/jj134200.aspx) provides links to documentation that allows you to deploy the following Enterprise DirectAccess scenarios.  
  
-   Deploy Remote Access in a Cluster  
  
-   Deploy Multiple Remote Access Servers in a Multisite Deployment  
  
-   Deploy Remote Access with OTP Authentication  
  
-   Deploy Remote Access in a Multi\-Forest Environment  
  
### DirectAccess Test Lab Guides  
The topic [DirectAccess Test Lab Guides_1](../Topic/DirectAccess-Test-Lab-Guides_1.md) provides links to test lab guides for DirectAccess.  
  
### DirectAccess Offline Domain Join  
The [DirectAccess Offline Domain Join](http://technet.microsoft.com/library/jj574150.aspx) guide explains the steps to perform an offline domain join with DirectAccess. During an offline domain join, a computer is configured to join a domain without a physical or VPN connection to the organization network.  
  
### DirectAccess Known Issues  
The topic [Remote Access \(DirectAccess\) Known Issues](http://technet.microsoft.com/library/dn464275.aspx) provides information about recommended hotfixes and updates for DirectAccess.  
  
### DirectAccess Unsupported Configurations  
The topic [DirectAccess Unsupported Configurations](http://technet.microsoft.com/library/dn464274.aspx) provides a list of unsupported DirectAccess configurations.  
  
### DirectAccess Troubleshooting  
You can use [Troubleshooting DirectAccess](http://technet.microsoft.com/library/dn467926.aspx) to repair problems you encounter when deploying DirectAccess.  
  
### Migrate from Forefront UAG SP1 DirectAccess to Windows Server 2012  
The topic [Migrate from Forefront UAG SP1 DirectAccess to Windows Server 2012](http://technet.microsoft.com/library/hh831658.aspx) describes the migration of an existing Forefront UAG SP1 DirectAccess deployment to DirectAccess in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
