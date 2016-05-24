---
title: Installing an Additional Domain Controller by Using IFM
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3dc846c2-ec2b-4413-9a96-2b134bb18f93
author: Femila
---
# Installing an Additional Domain Controller by Using IFM
  When you install Active Directory Domain Services \(AD DS\) by using the install from media \(IFM\) method, you can reduce the replication traffic that is initiated during the installation of an additional domain controller in an Active Directory domain. Reducing the replication traffic reduces the time that is necessary to install the additional domain controller.  
  
 [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] include an improved version of the Ntdsutil tool that you can use to create installation media for an additional domain controller. You can use Ntdsutil.exe to create installation media for additional domain controllers that you are creating in a domain. The IFM method uses the data in the installation media to install AD DS, which eliminates the need to replicate every object from a partner domain controller. However, objects that were modified, added, or deleted since the installation media was created must be replicated. If the installation media was created recently, the amount of replication that is required is considerably less than the amount of replication that is required for a regular AD DS installation.  
  
 You can also create installation media by restoring a critical\-volume backup of a similar domain controller in the same domain to an alternate location. For information about creating installation media by restoring a critical\-volume backup to an alternate location, see Restoring a Critical\-Volume Backup to an Alternate Location \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120612](http://go.microsoft.com/fwlink/?LinkID=120612)\).  
  
> [!NOTE]  
>  You cannot restore a system state backup to an alternate location. A system state backup can be restored only on the local domain controller. Therefore, a system state backup is not appropriate for creating installation media. To use this method of creating installation media, you must restore a critical\-volume backup.  
  
 The procedures in this task are particularly useful for installing domain controllers in remote sites. By using these procedures, you can avoid having to either replicate the entire Active Directory replica over a wide area network \(WAN\) link or disconnect an existing domain controller while it is being shipped to the remote site. For more information about installing additional domain controllers in remote sites, see [Adding Domain Controllers in Remote Sites](../Topic/Adding-Domain-Controllers-in-Remote-Sites.md).  
  
 IFM has the following requirements:  
  
-   You cannot use IFM to create the first domain controller in a domain. A Windows Server 2008–based domain controller must be running in the domain before you can perform IFM installations.  
  
-   The media that you use to create additional domain controllers must be taken from a domain controller in the same domain as the domain of the new domain controller.  
  
-   If the domain controller that you are creating is to be a global catalog server, the media for the installation must be created on an existing global catalog server in the domain.  
  
-   To install a domain controller that is a Domain Name System \(DNS\) server, you must create the installation media on a domain controller that is a DNS server in the domain.  
  
-   To create installation media for a full \(writable\) domain controller, you must run the **ntdsutil ifm** command on a writable domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
    > [!NOTE]  
    >  You cannot run the **ntdsutil ifm** command on a domain controller that runs Windows Server 2003. However, you can create a system state backup of a Windows Server 2003 domain controller, restore the backup to an alternate location, and then use the **dcpromo \/adv** command to create a Windows Server 2003 domain controller. For information about performing IFM installations on domain controllers that are running Windows Server 2003, see Installing a Domain Controller in an Existing Domain Using Restored Backup Media \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120623](http://go.microsoft.com/fwlink/?LinkId=120623)\).  
  
-   To create installation media for a read\-only domain controller \(RODC\), you can run the **ntdsutil ifm** command on either a writable domain controller or an RODC that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For RODC installation media, Ntdsutil removes any cached secrets, such as passwords. For more information about installing and managing RODCs, see the Step\-by\-Step Guide for Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\).  
  
-   You can use a 32\-bit domain controller to generate installation media for a 64\-bit domain controller; the reverse is also true. The ability to mix processor types for IFM installations is new in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   To include the SYSVOL folder, the domain controller on which you generate the installation media and the additional domain controller that you plan to create must both run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 or later or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. In addition, you must use DFS Replication to replicate SYSVOL in the domain. Use Robocopy.exe to copy the installation media from the source domain controller to the destination domain controller. For more information, see [Create Installation Media by Using Ntdsutil](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md).  
  
-   The IFM process creates a temp database in the %TMP% folder. You need at least 110% of the size of the AD DS or AD LDS database free on the drive where the %TMP% folder is in order for the operation to succeed. You can redirect the %TMP% folder to another disk on the server in order to use more space.  
  
 Ntdsutil.exe can create the four types of installation media, as described in the following table.  
  
|Type of installation media|Parameter|Description|  
|--------------------------------|---------------|-----------------|  
|Full \(writable\) domain controller|**Create Full**  *PathToMediaFolder*|Creates installation media for a writable domain controller or an Active Directory Lightweight Directory Services \(AD LDS\) instance in the folder that is identified in the path. If you are creating media in a shared folder on another computer, map a network drive to the folder before you perform the procedure.|  
|RODC|**Create RODC**  *PathToMediaFolder*|Creates installation media for an RODC in the folder that is identified in the path.|  
|Full \(or writable\) domain controller with SYSVOL **Important:**  This option works only for domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|**Create Sysvol Full**  *PathToMediaFolder*|Creates installation media for a writable domain controller with SYSVOL in the folder that is identified in the path.|  
|RODC with SYSVOL **Important:**  This option works only for domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|**Create Sysvol RODC**  *PathToMediaFolder*|Creates installation media for an RODC with SYSVOL in the folder that is identified in the path.|  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Ntdsutil.exe  
  
-   Dcpromo.exe  
  
-   Robocopy.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Create Installation Media by Using Ntdsutil](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md)  
  
2.  [Install an Additional Domain Controller by Using Installation Media](../Topic/Install-an-Additional-Domain-Controller-by-Using-Installation-Media.md)  
  
## See Also  
 [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md)   
 [Adding Domain Controllers in Remote Sites](../Topic/Adding-Domain-Controllers-in-Remote-Sites.md)  
  
  