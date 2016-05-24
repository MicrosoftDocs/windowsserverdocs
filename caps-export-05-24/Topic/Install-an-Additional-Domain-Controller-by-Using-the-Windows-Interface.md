---
title: Install an Additional Domain Controller by Using the Windows Interface
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 37dddb9a-87de-4079-80f6-bea913b8ef9b
author: Femila
---
# Install an Additional Domain Controller by Using the Windows Interface
  You can use this procedure to add the Active Directory Domain Services \(AD DS\) server role to a server to create a domain controller in an existing domain. You can complete this procedure by using the Windows graphical user interface \(GUI\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install an additional domain controller by using the Windows interface  
  
1.  Click **Start**, and then click **Server Manager**.  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  Review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, click **Active Directory Domain Services**, and then click **Next**.  
  
5.  Review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
     You can click **Use advanced mode installation** to see additional installation options. Specifically, click **Use advanced mode installation** if you want to install from media or identify the source domain controller for Active Directory replication.  
  
9. On the **Operating System Compatibility** page, review the warning about the default security settings for Windows Server 2008 domain controllers, and then click **Next**.  
  
10. On the **Choose a Deployment Configuration** page, click **Existing forest**, click **Add a domain controller to an existing domain**, and then click **Next**.  
  
11. On the **Network Credentials** page, type the name of any existing domain in the forest where you plan to install the additional domain controller. Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group. When you are finished providing credentials, click **Next**.  
  
12. On the **Select a Domain** page, select the domain of the new domain controller, and then click **Next**.  
  
13. On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to its IP address, and then click **Next**.  
  
14. On the **Additional Domain Controller Options** page, make the following selections, and then click **Next**:  
  
    -   **DNS server**: This option is selected by default so that your domain controller can function as a DNS server. If you do not want the domain controller to be a DNS server, clear this option.  
  
        > [!NOTE]  
        >  If you select the option to make this domain controller a DNS server, you might receive a message that indicates that a DNS delegation for the DNS server could not be created and that you should manually create a DNS delegation to the DNS server to ensure reliable name resolution. If you are installing an additional domain controller in either the forest root domain or a tree root domain, you do not have to create the DNS delegation. In this case, click **Yes**, and disregard the message.  
  
    -   **Global Catalog**: This option is selected by default. It adds the global catalog, read\-only directory partitions to the domain controller, and it enables global catalog search functionality.  
  
    -   **Read\-only domain controller**. This option is not selected by default. It makes the additional domain controller a read\-only domain controller \(RODC\).  
  
15. If you selected **Use advanced mode installation** on the **Welcome** page, the **Install from Media** page appears. You can provide the location of installation media to be used to create the domain controller and configure AD DS, or you can have all source replication occur over the network. Note that some data will be replicated over the network even if you install from media. For information about using this method to install the domain controller, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
16. If you selected **Use advanced mode installation** on the **Welcome** page, the **Source Domain Controller** page appears. Click **Let the wizard choose an appropriate domain controller** or click **Use this specific domain controller** to specify a domain controller that you want to provide as a source for replication to create the new domain controller, and then click **Next**. If you do not choose to install from media, all data will be replicated from this source domain controller.  
  
17. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the SYSVOL files, and then click **Next**.  
  
     Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other nondirectory files.  
  
18. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**. This password must be used to start AD DS in Directory Services Restore Mode \(DSRM\) for tasks that must be performed offline.  
  
19. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you have selected to an answer file that you can use to automate subsequent Active Directory operations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
    > [!NOTE]  
    >  If you are installing an additional domain controller in a child domain and you are using child domain credentials, the **Windows Security** dialog box appears because access is denied in the parent domain to update the DNS delegation in the parent zone. In this case, click the other user icon and provide administrator credentials for the parent domain, and then click **OK**.  
  
20. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
21. You can select **Reboot on completion** to have the server restart automatically, or you can restart the server to complete the installation of AD DS when you are prompted to do so.  
  
## See Also  
 [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md)   
 [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md)  
  
  