---
title: Prerequisites for Deploying DirectAccess
description: This topic provides prerequisites for DirectAccess deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57c7e039-42ef-4909-867a-b5f669c9e74e
ms.author: lizross
author: eross-msft
---
# Prerequisites for Deploying DirectAccess

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following table lists the prerequisites necessary for using the configuration wizards to deploy DirectAccess.  
  
|||  
|-|-|  
|Scenario|Prerequisites|  
|[Deploy a Single DirectAccess Server Using the Getting Started Wizard](../../remote-access/directaccess/single-server-wizard/Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md)|-   Windows Firewall must be enabled on all profiles<br /><br />-   Only supported for clients running Windows 10&reg;, <br />              Windows&reg; 8, and Windows&reg; 8.1 Enterprise.<br /><br />-   A public key infrastructure is not required.<br /><br />-   Not supported for deploying two-factor authentication. Domain credentials are required for authentication.<br /><br />-   Automatically deploys DirectAccess to all mobile computers in the current domain.<br /><br />-   Traffic to the Internet does not go through DirectAccess. Force tunnel configuration is not supported.<br /><br />-   DirectAccess server is the network location server.<br /><br />-   Network Access Protection (NAP) is not supported.<br /><br />-   Changing policies by using a feature other than the DirectAccess management console or Windows PowerShell cmdlets is not supported.<br /><br />-   For a multisite configuration, now or in the future, first follow the guidance in [Deploy a Single DirectAccess Server with Advanced Settings](../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).|  
|[Deploy a Single DirectAccess Server with Advanced Settings](../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md)|-   A public key infrastructure must be deployed.<br />    For more information, see [Test Lab Guide Mini-Module: Basic PKI for Windows Server 2012](https://social.technet.microsoft.com/wiki/contents/articles/7862.test-lab-guide-mini-module-basic-pki-for-windows-server-2012.aspx).<br /><br />-   Windows Firewall must be enabled on all profiles.<br /><br />The following server operating systems support DirectAccess.<br /><br />-   You can deploy all versions of  Windows Server 2016 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2012 R2 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2012 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2008 R2 as a DirectAccess client or a DirectAccess server.<br /><br />The following client operating systems support DirectAccess.<br /><br />-   Windows 10&reg; Enterprise<br />-   Windows 10&reg; Enterprise 2015 Long Term Servicing Branch (LTSB)<br />-   Windows&reg; 8 and 8.1 Enterprise<br />-   Windows&reg; 7 Ultimate<br />-   Windows&reg; 7 Enterprise<br /><br />-   Force tunnel configuration is not supported with KerbProxy authentication.<br /><br />-   Changing policies by using a feature other than the DirectAccess management console or Windows PowerShell cmdlets is not supported.<br /><br />-   Separating NAT64/DNS64 and IPHTTPS server roles on another server is not supported.|  
  


