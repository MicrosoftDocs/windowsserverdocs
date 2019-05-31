---
title: "Add Windows Server Essentials as a Member Server"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d09dd82f-f7d2-47ce-862d-fd9869f2021c
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Windows Server Essentials as a Member Server

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This topic applies to a server running Windows Server 2012 R2 Standard, Windows Server 2012 R2 Datacenter, or Windows Server 2016 with the Windows Server Essentials Experience role installed. In the remainder of this document, the Windows Server Essentials Experience role will be referred to as Windows Server Essentials.  
  
> [!NOTE]
>   Windows Server Essentials can only be deployed as domain controller. In this document, Windows Server Essentials does not include  Windows Server Essentials.  
  
 Windows Server Essentials does not need to be a primary server within a Windows domain. You can add Windows Server Essentials as a member server to an existing Active Directory domain environment and take advantage of the simple data protection, secure remote access, and cloud integration features that it provides. In addition, Windows Server Essentials can be deployed in an existing Active Directory environment without having to be a domain controller. This enables you to extend storage or to use a branch office for local storage and administration.  
  
 You can add Windows Server Essentials in the following scenarios:  
  
-   Add Windows Server Essentials in a branch office location and join it to the domain controller that is located in the main office at a separate location by using the native tools. You can turn on the BranchCache features for optimum bandwidth utilization on this member server.  
  
-   Add Windows Server Essentials as a member server within a  Windows Server Essentials network to help extend storage on your network by adding additional server folders on your member server.  
  
-   Add Windows Server Essentials as a member server in the local office if your primary server running  Windows Server Essentials is hosted in  Microsoft Azure or hosted by a third-party hoster. Having Windows Server Essentials as a member server at your local office site helps to optimize bandwidth usage.  
  
## Adding Windows Server Essentials as a member server  
 To add Windows Server Essentials as a member server to a primary server running  Windows Server 2012 R2 or  Windows Server Essentials in an existing Active Directory environment, you must complete the following steps:  
  
1.  Join the server running Windows Server Essentials to a workgroup.  
  
2.  Join the server running Windows Server Essentials to the domain of a primary  Windows Server Essentials server.  
  
3.  Configure the  Windows Server Essentials Experience from Server Manager.  
  
#### To join Windows Server Essentials to a workgroup or domain  
  
1. After you complete the installation of Windows Server Essentials on your second server, close the Configure Windows Server Essentials Wizard.  
  
2. In the **Search** box, type **System Settings**, and in the search results, click **View advanced system settings**.  
  
3. In **System Properties**, click the **Computer Name** tab.  
  
4. In **Computer Name**, in the **Domain** section, click **Change**.  
  
5. In **Computer Name/Domain Changes**, in the **Member** section, choose if you want to join the server running  Windows Server Essentials to a **Workgroup** or to a **Domain**.  
  
   -   To add the server to a workgroup, type **workgroup**, and then click **OK**.  
  
   -   To join this server to an existing Active Directory domain, type the name of the domain, and then click **OK**.  
  
6. Restart the server to apply the changes.  
  
   After you have joined the server to your primary server ��s domain, you can continue to configure Windows Server Essentials by running the Configure Windows Server Essentials Wizard from Server Manager.  
  
#### To configure Windows Server Essentials Experience on a member server  
  
1.  (Optional) Change the server name, if needed.  
  
    > [!IMPORTANT]
    >  You cannot change the server name after you have configured  Windows Server Essentials Experience.  
  
2.  Sign in to the server by using your Domain Admin account.  
  
3.  Open Server Manager.  
  
4.  In the flag notification area in **Server Manager**, click the flag, and then click **Configure Windows Server Essentials**.  
  
5.  Opt to configure the server as a member server, and then click **Next**.  
  
6.  Click **Configure** to begin the configuration. The configuration process takes approximately 10 minutes to complete.  
  
7.  On the desktop, click the Dashboard icon to start the server Dashboard. On the Home page, complete the **Getting Started** tasks that are listed on the **Setup** tab.  
  
## See also  
  

-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)

-   [Install Windows Server Essentials](../install/Install-Windows-Server-Essentials.md)

