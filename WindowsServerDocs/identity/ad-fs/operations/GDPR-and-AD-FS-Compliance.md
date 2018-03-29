---

title: GDPR Compliance and AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 03/29/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---
# GDPR Compliance and AD FS

>Applies To: Windows Server 2016, Windows Server 2012 R2

In May 2018, a European privacy law, the [General Data Protection Regulation (GDPR)](https://ec.europa.eu/info/law/law-topic/data-protection_en), is due to take effect. The GDPR imposes new rules on companies, government agencies, non-profits, and other organizations that offer goods and services to people in the European Union (EU), or that collect and analyze data tied to EU residents. The GDPR applies no matter where you are located. 
Microsoft products and services are available today to help you meet the GDPR requirements. Read more about Microsoft Privacy policy at [Trust Center](https://www.microsoft.com/trustcenter).

## AD FS Event Logs
An AD FS server stores the following data that is in scope for GDPR compliance:


- Data about a person's login activity in the AD FS Admin Event log
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Custom Views -> Server Roles -> Active Directory Federation Services

![](media/gdpr-and-ad-fs-compliance/gdpr1.png)

- Data about a person's login activity in the Windows Security log
  This log only contains user login data if AD FS Auditing is enabled.
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Windows Logs -> Security
  
- Data about a person's login activity in the AD FS Tracing Debug log
   This log only contains user login data if the AD FS Tracing Debug log is Enabled.
  
    To find this log, open the Event Viewer on the AD FS server and navigate to Applications and Services Logs -> AD FS Tracing -> Debug
 

Each of the above logs retains information based on a configurable maximum log size.  To remove information about a person from the AD FS server, delete the contents of the above logs or, alternatively, search the logs for the person's Windows account name (UPN or SamAccountname) and delete the corresponding entries.  

If you are exporting event log data to a security information and event management (SIEM) or other log analysis system, be sure to delete information from that system as well.

## AD FS and Azure MFA
When using AD FS with the Azure MFA Server and/or Azure MFA (cloud based), the AD FS Azure MFA adapter collects and stores information for 90 days.  Guidance for GDPR compliance with Azure MFA can be found [here](https://docs.microsoft.com/azure/multi-factor-authentication/multi-factor-authentication-gdpr).

 