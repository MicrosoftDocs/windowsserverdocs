---
title: Remote Desktop - Allow access to your PC
description: Learn about your options for remotely accessing your PC
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f1557ed-53f7-4333-b023-c8e0f4b58bf4
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 01/25/2017
---
# Remote Desktop - Allow access to your PC

>Applies To: Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

You can use Remote Desktop to connect to and control your PC from a remote device by using the [Microsoft Remote Desktop client app](remote-desktop-clients.md) (available for iOS, Android, Mac, and Windows). When you allow remote connections to your PC, you can use another device to connect to your PC and have access to all of your apps, files, and network resources as if you were sitting at your desk.  

To automatically configure your PC for remote access, download and run the [Microsoft Remote Desktop Assistant](https://www.microsoft.com/download/details.aspx?id=50042). This assistant updates your system settings to enable remote access, ensures your computer is awake for connections, and checks that your firewall allows Remote Desktop connections. 

## Should I enable Remote Desktop?

If you only want to access your PC when you are physically sitting in front of it, you don't need to enable Remote Desktop. Enabling Remote Desktop opens a port on your PC that is visible to your local network. You should only enable Remote Desktop in trusted networks, such as your home. You also don't want to enable Remote Desktop on any PC where access is tightly controlled.

Be aware that when you enable access to Remote Desktop, you are granting anyone in the Administrator's group, as well as any additional users you select through the **Select user** button, the ability to remotely access their accounts on the computer.


## Why allow connections only with Network Level Authentication? 
 
If you want to restrict who can access your PC, choose to allow access only with Network Level Authentication (NLA). When you enable this option, users have to authenticate themselves to the network before they can connect to your PC. Allowing connections only from computers running Remote Desktop with NLA is a more secure authentication method that can help protect your computer from malicious users and software. To learn more about NLA and Remote Desktop, check out  [Configure NLA for RDS Connections](https://technet.microsoft.com/library/cc732713(v=ws.11).aspx). 
 
Not finding content you need? Windows 10 users, tell us what you want on [Feedback Hub](feedback-hub:?tabid=2&contextid=898). 