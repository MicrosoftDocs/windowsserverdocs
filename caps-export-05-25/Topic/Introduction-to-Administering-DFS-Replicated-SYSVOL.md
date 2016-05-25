---
title: Introduction to Administering DFS-Replicated SYSVOL
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b70e4241-ab24-44d8-b6c7-c25f9910ab58
author: Femila
---
# Introduction to Administering DFS-Replicated SYSVOL
  SYSVOL is a collection of folders that contain a copy of the domain’s public files, including system policies, logon scripts, and important elements of Group Policy objects \(GPOs\). The SYSVOL directory must be present and the appropriate subdirectories must be shared on a server before the server can advertise itself on the network as a domain controller. Shared subdirectories in the SYSVOL tree are replicated to every domain controller in the domain.  
  
> [!NOTE]  
>  For Group Policy, only the Group Policy template \(GPT\) is replicated through SYSVOL replication. The Group Policy container \(GPC\), which is stored in the domain, is replicated through Active Directory replication. For Group Policy to be effective, both parts must be available on a domain controller.  
  
## SYSVOL terminology and capitalization  
 SYSVOL is referred to as the “SYSVOL share.” The default root of the SYSVOL replica is at the path %systemroot%\\SYSVOL\\domain, but the folder that is actually shared by the domain controller is the %systemroot%\\SYSVOL\\sysvol folder by default.  
  
> [!NOTE]  
>  The location of the SYSVOL directory and subdirectories is configurable during and after Active Directory installation. The default locations under %systemroot%\\SYSVOL are used throughout this guide only as a relative reference to the location of SYSVOL files and folders.  
  
 The %systemroot%\\SYSVOL\\domain and %systemroot%\\SYSVOL\\sysvol folders appear to contain the same content because SYSVOL uses junction points \(also called reparse points\). A junction point is a physical location on a hard disk that points to data that is located elsewhere on the hard disk or on another storage device. Junction points look like folders and behave like folders \(in Windows Explorer they appear to be shortcuts to folders\), but they are not folders. A junction point contains a link to another folder. When a program opens it, the junction point automatically redirects the program to the folder to which the junction point is linked. The redirection is completely transparent to the user and the application. For example, if you open a command prompt and type `dir` to list the contents of \\%systemroot%\\SYSVOL\\sysvol, you notice a folder that is listed as \<JUNCTION\>. The junction point in %systemroot%\\SYSVOL\\sysvol links to %systemroot%\\SYSVOL\\domain.  
  
 In this guide, in reference to SYSVOL components and folders, the capitalization that is used reflects the capitalization of the default folders and parameters as they appear in the file system, in the registry, and in Active Directory Domain Services \(AD DS\). For example, the default SYSVOL directory tree always appears as %systemroot%\\SYSVOL\\sysvol, as it appears in Windows Explorer. When the topic is specific to the sysvol shared folder, lowercase sysvol is used. Similarly, the area of SYSVOL that is historically referred to as “the staging area” is described in this guide as “the staging areas subdirectory.” In this way, the folder “%systemroot%\\SYSVOL\\staging areas” is clearly understood and distinct from the “%systemroot%\\SYSVOL\\staging” folder. Capitalization of registry parameters and Active Directory attribute names are presented as they appear in those locations.  
  
## Using DFS Replication for replicating SYSVOL in Windows Server 2008  
 Distributed File System \(DFS\) Replication is a replication service that is available for replicating SYSVOL to all domain controllers in domains that have the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain functional level. DFS Replication was introduced in Windows Server 2003 R2. However, on domain controllers that are running Windows Server 2003 R2, SYSVOL replication is performed by the File Replication Service \(FRS\).  
  
> [!NOTE]  
>  The information and instructions in this section relate to DFS Replication of SYSVOL. For information about managing SYSVOL when you use FRS for file replication, see Administering FRS\-Replicated SYSVOL \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122535](http://go.microsoft.com/fwlink/?LinkId=122535)\).  
  
 DFS Replication technology significantly improves replication of SYSVOL. In Windows 2000 Server, Windows Server 2003, and Windows Server 2003 R2, FRS is used to replicate the contents of the SYSVOL share. When a change to a file occurs, FRS replicates the entire updated file. With DFS Replication, for files larger than 64 KB, only the updated portion of the file is replicated.  
  
 To replicate only updates to files, DFS Replication uses an algorithm called remote differential compression \(RDC\). RDC detects changes to the data in a file and enables DFS Replication to replicate changes in the form of file blocks, without having to replicate the entire file. RDC detects insertions, removals, and rearrangements of data in files. The DFS Replication service monitors SYSVOL, and, if a change occurs to any file that is stored in SYSVOL, DFS Replication automatically replicates the file updates to the SYSVOL folders on the other domain controllers in the domain. An additional improvement is that DFS Replication does not require the version vector join \(vvjoin\) operation, which is performed between FRS replication partners when new connections are created. Vvjoin is a CPU\-intensive operation that can affect the performance of the server and cause increased replication traffic.  
  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], DFS Replication is the default file replication service for domains that are initially created on domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. However, in a domain that is upgraded from another operating system to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], FRS is the default replication service for SYSVOL replication. To implement DFS Replication of SYSVOL after an upgrade to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain functional level, you must perform a preliminary migration process for replication of the SYSVOL tree.  
  
