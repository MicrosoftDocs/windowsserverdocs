---
title: Performing a Staged RODC Installation by Using the Graphical User Interface (GUI)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 542632ea-00be-4163-bb5d-d3cd32d8e4d2
author: Femila
---
# Performing a Staged RODC Installation by Using the Graphical User Interface (GUI)
  Use the following procedures to create an RODC account and to attach a server to that account.  
  
 You can use the Active Directory Users and Computers snap\-in to create an RODC account.  
  
#### To create an RODC account by using the Windows interface  
  
1.  Click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2.  Either right\-click the **Domain Controllers** organizational unit \(OU\) or click the **Domain Controllers** OU, and then click **Action**.  
  
3.  Click **Pre\-create Read\-only Domain Controller account**.  
  
4.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, if you want to modify the default the Password Replication Policy \(PRP\), select **Use advanced mode installation**, and then click **Next**.  
  
5.  On the **Operating System Compatibility** page, review the warning about the default security settings for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers, and then click **Next**.  
  
6.  On the **Network Credentials** page, under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group. When you are finished providing credentials, click **Next**.  
  
7.  On the **Specify the Computer Name** page, type the computer name of the server that will be the RODC.  
  
8.  On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to the IP address of the computer on which you are running the wizard, and then click **Next**.  
  
9. On the **Additional Domain Controller Options** page, make the following selections, and then click **Next**:  
  
    -   **DNS server**: This option is selected by default so that your domain controller can function as a Domain Name System \(DNS\) server. If you do not want the domain controller to be a DNS server, clear this option. However, if you do not install the DNS server role on the RODC and the RODC is the only domain controller in the branch office, users in the branch office will not be able to perform name resolution when the wide area network \(WAN\) to the hub site is offline.  
  
    -   **Global catalog**: This option is selected by default. It adds the global catalog, read\-only directory partitions to the domain controller, and it enables global catalog search functionality. If you do not want the domain controller to be a global catalog server, clear this option. However, if you do not install a global catalog server in the branch office or enable universal group membership caching for the site that includes the RODC, users in the branch office will not be able to log on to the domain when the WAN to the hub site is offline.  
  
    -   **Read\-only domain controller**. When you create an RODC account, this option is selected by default and you cannot clear it.  
  
10. If you selected the **Use advanced mode installation** check box on the **Welcome** page, the **Specify the Password Replication Policy** page appears. By default, no account passwords are replicated to the RODC, and security\-sensitive accounts \(such as members of the Domain Admins group\) are explicitly denied from ever having their passwords replicated to the RODC.  
  
     To accept the default setting, click **Next**.  
  
     Or  
  
     To add other accounts to policy, click **Add**. If the accounts will be allowed to have their passwords replicated to the RODC, click **Allow passwords for the account to replicate to this RODC**. If the accounts will be denied from having their passwords replicated to the RODC, click **Deny passwords for the account from replicating to this RODC**. Then, click **OK**. When you are done adding other accounts, click **Next**.  
  
     When you install the first RODC in a domain, domain group accounts that are required for RODCs to function are created. Depending on your replication topology, the wizard might return an error indicating that these group accounts are not available when you try to install another RODC in the domain. In this case, wait for replication to complete before you install the additional RODC.  
  
11. In **Select Users, Computers, and Groups**, type the names of the accounts that you want to add to the policy, and then click **OK**.  
  
12. On the **Delegation of RODC Installation and Administration** page, type the name of the user or the group who will attach the server to the RODC account that you are creating. You can type the name of only one security principal.  
  
     To search the directory for a specific user or group, click **Set**. In **Select Users, Computers, or Groups**, type the name of the user or group. We recommend that you delegate RODC installation and administration to a group.  
  
     This user or group will also have local administrative rights on the RODC after the installation. If you do not specify a user or group, only members of the Domain Admins group or the Enterprise Admins group will be able to attach the server to the account.  
  
     When you are finished, click **Next**.  
  
13. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type a name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to create the RODC account.  
  
14. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
 After you create the account for the RODC, the user or group to whom you delegated installation and administration of the RODC \(in step 11 in the previous procedure\) can run the Active Directory Domain Services Installation Wizard on the server that will become the RODC. Make sure that the server is not joined to the domain before you start the wizard.  
  
#### To attach a server to an RODC account using the Windows interface  
  
1.  Log on as local Administrator to the server that will become the RODC, and then open an elevated command prompt.  
  
2.  Type the following command, and then press ENTER:  
  
     `dcpromo /UseExistingAccount:Attach`  
  
    > [!NOTE]  
    >  This command is required to start the second stage of the RODC installation. After the administrator enters credentials \(step 4\), the wizard will automatically detect the name of the server and try to match it to an RODC account that has been precreated for it.  
  
3.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**, or, if you want to install from media or identify the source domain controller for AD DS replication, select the **Use advanced mode installation** check box  
  
4.  On the **Network Credentials** page, type the name of any existing domain in the forest where you plan to install the additional domain controller. Under **Specify the account credentials to use to perform the installation**, click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that was delegated the ability to install and administer the RODC when the RODC account was created. When you are finished providing credentials, click **Next**.  
  
5.  On the **Select Domain Controller Account** page, confirm that the wizard has found an existing RODC account that matches the name of the server, and then click **Next**.  
  
     If you do not have static IPv4 and IPv6 addresses assigned to your network adapters, a warning message might appear advising you to set static addresses for both of these protocols before you can continue. If you have assigned a static IPv4 address to your network adapter and your organization does not use IPv6, you can ignore this message and click, **Yes, the computer will use a dynamically assigned IP address \(not recommended\).**  
  
    > [!IMPORTANT]  
    >  We recommend that you not disable the IPv6 protocol.  
  
6.  If you selected advanced installation mode, you can specify the following advanced options:  
  
    1.  On the **Install from Media** page, you can provide the location of installation media to be used to create the domain controller and configure AD DS, or you can choose to have all data replicated over the network. Note that some data will be replicated over the network even if you choose to install from media. For information about using this method to install the domain controller, see [Installing AD DS from Media_deleted](../Topic/Installing-AD-DS-from-Media_deleted.md).  
  
    2.  On the **Source Domain Controller** page, you can specify a domain controller from which to replicate the configuration and schema directory partitions \(or the entire Active Directory database if you do not choose to install from media\). If you select **This specific domain controller**, you can select the domain controller that you want to provide source replication to create the new domain controller, and then click **Next**.  
  
7.  On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume \(SYSVOL\) files, and then click **Next**.  
  
     Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other nondirectory files.  
  
8.  On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**. This password is used to start AD DS in Directory Service Restore Mode \(DSRM\) for tasks that must be performed offline. The password complexity and length must comply with the domain security policy.  
  
9. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type a name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
10. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the AD DS installation when you are prompted to do so.  
  
  