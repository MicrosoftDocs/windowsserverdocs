---
title: Managing Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 67fc581b-e712-4916-bc11-e6489eab4960
author: Femila
---
# Managing Domain Controllers
  The tasks that are described in this objective apply to the installation and management of Active Directory Domain Services \(AD DS\) on writable domain controllers. For information about installing and managing read\-only domain controllers \(RODCs\), see the Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\) and Planning and Deploying Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 The tasks that are described in this objective will help you do the following:  
  
-   Install Remote Server Administration Tools \(RSAT\) on a member server that is running Windows Server 2008 or on a client computer that is running Windows Vista with Service Pack 1 \(SP1\). RSAT include a selection for Active Directory Domain Services Tools. You can install these tools on a non\-domain\-controller computer in the domain and then use this computer to manage domain controllers remotely.  
  
-   Manage antivirus software. Antivirus software provides important safeguards. However, installation on a domain controller requires care to ensure that domain controller performance is not affected.  
  
-   Prepare for Active Directory installation. Proper preparation decreases the chances of problems occurring during and after the installation.  
  
-   Install an additional domain controller in an existing domain. This task involves preparation steps of gathering information and configuring the TCP\/IP and Domain Name System \(DNS\) client settings. You can use the following methods to install Active Directory Domain Services \(AD DS\) on a server to create an additional domain controller in an existing domain:  
  
    -   Run the Active Directory Domain Services Installation Wizard, and use Active Directory replication to create the Active Directory replica and either the File Replication Service \(FRS\) or Distributed File System \(DFS\) Replication to create the SYSVOL replicas.  
  
    -   Run the Active Directory Domain Services Installation Wizard, and use installation from media \(IFM\) to create the Active Directory replica.  
  
        > [!NOTE]  
        >  By default, SYSVOL is created on the new domain controller by replication from a source domain controller. It does not come from the installation media. Obtaining SYSVOL from installation media requires additional procedures. For information about the process for configuring the server to obtain SYSVOL from installation media, see article 311078 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=70809](http://go.microsoft.com/fwlink/?LinkId=70809)\).  
  
    -   Run the Active Directory Domain Services Installation Wizard, and use an answer file to provide the information that the Active Directory Domain Services Installation Wizard requires. You can create an answer file by using the Export feature in the Active Directory Domain Services Installation Wizard during domain controller installation.  
  
-   Verify installation. Perform tests to verify that AD DS is properly installed and the domain controller is functioning.  
  
-   Add domain controllers to remote sites. When you prepare and ship an additional domain controller to a remote site, you can either install the domain controller before shipping or install the domain controller in the remote site. This process is different if you are installing an RODC. For information about installing RODCs in remote sites, see the Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\).  
  
    -   When you install a domain controller in a hub site or staging site before shipment, you must disconnect the domain controller for a period, which requires careful preparation. When you reconnect the domain controller, Active Directory replication brings the domain controller up to date.  
  
    -   When you install the domain controller in the remote site, you can use installation media that is prepared from an existing domain controller to avoid having to replicate AD DS over a wide area network \(WAN\) link.  
  
-   Rename a domain controller. You may have to rename a domain controller for organizational or administrative reasons.  
  
-   Remove AD DS from \(decommission\) a properly functioning domain controller. This task includes first transferring operations master roles \(also known as flexible single\-master operation \(FSMO\) roles\) and the global catalog, if necessary.  
  
-   Force the removal of a nonfunctioning domain controller from a domain. If a domain controller is not functioning properly on the network, the Active Directory Domain Services Installation Wizard cannot contact other domain controllers and DNS servers that are required for Active Directory removal. In this case, you can invoke a special version of the wizard to forcefully remove objects from AD DS that represent the server as a domain controller.  
  
 This section includes the following tasks for managing domain controllers:  
  
-   [Installing Remote Server Administration Tools for AD DS](../Topic/Installing-Remote-Server-Administration-Tools-for-AD-DS.md)  
  
-   [Managing Antivirus Software on Active Directory Domain Controllers](../Topic/Managing-Antivirus-Software-on-Active-Directory-Domain-Controllers.md)  
  
-   [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md)  
  
-   [Installing a Domain Controller in an Existing Domain](../Topic/Installing-a-Domain-Controller-in-an-Existing-Domain.md)  
  
-   [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md)  
  
-   [Adding Domain Controllers in Remote Sites](../Topic/Adding-Domain-Controllers-in-Remote-Sites.md)  
  
-   [Renaming a Domain Controller](../Topic/Renaming-a-Domain-Controller.md)  
  
-   [Decommissioning a Domain Controller](../Topic/Decommissioning-a-Domain-Controller.md)  
  
-   [Forcing the Removal of a Domain Controller_1](../Topic/Forcing-the-Removal-of-a-Domain-Controller_1.md)  
  
  