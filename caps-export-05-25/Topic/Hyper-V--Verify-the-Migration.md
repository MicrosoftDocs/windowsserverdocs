---
title: Hyper-V: Verify the Migration
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99e7b983-2ed4-42b1-a597-ce85438976a4
author: cwatsonmsft
---
# Hyper-V: Verify the Migration
After you have completed the migration, perform the following verification steps to ensure that the migration succeeded.  
  
### Verify the Hyper\-V security policy  
Use the Hyper\-V security policy information \(that you gathered when you prepared for migration\) to verify that the roles and scopes are the same on the destination server as the corresponding roles and scopes on the source server.  
  
### Verify the networking configuration  
Use the information you gathered about the virtual and physical networks to verify the following:  
  
-   The virtual networks are the same on the destination server as they were on the source server.  
  
-   If you migrated IP settings for the physical network adapters, such as static IP addresses, they are applied to the corresponding network adapter on the destination server.  
  
### Verify the configuration and availability of the virtual machines  
Perform the following steps to determine whether the migrated virtual machines will operate as expected.  
  
##### To verify the virtual machines  
  
1.  Use the virtual machine information you gathered when you prepared for migration to verify the following:  
  
    1.  Check to see that the set of virtual machines on the destination server has all the virtual machines that were on the source server.  
  
    2.  For each virtual machine, verify that the state of the virtual machine on the destination server is the same as it was on the source server before the migration.  
  
    3.  For each virtual machine, verify that the snapshots it has are identical in number and structure to the snapshots of the corresponding virtual machine on the source server.  
  
    4.  Verify that the memory and number of virtual processors are the same as they were on the source server.  
  
    5.  Verify that the storage configuration \(virtual hard disks and\/or physical disks attached directly to the virtual machine\) is identical to that on the source server.  
  
2.  Start each migrated virtual machine. If a virtual machine does not start, check the event log under Applications and Service Logs\\Microsoft\\Windows\\Hyper\-V virtual machineMS\\Admin to see why it failed to start. Common reasons for failure include:  
  
    -   The virtual machine is not in the correct scope in the authorization policy.  
  
    -   The storage is misconfigured. For example, one or more virtual hard disks might not be in the specified location. Check the hard disk settings for the virtual machine to make sure that the path to the .vhd file is valid. If the virtual machine is configured to use a directly attached physical disk, make sure it is attached to the destination server and shows as offline in Disk Management on the server.  
  
    -   One or more virtual hard disks do not have the required security permissions in the file system where the .vhd files are stored.  
  
3.  Run some basic operations that change the state of each virtual machine to verify that the operations work as expected on the migrated virtual machine. For example, saving and restoring, pausing and resuming, starting and stopping, or taking and applying or deleting snapshots.  
  
4.  Delete any of the snapshots you have taken as part of the previous step, turn off the virtual machine to merge the snapshot disks, and then turn on the virtual machine.  
  
5.  After the virtual machine has booted into the operating system, run the necessary application\-specific tests to ensure that the application on the virtual machine can provide the same service levels as it provided before the virtual machine was migrated.  
  
6.  Verify that you can access the desktop of each virtual machine using Remote Desktop or Virtual Machine Connection, if you had access to the desktop on the source server.  
  
7.  If the virtual machine passes all of the above tests, it is ready to be put into production.  
  
