---
title: Chapter 4: Protecting Virtual Machines
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f651fbe6-7047-464f-82b0-206fb778c175
author: cwatsonmsft
---
# Chapter 4: Protecting Virtual Machines
This chapter provides guidance for protecting the files that are used to create and run virtual machines \(VMs\), such as virtual hard disk \(VHDX\) files and configuration files. The chapter also includes best practice information and resources designed to help you safeguard the operating systems running within a VM against common threats.  
  
As files on disk, VM resources can be secured using many of the same techniques that are commonly used to store other files in Windows Server environments, including file system security, encryption, and object access auditing.  
  
To secure supported guest operating systems, see the appropriate documentation from the operating system vendors. The list of supported guest operating systems listed in the  [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143#BKMK_SOFT).  
  
## Conservative approach to Permissions  
It is recommended that administrators follow a conservative approach for VM settings and provide each virtual machine access to the physical hard disks, virtual hard disks, and removable storage devices that it needs, and no others.  
  
For example, if a virtual machine does not require access to a resource like a CD\/DVD drive except when software is being installed remove the virtual drive or select **None** as the media when it is not in use.  
  
## Time Synchronization  
Time synchronization can be important in some auditing scenarios, because the system time of virtual machines can drift out of sync with the management operating system for virtual machines that are under constant heavy load. For time synchronization to work, the appropriate Hyper\-V Integration Services will need to be installed on the virtual machines. The details of the installation are covered in [Install or upgrade integration services](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d#BKMK_step4). For virtual machines that are configured as domain controllers, disabling time synchronization is recommended to ensure that domain controllers use the default Windows Time service \(W32time\) domain hierarchy time synchronization.  
  
## Decommissioning high\-security virtual hard disks  
For high\-security VMs that contain sensitive information, establish a process for securely deleting the virtual hard disk files after decommissioning. Tools such as [SDelete](http://technet.microsoft.com/sysinternals/bb897443.aspx), can help with this process. When dedup is used, high\-security virtual hard disk files should be placed in a folder that is marked for exclusion from dedup. Running BitLocker on the virtual hard disk files containing sensitive information from the host operating system can also prevent offline information disclosure attacks on high\-security virtual hard disks.  
  
## OS updates  
For security \(and other\) considerations, it is recommended that the Operating System running inside the guest VM is up to date with the latest patches installed.  
  
## Integration Component updates  
It is recommended that the integration components in the guest VM’s operating system are up to date.  
  
## Firewall and Antivirus Requirements  
It is recommended that Firewalls, antivirus software, and intrusion detection software as appropriate for the environment be installed on the virtual machine of interest’s operating system.  
  
## Group Policy Considerations  
Like physical servers, virtual machines should be added to the appropriate organizational units \(OUs\) so that Group Policy settings apply correctly.  
  
## Shared Resources  
When storage and networking resources are shared across more than one VM’s, it is important to consider isolating critical VMs to different virtual networks or storage locations to avoid the possibility of network\/storage starvation.  
  
## See also:  
[Chapter 1: Overview](../Topic/Chapter-1--Overview.md)  
  
[Chapter 2: Hardening the Hyper\-V host](../Topic/Chapter-2--Hardening-the-Hyper-V-host.md)  
  
[Chapter 3: Roles & Delegation](../Topic/Chapter-3--Roles---Delegation.md)  
  
[Chapter 5: Best Practices Checklist](../Topic/Chapter-5--Best-Practices-Checklist.md)  
  
