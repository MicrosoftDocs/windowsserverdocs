---
description: "Learn more about: Interoperating with AD FS 1.x"
ms.assetid: 97999892-29c6-4076-be19-5e5259d8ada6
title: Interoperating with AD FS 1.x
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.author: billmath
---
# Interoperating with AD FS 1.x

For interoperability between Active Directory Federation Services \(AD FS\) in Windows Server&reg; 2012 and AD FS 1.*x*, complete one or more of the following tasks, depending on the needs of your organization:

-   Plan for interoperability between AD FS in  Windows Server 2012  and previous versions of AD FS, and learn more about the Name ID claim type. For more information, see [Planning for Interoperability with AD FS 1.x](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff678040(v=ws.11)).

-   If you will be sending claims from an AD FS Federation Service in  Windows Server 2012  that can be consumed by an AD FS 1.*x* Federation Service, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service](Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Federation-Service.md).

-   If you will be sending claims from an AD FS Federation Service in  Windows Server 2012  that can be consumed by an application that is hosted by a Web server running the AD FS 1.*x* claims\-aware Web agent, see [Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent](Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Claims-Aware-Web-Agent.md).

-   If you will be sending claims from an AD FS 1.*x* Federation Service to be consumed by an AD FS Federation Service in  Windows Server 2012 , see [Checklist: Configuring AD FS  to Consume Claims from AD FS 1.x](Checklist--Configuring-AD-FS--to-Consume-Claims-from-AD-FS-1.x.md).

## Differences between Federation Service settings
Although most of the AD FS 1.*x* Federation Service settings work in a similar manner as the AD FS Federation Service in  Windows Server 2012  settings, some setting names have changed. The following table lists the names of settings for an AD FS 1.*x* Federation Service and their equivalent names for an AD FS Federation Service in  Windows Server 2012 .

|AD FS 1.x Federation Service setting|Equivalent AD FS Federation Service in  Windows Server 2012  setting
|----------------------------------------|----------------------------------------------------------------------------------------------------------
|Account Partner|Claims provider trust
|Resource Partner|Relying party trust
|Application|Relying party trust
|Application Properties|Relying party trust properties
|Application URL|Relying party identifier and WS\-Federation Passive Endpoint URL
|Federation Service URI|Federation Service identifier
|Federation Service endpoint URL|WS\-Federation Passive Endpoint URL

## See Also
[AD FS and AD FS 1.x Interoperability](/archive/blogs/askds/ad-fs-2-0-and-ad-fs-1-x-interoperability)