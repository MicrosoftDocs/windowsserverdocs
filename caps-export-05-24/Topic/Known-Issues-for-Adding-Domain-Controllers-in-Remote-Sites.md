---
title: Known Issues for Adding Domain Controllers in Remote Sites
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2c608d24-43db-465b-9c5b-6674317a41ad
author: Femila
---
# Known Issues for Adding Domain Controllers in Remote Sites
  Review the following known issues before adding domain controllers in remote sites. You can use the information in this section to determine the method for adding domain controllers in remote sites that is best for your environment. Each method has advantages and disadvantages that are described in this section.  
  
> [!IMPORTANT]  
>  Do not attempt to perform actions based only on the recommendations in this topic. Step\-by\-step guidance is provided in the task\-based topics in this section for all actions that are recommended in this topic. Follow the links in this topic to the related task\-based topics.  
  
 You can use the following methods to add domain controllers in remote sites:  
  
-   Ship the member computer to the remote site, and then use the install from media \(IFM\) method to install Active Directory Domain Services \(AD DS\) on that computer. IFM uses previously prepared installation media as the source for the installation of AD DS in the remote site, avoiding replication from a source domain controller.  
  
-   Install AD DS in the hub site by using the normal Dcpromo method or the IFM method, and then ship the installed domain controller to the remote site.  
  
 SYSVOL replication issues potentially affect both methods.  
  