## Requirements for using DFS Replication  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], for newly created domains operating at the Active Directory domain functional level of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], DFS Replication is used by default for SYSVOL replication. If your domain controllers are upgraded from another operating system to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must install DFS Replication on all domain controllers in the domain, raise the domain functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and then follow a migration process to move from using FRS replication of SYSVOL to DFS Replication. For more information about the SYSVOL migration process, see SYSVOL Migration Series: Part 1 – Introduction to the SYSVOL migration process \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=119296](http://go.microsoft.com/fwlink/?LinkID=119296)\). For more information about DFS Replication, see Distributed File System Replication: Frequently Asked Questions \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122537](http://go.microsoft.com/fwlink/?LinkId=122537)\).  
  
 The day\-to\-day operation of SYSVOL replication is an automated process that does not require any human intervention other than watching for alerts that the DFS Replication service raises. Occasionally, you might perform some system maintenance as you change your network.  
  
 The topics in this section describe the tasks that are required for managing SYSVOL replication, including maintaining capacity and relocating SYSVOL components.  
  
## Key considerations for administering SYSVOL  
 A new graphical user interface \(GUI\) management tool, DFS Management, provides options for performing many SYSVOL management tasks. In Windows Server 2003, most SYSVOL management tasks required registry changes. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can use DFS Management to perform the following SYSVOL updates:  
  
-   Change the space that is allocated to the staging area  
  
-   Change the staging area path  
  
    > [!NOTE]  
    >  You cannot use DFS Management to change the SYSVOL path. You must make this change in the registry directly. For information about changing the SYSVOL path, see [Relocating SYSVOL Manually](../Topic/Relocating-SYSVOL-Manually.md).  
  
