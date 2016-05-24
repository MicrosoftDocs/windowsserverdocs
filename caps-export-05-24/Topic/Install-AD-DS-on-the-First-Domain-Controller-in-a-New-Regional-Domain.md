---
title: Install AD DS on the First Domain Controller in a New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 89d1d46e-bd62-4b87-833b-4a1046e86130
author: Femila
---
# Install AD DS on the First Domain Controller in a New Regional Domain
If you are installing a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] regional domain in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest, you do not have to prepare the forest before you begin the installation. However, before you install a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] regional domain in a Windows Server 2003 or Microsoft Windows 2000 Server forest, you must run the command\-line tool Adprep. Running Adprep prepares the forest before you install the first domain controller of the new regional domain that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
For more information about other ways to install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]regional domains, see Installing a New [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Child Domain \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102560](http://go.microsoft.com/fwlink/?LinkId=102560)\).  
  
The Windows interface provides wizards that guide you through the Active Directory Domain Services \(AD DS\) installation process.  
  
Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install a new regional domain  
  
1.  Click **Start**, and then click **Server Manager**.  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, select the **Active Directory Domain Services** check box, and then click **Next**.  
  
5.  If necessary, review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
    If you select the **Use advanced mode installation** check box, the wizard displays the **Domain NetBIOS Name** page and the **Source Domain Controller** page. On the **Domain NetBIOS Name** page, you can change the NetBIOS name that the wizard generates by default. On the **Source Domain Controller** page, you can choose a specific domain controller to use for sending and receiving domain data during the installation.  
  
9. On the **Choose a Deployment Configuration** page, click **Existing forest** and **Create a new domain in an existing forest**, and then click **Next**.  
  
10. On the **Network Credentials** page, type the name of any existing domain in the forest where you want to install a new domain, and then complete the following steps:  
  
    1.  Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**.  
  
    2.  In the **Windows Security** dialog box, provide the user name and password for an account that can install the new domain.  
  
        To install a new domain, you must be a member of the Enterprise Admins group.  
  
    3.  When you have finished providing credentials, click **Next**.  
  
11. On the **Name the New Domain** page, type the fully qualified domain name \(FQDN\) of the parent domain and the single\-label name of the child domain, and then click **Next**.  
  
12. On the **Domain NetBIOS Name** page, change the name, if necessary, and then click **Next**.  
  
13. On the **Set Domain Functional Level** page, select the domain functional level that accommodates the domain controllers that you plan to install anywhere in the domain, and then click **Next**.  
  
14. On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to its IP address, and then click **Next**.  
  
15. On the **Additional Domain Controller Options** page, select any additional options for the domain controller, and then click **Next**.  
  
    The **DNS server** option is selected by default so that your domain controller can function as a Domain Name System \(DNS\) server. A DNS zone and a delegation for that zone are automatically created for this domain.  
  
    The **Global catalog** option is not selected by default. If you select this option, this domain controller will also host the domain\-wide operations master roles for the new domain, including the infrastructure operations master role. Hosting the infrastructure operations master role on a global catalog server in a child domain can cause problems unless all the domain controllers in the domain are global catalog servers.  
  
16. On the **Source Domain Controller** page, select **Any writable domain controller** or select **This specific domain controller** to specify a domain controller from which to replicate the configuration and schema directory partitions, and then click **Next**.  
  
17. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume \(SYSVOL\) files, and then click **Next**.  
  
    Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other files that are not directory files.  
  
18. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**.  
  
    You must use this password to start AD DS in Directory Service Restore Mode for tasks that you must perform offline.  
  
19. On the **Summary** page, review your selections.  
  
    Click **Back** to change any selections, if necessary.  
  
    To save the installation settings that you selected to an answer file that you can use to automate subsequent AD DS installations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
    When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
20. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
21. When you are prompted to restart the server, you can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server manually to complete the AD DS installation.  
  
