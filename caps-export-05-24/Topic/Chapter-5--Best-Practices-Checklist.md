---
title: Chapter 5: Best Practices Checklist
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4c404345-b849-4ad2-b138-c68186159c4d
author: cwatsonmsft
---
# Chapter 5: Best Practices Checklist
Securing Hyper\-V involves all the measures that are required to safeguard any Windows Server 2012 server role, plus a few extra to help secure the VMs, configuration files, and data. The following list of recommended best practices serves as a checklist to help you enhance the security of your Hyper\-V environment.  
  
## Host Configuration  
Microsoft recommends paying close attention to the following best practices for securing Hyper\-V when configuring the management operating system:  
  
-   Use a Server Core installation for the management operating system.  
  
-   Keep the management operating system up to date with the latest security updates  
  
-   Use a separate network with a dedicated network adapter for the management operating system of the physical Hyper\-V computer.  
  
-   Secure the storage devices where you keep virtual machine resource files.  
  
-   Harden the management operating system using the baseline security setting recommendations described in the [Windows Server 2012 Security Baseline](http://technet.microsoft.com/library/jj898542.aspx).  
  
-   Do not install or use of anti\-malware in the management operating system. If anti\-malware is used in the management operating system, proper exclusion settings need to be set.  
  
-   Do not grant virtual machine administrators permissions on the management operating system.  
  
-   Use BitLocker Drive Encryption to protect resources.  
  
-   Use a private or secure network to access VM configurations and virtual hard disk files.  
  
-   Use a private\/dedicated network for your live migration traffic. Consider enabling IPSec on this network to use encryption and secure your VM’s data going over the network during migration  
  
-   For environments running the RemoteFX Virtual GPU, it is recommended to download and install the latest drivers for all physical video cards that are present.  
  
## Virtual Machine Configuration  
The following recommended best practices can help you enhance security when configuring virtual machines on servers running the Hyper\-V role:  
  
-   Store virtual hard disks and snapshot files in a secure location.  
  
-   Ensure that virtual network adapters connect to the correct virtual switch and have the appropriate security setting and limits applied.  
  
-   Configure only required storage devices for a virtual machine.  
  
-   Harden the operating system running in each virtual machine according to the server role it performs using the baseline security setting recommendations described in the [Windows Server 2012 Security Baseline](http://technet.microsoft.com/library/jj898542.aspx).  
  
-   Configure antivirus, firewall, and intrusion detection software within virtual machines as appropriate based on server role.  
  
-   Ensure that virtual machines have all the latest security updates before they are turned on in a production environment.  
  
-   Ensure that your virtual machines have integration services installed and up to date.  
  
## See also:  
[Chapter 1: Overview](../Topic/Chapter-1--Overview.md)  
  
[Chapter 2: Hardening the Hyper\-V host](../Topic/Chapter-2--Hardening-the-Hyper-V-host.md)  
  
[Chapter 3: Roles & Delegation](../Topic/Chapter-3--Roles---Delegation.md)  
  
[Chapter 4: Protecting Virtual Machines](../Topic/Chapter-4--Protecting-Virtual-Machines.md)  
  
