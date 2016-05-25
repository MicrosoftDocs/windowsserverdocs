---
title: Install AD DS on the Second Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6fe8ef6b-0255-4f20-b9bc-6f4f36d6bd7e
author: Femila
---
# Install AD DS on the Second Domain Controller
You install Active Directory Domain Services \(AD DS\) on the computer that you want to make the second forest root domain controller by running the Active Directory Domain Services Installation Wizard.  
  
The Windows interface in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] provides two wizards that guide you through the AD DS installation process. One wizard is the Add Roles Wizard, which you can access in Server Manager. The other wizard is the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), which you can access in either of the following ways:  
  
-   When you complete the Add Roles Wizard, click the link to launch the Active Directory Domain Services Installation Wizard.  
  
-   Click **Start**, click **Run**, type **dcpromo.exe**, and then click **OK**.  
  
If you use the advanced options in the Active Directory Domain Services Installation Wizard, you can control how the AD DS database is installed on the server, by using Install from Media \(IFM\) or replication:  
  
-   Using IFM, you can provide a location for installation media that you have created with Ntdsutil.exe or that you have restored from a backup of a similar domain controller in the same domain. If you create the installation media by using Ntdsutil, you have the option to create secure installation media for a read\-only domain controller \(RODC\). In this case, Ntdsutil removes cached secrets, such as passwords, from the installation media.  
  
-   Using replication, you can specify a domain controller in the domain from which to replicate AD DS.  
  
Membership in the Domain Admins group for the domain in which you install the domain controller is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install AD DS on a domain controller in an existing domain  
  
1.  Click **Start**, and then click **Server Manager**.  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, click the **Active Directory Domain Services** check box, and then click **Next**.  
  
5.  Review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
    As an alternative, if you want to install from media or identify the source domain controller for AD DS replication, select **Use advanced mode installation**, and then click **Next**.  
  
9. On the **Choose a Deployment Configuration** page, click **Existing forest**, click **Add a domain controller to an existing domain**, and then click **Next**.  
  
10. On the **Network Credentials** page, type the name of any existing domain in the forest where you plan to install the additional domain controller, and then take the following actions:  
  
    1.  Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**.  
  
    2.  In the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. \(To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group.\)  
  
    3.  When you are finished providing credentials, click **Next**.  
  
11. On the **Select a Domain** page, select the domain of the new domain controller, and then click **Next**.  
  
12. On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to its IP address, and then click **Next**.  
  
    Dcpromo suggests that you install the domain controller in the site that corresponds to its IP address.  
  
13. On the **Additional Domain Controller Options** page, make the following selections, and then click **Next**:  
  
    -   **DNS server**: This option is selected by default when AD DS integrates the DNS Server service into the domain so that your domain controller can function as a DNS server. If you do not want the domain controller to be a DNS server, clear the check box for this option.  
  
    > [!IMPORTANT]  
    > We recommend that you install DNS when you run the Active Directory Domain Services Installation Wizard \(keep the default option for DNS installation suggested by dcpromo.exe\), in which case the wizard creates the DNS zone delegation automatically.  
  
    -   **Global Catalog**: This option is selected by default. It adds the global catalog, read\-only directory partitions to the domain controller, and it enables global catalog search functionality.  
  
    -   **Read\-only domain controller**: This option is not selected by default. It makes the additional domain controller read\-only. For more information about RODCs, see Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\).  
  
14. If you selected the advanced installation mode, you can specify the following advanced options:  
  
    1.  On the **Install from Media** page, you can provide the location of the installation media that you want to use to create the domain controller and configure AD DS, or you can have all of the replication done over the network. \(Some data is replicated over the network even if you install from media.\) For information about using this method to install the domain controller, see Installing AD DS From Media \([http:\/\/go.microsoft.com\/fwlink\/LinkID\=93104](http://go.microsoft.com/fwlink/?LinkId=93104)\).  
  
    2.  On the **Source Domain Controller** page, you can specify a domain controller from which to replicate the configuration and schema directory partitions. If you select **This specific domain controller**, you can select the domain controller that you want to provide source replication to create the new domain controller, and then click **Next**. If you do not choose to install from media, all data is replicated from this source domain controller.  
  
15. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume \(SYSVOL\) files, and then click **Next**.  
  
    Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other files that are not directory files.  
  
16. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**.  
  
    You must use this password to start AD DS in Directory Service Restore Mode for tasks that must be performed offline.  
  
17. On the **Summary** page, review your selections.  
  
    Click **Back** to change any selections, if necessary.  
  
    To save the settings that you have selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
    When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
18. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
19. When you are prompted to restart the server, you can either select the **Reboot on completion** check box to restart the server restart automatically or you can restart the server manually to complete the AD DS installation.  
  
For more information about other ways to install additional [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers in an existing forest, see Installing an Additional [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92692](http://go.microsoft.com/fwlink/?LinkId=92692)\).  
  
