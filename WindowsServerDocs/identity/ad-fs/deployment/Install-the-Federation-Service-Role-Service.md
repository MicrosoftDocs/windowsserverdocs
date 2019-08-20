---
ms.assetid: e33673ff-ea1c-4476-a549-3bf5899a47dd
title: Install the Federation Service Role Service
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Install the Federation Service Role Service

Now that you have properly configured a computer with the prerequisite applications and certificates, you are ready to install the Federation Service role service of Active Directory Federation Services \(AD FS\). When you install the Federation Service on a computer, that computer becomes a federation server.  
  
> [!NOTE]  
> For the Federated Web Single\-Sign\-On \(SSO\) design, you must have at least one federation server in the account partner organization and at least one federation server in the resource partner organization. For more information, see [Where to Place a Federation Server](https://technet.microsoft.com/library/dd807127.aspx).  
  
You can use the following procedure to install the Federation Service role service of AD FS on a computer that will become the first federation server or on a computer that will become a federation server for an existing federation server farm.  
  
## Prerequisites  
Verify that an SSL certificate with the private key has already been installed or imported into the local certificate store \(Personal store\) before you start this procedure. If you will be using a token\-signing certificate that is issued by a certification authority \(CA\), verify that a token\-signing certificate with the private key has already been installed or imported into the local certificate store \(Personal store\) before you start this procedure. As an alternative, you can create a self\-signed, token\-signing certificate using the Add Roles Wizard, as described in this procedure. For more information about token\-signing certificates, see [Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx).  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
#### To install the Federation Service role service  
  
1.  On the **Start** screen, type**Server Manager**, and then press ENTER.  
  
2.  Click **Manage**, and then click **Add Roles and Features** to start the Add Roles and Features Wizard.  
  
3.  On the **Before you begin** page, click **Next**.  
  
4.  On the **Select installation type** page, click **Role\-based or Feature\-based installation**, and click **Next**.  
  
5.  On the **Select destination server** page, click **Select a server from the server pool**, verify that the target computer is highlighted, and then click **Next**.  
  
6.  On the **Select server roles** page, click **Active Directory Federation Services**, and then click next.  
  
    > [!NOTE]  
    > If you are prompted to install additional .NET Framework or Windows Process Activation Service features, click **Add Features** to install them.  
  
7.  On the **Select features** page, verify that the features are set, and then click **Next**.  
  
8.  On the **Active Directory Federation Service \(AD FS\)** page, click **Next**.  
  
9. On the **Select role services** page, select the **Federation Service** check box, and then click **Next**.  
  
10. On the **Web Server Role \(IIS\)** page, click **Next**.  
  
11. On the **Select role services** page, click **Next**.  
  
12. After you verify the information on the **Confirm installation selections** page, select the **Restart the destination server automatically if required** check box, and then click **Install**.  
  
13. On the **Installation progress** page, verify that everything installed correctly, and then click **Close**.  
  

