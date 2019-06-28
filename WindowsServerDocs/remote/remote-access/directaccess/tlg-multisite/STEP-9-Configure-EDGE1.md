---
title: STEP 9 Configure EDGE1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f6e8d85b-de65-43b3-bf3e-ec84471a1fcc
ms.author: pashort
author: shortpatti
---
# STEP 9 Configure EDGE1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following procedures are performed on the EDGE1 server:  
  
1. Configure the DNS servers on EDGE1. It is necessary to configure the DNS server from the corp2.corp.contoso.com domain on EDGE1.  
  
2. Configure routing between subnets. Configure routing on EDGE1 to enable communication between the Corpnet and 2-Corpnet subnets.  
  
## <a name="IPv6"></a>Configure the DNS servers on EDGE1  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Corpnet**, click the link.  
  
2.  In the Network Connections window, right-click **Corpnet**, and then click **Properties**.  
  
3.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  In **Alternate DNS server**, type **10.2.0.1**. and then click **OK**.  
  
5.  Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
6.  In **Alternate DNS server**, type **2001:db8:2::1** and then click **OK**.  
  
7.  On the **Corpnet Properties** dialog box, click **Close**.  
  
8.  Close the **Network Connections** window.  
  
## <a name="ConfigRouting"></a>Configure routing between subnets  
  
1.  On the **Start** screen, type**cmd.exe**, right-click **cmd**, click **Advanced**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Command Prompt window, enter the following commands. After entering each command, press ENTER.  
  
    ```  
    netsh interface IPv4 add route 10.2.0.0/24 Corpnet 10.0.0.254  
    netsh interface IPv6 add route 2001:db8:2::/64 Corpnet 2001:db8:1::fe  
    ```  
  
3.  Close the Command Prompt window.  
  


