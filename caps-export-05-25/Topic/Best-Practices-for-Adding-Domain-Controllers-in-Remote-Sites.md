---
title: Best Practices for Adding Domain Controllers in Remote Sites
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e491552b-7d31-4052-8f3d-21ba83de8e00
author: Femila
---
# Best Practices for Adding Domain Controllers in Remote Sites
  By reviewing the information in [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md), you can determine the best method to use for installing Active Directory Domain Services \(AD DS\) to create domain controllers in your remote sites. The following best practices help ensure trouble\-free installation of domain controllers in remote sites.  
  
> [!IMPORTANT]  
>  Do not attempt to perform actions based only on the recommendations that are described in this topic. Step\-by\-step guidance is provided in the task\-based topics in this guide for all recommendations in this topic.  
  
## Best practices for using IFM to install AD DS in the remote site  
 Installation from media \(IFM\) is a method of installing AD DS without replication from a source domain controller. By using IFM, you provide a local source for the domain, configuration, and schema directory partitions—and, as an option, global catalog, partial, read\-only directory partitions and Domain Name System \(DNS\) application directory partitions. The local source is the installation media files that reside on the server that you are installing. Updates to object attributes that occur since the installation media was created will replicate over the network from an existing domain controller in the domain or forest. Although SYSVOL is part of the installation media, under normal conditions the source for SYSVOL is not the installation media. Instead, SYSVOL is created by replication from an existing domain controller. Configuring the installation media to be the source for SYSVOL requires additional procedures. For information about using installation media as the source for SYSVOL during IFM installation of AD DS, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 To use IFM for installation of one or more additional domain controllers in a domain, you can do one of the following:  
  
-   Specify a volume on the installation computer as the location for the media when you run the **ntdsutil ifm** command. For information about the effects of the location on the installation process, see [Preparing a Server Computer for Shipping and Installation from Media](../Topic/Preparing-a-Server-Computer-for-Shipping-and-Installation-from-Media.md).  
  
-   Create the media locally, and then copy \("burn"\) the installation media onto removable media, such as a portable disk drive, CD, or DVD, which can be shipped with the installation computer when it leaves the staging site, or it can be shipped separately.  
  
-   Create the media locally, and then transfer the installation media to the local hard drive of the workgroup computer before it leaves the staging site.  
  
 For information about the advantages and disadvantages of these methods, see [Preparing a Server Computer for Shipping and Installation from Media](../Topic/Preparing-a-Server-Computer-for-Shipping-and-Installation-from-Media.md).  
  
 The following best practices optimize data security and consistency when you add domain controllers in remote sites:  
  
