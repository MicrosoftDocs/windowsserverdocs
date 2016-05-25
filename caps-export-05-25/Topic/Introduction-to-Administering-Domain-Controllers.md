---
title: Introduction to Administering Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 99e7f9ac-304f-42ec-9eb8-b6c77d209150
author: Femila
---
# Introduction to Administering Domain Controllers
  Although installed domain controllers require little management, your overall operations environment might require change\-related tasks, such as adding or removing domain controllers, including managing the preparation and shipment of domain controllers to remote sites. During your day\-to\-day operations, you might need to do some or all of the following:  
  
-   Install tools that you can use to administer Active Directory Domain Services \(AD DS\) remotely  
  
-   Install and remove AD DS to create or decommission domain controllers  
  
-   Rename domain controllers  
  
-   Add domain controllers to remote \(branch\) sites  
  
## Installing Remote Server Administration Tools  
 To manage domain controllers, you can configure a member server that is running Windows Server 2008 or a workstation that is running Windows Vista with Service Pack 1 \(SP1\) with the same administration tools for managing AD DS that are available on a domain controller. Administering domain controllers remotely from a member server or a workstation is more secure and more efficient than logging on to a domain controller locally. You can use Server Manager to install the Remote Server Administration Tools feature to include Active Directory Domain Services Tools.  
  
## Installing and removing AD DS  
 To create a new domain controller, you install AD DS on a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Installing domain controllers to create a forest and new domains is a deployment task that you perform when you initially deploy your forest, and it is beyond the scope of this guide. However, as your forest grows, you might need to add more domain controllers to existing domains.  
  
### Adding domain controllers  
 You might want to add a new domain controller for the following reasons:  
  
-   Additional applications that use AD DS \(Active Directory–integrated applications\) might require increased capacity.  
  
-   Additional domain controllers might be needed to provide upgrades and fault tolerance and to reduce failures.  
  
-   You might add a new site where users require a domain controller for logging on to the domain.  
  
 Many improvements to the installation process are available in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. For information about new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] features and options, see What's New in AD DS Installation and Removal  
\([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=103330](http://go.microsoft.com/fwlink/?LinkId=103330)\). For information about the criteria and best practices for deploying domain controllers, see Planning Domain Controller Placement \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120383](http://go.microsoft.com/fwlink/?LinkId=120383)\).  
  
### Removing domain controllers  
 When you no longer need a server to be a domain controller, you remove AD DS from the server. The process of removing AD DS is similar to the process for installing AD DS. You run many of the same tests before you remove AD DS that you run before you install AD DS. These tests ensure that the removal process occurs without any problems. If a domain controller has a hardware failure, AD DS cannot be started, and you plan to never return that domain controller to service, you must use a procedure that forces the removal of AD DS and then take additional steps to remove the server object and its metadata from the directory.  
  
## Renaming domain controllers  
 You often have to rename a domain controller for organizational or administrative reasons or when the computer hardware must be replaced. Renaming a domain controller requires that Domain Name System \(DNS\) resource records be updated with the new IP\-to\-host name mappings and that service principal names \(SPNs\) replicate to all domain controllers in the domain.  
  
## Adding domain controllers to branch sites  
 If enough directory users are employed in a branch office, especially in a site that has slow connectivity to the hub site, you might have to add a domain controller to the site to provide directory access for logons and searches.  
  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you have the option to deploy read\-only domain controllers \(RODCs\). An RODC is an additional domain controller that hosts read\-only directory partitions of the Active Directory database. An RODC is primarily designed to be deployed in a branch office environment. Branch offices typically have relatively few users, poor physical security, relatively poor network bandwidth to a hub site, and little local information technology \(IT\) expertise. RODCs receive replication updates from the hub site, but they do not accept manual updates to AD DS and they do not replicate directory updates to other domain controllers. Therefore, although security precautions should be maintained, the stringent security measures that apply to protecting a writable domain controller are lessened. In addition, elevated administrative credentials are not required to install and manage the RODC. The information in this guide is specific to managing writable domain controllers. For information about managing RODCs, see Planning and Deploying Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 When you are creating a new branch site, a local domain controller is not available to be the source for Active Directory replication. If the wide area network \(WAN\) connection with the closest hub site is slow or unreliable, replicating AD DS can be time consuming and might fail if the connection is lost. When you deploy the first domain controller in a branch site, if you want to avoid replicating AD DS, you have the following options:  
  
-   Install the domain controller in the hub site, and then ship the installed domain controller to the site.  
  
-   Ship the server computer to the branch site, and then install AD DS in the branch site.  
  
     When you install the domain controller in the branch site, the server can receive AD DS in one of two ways:  
  
    -   By Active Directory replication over a WAN link  
  
    -   Directly from locally available installation media  
  
### Installing from media  
 Installation from media \(IFM\) eliminates the use of replication to create the Active Directory domain, configuration, and schema directory partition replicas on the new domain controller. Assuming that the remote site is connected to a hub site by a WAN link and that the remote site does not contain a domain controller for the domain, you might want to avoid the additional time and the performance impact of replicating the full contents of AD DS over the WAN link when you add the new domain controller to the remote site. In this case, you can use IFM to install AD DS.  
  
 On a domain controller that is running Windows Server 2003, installation media must be created by backing up system state and restoring the backup file to a location either on the server you are installing or on removable media. The IFM process is improved in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], eliminating the necessity of using the backup and restore process to create the installation media. On a domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can use the Ntdsutil command\-line tool to create the installation media. Then, you can use the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\) to install AD DS from the installation media.  
  
 If you want to use Ntdsutil to create the installation media to install a domain controller, both the source of the media and the target server that is to be promoted to a domain controller must be running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. In addition, the operating system of the source of the backup and the target server must be the same. For example, you cannot install AD DS on a server that is running Windows Server 2003 using installation media that is created on a domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. An improvement in the requirements for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers over the requirements for Windows Server 2003 domain controllers is that the hardware platform \(32\-bit or 64\-bit\) of the two computers does not have to match.  
  
 Although information in this guide is specific to installing writable domain controllers in branch office sites, in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forests, RODCs are the recommended domain controller installation for branch office sites. For information about using IFM to install RODCs, see Planning and Deploying Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
### Shipping installed domain controllers to branch sites  
 Shipping an existing domain controller requires removing it from the replication topology for what may be an extended period. Preparation is required to ensure a smooth transition when the domain controller restarts in the branch site. For example, you must be sure that the domain controller does not hold any operations master \(also known as flexible single master operations or FSMO\) roles and that replication is updated immediately before you disconnect the domain controller.  
  
  