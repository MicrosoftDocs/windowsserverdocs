---
ms.assetid: 39c0126d-af5e-4dcb-88c1-aa38f888e973
title: Active Directory-Integrated DNS Zones
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Active Directory-Integrated DNS Zones

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Domain Name System (DNS) servers running on domain controllers can store their zones in Active Directory Domain Services (AD DS). In this way, it is not necessary to configure a separate DNS replication topology that uses ordinary DNS zone transfers because all zone data is replicated automatically by means of Active Directory replication. This simplifies the process of deploying DNS and provides the following advantages:  
  
-   Multiple masters are created for DNS replication. Therefore, any domain controller in the domain running the DNS Server service can write updates to the Active Directory-integrated DNS zones for the domain name for which they are authoritative. A separate DNS zone transfer topology is not needed.  
  
-   Secure dynamic updates are supported. Secure dynamic updates allow an administrator to control what computers update what names and prevent unauthorized computers from overwriting existing names in DNS.  
  
Active Directory-integrated DNS in  Windows Server 2008  stores zone data in application directory partitions. (There are no behavioral changes from Windows Server 2003-based DNS integration with Active Directory.) The following DNS-specific application directory partitions are created during AD DS installation:  
  
-   A forest-wide application directory partition, called ForestDnsZones  
  
-   Domain-wide application directory partitions for each domain in the forest, named DomainDnsZones  
  
For more information about how AD DS stores DNS information in application partitions, see the [DNS Technical Reference](https://go.microsoft.com/fwlink/?LinkId=106636).  
  
> [!NOTE]  
> We recommend that you install DNS when you run the Active Directory Domain Services Installation Wizard (Dcpromo.exe). If you do this, the wizard creates the DNS zone delegation automatically. For more information, see [Deploying a Windows Server 2008 Forest Root Domain](https://technet.microsoft.com/library/cc731174.aspx).  
  


