---

title: User Privacy and AD FS
description:
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 04/24/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---
# User privacy and AD FS

>Applies To: Windows Server 2016, Windows Server 2012 R2

Personal data is any information relating to an identified or identifiable person.  There is no distinction between a person's private, public, or work roles.  Microsoft products and services are available today to help you meet the privacy requirements. Read more about Microsoft Privacy policy at [Trust Center](https://www.microsoft.com/trustcenter).

## AD FS Event Logs
An AD FS server stores the following data that contains user privacy information:


- Data about a person's login activity in the AD FS Admin Event log
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Custom Views -> Server Roles -> Active Directory Federation Services

![](media/gdpr-and-ad-fs-compliance/gdpr1.png)

- Data about a person's login activity in the Windows Security log
  This log only contains user login data if AD FS Auditing is enabled.
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Windows Logs -> Security
  
- Data about a person's login activity in the AD FS Tracing Debug log
   This log only contains user login data if the AD FS Tracing Debug log is Enabled.
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Applications and Services Logs -> AD FS Tracing -> Debug
 

Each of the above logs retains information based on a configurable maximum log size.  To remove information about a person from the AD FS server, delete the contents of the above logs.

If you are exporting event log data to a security information and event management (SIEM) or other log analysis system, be sure to delete information from that system as well.



 