-   View shared folders  
  
 You can use the Diagnostic Reports features of DFS Management to implement a monitoring system to detect low disk space and other potential DFS Replication disruptions so that you can resolve these issues before the system stops replicating. The Ultrasound utility, which is a tool for monitoring FRS, cannot be used for DFS Replication. Instead, you can use the DFS Replication health reports that DFS Management generates. For information about using DFS Management to generate diagnostic reports, see Create a Diagnostic Report for DFS Replication \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122538](http://go.microsoft.com/fwlink/?LinkId=122538)\).  
  
 Other key considerations for managing SYSVOL include the following:  
  
-   **Capacity**  
  
     To manage SYSVOL, enough space must be provided to store SYSVOL. The quota that is allocated to the DFS Replication staging area is 4 gigabytes \(GB\) \(4096 MB\). The maximum size is 4 terabytes \(TB\) \(4096 GB\). Depending on the configuration of your domain, SYSVOL can require a significant amount of disk space to function properly. During the initial deployment, SYSVOL might be allocated adequate disk space to function. However, as your installation of Active Directory Domain Services \(AD DS\) grows in size and complexity, the required capacity can exceed the available disk space.  
  
     If you receive indications that disk space is low, determine whether the cause is attributable to inadequate physical space on the disk or the DFS Management setting that limits the quota that is allocated to the staging area. If staging area disk space is low, DFS Replication encounters frequent staging area cleanup events. You can avoid this scenario by using .admx file capability to implement a Central Store in SYSVOL to store and to replicate Windows Vista policy files. For information about using this solution, see article 929841 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122539](http://go.microsoft.com/fwlink/?LinkId=122539)\). You can also reduce SYSVOL size and replication time by managing Administrative Templates in Group Policy. For information about using this solution, see article 813338 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122540](http://go.microsoft.com/fwlink/?LinkId=122540)\).  
  
-   **Hardware maintenance**  
  
     System maintenance, such as removal of a disk drive, can make it necessary for you to relocate SYSVOL. Even if the maintenance occurs on a different disk drive, verify that the maintenance does not affect SYSVOL. Logical drive letters can change after you add and remove disks. DFS Replication locates SYSVOL by using paths that are stored in AD DS. If drive letters change after you add or remove disk drives, you must manually update the paths in AD DS.  
  
-   **Backing up GPOs**  
  
     The successful operation of Group Policy depends on the reliable operation of SYSVOL. Key components of GPOs exist in SYSVOL \(in the policies subdirectory\), and it is essential that these GPO components remain synchronized with related components in AD DS. Therefore, backing up only the SYSVOL component does not represent a full and complete backup of your GPOs. The Group Policy Management Console \(GPMC\) provides both UI\-based and scriptable methods for backing up GPOs. It is important that you back up GPOs as part of your regular backup\/disaster recovery processes. Soon after installation of a new domain, the default domain and default domain controllers' GPOs should be backed up. They should also be backed up after any subsequent changes are made. GPOs are included in system state backups. For information about backing up system state, see [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md). For information about backing up GPOs, see Back Up a Group Policy Object \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122542](http://go.microsoft.com/fwlink/?LinkID=122542)\).  
  
-   **Relocating SYSVOL**  
  
     When you relocate SYSVOL, you must first copy the entire folder structure to a new location. Then, you must update the junction points and path values that are stored in the registry and in AD DS to maintain the relationships between the paths, the folders, and the junctions. As an option, you can relocate the staging area and leave the rest of SYSVOL at its original location. In this case, you must update the staging folder path in AD DS.  
  
## Relocating SYSVOL folders  
 SYSVOL relocation should be undertaken only when required by disk space maintenance or upgrades. By default, SYSVOL is contained in the %systemroot%\\SYSVOL folder. The tree of folders that is contained within this folder can be extensive, depending on the size of SYSVOL, number of GPOs, and use of logon scripts. When you relocate SYSVOL folders, ensure that you copy all folders \(including any hidden folders\) and ensure that the relationships of the folders do not change.  
  
> [!NOTE]  
>  To ensure that all folders appear in Windows Explorer, on the **Tools** menu, click **Folder Options**. On the **View** tab, select **Show hidden files and folders**.  
  
 Before you attempt to relocate all or portions of SYSVOL, you must clearly understand the folder structure and the relationships between the folders and the path and size information that is stored in AD DS. When folders are moved, any associated values that are stored in AD DS and the registry must be updated to match the new location. The folder structure contains junction points that also require updating after folders are moved to a new location.  
  
 When you relocate folders, you use the first three levels of subdirectories to properly update the path locations that DFS Replication uses. These levels are affected by junction points and parameter settings. These folders include the following:  
  
-   %systemroot%\\SYSVOL  
  
-   %systemroot%\\SYSVOL\\domain  
  
-   %systemroot%\\SYSVOL\\domain\\DfsrPrivate  
  
-   %systemroot%\\SYSVOL\\domain\\Policies  
  
-   %systemroot%\\SYSVOL\\domain\\scripts  
  
-   %systemroot%\\SYSVOL\\staging  
  
-   %systemroot%\\SYSVOL\\staging\\domain  
  
-   %systemroot%\\SYSVOL\\staging areas  
  
-   %systemroot%\\SYSVOL\\staging areas\\\<FQDN\>, where FQDN is the fully qualified domain name of the domain that this domain controller hosts, for example, contoso.com.  
  
-   %systemroot%\\SYSVOL\\sysvol  
  
-   %systemroot%\\SYSVOL\\sysvol\\\<FQDN\>, where FQDN is the fully qualified domain name of the domain that this domain controller hosts, for example, contoso.com.  
  
> [!NOTE]  
>  If any of the folders do not appear in Windows Explorer, click **Tools**, and then click **Folder Options**. On the **View** tab, click **Show hidden files and folders**.  
  
 If you use Windows Explorer to view these folders, they appear to be typical folders. If you open a command prompt and type `dir` to list these folders, you notice that two special folders are listed as \<JUNCTION\>. Both folders labeled FQDN are junction points. The junction point in %systemroot%\\SYSVOL\\sysvol links to %systemroot%\\SYSVOL\\domain. The junction in %systemroot%\\SYSVOL\\staging areas links to %systemroot%\\SYSVOL\\staging\\domain. If you change the path to the folders to which the junctions are linked, you must also update the junctions, including drive letter changes and folder changes.  
  
 Besides junction points linking to folders within the SYSVOL tree, the registry and AD DS also store references to folders. These references contain paths that you must update if you change the location of the folder:  
  
-   Registry: The **SysVol** Netlogon parameter in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**. This registry entry stores the path to the sysvol shared folder \(default %systemroot%\\SYSVOL\\sysvol\). The Netlogon service uses this path to identify the location of the folder that it uses to create the SYSVOL and NETLOGON \(scripts\) share points.  
  
-   AD DS: Two attributes in AD DS store the paths for the SYSVOL root and staging area folders, as shown in the following table.  
  
|Directory value|Default referenced location|Contents|  
|---------------------|---------------------------------|--------------|  
|**msDFSR\-RootPath**|%systemroot\\SYSVOL\\domain|Policies and scripts|  
|**msDFSR\-StagingPath**|%systemroot\\SYSVOL\\staging\\domain|Staging area folders|  
  
  