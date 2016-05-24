---
title: Chapter 3: Roles &amp; Delegation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 87756677-5c90-4bd5-927c-0437bf044a3e
author: cwatsonmsft
---
# Chapter 3: Roles &amp; Delegation
This chapter covers details on delegation of access to resources. Additionally, it includes guidance on effective delegation of administrative roles to ensure security.  
  
## Virtual Accounts  
Each virtual machine in Hyper\-V, is associated with a virtual machine worker process \(vmwp.exe\) running in the Hyper\-V host. In previous versions of Windows Server, these processes had VM specific and group Security Identifiers \(SID\) in their security context, but ran with Network Service as their primary account. In Windows Server 2012, Hyper\-V uses virtual accounts and runs each of the worker processes using their respective virtual machine specific SID as the primary account. As a result virtual machine worker processes no longer share the common Network Service account and better isolation is ensured. For additional information see the [Service Accounts Guide](http://technet.microsoft.com/library/dd548356.aspx).  
  
## Hyper\-V Manager  
Hyper\-V manager allows users designated as administrators \(members of the Administrators or Hyper\-V Administrators security group\) of the management operating system to manage the virtual machines on the host. Authorized users can use Hyper\-V Manager to perform a variety of management tasks on the host, including starting and stopping VMs, importing and deploying VMs, and managing snapshots. By default, anyone who is a local administrator of the management operating system can use Hyper\-V Manager on the host. In addition, a user can also use Hyper\-V Manager to remotely manage Hyper\-V on other servers in a domain to which the user has administrative access.  
  
## VMConnect Access Controls  
The Hyper\-V Virtual Machine Connection Tool \(VMConnect\) uses Windows Management Instrumentation \(WMI\) and the Remote Desktop Protocol to provide access to the desktop or console environment of running virtual machines.  
  
When the connection tool is connected to a VM, a user can interact with it using input devices \(keyboard, mouse\). A connection may be established either locally on the Hyper\-V server or remotely over a network from a client on which the tool is installed.  
  
A Hyper\-V administrator can grant a non\-administrative user access to any virtual machines interactive console without granting the user any additional privileges such as starting, stopping or even viewing the configuration of the virtual machine.  The Hyper\-V Virtual Machine Connection Tool \(VMConnect\) does not allow for this level of access. However, using publically documented APIs an application can be created to leverage this functionality.  When an administrator grants a user role VMConnect privileges, those privileges persist after revocation of the administrators Hyper\-V permissions. VMConnect privileges must be explicitly removed.  
  
## Virtual Machine Generation ID  
Virtual machine generation ID was introduced with Windows Server 2012.  
  
The virtual machine generation ID is a cryptographically random integer value identifier that will be different every time the virtual machine executes from a different configuration file—such as executing from a recovered snapshot, or executing after restoring from backup.  It is exposed via the virtual machines BIOS as a 128\-bit integer. It provides a means for Cryptographic software and Vector\-clock synchronization software to protect against potential negative effects of virtual machines returning to an earlier point in time \(such as applying a checkpoint\).  
  
For additional information on virtual machine generation ID please refer to [Virtual Machine Generation ID](http://www.microsoft.com/download/details.aspx?id=30707).  
  
## BitLocker Drive Encryption  
Windows BitLocker Drive Encryption is a data protection feature included with Windows.  
  
BitLocker can protect virtual machine configurations and their virtual hard disks. Any configuration and virtual hard disk files that are created and stored on a BitLocker encrypted physical disk volume receive BitLocker protection.  
  
BitLocker Drive Encryption is supported in the Hyper\-V management operating system only. BitLocker Drive Encryption is not supported within a virtual machine.  
  
For additional details on using BitLocker see the [BitLocker Overview](../Topic/BitLocker-Overview.md).  
  
Hyper\-V does not support storing any configuration or virtual hard disk on Encrypting File System \(EFS\) volumes.  
  
## Securing Hyper\-V and Virtual Machine Related Files  
Files that contain configuration information about Hyper\-V as well as each virtual machine are stored in the %programdata%\\Microsoft\\Windows\\Hyper\-V\\ directory by default.  
  
If a different storage location is specified, it is recommended to ensure that both the System account and the Administrators group have Full Control permissions for the new folder, and that access by other accounts is strictly limited as appropriate.  
  
By default, new virtual hard disk files are stored in the %users%\\Public\\Documents\\Hyper\-V\\Virtual Hard Disks directory. The default storage location for virtual hard disks can be changed in the Hyper\-V manager or with PowerShell. If a different storage location is specified, it is recommended that the following permissions are assigned:  
  
### Table 1.1. Recommended permission Settings for virtual hard disk Folder  
  
|Names|Permissions|Apply to|  
|---------|---------------|------------|  
|Administrators<br /><br />System|Full Control|This folder, subfolders, and files|  
|Creator Owner|Full Control|Subfolders and files only|  
  
Additionally, if the storage location is a SMB share, then additional privileges are needed Administrators & Hyper\-V Administrators needing to create and manage VHDS, Machine accounts for all Hyper\-V nodes that may need to run the VM. For additional details, see [Storing Windows Server 2008 Hyper\-V files on a CIFS\/SMB file share](http://blogs.technet.com/b/josebda/archive/2008/06/24/storing-windows-server-2008-hyper-v-files-on-an-cifs-smb-file-share.aspx).  
  
The registry is secure by default and requires administrative privileges for modifications.  
  
## Using File System Security to Protect Virtual Machine Resources  
Access control lists \(ACLs\) can be used to protect virtual hard disk files and virtual machine configuration files from unauthorized file system\-level access. This approach can prevent scenarios such as an unauthorized person copying a virtual hard disk from a Hyper\-V host or library server to another location, or replacing an existing virtual machine file with an altered version. However, using ACLs to restrict access to files or folders is not an effective way to manage administrative access to VMs themselves.  
  
For a user to attach a virtual hard disk, ISO image or a virtual floppy disk to a virtual machine, the user must have permissions on the respective file.  
  
## Tracking Access to Virtual Machine Resources  
It is recommended that administrators enable object access auditing on all files associated with a virtual machine for every user or group that has access to the files through the file system. This approach will ensure that every attempt by a user to open, copy, modify, or delete an audited file will be recorded, which can be useful in a number of scenarios.  
  
For example, if a malicious administrator makes an unauthorized copy of a sensitive virtual hard disk file, the audit log can be used to trace the action back to the person responsible. For additional security, a monitoring product like Microsoft System Center Operations Manager can be configured to issue alerts when access attempts are made under certain circumstances, which could help prevent security breaches.  
  
[http:\/\/technet.microsoft.com\/library\/cc962004.aspx](http://technet.microsoft.com/library/cc962004.aspx) on SACLs  
  
[http:\/\/technet.microsoft.com\/library\/cc776774.aspx](http://technet.microsoft.com/library/cc776774.aspx) on reading event logs  
  
## See also:  
[Chapter 1: Overview](../Topic/Chapter-1--Overview.md)  
  
[Chapter 2: Hardening the Hyper\-V host](../Topic/Chapter-2--Hardening-the-Hyper-V-host.md)  
  
[Chapter 4: Protecting Virtual Machines](../Topic/Chapter-4--Protecting-Virtual-Machines.md)  
  
[Chapter 5: Best Practices Checklist](../Topic/Chapter-5--Best-Practices-Checklist.md)  
  
