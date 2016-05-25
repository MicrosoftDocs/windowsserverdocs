---
title: Install the Federation Service Proxy Role Service
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb153272-510b-4824-be41-c19b17a22873
author: billmath
---
# Install the Federation Service Proxy Role Service
After you configure a computer with the prerequisite applications and certificates, you are ready to install the Federation Service Proxy role service of Active Directory Federation Services \(AD FS\). You can use the following procedure to install the Federation Service Proxy role service. When you install the Federation Service Proxy role service on a computer, that computer becomes a federation server proxy.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install the Federation Service Proxy role service  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Server Manager**, and then press ENTER.  
  
2.  Click **Manage**, and then click **Add Roles and Features** to start the Add Roles and Features Wizard.  
  
3.  On the **Before you begin** page, click **Next**.  
  
4.  On the **Select installation type** page, click **Role\-based or Feature\-based installation**, and click **Next**.  
  
5.  On the **Select destination server** page, click **Select a server from the server pool**, verify that the target computer is highlighted, and then click **Next**.  
  
6.  On the **Select server roles** page, click **Active Directory Federation Services**, and then click next.  
  
    > [!NOTE]  
    > If you are prompted to install additional .NET Framework or Windows Process Activation Service features, click **Add Features** to install them.  
  
7.  On the **Select features** page, verify that the features are set, and then click **Next**.  
  
8.  On the **Active Directory Federation Service \(AD FS\)** page, click **Next**.  
  
9. On the **Select role services** page, select the **Federation Service Proxy** check box, and then click **Next**.  
  
10. On the **Web Server Role \(IIS\)** page, click **Next**.  
  
11. On the **Select role services** page, click **Next**.  
  
12. After you verify the information on the **Confirm installation selections** page, select the **Restart the destination server automatically if required** check box, and then click **Install**.  
  
13. On the **Installation progress** page, verify that everything installed correctly, and then click **Close**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
