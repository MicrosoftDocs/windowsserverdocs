---
title: Installing a New Child Domain by Using the Graphical User Interface (GUI)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8e316960-c9c3-4ace-ad80-5a84a120a0c5
author: Femila
---
# Installing a New Child Domain by Using the Graphical User Interface (GUI)
  The Windows interface provides wizards that guide you through the process for installing Active Directory Domain Services \(AD DS\).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group in the forest.  
  
### To install a new child domain by using the Windows interface  
  
1.  [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, click the **Active Directory Domain Services** check box, and then click **Next**.  
  
    > [!NOTE]  
    >  On a server that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you may have to click **Add Required Features** to install .NET Framework 3.5.1 features before you can click **Next**.  
  
5.  If necessary, review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
     To get additional installation options, select the **Use advanced mode installation** check box.  
  
9. On the **Operating System Compatibility** page, review the warning about the default security settings for Windows Server 2008 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers, and then click **Next**.  
  
10. On the **Choose a Deployment Configuration** page, click **Existing forest** and **Create a new domain in an existing forest**, and then click **Next**.  
  
11. On the **Network Credentials** page, type the name of any existing domain in the forest where you plan to install a new domain. Under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that can install the new domain. To install a new domain, you must be a member of the Enterprise Admins group. When you are finished providing credentials, click **Next**.  
  
12. On the **Name the New Domain** page, type the fully qualified domain name \(FQDN\) of the parent domain and the single\-label name of the child domain, and then click **Next**.  
  
     [!INCLUDE[ad_dcpromotext](../Token/ad_dcpromotext_md.md)]  
  
13. If you selected **Use advanced mode installation** on the **Welcome** page, the **Domain NetBIOS Name** page appears. On this page, type the NetBIOS name of the domain, if necessary, or accept the default name, and then click **Next**.  
  
14. On the **Set Domain Functional Level** page, select the domain functional level that accommodates the domain controllers that you plan to install anywhere in the domain, and then click **Next**.  
  
15. On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to its IP address, and then click **Next**.  
  
16. On the **Additional Domain Controller Options** page, select any additional options for the domain controller, and then click **Next**.  
  
     The **DNS server** option is selected by default so that your domain controller can function as a DNS server. A DNS zone and a delegation for that zone will be created automatically for this domain.  
  
     The **Global catalog** option is not selected by default. If you select this option, this domain controller will also host the domain\-wide operations master roles for the new domain, including the infrastructure master role. Hosting the infrastructure mater role on a global catalog server in a child domain can cause problems unless all the domain controllers in the domain are global catalog servers.  
  
     If you do not have static IPv4 and IPv6 addresses assigned to your network adapters, a warning message might appear advising you to set static addresses for both of these protocols before you can continue. If you have assigned a static IPv4 address to your network adapter and your organization does not use IPv6, you can ignore this message and click, **Yes, the computer will use a dynamically assigned IP address \(not recommended\).**  
  
    > [!IMPORTANT]  
    >  We recommend that you not disable the IPv6 protocol.  
  
17. If you selected **Use advanced mode installation** on the **Welcome** page, the **Source Domain Controller** page appears. Select **Any writable domain controller** or select **This specific domain controller** to specify a domain controller from which to replicate the configuration and schema directory partitions, and then click **Next**.  
  
18. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the SYSVOL files, and then click **Next**.  
  
     Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other nondirectory files.  
  
19. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**. This password must be used to start AD DS in Directory Service Restore Mode \(DSRM\) for tasks that must be performed offline.  
  
20. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the installation settings that you selected to an answer file that you can use to automate subsequent AD DS installations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
21. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
22. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the AD DS installation when you are prompted to do so.  
  
  