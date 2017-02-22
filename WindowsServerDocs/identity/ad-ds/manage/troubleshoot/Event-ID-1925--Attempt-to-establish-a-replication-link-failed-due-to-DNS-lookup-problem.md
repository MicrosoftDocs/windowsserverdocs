---
ms.assetid: a695aee3-971f-4e9c-94e8-092ebdefea84
title: Event ID 1925 - Attempt to establish a replication link failed due to DNS lookup problem
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 1925: Attempt to establish a replication link failed due to DNS lookup problem

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This problem typically occurs when an attempt to establish a replication link fails as a result of a Domain Name System (DNS) lookup problem. If you receive Event ID 1925 with the error message that DNS lookup failed, inbound replication of a directory partition has failed on the destination domain controller, and you must fix the DNS problem. </para>
    <para>The following is an example of the event text: </para>
    <code>Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: 3/12/2008  8:14:13 AM
Event ID: 1925
Task Category: Knowledge Consistency Checker 
Level: Warning
Keywords: Classic
User: ANONYMOUS LOGON
Computer: DC3.contoso.com
Description:
The attempt to establish a replication link for the following 
writable directory partition failed. 

Directory partition: 
CN=Configuration,DC=contoso,DC=com 
Source directory service: 
CN=NTDS Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,
CN=Sites,CN=Configuration,DC=contoso,DC=com 
Source domain controller address: 
f8786828-ecf5-4b7d-ad12-8ab60178f7cd._msdcs.contoso.com 
Intersite transport (if any): CN=IP,CN=Inter-Site Transports,
CN=Sites,CN=Configuration,DC=constoso,DC=com

This domain controller will be unable to replicate with the 
source domain controller until this problem is corrected.  

User Action 
Verify if the source domain controller is accessible or 
network connectivity is available. 

Additional Data 
Error value: 
8524 The DSA operation is unable to proceed because of a DNS 
lookup failure.
</code>
  </introduction>
  <section>
    <title>Resolution</title>
    <content>
      <para>Proceed with DNS testing as described in "<link xlink:href="85b1d179-f53e-4f95-b0b8-5b1c096a8076">Event ID 2087: DNS lookup failure caused replication to fail</link>."</para>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>


