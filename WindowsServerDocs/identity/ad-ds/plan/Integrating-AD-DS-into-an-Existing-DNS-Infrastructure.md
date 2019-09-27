---
ms.assetid: 4981b32f-741e-4afc-8734-26a8533ac530
title: Integrating AD DS into an Existing DNS Infrastructure
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Integrating AD DS into an Existing DNS Infrastructure

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

If your organization already has an existing Domain Name System (DNS) Server service, the DNS for Active Directory Domain Services (AD DS) owner must work with the DNS owner for your organization to integrate AD DS into the existing infrastructure. This involves creating a DNS server and DNS client configuration.  
  
## Creating a DNS server configuration  
When integrating AD DS with an existing DNS namespace, we recommend that you do the following:  
  
-   Install the DNS Server service on every domain controller in the forest. This provides fault tolerance if one of the DNS servers is unavailable. In this way, domain controllers do not need to rely on other DNS servers for name resolution. This also simplifies the management environment because all domain controllers have a uniform configuration.  
  
-   Configure the Active Directory forest root domain controller to host the DNS zone for the Active Directory forest.  
  
-   Configure the domain controllers for each regional domain to host the DNS zones that correspond to their Active Directory domains.  
  
-   Configure the zone containing the Active Directory forest-wide locator records (that is, the _msdcs.*forestname* zone) to replicate to every DNS server in the forest by using the forest-wide DNS application directory partition.  
  
    > [!NOTE]  
    > When the DNS Server service is installed with the Active Directory Domain Services Installation Wizard (we recommend this option), all the previous tasks are performed automatically. For more information, see [Deploying a Windows Server 2008 Forest Root Domain](https://technet.microsoft.com/library/cc731174.aspx).  
  
    > [!NOTE]  
    > AD DS uses forest-wide locator records to enable replication partners to find each other and to enable clients to find global catalog servers. AD DS stores the forest-wide locator records in the _msdcs.*forestname* zone. Because the information in the zone must be widely available, this zone is replicated to all DNS servers in the forest by means of the forest-wide DNS application directory partition.  
  
The existing DNS structure remains intact. You do not need to move any servers or zones. You simply need to create a delegation to your Active Directory-integrated DNS zones from your existing DNS hierarchy.  
  
## Creating the DNS client configuration  
To configure DNS on client computers, the DNS for AD DS owner must specify the computer naming scheme and how the clients will locate DNS servers. The following table lists our recommended configurations for these design elements.  
  
|Design element|Configuration|  
|------------------|-----------------|  
|Computer naming|Use default naming. When a Windows 2000, Windows XP, Windows Server 2003,  Windows Server 2008 , or Windows Vista-based computer joins a domain, the computer assigns itself a fully qualified domain name (FQDN) that comprises the host name of the computer and the name of the Active Directory domain.|  
|Client resolver configuration|Configure client computers to point to any DNS server on the network.|  
  
> [!NOTE]  
> Active Directory clients and domain controllers can dynamically register their DNS names even if they are not pointing to the DNS server that is authoritative for their names.  
  
A computer might have a different existing DNS name if the organization previously, statically registered the computer in DNS or if the organization previously deployed an integrated Dynamic Host Configuration Protocol (DHCP) solution. If your client computers already have a registered DNS name, when the domain to which they are joined is upgraded to  Windows Server 2008  AD DS, they will have two different names:  
  
-   The existing DNS name  
  
-   The new fully qualified domain name (FQDN)  
  
Clients can still be located by either name. Any existing DNS, DHCP, or integrated DNS/DHCP solution is left intact. The new primary names are created automatically and updated by means of dynamic update. They are cleaned up automatically by means of scavenging.  
  
If you want to take advantage of Kerberos authentication when connecting to a server running Windows 2000, Windows Server 2003, or  Windows Server 2008 , you must make sure that the client connects to the server by using the primary name.  
  


