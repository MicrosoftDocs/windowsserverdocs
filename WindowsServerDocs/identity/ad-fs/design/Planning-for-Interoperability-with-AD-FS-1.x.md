---
ms.assetid: 04b63d9f-e924-4146-9b1d-785ed8b4239c
title: Planning for Interoperability with AD FS 1.x
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Planning for Interoperability with AD FS 1.x

Active Directory Federation Services \(AD FS\) federation servers running Windows Server® 2012 can interoperate with both an AD FS 1.0 \(installed with Windows Server 2003 R2\) Federation Service and an AD FS 1.1 \(installed with Windows Server 2008 or Windows Server 2008 R2\) Federation Service. Any of the following interoperability combinations are supported:  

-   Any AD FS 1.*x* Federation Service can send a claim that can be consumed by an AD FS Federation Service in  Windows Server 2012 . For more information, see [Checklist: Configuring AD FS  to Consume Claims from AD FS 1.x](../../ad-fs/deployment/Checklist--Configuring-AD-FS--to-Consume-Claims-from-AD-FS-1.x.md).  

-   Any AD FS Federation Service in  Windows Server 2012  can send an AD FS 1.*x*\-compatible claim that can be consumed by an AD FS 1.*x* Federation Service. For more information, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service](../../ad-fs/deployment/Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Federation-Service.md).  

-   Any AD FS Federation Service in  Windows Server 2012  can send an AD FS 1.*x*\-compatible claim that can be consumed by one or more Web servers running the AD FS 1.*x* claims\-aware Web agent. For more information, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent](../../ad-fs/deployment/Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Claims-Aware-Web-Agent.md).  

> [!NOTE]  
> AD FS does not support or interoperate with the AD FS 1.*x* Windows NT token–based Web agent.  

An AD FS 1.*x*\-compatible claim is a claim that can be sent by an AD FS Federation Service in  Windows Server 2012  and understood by an AD FS 1.*x* Federation Service. So that an AD FS 1.*x* Federation Service can consume the claims that an AD FS Federation Service sends, a Name Identifier \(ID\) claim type must be sent.  

## Understanding the Name ID claim type  
The Name ID claim type is the equivalent of the identity claim type that AD FS 1.*x* uses. It must be used whenever you want to interoperate with AD FS 1.*x*. The Name ID claim type enables either an AD FS 1.*x* Federation Service or the AD FS 1.*x* claims\-aware Web agent to consume claims that AD FS in  Windows Server 2012  sends, as long as these claims are sent in one of the Name ID formats in the following table.  


|      Name ID format       |               Corresponding URI                |
|---------------------------|------------------------------------------------|
| AD FS 1.*x* Email Address | http://schemas.xmlsoap.org/claims/EmailAddress |
|   AD FS 1.*x* Email UPN   |     http://schemas.xmlsoap.org/claims/UPN      |
|        Common Name        |  http://schemas.xmlsoap.org/claims/CommonName  |
|           Group           |    http://schemas.xmlsoap.org/claims/Group     |

Only one Name ID claim in the appropriate format must be sent. When that criterion is satisfied, many other claims may be sent as well, assuming that they conform to the restrictions described in the table.  

> [!NOTE]  
> An AD FS 1.*x* Federation Service can interpret only incoming claim types that begin with the Uniform Resource Identifier \(URI\) of http://schemas.xmlsoap.org/claims/.  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
