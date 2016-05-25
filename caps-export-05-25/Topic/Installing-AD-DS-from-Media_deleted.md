---
title: Installing AD DS from Media_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 146d1360-09ac-4cdd-8d44-c9756d3550c9
author: Femila
---
# Installing AD DS from Media_deleted
  You can use the Ntdsutil.exe tool to create installation media for additional domain controllers that you are creating in a domain. By using the Install from Media \(IFM\) option, you can minimize the replication of directory data over the network. This helps you install additional domain controllers in remote sites more efficiently.  
  
 Ntdsutil.exe can create four types of installation media, as described in the following table.  
  
 You must use read\-only domain controller \(RODC\) installation media to install an RODC. For RODC installation media, the **ntdsutil** command removes any cached secrets, such as passwords. You can create RODC installation media either on an RODC or on a writeable domain controller. You must use writeable domain controller installation media to install a writeable domain controller. You can create writeable domain controller installation media only on a writeable domain controller.  
  
 If the source domain controller where you create the installation media and the destination server where you plan to install Active Directory Domain Services \(AD DS\) both run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 or later or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and if you are using Distributed File System \(DFS\) Replication for SYSVOL, you can run the **ntdsutil ifm** command with an option to include the SYSVOL shared folder in the installation media. If the installation media includes SYSVOL, you must use Robocopy.exe to copy the installation media from the source domain controller to the destination server. For more information, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
|Type of installation media|Parameter|Description|  
|--------------------------------|---------------|-----------------|  
|Full \(or writable\) domain controller|**Create Full**  *PathToMediaFolder*|Creates installation media for a writable domain controller or an Active Directory Lightweight Directory Services \(AD LDS\) instance in the folder that is identified in the path.|  
|RODC|**Create RODC**  *PathToMediaFolder*|Creates installation media for an RODC in the folder that is identified in the path.|  
|Full \(or writable\) domain controller with SYSVOL **Important:**  This option works only for domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|**Create Sysvol Full**  *PathToMediaFolder*|Creates installation media for a writable domain controller with SYSVOL in the folder that is identified in the path.|  
|RODC with SYSVOL **Important:**  This option works only for domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|**Create Sysvol RODC**  *PathToMediaFolder*|Creates installation media for an RODC with SYSVOL in the folder that is identified in the path.|  
  
 You cannot run the **ifm** command on a domain controller that runs Windows Server 2003. However, you can create a backup of a Windows Server 2003 domain controller and then use the **dcpromo \/adv** command to create a Windows Server 2003 domain controller.  
  
 Installation from media does not work across different operating system versions. In other words, you must use a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller to generate installation media to use for another [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller installation.  
  
 When the Active Directory Recycle Bin is enabled, any installation media that was created before the Active Directory Recycle Bin was enabled is no longer valid. Create new installation media while Active Directory Recycle Bin is enabled.  
  
 You can use a 32\-bit domain controller to generate installation media for a 64\-bit domain controller, the reverse is also true.  
  
 You can use the following procedure to create installation media for AD DS.  
  
 **Administrative Credentials**  
  
 To create installation media for AD DS, you must be able to log on to a domain controller interactively and be able to make a backup. On a writable domain controller, this means that you must be a member of the **Builtin Administrators**, **Server Operators**, **Domain Admins**, or the **Enterprise Admins** groups to perform the following procedure.  
  
 On an RODC, a user that you delegate can create the installation media, but you can only create RODC installation media \(not installation media for a writable domain controller\) on an RODC.  
  
### To create installation media  
  
1.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator** to open an elevated command prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    ntdsutil  
    ```  
  
3.  At the `ntdsutil` prompt, type the following command, and then press ENTER:  
  
    ```  
    activate instance ntds  
    ```  
  
4.  At the `ntdsutil` prompt, type the following command, and then press ENTER:  
  
    ```  
    ifm  
    ```  
  
5.  At the `ifm:` prompt, type the command for the type of installation media that you want to create \(as listed in the table earlier in this topic\), and then press ENTER.  
  
     For example, to create RODC installation media, type the following command, and then press ENTER:  
  
    ```  
    create rodc C:\InstallationMedia  
    ```  
  
     Where `C:\InstallationMedia` is the path to the folder where you want the installation media to be created.  
  
     You can save the installation media to a network shared folder or to any other type of removable media.  
  
    > [!NOTE]  
    >  The IFM process creates a temp database in the %TMP% folder. You need at least 110% of the size of the AD DS or AD LDS database free on the drive where the %TMP% folder is in order for the operation to succeed. You can redirect the %TMP% folder to another disk on the server in order to use more space.  
  
 When you create additional domain controllers in the domain, you can refer to the shared folder or removable media where you store the installation media—on the **Install from Media** page in the Active Directory Domain Services Installation Wizard or by using the **\/ReplicationSourcePath** parameter during an unattended installation.  
  
 The wizard installs AD DS using the data in the installation media, which eliminates the need to replicate every object from a partner domain controller. However, objects that were modified, added, or deleted since the installation media was created must be replicated. If the installation media was created recently, the amount of replication that is required is considerably less than the amount of replication that is required for a regular AD DS installation.  
  
  