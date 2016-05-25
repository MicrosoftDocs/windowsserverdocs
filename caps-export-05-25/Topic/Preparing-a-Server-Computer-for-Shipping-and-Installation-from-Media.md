---
title: Preparing a Server Computer for Shipping and Installation from Media
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fcaa54b4-7536-47cc-9232-4874b3a3314f
author: Femila
---
# Preparing a Server Computer for Shipping and Installation from Media
  The specific guidelines for installing Active Directory Domain Services \(AD DS\) from installation media are provided in the topic [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md). Be sure to read that topic before you perform the procedures that are specified in this section.  
  
 To prepare for an IFM installation, perform the following tasks:  
  
-   Determine the type of domain controller that you want to install. Identify a domain controller that is suitable for creating the media according to whether you are creating an additional domain controller that is a global catalog server, a Domain Name System \(DNS\) server, both, or neither. You must create the installation media on the same type of domain controller that you want to create.  
  
-   Determine whether to create the installation media in a shared folder on the computer that will be installed or use removable media to ship the installation media separately from the computer. If you will create the media in a shared folder on the installation server, do the following:  
  
    -   Determine the volume on which to create the media. See the criteria in “Determine the volume for installation media” in this topic.  
  
    -   Create a shared folder on the server and map a network drive to the folder on the domain controller that you are using to create the media.  
  
-   Install the operating system on the server computer. This task is best performed in the hub site where administrative personnel are available.  
  
-   Enable Remote Desktop on the server before you ship it.  
  
-   If you want to include application directory partitions on the domain controller, prepare an answer file that contains the location of the installation media and the application directory partitions.  
  
-   Determine the volume on which to store the installation media on the installation server. This location affects SYSVOL replication after the installation of AD DS.  
  
## Determining the volume for installation media  
 The volume on which you store the installation media has implications for SYSVOL files. If you plan to perform additional, preliminary procedures to ensure that the installation media is the source for SYSVOL on the installation server, the installation media must be stored on the same volume that you specify during Active Directory installation to host the SYSVOL tree. If you do not store the installation media on the volume where SYSVOL is to be hosted, SYSVOL is replicated to the new domain controller, regardless of whether you perform the additional, preliminary procedures.  
  
 Use the following references for information about ensuring that SYSVOL is not replicated during IFM:  
  
-   For information about how to ensure that the installation media is used as the source for SYSVOL when you are using FRS to replicate SYSVOL, see "Seeding the SYSVOL tree from restored files during IFM promotion" in article 311078 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=70809](http://go.microsoft.com/fwlink/?LinkID=70809)\).  
  
-   For information about how to ensure that the installation media is used as the source for SYSVOL when you are using Distributed File System \(DFS\) Replication to replicate SYSVOL, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 To assess the effect of SYSVOL replication, as opposed to additional configuration that is required to ensure that the installation media is used as the source for SYSVOL, test both processes in a lab environment that mirrors your production environment in terms of wide area network \(WAN\) speed and replication latency.  
  
> [!NOTE]  
>  We recommend that you deploy at least two domain controllers in each domain for the purposes of redundancy and failover.  
  
## Enabling Remote Desktop  
 You can use Remote Desktop to connect to the domain controller and manage it remotely. Remote Desktop is disabled by default in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. To install AD DS, you must have Domain Admins credentials in the domain into which you are adding the domain controller. This level of service administration may not be available in the remote site. In any case, you will probably want to be able to install and manage the domain controller from the hub site.  
  
## Including application directory partitions  
 If you want application directory partitions to be included in the installation, you must use an answer file to perform the IFM installation and include the **\/ApplicationPartitionsToReplicate** parameter in the answer file. When you perform an unattended installation, Dcpromo uses the answer file for installation instructions, including the location of installation media and application directory partitions.  
  
 **Task requirements**  
  
 The following tools are required to complete this task:  
  
-   Ntdsutil.exe  
  
-   System Control Panel  
  
-   Dcpromo.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Create Installation Media by Using Ntdsutil](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md). Before you perform this procedure, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
     Perform this procedure on a domain controller that is the type of domain controller that you want to create \(for example, a global catalog server or a DNS server\). Specify removable media or a shared folder on the installation server as the location for the installation media.  
  
2.  [Enable Remote Desktop](../Topic/Enable-Remote-Desktop.md) on the installation server.  
  
3.  Ship the installation server and any prepared removable media and answer file to the remote site. Ship these items separately and securely.  
  
 When the server is running in the remote site, install the domain controller as follows:  
  
1.  [Create a Remote Desktop Connection](../Topic/Create-a-Remote-Desktop-Connection.md) to the remote server.  
  
2.  [Install an Additional Domain Controller by Using Installation Media](../Topic/Install-an-Additional-Domain-Controller-by-Using-Installation-Media.md). When the domain controller restarts after installation, the Remote Desktop Connection is dropped. After the installed domain controller restarts, you must reconnect by using Remote Desktop Connection.  
  
## See Also  
 [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md)  
  
  