-   **Upgrade to Windows Server 2008.** Windows Server 2008 includes an enhanced version of Ntdsutil.exe that you can use to create installation media, rather than using a restored system state backup as is required in Windows Server 2003. Ntdsutil.exe in Windows Server 2008 includes a new **ifm** command that creates installation media for additional domain controllers. The installation media that is created by this command contains only is the items that are required for installing AD DS: the Ntds.dit database file and the registry. You can create media for a full \(writable\) installation of AD DS or for a read\-only domain controller \(RODC\) installation. For the RODC installation, the **ntdsutil ifm** command creates secure installation media by removing secrets, such as passwords, from the Active Directory data. You create the media by using Volume Shadow Copy Service \(VSS\), taking a fraction of the time that is required to create a backup. For information about upgrading the forest to Windows Server 2008, see the AD DS Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116283](http://go.microsoft.com/fwlink/?LinkId=116283)\).  
  
    > [!NOTE]  
    >  On a domain controller that is running Windows Server 2008, you cannot restore a system state backup to an alternate location. Instead, use the **ntdsutil ifm** command to create installation media.  
  
-   **Create media on the type of domain controller that you want to add.** You must create installation media on the type of domain controller that you want to add. If you want to add a global catalog server in the remote site, run the **ntdsutil ifm** command on a global catalog server in the domain. If you want to add a DNS server, run the **ntdsutil ifm** command on a domain controller that is a DNS server in the domain.  
  
-   **Take the same security precautions when you ship removable installation media—or a server computer that contains installation media—as you would when you ship an installed domain controller.** For information about securing domain controllers, see the Best Practice Guide for Securing Windows Server Active Directory Installations \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=28521](http://go.microsoft.com/fwlink/?LinkId=28521)\).  
  
-   **Minimize the time between media creation and installation.** Minimizing this delay reduces the number of updates that will be required to replicate after installation.  
  
-   **Install the operating system before you ship the server to the remote site.** Installing the operating system requires expertise that might not be available at branch sites. Ideally, installation routines are available in the staging site to automate the operating system installation process and ensure uniformity for all domain controllers \(partition sizes, drive letter assignments, and so on\). As part of the operating system installation, apply a standardized set of hotfixes plus any available service packs to ensure service consistency throughout the forest.  
  
-   **Ship the server as a member of a workgroup rather than a member server in a domain.** If the server is joined to a domain and then stolen during shipment, information about domain names, DNS suffixes, and the number of domains in the forest can aid attackers in their attempts to compromise or steal directory data.  
  
-   **Ship computers with properly configured IP, subnet mask, default gateway, and DNS server addresses.** Remember to reconfigure the server with TCP\/IP settings that are appropriate to the target site, not the staging site.  
  
-   **Enable Remote Desktop on the server computer before shipping.** This best practice assumes that you want to install and manage AD DS remotely rather than employing an administrator with Domain Admins credentials in each remote site.  
  
## Best practices for installing domain controllers before you ship them to a remote site  
 When you install AD DS in the hub or staging site, disconnect the installed domain controller, and then ship the computer to the remote site, you are disconnecting a viable domain controller from the replication topology. The most significant risk from disconnection is that the domain controller will remain offline long enough to exceed the tombstone lifetime and thereby become capable of retaining objects that have been permanently deleted from the directory on all other domain controllers in the domain. Such objects, called lingering objects, cause directory inconsistency, and, under certain conditions, they can be reintroduced into the directory. For information about the causes and effects of lingering objects and how to avoid them, see [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md).  
  
 The following best practices help ensure a smooth and secure disconnection and restart. For step\-by\-step procedures to perform all of these best practices, see [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md) and [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md).  
  
-   **Configure the tombstone lifetime appropriately.** Ensure that the tombstone lifetime is not lowered below the default value. The default tombstone lifetime in a forest that is created on a domain controller running Windows 2000 Server or Windows Server 2003 is 60 days. The default tombstone lifetime in a forest that is created on a server running Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 with Service Pack 2 \(SP2\), Windows Server 2003 R2, or Windows Server 2008 is 180 days. If you must disconnect a domain controller for a period of several weeks or months, before you disconnect the domain controller, do the following:  
  
    -   **Estimate the anticipated length of disconnection.**  
  
    -   **Determine the value of the tombstone lifetime for the forest.** This value is stored in the **tombstoneLifetime** attribute of CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration,DC\=*ForestRootDomain*.  
  
    -   **Determine the maximum length of time that the domain controller can be disconnected safely.** From the tombstone lifetime number of days, subtract a generous estimate of the number of days that are required for end\-to\-end replication latency. The resulting amount of time is the maximum period for which the domain controller can be disconnected safely, without danger of expired deletions \(tombstones\) remaining on the domain controller.  
  
    -   **Determine whether to extend the tombstone lifetime for the forest.** If you estimate the maximum time of disconnection to be longer than the tombstone lifetime, you must determine whether to extend the tombstone lifetime or perform the procedure to remove lingering objects from the domain controller after it is reconnected. If you extend the tombstone lifetime, you must also make sure that all domain controllers have adequate disk space to store additional tombstones. In addition, make sure that replication of the tombstone lifetime change has reached all potential source domain controllers before you run Dcpromo to install an additional domain controller.  
  
-   **Ensure that strict replication consistency is enabled on all domain controllers.** Strict replication consistency is a registry setting that—when it is enabled—stops inbound replication of a directory partition from a source domain controller that is suspected of having a lingering object. Strict replication consistency should be enabled for the forest to prevent the reintroduction of a lingering object into the directory. You can use the **repadmin \/regkey** command to enable this setting on a specific domain controller or on all domain controllers in the forest, as described in [Enable Strict Replication Consistency](../Topic/Enable-Strict-Replication-Consistency.md).  
  
-   **Monitor the Knowledge Consistency Checker \(KCC\) topology and replication to ensure that unintended long disconnections are detected.** By monitoring replication, you can detect disconnections that occur as a result of network failures, service failures, or configuration errors. Use the Active Directory Management Pack or other monitoring application to implement a monitoring solution for your Active Directory deployment. Event IDs to monitor include 1311, 1388, 1925, 1988, 2042, 2087, and 2088.  
  
-   **Ship computers with properly configured IP, subnet mask, default gateway, and DNS server addresses.** Remember to reconfigure the server with TCP\/IP settings that are appropriate to the target site, not the staging site.  
  
-   **Prepare the registry for automatic nonauthoritative restore of SYSVOL when the domain controller restarts.** This recommendation applies only when you use FRS to replicate SYSVOL. For FRS replication of SYSVOL, the nonauthoritative restore prevents the domain controller from having to reconcile and process deletions and modifications that took place from the time of the last SYSVOL update to the time that the domain controller is restarted in the new site, which improves synchronization time. For information about preparing for nonauthoritative restore of SYSVOL, see Prepare a domain controller for nonauthoritative SYSVOL restart \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122831](http://go.microsoft.com/fwlink/?LinkId=122831)\). This additional configuration is not required for Distributed File System \(DFS\) Replication of SYSVOL because DFS Replication processes updates differently.  
  
-   **Ensure that the domain controller replicates successfully with all replication partners.** Immediately before you disconnect the domain controller, force replication with its partners. Check that replication has succeeded before you disconnect the domain controller.  
  
-   **Label the domain controller.** When you disconnect the domain controller, attach a label to the computer that identifies the date and time of disconnection, the destination, and the IP settings.  
  
-   **When you reconnect the domain controller, update SYSVOL as quickly as possible.** The domain controller does not serve as a domain controller until SYSVOL has been updated through replication. If the site has one or more other domain controllers in the same domain, start the domain controller anytime. If the site contains no other domain controller in the same domain, time the restart of the domain controller to coincide with the beginning of intersite replication.  
  
-   **To avoid time skew issues**, **ensure that the system clock is synchronized with the domain source on startup.** When you start the domain controller in the remote site, use the following command to ensure that the domain controller uses the domain hierarchy to synchronize time:  
  
     `w32tm /resync/ computer:<PDCEmulatorHostName>`  
  
## See Also  
 [Known Issues for Adding Domain Controllers in Remote Sites](../Topic/Known-Issues-for-Adding-Domain-Controllers-in-Remote-Sites.md)   
 [Preparing a Server Computer for Shipping and Installation from Media](../Topic/Preparing-a-Server-Computer-for-Shipping-and-Installation-from-Media.md)   
 [Preparing an Existing Domain Controller for Shipping and Long-Term Disconnection](../Topic/Preparing-an-Existing-Domain-Controller-for-Shipping-and-Long-Term-Disconnection.md)   
 [Reconnecting a Domain Controller After a Long-Term Disconnection](../Topic/Reconnecting-a-Domain-Controller-After-a-Long-Term-Disconnection.md)  
  
  