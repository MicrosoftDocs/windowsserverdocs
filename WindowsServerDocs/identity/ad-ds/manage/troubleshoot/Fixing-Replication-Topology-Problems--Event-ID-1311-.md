---
ms.assetid: f56c5c62-4b0e-4cd7-80e9-1c9bf42e517f
title: Fixing Replication Topology Problems (Event ID 1311)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Fixing Replication Topology Problems (Event ID 1311)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This problem typically occurs when the replication configuration information in Active Directory Domain Services (AD DS) does not accurately reflect the physical topology of the network. </para>
    <para>The Knowledge Consistency Checker (KCC) constructs and maintains the Active Directory replication topology automatically. Every 15 minutes, the KCC examines the sum of all directory partition replicas that reside on domain controllers in the forest, as well as administrator-defined settings for connections, sites, and site links.</para>
    <para>Although generation of the replication topology occurs automatically, administrative configuration errors can result in an Active Directory replication topology that is inconsistent with the physical connections that are available. In AD DS it is possible to create objects for which there is no physical network support. For example, you can use the Active Directory Sites and Services snap-in to create a site object and assign subnet addresses that do not exist. The KCC will attempt to use these objects to create connections between domain controllers, but replication cannot occur because the network does not exist to support the replication topology as it is configured.</para>
    <para>Event ID 1311 is logged in the Directory Service event log when the replication configuration information in AD DS does not accurately reflect the physical topology of the network. Use the information in Event ID 1311 " KCC Replication Path Computation (<externalLink><linkText>https://go.microsoft.com/fwlink/?LinkId=124054</linkText><linkUri>https://go.microsoft.com/fwlink/?LinkId=124054</linkUri></externalLink>) to identify and fix topology problems.</para>
  </introduction>
  <relatedTopics />
</developerConceptualDocument>

