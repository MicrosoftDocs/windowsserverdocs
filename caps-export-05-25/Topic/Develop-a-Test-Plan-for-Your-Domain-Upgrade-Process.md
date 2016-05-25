---
title: Develop a Test Plan for Your Domain Upgrade Process
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6eaab0bd-03af-48d8-9c2a-4a86c5d1d35e
author: Femila
---
# Develop a Test Plan for Your Domain Upgrade Process
It is important to develop a plan for testing your domain upgrade procedures throughout the upgrade process. Before you begin, test your existing domain controllers to ensure that they are functioning properly. Continue to test your domain controllers throughout the process to verify that Active Directory Domain Services \(AD DS\) replication is consistent and successful.  
  
The following table lists the tools and log files to use in your test plan. For more information about installing tools to test domain controllers, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](http://go.microsoft.com/fwlink/?LinkId=177813) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=177813\).  
  
|Tool\/log file|Description|Location|  
|------------------|---------------|------------|  
|Repadmin.exe|Checks replication consistency and monitors both inbound and outbound replication partners. Displays replication status of inbound replication partners and directory partitions.|%systemroot%\\Windows\\System32 **Note:** This tool is added to the server as part of the AD DS installation.|  
|Dcdiag.exe|Diagnoses the state of domain controllers in a forest or enterprise, tests for successful Active Directory connectivity and functionality, and returns the results as passed or failed.|%systemroot%\\Windows\\System32 **Note:** This tool is added to the server as part of the AD DS installation.|  
|Nltest.exe|Queries and checks the status of trusts and can forcibly shut down domain controllers. Provides domain controller location capabilities.|%systemroot%\\Windows\\System32 **Note:** This tool is added to the server as part of the AD DS installation.|  
|Dnscmd.exe|Provides the properties of Domain Name System \(DNS\) servers, zones, and resource records.|%systemroot%\\Windows\\System32 **Note:** This tool is added to the server as part of the AD DS installation.|  
|Adprep.log|Provides a detailed progress report of the forest and domain preparation process.|%SystemRoot%\\Windows\\Debug\\ADPrep\\Logs|  
|Dcpromoui.log and Dcpromo.log|Provides a detailed progress report of the Active Directory installation. Includes information regarding replication and services in addition to applicable error messages.|%systemroot%\\Windows\\debug **Note:** These logs are added to the server as part of the AD DS installation.|  
|Adsiedit.exe|A Microsoft Management Console \(MMC\) snap\-in that acts as a low\-level editor for AD DS and allows you to view, add, delete, and move objects and attributes within the directory.|%systemroot%\\Windows\\System32 **Note:** This tool is added to the server as part of the AD DS installation.|  
  
For more information about support tools for Windows, see Help and Support for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
