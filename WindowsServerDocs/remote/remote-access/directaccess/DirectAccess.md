---
title: DirectAccess
description: You can use this topic for a brief overview of DirectAccess in Windows Server.
manager: brianlic
ms.topic: article
ms.assetid: 6b71d18e-1939-4fc0-bb42-29e0e5ffc8da
ms.author: jgerend
author: JasonGerend
ms.date: 11/16/2022
---
# DirectAccess

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

>[!IMPORTANT]
>Microsoft highly recommends that you use Always On VPN instead of DirectAccess for new deployments. For more information, see [Always on VPN](../overview-always-on-vpn.md).

You can use this topic for a brief overview of DirectAccess, including the server and client operating systems that support DirectAccess, and for links to additional DirectAccess documentation for Windows Server.

> [!NOTE]
> In addition to this topic, the following DirectAccess documentation is available.
>
> -   [DirectAccess Deployment Paths in Windows Server](DirectAccess-Deployment-Paths-in-Windows-Server.md)
> -   [Prerequisites for Deploying DirectAccess](Prerequisites-for-Deploying-DirectAccess.md)
> -   [DirectAccess Unsupported Configurations](DirectAccess-Unsupported-Configurations.md)
> -   [DirectAccess Test Lab Guides](DirectAccess-Test-Lab-Guides.md)
> -   [DirectAccess Known Issues](DirectAccess-Known-Issues.md)
> -   [DirectAccess Capacity Planning](DirectAccess-Capacity-Planning.md)
> -   [DirectAccess Offline Domain Join](DirectAccess-Offline-Domain-Join.md)
> -   [Troubleshooting DirectAccess](Troubleshooting-DirectAccess.md)
> -   [Deploy a Single DirectAccess Server Using the Getting Started Wizard](single-server-wizard/Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md)
> -   [Deploy a Single DirectAccess Server with Advanced Settings](single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md)
> -   [Add DirectAccess to an Existing Remote Access (VPN) Deployment](add-to-existing-vpn/Add-DirectAccess-to-an-Existing-Remote-Access-VPN-Deployment.md)

DirectAccess  allows connectivity for remote users to organization network resources without the need for traditional Virtual Private Network (VPN) connections. With DirectAccess connections, remote client computers are always connected to your organization - there is no need for remote users to start and stop connections, as is required with VPN connections. In addition, your IT administrators can manage DirectAccess client computers whenever they are running and Internet connected.

>[!IMPORTANT]
>Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported. You cannot use Remote Access in an Azure VM to deploy VPN, DirectAccess, or any other Remote Access feature in Windows Server. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

DirectAccess provides support only for domain-joined clients that include operating system support for DirectAccess.

The following client operating systems support DirectAccess.

- Windows 11 Enterprise

- Windows 10 Enterprise

- Windows 10 Enterprise 2015 Long Term Servicing Branch (LTSB)

- Windows 8.1 Enterprise