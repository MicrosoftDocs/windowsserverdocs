---
ms.assetid: 208928eb-bb17-4984-a312-23fff43133e3
title: Auditing Enhancements to AD FS in Windows Server 2016
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 10/25/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# Auditing Enhancements to AD FS in Windows Server 2016


Currently, in AD FS for Windows Server 2012 R2 there are numerous audit events generated for a single request and the relevant information about a log-in or token issuance activity is either absent (in some versions of AD FS) or spread across multiple audit events. By default the AD FS audit events are turned off due to their verbose nature.  
    With the release of AD FS in Windows Server 2016, auditing has become more streamlined and less verbose.  
  
## Auditing levels in AD FS for Windows Server 2016  
By default, AD FS in Windows Server 2016 has basic auditing enabled.  With basic auditing, administrators will see 5 or less events for a single request.  This marks a significant decrease in the number of events administrators have to look at, in order to see a single request.   The auditing level can be raised or lowered using the PowerShell cmdlt:  Set-AdfsProperties -AuditLevel.  The table below explains the available auditing levels.  
  
||||  
|-|-|-|  
|Audit Level|PowerShell syntax|Description|  
|None|Set-AdfsProperties - AuditLevel None|Auditing is disabled and no events will be logged.|  
|Basic (Default)|Set-AdfsProperties - AuditLevel Basic|No more than 5 events will be logged for a single request|  
|Verbose|Set-AdfsProperties - AuditLevel Verbose|All events will be logged.  This will log a significant amount of information per request.|  
  
To view the current auditing level, you can use the PowerShell cmdlt:  Get-AdfsProperties.  
  
![audit enhancements](media/Auditing-Enhancements-to-AD-FS-in-Windows-Server-2016/ADFS_Audit_1.PNG)  
  
The auditing level can be raised or lowered using the PowerShell cmdlt:  Set-AdfsProperties -AuditLevel.  
  
![audit enhancements](media/Auditing-Enhancements-to-AD-FS-in-Windows-Server-2016/ADFS_Audit_2.png)  
  
## Types of Audit Events  
AD FS Audit Events can be of different types, based on the different types of requests processed by AD FS. Each type of Audit Event has specific data associated with it.  The type of audit events can be differentiated between login requests (i.e. token requests) versus system requests (server-server calls including fetching configuration information).    
  The table below describes the basic types of audit events.  
  
||||  
|-|-|-|  
|Audit Event Type|Event ID|Description|  
|Fresh Credential Validation Success|1202|A request where fresh credentials are validated successfully by the Federation Service. This includes WS-Trust, WS-Federation, SAML-P (first leg to generate SSO) and OAuth Authorize Endpoints.|  
|Fresh Credential Validation Error|1203|A request where fresh credential validation failed on the Federation Service. This includes WS-Trust, WS-Fed, SAML-P (first leg to generate SSO) and OAuth Authorize Endpoints.|  
|Application Token Success|1200|A request where a security token is issued successfully by the Federation Service. For WS-Federation, SAML-P this is logged when the request is processed with the SSO artifact. (such as the SSO cookie).|  
|Application Token Failure|1201|A request where  security token issuance failed on the Federation Service. For WS-Federation, SAML-P this is logged when the request was processed with the SSO artifact. (such as the SSO cookie).|  
|Password Change Request Success|1204|A transaction where the password change request was successfully processed by the Federation Service.|  
|Password Change Request Error|1205|A transaction where the password change request failed to be processed by the Federation Service.| 
|Sign Out Success|1206|Describes a successful sign-out request.|  
|Sign Out Failure|1207|Describes a failed sign-out request.|  

  


