---
title: Installing a New Forest by Using the Graphical User Interface (GUI)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e398ac0c-0e73-494f-954c-f98fb04624c9
author: Femila
---
# Installing a New Forest by Using the Graphical User Interface (GUI)
  Windows provides two wizards that guide you through the AD DS installation process. The first wizard is the Add Roles Wizard, which you can access in Server Manager. The second wizard is the Active Directory Domain Services Installation Wizard, which you can access in the following ways:  
  
-   When you complete the Add Roles Wizard, click the link to launch the Active Directory Domain Services Installation Wizard.  
  
-   Click Start, click Run, type dcpromo.exe, and then click OK.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be logged on as the local Administrator for the computer. Depending on the operating system installation options that were selected for the computer, the local Administrator password might be blank or it might not be required. In this case, run the following command at a command prompt before you start to install AD DS:  
  
 **net user Administrator \<**password**\>\/passwordreq:yes**  
  
 Replace **\<**password**\>** with a strong password.  
  
### To install a new forest by using the Windows interface  
  
1.  [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page and then click **Next**.  
  
4.  On the **Select Server Roles** page, click the **Active Directory Domain Services** check box, and then click **Next**.  
  
    > [!NOTE]  
    >  On a server that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you might have to click **Add Required Features** to install .NET Framework 3.5.1 features before you can click **Next**.  
  
5.  If necessary, review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
     You can select the **Use advanced mode installation** check box to get additional installation options.  
  
9. On the **Operating System Compatibility** page, review the warning about the default security settings for Windows Server 2008 and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers, and then click **Next**.  
  
10. On the **Choose a Deployment Configuration** page, click **Create a new domain in a new forest**, and then click **Next**.  
  
11. On the **Name the Forest Root Domain** page, type the full Domain Name System \(DNS\) name for the forest root domain, and then click **Next**.  
  
     [!INCLUDE[ad_dcpromotext](../Token/ad_dcpromotext_md.md)]  
  
12. If you selected **Use advanced mode installation** on the Welcome page, the **Domain NetBIOS Name** page appears. On this page, type the NetBIOS name of the domain if necessary or accept the default name, and then click **Next**.  
  
13. On the **Set Forest Functional Level** page, select the forest functional level that accommodates the domain controllers that you plan to install anywhere in the forest, and then click **Next**.  
  
14. On the **Set Domain Functional Level** page, select the domain functional level that accommodates the domain controllers that you plan to install anywhere in the domain, and then click **Next**.  
  
    > [!NOTE]  
    >  The **Set Domain Functional Level** page does not appear if you select the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest functional level on a server that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or if you select the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest functional level on a server that runs [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
15. On the **Additional Domain Controller Options** page, **DNS server** is selected by default so that your forest DNS infrastructure can be created during AD DS installation. If you plan to use Active Directory–integrated DNS, click **Next**. If you have an existing DNS infrastructure and you do not want this domain controller to be a DNS server, clear the **DNS server** check box, and then click **Next**.  
  
     If you do not have static IPv4 and IPv6 addresses assigned to your network adapters, a warning message might appear advising you to set static addresses for both of these protocols before you can continue. If you have assigned a static IPv4 address to your network adapter and your organization does not use IPv6, you can ignore this message and click, **Yes, the computer will use a dynamically assigned IP address \(not recommended\).**  
  
    > [!IMPORTANT]  
    >  We recommend that you not disable the IPv6 protocol.  
  
     If the wizard cannot create a delegation for the DNS server, it displays a message to indicate that you can create the delegation manually. To continue, click **Yes**.  
  
16. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the SYSVOL files, and then click **Next**.  
  
     Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other nondirectory files.  
  
17. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**. This password must be used to start AD DS in Directory Service Restore Mode for tasks that must be performed offline.  
  
18. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the selected settings to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
19. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the AD DS installation when you are prompted to do so.  
  
> [!NOTE]  
>  If you are using Active Directory\-integrated DNS, the IP address for the Preferred DNS server for the first domain controller in the forest is automatically set to the loopback address of 127.0.0.1. This helps assure that the IP address of the first domain controller will be resolved in DNS even if the address is changed.  
  
  