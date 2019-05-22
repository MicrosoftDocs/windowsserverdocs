---
ms.assetid: 6ecf8d85-cd61-4c87-add8-00a679a6e3ff
title: Add a Federation Server to a Federation Server Farm
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Add a Federation Server to a Federation Server Farm


After you install the Federation Service role service and configure the required certificates on a computer, you are ready to configure the computer to become a federation server. You can use the following procedure to join a computer to a new federation server farm.  
  
You join a computer to a farm with the AD FS Federation Server Configuration Wizard. When you use this wizard to join a computer to an existing farm, the computer is configured with a read\-only copy of the AD FS configuration database and it must receive updates from a primary federation server.  
  
> [!NOTE]  
> For the Federated Web Single\-Sign\-On \(SSO\) design, you must have at least one federation server in the account partner organization and at least one federation server in the resource partner organization. For more information, see [Where to Place a Federation Server](https://technet.microsoft.com/library/dd807127.aspx).  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
### To add a federation server to a federation server farm  
  
1.  There are two ways to start the AD FS Federation Server Configuration Wizard. To start the wizard, do one of the following:  
  
    -   After the Federation Service role service installation is complete, open the AD FS Management snap\-in and click the **AD FS Federation Server Configuration Wizard** link on the **Overview** page or in the **Actions** pane.  
  
    -   Anytime after the setup wizard is complete, open Windows Explorer, navigate to the **C:\\Windows\\ADFS** folder, and double\-click **FsConfigWizard.exe**.  
  
2.  On the **Welcome** page, verify that **Add a federation server to an existing Federation Service** is selected, and then click **Next**.  
  
3.  If the AD FS database that you selected already exists, the **Existing AD FS Configuration Database Detected** page appears. If that occurs, click **Delete database**, and then click **Next**.  
  
    > [!CAUTION]  
    > Select this option only when you are sure that the data in this AD FS database is not important or that it is not used in a production federation server farm.  
  
4.  On the **Specify the Primary Federation Server and Service Account** page, under **Primary federation server name**, type the computer name of the primary federation server in the farm, and then click **Browse**. In the **Browse** dialog box, locate the domain account that is used as the service account by all other federation servers in the existing federation server farm, and then click **OK**. Type the password and confirm it, and then click **Next**:  
  
    > [!NOTE]  
    > For more information about specifying a service account for a federation server farm, see [Manually Configure a Service Account for a Federation Server Farm](Manually-Configure-a-Service-Account-for-a-Federation-Server-Farm.md). Each federation server in the federation server farm must specify the same service account for the farm to be operational. For example, if the service account that was created was contoso\\ADFS2SVC, each computer you configure for the federation server role and that will participate in the same farm must specify contoso\\ADFS2SVC at this step in the Federation Server Configuration Wizard for the farm to be operational.  
  
5.  On the **Ready to Apply Settings** page, review the details. If the settings appear to be correct, click **Next** to begin configuring AD FS with these settings.  
  
6.  On the **Configuration Results** page, review the results. When all the configuration steps are finished, click **Close**  to exit the wizard.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  

