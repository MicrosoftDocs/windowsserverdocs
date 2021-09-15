---
title: Prerequisites for Deploying DirectAccess
description: This topic provides prerequisites for DirectAccess deployment in Windows Server 2016.
manager: brianlic
ms.topic: article
ms.assetid: 57c7e039-42ef-4909-867a-b5f669c9e74e
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Prerequisites for Deploying DirectAccess

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

The following table lists the prerequisites necessary for using the configuration wizards to deploy DirectAccess.

|Scenario|Prerequisites|
|-|-|
|[Deploy a Single DirectAccess Server Using the Getting Started Wizard](../../remote-access/directaccess/single-server-wizard/Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md)|-   Windows Firewall must be enabled on all profiles<p>-   Only supported for clients running Windows 10&reg;, <br />              Windows&reg; 8, and Windows&reg; 8.1 Enterprise.<p>-   A public key infrastructure is not required.<p>-   Not supported for deploying two-factor authentication. Domain credentials are required for authentication.<p>-   Automatically deploys DirectAccess to all mobile computers in the current domain.<p>-   Traffic to the Internet does not go through DirectAccess. Force tunnel configuration is not supported.<p>-   DirectAccess server is the network location server.<p>-   Network Access Protection (NAP) is not supported.<p>-   Changing policies by using a feature other than the DirectAccess management console or Windows PowerShell cmdlets is not supported.<p>-   For a multisite configuration, now or in the future, first follow the guidance in [Deploy a Single DirectAccess Server with Advanced Settings](../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).|
|[Deploy a Single DirectAccess Server with Advanced Settings](../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md)|- A public key infrastructure must be deployed.<br /> For more information, see [Test Lab Guide Mini-Module: Basic PKI for Windows Server 2012](/answers/topics/windows-server-2012.html).<p>- Windows Firewall must be enabled on all profiles.<p>The following server operating systems support DirectAccess.<p>-   You can deploy all versions of  Windows Server 2016 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2012 R2 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2012 as a DirectAccess client or a DirectAccess server.<br />-   You can deploy all versions of Windows Server 2008 R2 as a DirectAccess client or a DirectAccess server.<p>The following client operating systems support DirectAccess.<p>-   Windows 10&reg; Enterprise<br />-   Windows 10&reg; Enterprise 2015 Long Term Servicing Branch (LTSB)<br />-   Windows&reg; 8 and 8.1 Enterprise<br />-   Windows&reg; 7 Ultimate<br />-   Windows&reg; 7 Enterprise<p>-   Force tunnel configuration is not supported with KerbProxy authentication.<p>-   Changing policies by using a feature other than the DirectAccess management console or Windows PowerShell cmdlets is not supported.<p>-   Separating NAT64/DNS64 and IPHTTPS server roles on another server is not supported.|
