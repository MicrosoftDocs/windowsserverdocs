---
title: Remote Access: Prepare to Migrate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 20678d45-6d94-4d42-b2b8-e51d9b470eaf
author: vhorne
---
# Remote Access: Prepare to Migrate
Perform the following steps before you begin migrating Remote Access from your x86\-based or x64\-based source server to an x64\-based destination server that is running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
-   [Prepare your destination server](#bkmk_2)  
  
-   [Prepare your source server](#bkmk_3)  
  
-   [Install the migration tools](#bkmk_1)  
  
Membership in the local **Administrators** group or equivalent is the minimum required to complete these procedures. If User Account Control \(UAC\) is enabled, you might have to run the following steps by using the **Run as administrator** option.  
  
## <a name="bkmk_2"></a>Prepare your destination server  
Complete the following procedures to prepare the destination server for the migration of Remote Access.  
  
### Hardware requirements for the destination server  
Your destination server should have the same number or more network adapters as your source server. You can have more network adapters on the destination server than the source server, but the migration fails if you have fewer.  
  
> [!IMPORTANT]  
> The names of the network adapters on the destination server must be the same as those on the source server, and they must have the same intention \(for example, Internet facing versus intranet facing\). Most Remote Access server components have interface\-specific settings and configuration. Having the same number of interfaces, with the same names and intent, helps ensure that the settings are migrated to the right interface. This is critical to a successful migration. If there are more adapters on the destination server than on the source server, you must still have a one\-to\-one match between the names and intention of the network adapters on the source server and those on the destination server.  
  
> [!NOTE]  
> DirectAccess configuration can only be migrated from a computer running Windows Server 2012 to another computer running Windows 2012. Migration from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess is not supported.  
  
### Prepare the destination server for migration  
  
##### To prepare the destination server  
  
1.  Install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on the destination server.  
  
2.  Whether or not you intend to migrate the source server name to the destination server, give the destination server a temporary computer name at this time.  
  
3.  If you store the user accounts for remote access users locally on the Remote Access server instead of in Active Directory, and if you use the Challenge Handshake Authentication Protocol \(CHAP\) for authentication, then you must perform the following additional steps before migrating Remote Access:  
  
    1.  To enable the use of CHAP authentication, you must manually configure a local security policy setting that enables passwords to be stored by using a reversible encryption algorithm.  
  
        > [!IMPORTANT]  
        > We recommend that you do not use CHAP for authentication, and that you do not enable the setting to store passwords with reversible encryption. These options are not considered secure, and they are provided only for backwards compatibility. Use them only if your environment requires the use of CHAP.  
  
        1.  On the destination server, in the **Start** screen, click **Administrative tools**, and then click **Local Security Policy**.  
  
        2.  In the navigation tree, expand **Account Policies**, and then select **Password Policy**.  
  
        3.  In the details pane, double\-click **Store passwords using reversible encryption**, click **Enabled**, and then click **OK**.  
  
    2.  Migrate the local users and groups from the source server to the destination server. Do this separately and before you begin migrating Remote Access.  
  
4.  If the source server that is being replaced is joined to a domain, join the destination server to the same domain.  
  
5.  In the dashboard of the Server Manager console click **Add roles and Features**.  
  
6.  Click **Next** until you reach the **Select Server Roles** screen.  
  
7.  On the **Select Server Roles** screen, select **Remote Access**. Click **Add Required Features**, and then click **Next**.  
  
8.  On the **Select features** screen, click **Windows Server Migration Tools**. Click **Next** until you reach the **Select Role Services** screen.  
  
9. In the **Select Role Services** screen, select **Routing** and then click **Next**.  
  
10. On the **Confirm Installation selections** screen, click **Install**.  
  
11. On the **Installation progress** screen, verify that the installation was successful, and then click **Close**.  
  
12. Server roles were introduced in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and they are also used in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Remote Access is a role service that consists of the Routing service and the DirectAccess and VPN service. In Windows Server 2003, the Routing and VPN services were not separate. If the source server is running Windows Server 2003, ensure that both the Routing service and the DirectAccess and VPN service are installed on the destination server. If the source server is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], ensure that the destination server has the same Remote Access services installed as has the source server. If the source server has the routing service and the DirectAccess and VPN service, then you must install all these components on the destination server.  
  
13. If DirectAccess is being migrated, the IP\-HTTPS and Network Location certificate must be imported to the destination server. Note that if self\-signed certificates were being used on the source server, this step is not required.  
  
14. If DirectAccess is being migrated, run the Windows PowerShell cmdlet **install\-remoteaccess –prerequisite** to ensure that the destination server meets all the requirements for DirectAccess.  
  
The destination server is now prepared for migration.  
  
## <a name="bkmk_3"></a>Prepare your source server  
  
> [!IMPORTANT]  
> Before you begin migration, as a best practice, we recommend that you perform a backup of the source server. If the migration fails, and the recovery steps to restore the source server also fail, this backup can be critical for the quick restoration of service.  
  
### Back up your source server  
  
-   For information about backing up Windows Server 2003, see [Backing up and restoring data](http://go.microsoft.com/fwlink/?linkid=163718) in the Windows Server Technical Library \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=163718\).  
  
-   For information about backing up [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Backup and Recovery](http://go.microsoft.com/fwlink/?linkid=163719) in the Windows Server Technical Library \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=163719\).  
  
## <a name="bkmk_1"></a>Install the migration tools  
[!INCLUDE[wsmt](../Token/wsmt_md.md)] in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows an administrator to migrate some server roles, features, operating system settings, shares, and other data from computers that are running certain editions of Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
Install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the source and the destination servers. Complete installation, configuration, and removal instructions for [!INCLUDE[wsmt](../Token/wsmt_md.md)] are available in [Install, Use, and Remove Windows Server Migration Tools](../Topic/Install,-Use,-and-Remove-Windows-Server-Migration-Tools.md).  
  
> [!IMPORTANT]  
> Before you run the **Import\-SmigServerSetting**, **Export\-SmigServerSetting**, or **Get\-SmigServerFeature** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with domain users or groups who are members of local groups on the source server.  
>   
> Before you run the **Send\-SmigServerData** or **Receive\-SmigServerData** cmdlets, verify that during migration, both source and destination servers can contact the domain controller that is associated with those domain users who have rights to files or shares that are being migrated.  
  
## See Also  
[Migrate Remote Access to Windows Server 2012](../Topic/Migrate-Remote-Access-to-Windows-Server-2012.md)  
[Remote Access: Migrate Remote Access](../Topic/Remote-Access--Migrate-Remote-Access.md)  
[Remote Access: Verify the Migration](../Topic/Remote-Access--Verify-the-Migration.md)  
[Remote Access: Post-migration Tasks](../Topic/Remote-Access--Post-migration-Tasks.md)  
  
