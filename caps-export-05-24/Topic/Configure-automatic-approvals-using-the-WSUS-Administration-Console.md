---
title: Configure automatic approvals using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e10e752d-d440-446b-bb2b-745c618d9979
author: britw
---
# Configure automatic approvals using the WSUS Administration Console
In [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2, WSUS Setup automatically configures IIS to distribute the latest version of Automatic Updates to each client computer that contacts the WSUS server.  
  
The best way to configure Automatic Updates depends on the network environment. In an environment that uses Active Directory, you can use an existing domain–based Group Policy Object \(GPO\) or create a new GPO. In an environment without Active Directory, use the Local GPO. In this step, you will configure Automatic Updates and then point the client computers to the WSUS server.  
  
The following procedures assume that your network runs Active Directory. These procedures also assume that you are familiar with Group Policy and use it to manage the network.  
  
For more information about Group Policy, refer to the [Group Policy](http://go.microsoft.com/fwlink/?LinkID=89170) website.  
  
## Configure automatic approvals  
In step 4, you completed configuration of the updates that you want to download. Use this set of procedures to configure automatic updates for client computers.  
  
1.  Configure Automatic Updates in Group Policy.  
  
2.  Point a client computer to the WSUS server.  
  
3.  Manually start detection by the WSUS server.  
  
Perform the first two procedures on the domain–based GPO of your choice, and the third procedure at a command prompt on the client computer.  
  
#### To configure Automatic Updates  
  
1.  In the Group Policy Management Console \(GPMC\), browse to the GPO on which you want to configure WSUS, and then click **Edit**.  
  
2.  In the GPMC, expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, and then click **Windows Update**.  
  
3.  In the details pane, double\-click **Configure Automatic Updates**.  
  
4.  Click **Enabled**, and then click one of the following options:  
  
    -   **Notify for download and notify for install**. This option notifies a logged\-on administrative user before the download and before you install the updates.  
  
    -   **Auto download and notify for install**. This option automatically begins downloading updates and then notifies a logged\-on administrative user before installing the updates.  
  
    -   **Auto download and schedule the install**. This option automatically begins downloading updates and then installs the updates on the day and time that you specify.  
  
    -   **Allow local admin to choose setting**. This option lets local administrators use Automatic Updates in Control Panel to select a configuration option. For example, they can choose their own scheduled installation time. Local administrators cannot disable Automatic Updates.  
  
5.  Click **OK**.  
  
#### To point the client computers to the WSUS server  
  
1.  In the **Windows Update** details pane, double\-click **Specify intranet Microsoft update service location**.  
  
2.  Click **Enabled**, and type the HTTP URL of the same WSUS server in the **Set the intranet update service for detecting updates** box and in the **Set the intranet statistics server** box. For example, type *http:\/\/servername* in both boxes, and then click **OK**.  
  
> [!NOTE]  
> If you are using the Local GPO to point the computer to WSUS, this setting takes effect immediately, and this computer appears in the WSUS Administrative Console after a short time. You can speed up this process by manually initiating a detection cycle.  
  
After you set up a client computer, it will take several minutes before the computer appears on the **Computers** page in the WSUS Administration Console. For client computers configured with a domain\-based Group Policy, it can take about 20 minutes after Group Policy refreshes \(that is, applies any new policy settings to the client computer\). By default, Group Policy updates in the background every 90 minutes, with a random offset of 0–30 minutes. If you want to update Group Policy sooner, you can go to a command prompt on the client computer and type **gpupdate \/force**.  
  
For client computers that are configured by using the Local GPO, Group Policy is applied immediately, and the update takes about 20 minutes.  
  
If you begin detection manually, you do not have to wait 20 minutes for the client computer to contact WSUS.  
  
#### To manually start detection by the WSUS server  
  
1.  On the client computer, click **Start**, and then click **Run**.  
  
2.  Type **cmd** in the **Open** text box, and then click **OK**.  
  
3.  At the command prompt, type **wuauclt.exe \/detectnow**. This command\-line option instructs Automatic Updates to contact the WSUS server immediately.  
  
