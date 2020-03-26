---
title: Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: db15dcf5-4d64-48d7-818a-06c2839e1289
ms.author: lizross
author: eross-msft
---
# Test Lab Guide: Demonstrate DirectAccess in a Cluster with Windows NLB

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Remote Access is a server role in the  Windows Server 2016, Windows Server 2012 R2 andWindows Server 2012 operating systems that enables remote users to securely access internal network resources using DirectAccess or RRAS VPN. This guide contains step-by-step instructions for extending the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](https://go.microsoft.com/fwlink/p/?LinkId=237004) to demonstrate DirectAccess Network Load Balancing and cluster configuration.  
  
## About this guide  
This guide contains instructions for configuring and demonstrating Remote Access using six servers and two client computers. The completed Remote Access test lab with NLB simulates an intranet, the Internet, and a home network and demonstrates Remote Access functionality in different Internet connection scenarios.  
  
> [!IMPORTANT]  
> This lab is a proof of concept using the minimum number of computers. The configuration detailed in this guide is for test lab purposes only, and is not to be used in a production environment.  
  
## <a name="KnownIssues"></a>Known issues  
The following are known issues when configuring a cluster scenario:  
  
-   After configuring DirectAccess in an IPv4-only deployment with a single network adapter, and after the default DNS64 (the IPv6 address which contains ":3333::") is automatically configured on the network adapter, attempting to enable load-balancing via the Remote Access Management console causes a prompt for the user to supply an IPv6 DIP. If an IPv6 DIP is supplied, the configuration fails after clicking **Commit** with the error: The parameter is incorrect.  
  
    To resolve this issue:  
  
    1.  Download the backup and restore scripts from [Back up and Restore Remote Access Configuration](https://gallery.technet.microsoft.com/Back-up-and-Restore-Remote-e157e6a6).  
  
    2.  Back up your Remote Access GPOs using the downloaded script Backup-RemoteAccess.ps1  
  
    3.  Attempt to enable load balancing until the step at which it fails. On the Enable Load Balancing dialog box, expand the details area, right-click in the details area, and then click **Copy Script**.  
  
    4.  Open Notepad, and paste the contents of the clipboard. For example:  
  
        ```  
        Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress @('10.244.4.19/255.255.255.0','fdc4:29bd:abde:3333::2/128') -InternetVirtualIPAddress @('fdc4:29bd:abde:3333::1/128', '10.244.4.21/255.255.255.0') -ComputerName 'DA1.domain1.corp.contoso.com' -Verbose  
        ```  
  
    5.  Close any open Remote Access dialog boxes and close the Remote Access Management console.  
  
    6.  Edit the pasted text and remove the IPv6 addresses. For example:  
  
        ```  
        Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress @('10.244.4.19/255.255.255.0') -InternetVirtualIPAddress @('10.244.4.21/255.255.255.0') -ComputerName 'DA1.domain1.corp.contoso.com' -Verbose  
        ```  
  
    7.  In an elevated PowerShell window, run the command from the previous step.  
  
    8.  If the cmdlet fails while it is running (not due to incorrect input values), run the command Restore-RemoteAccess.ps1 and follow instructions to make sure that the integrity of your original configuration is maintained.  
  
    9. You can now open the Remote Access Management console again.  
  


