---
title: Installing an Additional Domain Controller by Using the Graphical User Interface (GUI)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5506943d-c5ea-4336-9718-722bf743b2e9
author: Femila
---
# Installing an Additional Domain Controller by Using the Graphical User Interface (GUI)
  The Windows interface provides two wizards that guide you through the installation process for Active Directory Domain Services \(AD DS\). The first wizard is the Add Roles Wizard, which you can access in Server Manager. The second wizard is the Active Directory Domain Services Installation Wizard, which you can access in the following ways:  
  
-   When you complete the Add Roles Wizard, click the link to open the Active Directory Domain Services Installation Wizard.  
  
-   Click **Start**, click **Run**, type **dcpromo.exe**, and then click **OK**.  
  
 If you use the advanced options in the Active Directory Domain Services Installation Wizard, you can control how AD DS is installed on the server, either by the install from media \(IFM\) method or by replication:  
  
-   IFM: You can provide a location for installation media that you have created with Ntdsutil.exe or that you have restored from a backup of a similar domain controller in the same domain. If you create the installation media by using Ntdsutil, you have the option to create secure installation media for a read\-only domain controller \(RODC\). In this case, Ntdsutil removes cached secrets, such as passwords, from the installation media. For more information, see [Installing AD DS from Media_deleted](../Topic/Installing-AD-DS-from-Media_deleted.md).  
  
-   Replication: You can specify a domain controller in the domain from which to replicate AD DS.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Domain Admins group in the domain in which the domain controller is being installed.  
  
### To install a domain controller in an existing domain by using the Windows interface  
  
1.  [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, click the **Active Directory Domain Services** check box, and then click **Next**.  
  
    > [!NOTE]  
    >  On a server that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you might have to click **Add Required Features** to install .NET Framework 3.5.1 features before you can click **Next**.  
  
5.  If necessary, review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
     If you want to install from media, identify the source domain controller for AD DS replication, or specify the Password Replication Policy \(PRP\) for an RODC as part of the installation of the additional domain controller, select **Use advanced mode installation**.  
  
9. On the **Operating System Compatibility** page, review the warning about the default security settings for Windows Server 2008 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers, and then click **Next**.  
  
10. On the **Choose a Deployment Configuration** page, click **Existing forest**, click **Add a domain controller to an existing domain**, and then click **Next**.  
  
11. On the **Network Credentials** page, type the name of any existing domain in the forest where you plan to install the additional domain controller. Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group. When you are finished providing credentials, click **Next**.  
  
12. On the **Select a Domain** page, select the domain of the new domain controller, and then click **Next**.  
  
13. On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to its IP address, and then click **Next**.  
  
14. On the **Additional Domain Controller Options** page, make the following selections, and then click **Next**:  
  
    -   **DNS server**: This option is selected by default so that your domain controller can function as a Domain Name System \(DNS\) server. If you do not want the domain controller to be a DNS server, clear this option.  
  
         If the DNS server role is not installed on the Primary Domain Controller \(PDC\) emulator in the forest root domain, then the option to install DNS server on an additional domain controller is not available. As a workaround in this situation, you can install the DNS server role before or after the AD DS installation.  
  
        > [!NOTE]  
        >  If you select the option to install DNS server, you might receive a message that indicates that a DNS delegation for the DNS server could not be created and that you should manually create a DNS delegation to the DNS server to ensure reliable name resolution. If you are installing an additional domain controller in either the forest root domain or a tree root domain, you do not have to create the DNS delegation. In this case, click **Yes** and disregard the message.  
  
    -   **Global Catalog**: This option is selected by default. It adds the global catalog, read\-only directory partitions to the domain controller, and it enables global catalog search functionality.  
  
    -   **Read\-only domain controller**. This option is not selected by default. It makes the additional domain controller read only; that is, it makes the domain controller an RODC.  
  
     If you do not have static IPv4 and IPv6 addresses assigned to your network adapters, a warning message might appear advising you to set static addresses for both of these protocols before you can continue. If you have assigned a static IPv4 address to your network adapter and your organization does not use IPv6, you can ignore this message and click, **Yes, the computer will use a dynamically assigned IP address \(not recommended\).**  
  
    > [!IMPORTANT]  
    >  We recommend that you not disable the IPv6 protocol.  
  
15. If you selected **Use advanced mode installation** on the **Welcome** page, the **Install from Media** page appears. You can provide the location of installation media to be used to create the domain controller and configure AD DS, or you can have all the replication done over the network. Note that some data will be replicated over the network even if you install from media. For information about using this method to install the domain controller, see [Installing AD DS from Media_deleted](../Topic/Installing-AD-DS-from-Media_deleted.md).  
  
16. If you selected **Use advanced mode installation** on the **Welcome** page, the **Source Domain Controller** page appears. Click **Let the wizard choose an appropriate domain controller** or click **Use this specific domain controller** to specify a domain controller that you want to provide as a source for replication to create the new domain controller, and then click **Next**. If you do not choose to install from media, all data will be replicated from this source domain controller.  
  
17. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume \(SYSVOL\) files, and then click **Next**.  
  
     Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other nondirectory files.  
  
18. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**. This password must be used to start AD DS in Directory Service Restore Mode \(DSRM\) for tasks that must be performed offline.  
  
19. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you have selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
20. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
21. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the AD DS installation when you are prompted to do so.  
  
  