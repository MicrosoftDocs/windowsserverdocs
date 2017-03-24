---
ms.assetid: 
title: Client Access Control policies in AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 03/24/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Access control policies in Active Directory Federation Services

This document provides an overview of client access policies in AD FS.  For detailed information on specific client access polices by version see:

- [Client access policies in AD FS 2.0](Access-Control-Policies-in-AD-FS-2.md)
- [Client access policies in Windows Server 2012 R2 AD FS](Access-Control-Policies-W2K12.md)
- [Client access policies in Windows Server 2016 AD FS](Access-Control-Policies-in-AD-FS.md)

Since the introduction of Active Directory Federation Services, client access policies have been available to restrict or allow users access to resources.  As AD FS has moved from version to version, how these policies are implemented has changed.  This document brings all of the different versions of AD FS client access policies together.  This page will act as a central location for the most update information on AD FS client Access policies.

## What are client access policies?


Client access policies work by identifying which authentication requests should be permitted based upon attributes of the request itself. To provide this additional request context information, client access policies introduce a set of new claim types that AD FS populates from header information sent by the requesting client. 

### Claim types
Client access policies work by identifying which authentication requests should be permitted based upon attributes of the request itself. To provide this additional request context information, client access policies use a set of claim types that AD FS populates from header information sent by the requesting client. For a detailed description of the new claim types and values, see New Claim Types.
## Common AD FS client access scenarios
The following table describes the scenarios supported by the client access policy feature.

|Scenario|Description|
|-----|-----| 
|Block all external access to Office 365|Office 365 access is allowed from all clients on the internal corporate network, but requests from external clients are denied based on the IP address of the external client.|
|Block all external access to Office 365, except Exchange ActiveSync|Office 365 access is allowed from all clients on the internal corporate network, as well as from any external client devices, such as smart phones, that make use of Exchange ActiveSync. All other external clients, such as those using Outlook, are blocked.|
|Block all external access to Office 365, except for browser-based applications such as Outlook Web Access or SharePoint Online|Blocks external access to Office 365, except for passive (browser-based) applications such as Outlook Web Access or SharePoint Online.|
|Block all external access to Office 365 for members of designated Active Directory groups|This scenario is used for testing and validating client access policy deployment. It blocks external access to Office 365 only for members of one or more Active Directory group. It can also be used to provide external access only to members of a group.|


## Next Steps
For more information on specific version of client access policies see"

- [Client access policies in AD FS 2.0](Access-Control-Policies-in-AD-FS-2.md)
- [Client access policies in Windows Server 2012 R2 AD FS](Access-Control-Policies-W2K12.md)
- [Client access policies in Windows Server 2016 AD FS](Access-Control-Policies-in-AD-FS.md)