## SYSVOL replication  
 SYSVOL is a shared folder that stores files that must be available and synchronized among all domain controllers in a domain. SYSVOL contains Net Logon scripts, Group Policy settings, and either File Replication Service \(FRS\) or Distributed File System \(DFS\) Replication staging directories and files, depending on the replication method in use for replicating DFS folders. Replication of the SYSVOL folder is required for AD DS to function properly.  
  
 The primary focus for both methods of installing additional domain controllers in remote sites is to avoid the replication of AD DS over a wide area network \(WAN\) between the remote site and the hub site. Each method accomplishes this goal. However, depending on the size of your SYSVOL, you might also be concerned about replication of SYSVOL files over the network. When you use the IFM method to install a domain controller, SYSVOL is replicated from a domain controller in the domain unless you perform preliminary procedures. For information about using installation media as the source for SYSVOL during IFM installation of AD DS when you use DFS Replication to replicate SYSVOL, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\). If you use FRS to replicate SYSVOL, see article 311078 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=70809](http://go.microsoft.com/fwlink/?LinkId=70809)\).  
  
## Using IFM to install a domain controller in a remote site  
 On domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the Ntdsutil command\-line tool is improved to include a new command for creating installation media. The method for using IFM to install domain controllers includes the following general steps:  
  
1.  Use the **Ntdsutil ifm** command to create installation media from an up\-to\-date domain controller in the domain. If you want the additional domain controller to be a global catalog server, create the media on a global catalog server. If you want the additional domain controller to be a Domain Name System \(DNS\) server, create the media on a DNS server.  
  
2.  When you create additional domain controllers in the domain, you can refer to the shared folder or removable media where you store the installation media as follows: on the **Install from Media** page in the Active Directory Domain Services Installation Wizard or by using the **\/ReplicationSourcePath** parameter during an unattended installation.  
  
 As an alternative, you can create installation media by using Wbadmin.exe to restore a critical\-volumes backup to an alternate location. However, the Ntdsutil method is more efficient because you eliminate the restore process, which adds time and effort to the installation process.  
  
> [!NOTE]  
>  In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you cannot restore a system state backup to a network shared folder.  
  
### Advantages of using IFM to install a domain controller in a remote site  
 The following advantages are associated with using IFM to install a domain controller in a remote site:  
  
-   You can install many domain controllers from a single source of installation media.  
  
-   You do not have to disconnect a functioning domain controller from the replication topology. Therefore, you can avoid the disadvantages that are associated with a domain controller that does not replicate. For information about the problems that are associated with domain controller disconnection, see [Issues with installing domain controllers before shipping them to the remote site](#BKMK_1).  
  
-   You avoid replicating AD DS over a WAN link, particularly a link that requires a dial\-up connection.  
  
-   If you enable Remote Desktop on the server before you ship it, you do not have to employ an administrator with Domain Admins credentials in the remote site. You can also use Remote Server Administration Tools \(RSAT\) to manage AD DS remotely. You can install the tools on a member server that is running Windows Server 2008 or on a workstation that is running Windows Vista with Service Pack 1 \(SP1\). For information about installing these tools, see [Installing Remote Server Administration Tools for AD DS](../Topic/Installing-Remote-Server-Administration-Tools-for-AD-DS.md).  
  
    > [!NOTE]  
    >  If you do not need a writable domain controller in a remote site, you can install a read\-only domain controller \(RODC\) in the remote site. RODCs do not require administrative credentials for management. For information about using RODCs in remote sites, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120709](http://go.microsoft.com/fwlink/?LinkID=120709)\).  
  
### Issues with using IFM to install a domain controller in a remote site  
 The following issues are associated with using IFM to install a writable domain controller in a remote site:  
  
-   **Domain Admins credentials and remote installation.** If you install a writable domain controller, an administrator must have Domain Admins credentials to install AD DS. Assuming that you do not employ a service administrator with this level of administrative credentials in each branch site, a domain administrator in the hub site must be able to connect remotely to the server to perform the installation. Therefore, you must enable Remote Desktop on the server before you ship it to the remote site.  
  
-   **Bridgehead server load balancing.** If installation media are sent to many sites and if enough domain controllers are promoted at the same time, you might experience performance issues with the bridgehead servers that are the source for Active Directory and SYSVOL replication.  
  
    > [!NOTE]  
    >  These issues are of concern only in situations in which hundreds of domain controllers might be promoted at the same time and FRS is the SYSVOL replication system. If you are deploying hundreds of writable domain controllers in branch sites, see the Windows Server 2003 Active Directory Branch Office Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=42506](http://go.microsoft.com/fwlink/?LinkId=42506)\). If you are installing RODCs in branch sites, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120840](http://go.microsoft.com/fwlink/?LinkID=120709)\).  
  
    -   **SYSVOL replication.** Whether you use DFS Replication or FRS to replicate SYSVOL, replication of the full SYSVOL occurs if you do not perform preliminary preseeding procedures, as described in article 311078 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=70809](http://go.microsoft.com/fwlink/?LinkId=70809)\) for SYSVOL that is replicated by FRS, and in Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\) for SYSVOL that is replicated by DFS Replication. When you install AD DS without this additional preparation, the SYSVOL data in the installation media is deleted and SYSVOL is generated by replication.  
  
         Because FRS on the source computer uses CPU, memory, and disk resources, the FRS recommendation is to perform a staged update on no more than 10 branch office domain controllers at a time for a single source hub domain controller. If a single domain controller functions as the source for SYSVOL replication to more than 10 destination domain controllers, performance on the source domain controller can decrease significantly. To balance source domain controllers, you can use an answer file with Dcpromo to specify the source domain controller.  
  
        > [!NOTE]  
        >  When you use DFS Replication to replicate SYSVOL, these conditions are not an issue.  
  
         For information about performing a staged installation of RODCs, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
## Installing domain controllers before shipping them to the remote site  
 When you install a domain controller and then disconnect it from the network for a period of time, you interrupt the normal activities of other domain controllers on the network. This interruption creates error conditions that result from various failed operations, such as attempts to replicate with the disconnected domain controller. As long as you are aware of the issues that disconnections cause, you can take steps to ensure smooth disconnection and reconnection.  
  
### Advantages of installing domain controllers before shipping them to the remote site  
 The following advantages are associated with installing domain controllers before you ship them to the remote site:  
  
-   **Standardization.** The process for installing domain controllers can be automated and standardized in the hub or staging site, with the one additional step of packing and shipping the domain controller. If you follow the instructions in this guide for safe disconnection and reconnection, restarting the domain controller in the remote site is all that is required.  
  
-   **Branch site personnel.** The requirement for personnel with Domain Admins credentials is limited to the hub site.  
  
###  <a name="BKMK_1"></a> Issues with installing domain controllers before shipping them to the remote site  
 The following issues are associated with installing domain controllers and then disconnecting them from the network while they are shipped to the remote site:  
  
-   **Disconnection error conditions.** After disconnection, online domain controllers in the domain continue to attempt replication with the disconnected domain controller, causing AD DS and SYSVOL replication errors to be generated for as long as the domain controller is disconnected.  
  
-   **Additional preparation.** Additional preparation is required to ensure smooth reconnection:  
  
    -   Preparing for the nonauthoritative restart of SYSVOL. To avoid full replication of SYSVOL, you can take steps to ensure that only SYSVOL updates are replicated when the domain controller starts in the branch site.  
  
    -   Ensuring an adequate tombstone lifetime to avoid the possibility of objects remaining on the domain controller that have been permanently deleted from the directory on all other domain controllers. The tombstone lifetime is a forest\-wide setting that determines how long an object deletion persists in the directory.  
  
-   **Protection of existing accounts and metadata.** You must ensure that computer accounts and metadata for the domain controller are not deleted or improperly modified while the domain controller is disconnected.  
  
-   **Risk of lingering objects.** A lingering object is an object that remains on a disconnected domain controller after the object has been permanently deleted from AD DS on all connected domain controllers. Deletion updates are replicated as tombstone objects. These objects have a limited lifetime in AD DS, which is defined by the tombstone lifetime. After a tombstone is permanently removed from Active Directory, replication of the deletion that it represented is no longer possible. Therefore, if you restart a domain controller on which such an object remains, replication does not recognize that object as a deleted object, and the object remains in AD DS on only the reconnected domain controller and nowhere else. If you plan to disconnect a domain controller for longer than the period of time that a domain controller keeps track of object deletions \(the tombstone lifetime\), you must take additional steps to ensure directory consistency.  
  
    > [!CAUTION]  
    >  The default value for the tombstone lifetime is 180 days. In this case, the risk is remote if the tombstone lifetime is not changed. However, because the tombstone lifetime value can be changed administratively and because the risk has such significant consequences, you should always check the tombstone lifetime setting. For more information about lingering objects and their causes and effects, see Fixing Replication Lingering Object Problems \(Event IDs 1388, 1988, 2042\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120797](http://go.microsoft.com/fwlink/?LinkId=120797)\).  
  
### Maintaining directory consistency when you disconnect a domain controller  
 Maintaining consistency of Active Directory data involves several related issues. Review the following known issues before you disconnect an installed domain controller:  
  
-   Protection against lingering object replication  
  
-   Availability of operations master roles in the domain and forest  
  
-   Up to dateness of Active Directory replication at the time of disconnection  
  
-   SYSVOL consistency at reconnection  
  
 For procedures to ensure that all of these issues are resolved, see the following topics:  
  
-   [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md)  
  
-   [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md)  
  
#### Protection against lingering object replication  
 Domain controllers that have not performed inbound replication in the number of days equal to the previous tombstone lifetime are vulnerable to retaining lingering objects. If a domain controller that has one or more lingering objects is reconnected to the replication topology and a lingering object is subsequently updated on that domain controller, the object might be recreated in AD DS, depending on how the strict replication consistency registry setting is configured.  
  
 A lingering object is made known to the replication system only if it is updated on the domain controller that stores it. In this case, the source domain controller attempts replication of an update to an object that the destination does not store. The **strict replication consistency** registry entry \(type **REG\_DWORD**\) in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters**\) determines whether replication is allowed to proceed if the domain controller receives a request for an update to an object that it does not have.  
  
 The value in the **strict replication consistency** registry entry determines whether replication proceeds or is stopped, as follows:  
  
-   **1** \(enabled\): Inbound replication of the specified directory partition from the source is stopped on the destination domain controller. Replication of the directory partition is stopped on both the source and destination domain controllers.  
  
-   **0** \(disabled\): The destination requests the full object from the source domain controller, and the destination domain controller reanimates a full copy of an object that it has previously deleted and permanently removed through garbage collection.  
  
 The default value of the **strict replication consistency** registry entry is 1 on domain controllers that are running Windows Server 2003, Windows Server 2003 R2, and Windows Server 2008. If you are in doubt as to whether strict replication consistency is in effect, you can use the Repadmin command\-line tool to set replication consistency to **Strict** for all domain controllers in the forest. If you have domain controllers that are running Windows Server 2000, update these domain controllers to Windows Server 2008.  
  
#### Availability of operations masters  
 If you disconnect a domain controller from the network, you must ensure that it is not holding any operations master roles for the domain or forest. Check the domain controller for any operations master roles and, if you find any, transfer the roles before you disconnect the domain controller.  
  
#### Up to dateness of active directory replication  
 Ensure that a domain controller is updated before you disconnect it. Immediately before you disconnect the domain controller, force replication with all replication partners and verify that each directory partition replicates to the domain controller that you are disconnecting. If replication of any directory partition does not succeed, resolve the replication problem before you disconnect the domain controller. By ensuring that replication is up to date, you can maximize the possible safe disconnection period, which cannot exceed the tombstone lifetime for the forest.  
  
#### SYSVOL consistency  
 When you use DFS Replication for SYSVOL replication, when you restart the domain controller in the new site DFS Replication updates SYSVOL by processing the latest changes from the source domain controller. To ensure that SYSVOL is updated as quickly as possible, time the restart of the domain controller with the intersite replication schedule.  
  
 When you use FRS for SYSVOL replication, in addition to timing restart according to the replication schedule preparation might be necessary to avoid an extended period of latency when SYSVOL is updated. When you restart a domain controller without this preparation, FRS reconciles and processes all deletions and modifications that took place from the time of the last SYSVOL update to the time that the domain controller is restarted in the new site. If you have a large SYSVOL, you can avoid this extra processing and replication time by preparing the domain controller for nonauthoritative SYSVOL restore before you ship the domain controller. For information about preparing the domain controller for nonauthoritative SYSVOL restore, see Prepare a domain controller for nonauthoritative SYSVOL restart \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122831](http://go.microsoft.com/fwlink/?LinkID=122831)\).  
  
## See Also  
 [Preparing a Server Computer for Shipping and Installation from Media](../Topic/Preparing-a-Server-Computer-for-Shipping-and-Installation-from-Media.md)   
 [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md)   
 [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md)  
  
  