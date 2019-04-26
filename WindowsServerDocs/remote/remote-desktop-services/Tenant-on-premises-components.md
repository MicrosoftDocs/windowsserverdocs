---
title: Tenant on-premises components
description: Describes the on-premises components in your RDS deployment.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3eebb38-a835-4fa6-9e41-1966014bf2cb
author: lizap
manager: dongill
---
# Tenant on-premises components

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

The following information describes the on-premises components that make up the desktop hosting deployment.  
  
##  Clients  
To access the hosted desktops and applications, the users must use Remote Desktop clients that support Remote Desktop Protocol (RDP) 7.1 or higher. In particular, the client must support Remote Desktop Gateway and Remote Desktop Connection Broker. To deliver applications to the local desktop, the client must also support the RemoteApp feature. To achieve highest gateway scale, the client must support the pure HTTP transport connections to RD Gateway.  
  
Additional information:  
[RemoteFX Enabled Devices](https://social.technet.microsoft.com/wiki/contents/articles/14534.remotefx-enabled-devices.aspx)  
[What's new in Windows Server 2012 R2 Remote Desktop Gateway](https://blogs.technet.microsoft.com/enterprisemobility/2013/03/14/whats-new-in-windows-server-2012-remote-desktop-gateway/#transport)  
[Microsoft Remote Desktop Clients](https://technet.microsoft.com/library/dn473009.aspx)  
[Remote Desktop app for Windows in Microsoft Store](https://apps.microsoft.com/windows/app/remote-desktop/051f560e-5e9b-4dad-8b2e-fa5e0b05a480)  
[Microsoft Remote Desktop - Android Apps on Google Play](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android)  
[Mac App Store - Microsoft Remote Desktop](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12)  
[Microsoft Remote Desktop in the App Store](https://itunes.apple.com/us/app/microsoft-remote-desktop/id714464092?mt=8)  
  
##  Active Directory Domain Services  
Some larger and more sophisticated tenants may choose to host an Active Directory Domain Services (AD DS) server on their premises. In this case, the AD DS server in the tenant's environment will typically be a replica of AD DS server that is on the tenant's premises. This is supported by creating a virtual network in the tenant's environment and using the Azure VPN to create a site-to-site connection from the tenant's on-premises network to the tenant's virtual network in the Azure data center.  
  
Additional information:  
[Microsoft Azure Virtual Network Overview](https://azure.microsoft.com/documentation/articles/virtual-networks-overview/)  
[Create a resource manager VNet with a Site-to-Site VPN connection using the Azure Portal](https://azure.microsoft.com/documentation/articles/vpn-gateway-howto-site-to-site-resource-manager-portal/)  


