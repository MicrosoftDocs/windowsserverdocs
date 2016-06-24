---
title: Encryption Zone GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 05af0590-526c-4c4e-8574-1ce972e5e1ec
---
# Encryption Zone GPOs
Handle encryption zones in a similar manner to the boundary zones. A computer is added to an encryption zone by adding the computer account to the encryption zone group. Woodgrove Bank has a single service that must be protected, and the computers that are running that service are added to the group CG_DOMISO_Encryption. This group is granted Read and Apply Group Policy permissions in on the GPO described in this section.

The GPO is only for server versions of Windows. Client computers are not expected to participate in the encryption zone. If the need for one occurs, either create a new GPO for that version of Windows, or expand the WMI filter attached to one of the existing encryption zone GPOs to make it apply to the client version of Windows.

-   [GPO_DOMISO_Encryption_WS2008](GPO_DOMISO_Encryption_WS2008.md)


