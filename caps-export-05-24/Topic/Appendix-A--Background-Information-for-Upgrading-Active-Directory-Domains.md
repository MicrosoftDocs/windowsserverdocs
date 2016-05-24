---
title: Appendix A: Background Information for Upgrading Active Directory Domains
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d36dbe1f-4ba5-4542-ba28-7588537c1863
author: Femila
---
# Appendix A: Background Information for Upgrading Active Directory Domains
Before you begin the process of upgrading your Windows 2000 or Windows Server 2003 Active Directory environment to Active Directory Domain Services \(AD DS\), become familiar with some important issues that affect the upgrade process.  
  
## Active Directory preparation tool  
To prepare Windows 2000 or Windows Server 2003 forests and domains for upgrade, or for the introduction of a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must use the Active Directory preparation tool \(Adprep.exe\). Adprep.exe is located in the \\sources\\adprep folder of the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system DVD and in the \\support\\adprep folder of the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system DVD. The [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] versions of Adprep are 64\-bit and 32\-bit \(Adprep32.exe\).  
  
Adprep.exe prepares the forests and domains for an upgrade to AD DS by performing a collection of operations. These operations include the following:  
  
-   Extending your current schema with new schema information that the Adprep.exe tool provides, while preserving previous schema modifications in your environment  
  
-   Resetting permissions on containers and objects throughout the directory for improved security and interoperability  
  
-   Copying administrative tools to manage [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domains to the local computer  
  
For more information about using Adprep.exe to prepare your environment, see [Prepare Your Infrastructure for Upgrade](../Topic/Prepare-Your-Infrastructure-for-Upgrade.md).  
  
## Application directory partitions for DNS  
Application directory partitions provide storage for application\-specific data that can be replicated to a specific set of domain controllers in the same forest. If you have at least one domain controller in your forest running Windows Server 2003, Windows Server 2008, or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and the domain naming operations master is also running Windows Server 2003, Windows Server 2008, or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can take advantage of application directory partitions.  
  
For example, you can use application directory partitions to store Domain Name System \(DNS\) data on Windows Server 2003–based domain controllers. DNS\-specific application directory partitions are automatically created in the forest and in each domain when the DNS Server service is installed on new or upgraded domain controllers. If application directory partition creation fails during AD DS installation, DNS attempts to create the partitions every time that the service starts. The creation and deletion of application directory partitions \(including the default DNS application directory partitions\) requires the domain naming master role holder to reside on a domain controller that runs Windows Server 2003, Windows Server 2008, or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
The following DNS\-specific application directory partitions are created during AD DS installation:  
  
-   ForestDnsZones—A forest\-wide application directory partition that is shared by all DNS servers in the same forest  
  
-   DomainDnsZones—Domain\-wide application directory partitions for each DNS server in the same domain  
  
### Service \(SRV\) resource records  
A [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controller Net Logon service uses dynamic updates to register service \(SRV\) resource records in the DNS database. This service \(SRV\) resource record is used to map the name of a service \(such as the Lightweight Directory Access Protocol \(LDAP\) service\) to the DNS computer name of a server that offers that service. In a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] network, an LDAP resource record locates a domain controller. A workstation that is logging on to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain queries DNS for service \(SRV\) resource records in the general form:  
  
`_<Service>._<Protocol>.<DnsDomainName>`  
  
Where *<Service>* is the service requested, *<Protocol>* is the protocol requested, and *<DnsDomainName>*is the fully qualified DNS name of the AD DS domain.  
  
AD DS servers offer the LDAP service over the TCP protocol; therefore, client computers find an LDAP server by querying DNS for a record of the form:  
  
`_ldap._tcp.<DnsDomainName>`  
  
> [!NOTE]  
> The service and protocol strings require an underscore \( \_ \) prefix to prevent potential collisions with existing names in the namespace.  
  
This format is applicable for implementations of LDAP servers other than [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers and also possible implementations of LDAP directory services that employ global catalog servers other than servers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
### \_msdcs.domain\_name subdomain  
This Microsoft\-specific subdomain allows location of domain controllers that have [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–specific roles in the domain. This subdomain also allows location of domain controllers by the globally unique identifier \(GUID\) when a domain has been renamed.  
  
To facilitate location of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers, the Net Logon service \(in addition to the standard \_Service.\_Protocol.<DnsDomainName> format records\) also registers service \(SRV\) resource records that identify the well\-known server\-type pseudonyms "dc" \(domain controller\), "gc" \(global catalog\), "pdc" \(primary domain controller\), and "domains" \(GUID\) as prefixes in the \_msdcs.<domain\_name> subdomain. To accommodate the location of domain controllers by server type or by GUID \(abbreviated "dctype"\), [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers register service \(SRV\) resource records in the following form in the \_msdcs.<domain\_name> subdomain:  
  
`_Service._Protocol.DcTyle._msdcs.<DnsDomainName>`  
  
### \_msdcs.forest\_root\_domain subdomain  
The \_msdcs.forest\_root\_domain subdomain stores forest\-wide resource records that are of interest to client computers and domain controllers from all parts of the forest. For example, all domain controllers in the forest register alias \(CNAME\) and LDAP, Kerberos, and gc service \(SRV\) resource records in the \_msdcs.forest\_root\_domain subdomain. The alias \(CNAME\) resource records are used by the replication system to locate replication partners, and the gc service \(SRV\) resource records are used by client computers to look up global catalog servers.  
  
For any two domain controllers to replicate with each other, including two domain controllers from the same domain, they must be able to look up forest\-wide locator records. For a newly created domain controller to participate in replication, it must be able to register its forest\-wide records in DNS, and other domain controllers must be able to look up these records. Therefore, the DNS servers that are authoritative for the \_msdcs.forest\_root\_domain subdomain need to be available for replication and global catalog lookups.  
  
For this reason, we recommend that you create a separate \_msdcs.forest\_root\_domain zone and define its replication scope so that it is replicated to all DNS servers in the forest.  
  
Some organizations running Windows 2000 Active Directory have already created an \_msdcs.forest\_root\_domain to help client computers locate domain controllers more efficiently. If an \_msdcs.forest\_root\_domain already exists in your Windows 2000 environment, we recommend that you move the zone to the ForestDnsZones application directory partition after all domain controllers in the forest are upgraded. In addition, for each domain in the forest, move the \_msdcs.<domain\_name> zone to the DomainDnsZones application directory partition for that domain.  
  
Moving the Active Directory–integrated DNS zones into the domain and forest\-wide application directory partitions provides the following benefits:  
  
-   Because the forest\-wide application directory partition can replicate outside a specified domain, and because moving the \_msdcs.forest\_root\_domain into the forest\-wide application directory partition replicates it to all domain controllers in the forest that are running the DNS Server service, you do not have to use DNS zone transfer to replicate the zone file information to DNS servers that are outside the domain.  
  
-   Domain\-wide replication can be targeted to minimize replication traffic because administrators can specify which of the domain controllers running the DNS Server service can receive the DNS zone data.  
  
-   Forest\-wide replication can be targeted to minimize replication traffic because DNS data is no longer replicated to the global catalog.  
  
-   DNS records located on global catalog servers in the forest are removed, minimizing the amount of information replicated with the global catalog.  
  
For more information about using application directory partitions to store DNS data, see [Move DNS Data into DNS Application Directory Partitions](../Topic/Move-DNS-Data-into-DNS-Application-Directory-Partitions.md).  
  
### Intrasite replication frequency  
Windows 2000–based domain controllers that are upgraded maintain their default intrasite replication frequency of 300\/30. That is, any changes that are made to AD DS replicate to all other domain controllers in the same site 5 minutes \(300 seconds\) after a change is made—with a 30\-second offset before notifying the next domain controller—until the forest functional level is raised to Windows Server 2003. When the forest functional level is raised to Windows Server 2003, the replication frequency of AD DS is changed to the Windows Server 2003default setting of 15\/3. That is, changes will replicate to all domain controllers in the same site 15 seconds after a change is made—with a 3\-second offset before notifying the next domain controller. If you modified the 300\/30 default replication frequency setting in Windows 2000, the setting does not change to the 15\/3 default setting in Windows Server 2003 after you complete the upgrade. However, a new installation of Windows Server 2003 will always use the 15\/3 intrasite replication frequency setting.  
  
> [!IMPORTANT]  
> Do not modify the default 300\/30 intrasite replication frequency on Windows 2000–based domain controllers. Instead, upgrade your Windows 2000–based domain to Windows Server 2003, and raise the forest functional level to Windows Server 2003 to take advantage of the 15\/3 intrasite replication frequency.  
  
## New groups and new group memberships that are created after upgrading the PDC  
After you upgrade the Windows 2000–based domain controller holding the role of the primary domain controller \(PDC\) emulator operations master \(also known as flexible single master operations or FSMO\) in each domain in the forest to Windows Server 2003, several new, well\-known, and built\-in groups are created. Also, some new group memberships are established. If you transfer the PDC emulator operations master role to a Windows Server 2003–based or a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controller instead of upgrading it, these groups will be created when the role is transferred. The new, well\-known, and built\-in groups include the following:  
  
-   Builtin\\Remote Desktop Users  
  
-   Builtin\\Network Configuration Operators  
  
-   Performance Monitor Users  
  
-   Performance Log Users  
  
-   Builtin\\Incoming Forest Trust Builders  
  
-   Builtin\\Performance Monitoring Users  
  
-   Builtin\\Performance Logging Users  
  
-   Builtin\\Windows Authorization Access Group  
  
-   Builtin\\Terminal Server License Servers  
  
The newly established group memberships include the following:  
  
-   If the Everyone group is in the Pre–Windows 2000 Compatible Access group, the Anonymous Logon group and the Authenticated Users group are also added to the Pre–Windows 2000 Compatible Access group.  
  
-   The Network Servers group is added to the Performance Monitoring alias.  
  
-   The Enterprise Domain Controllers group is added to the Windows Authorization Access group.  
  
In addition, when upgrading the Windows 2000–based domain controller that holds the role of the PDC emulator master in the forest root domain, the following additional security principals are created:  
  
-   LocalService  
  
-   NetworkService  
  
-   NTLM Authentication  
  
-   Other Organization  
  
-   Remote Interactive Logon  
  
-   SChannel Authentication  
  
-   This Organization  
  
After you upgrade the Windows Server 2003–based domain controller holding the role of the PDC emulator master in each domain in the forest to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or after you move the PDC emulator operations master role to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\-based domain controller, or after you add a read\-only domain controller \(RODC\) to your domain, the following new well\-known and built\-in groups are created:  
  
-   Builtin\\IIS\_IUSRS  
  
-   Builtin\\Cryptographic Operators  
  
-   Allowed RODC Password Replication Group  
  
-   Denied RODC Password Replication Group  
  
-   Read\-only Domain Controllers  
  
-   Builtin\\Event Log Readers  
  
-   Builtin\\Certificate Service DCOM Access  
  
-   Enterprise Read\-only Domain Controllers  
  
    > [!NOTE]  
    > The Enterprise Read\-only Domain Controllers group is created only in the root domain when either you upgrade the PDC emulator or introduce the first RODC, whichever comes first. The SID for this group is added to the RODC token even if the group does not appear to be present.  
  
The newly established group memberships are:  
  
-   IUSR security principal added to the Builtin\\IIS\_IUSRS group  
  
-   The following groups added to the Denied RODC Password Replication Group:  
  
    -   Group Policy Creator Owners  
  
    -   Domain Admins  
  
    -   Cert Publishers  
  
    -   Domain Controllers  
  
    -   Krbtgt  
  
    -   Enterprise Admins  
  
    -   Schema Admins  
  
    -   Read\-only Domain Controllers  
  
-   Network Service security principal added to Builtin\\Performance Log Users  
  
-   Also, the following new, additional security principals are created in the forest root domain:  
  
-   IUSR  
  
-   Owner Rights  
  
-   Well\-Known\-Security\-Id\-System security principal is renamed to System  
  
    > [!NOTE]  
    > If you move the PDC emulator master role from a Windows 2000–based domain controller to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\-based domain controller, all the new, well\-known, and built\-in groups and newly established group memberships mentioned above will be created.  
  
## Security policy considerations when upgrading from Windows 2000 to Windows Server 2003  
Server Message Block \(SMB\) packet signing and secure channel signing are security policies that are enabled by default on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers. To allow client computers running earlier versions of Windows to communicate with domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you might have to temporarily disable these security policies during the upgrade process.  
  
### SMB packet signing  
SMB packet signing is a security mechanism that protects the data integrity of SMB traffic between client computers and servers, and it prevents malicious software attacks by providing a form of mutual authentication. This is done by placing a digital security signature into each SMB packet, which is then verified by the receiving party. Server\-side SMB signing is required by default on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers; that is, all client computers are required to have SMB packet signing enabled.  
  
Client computers running Windows NT 4.0 with Service Pack 2 \(SP2\) or earlier, or particular non\-Microsoft operating systems, do not support SMB packet signing. These client computers will not be able to authenticate to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controller. To ensure successful authentication, upgrade these client computers to a later version of the operating system or service pack. However, if you cannot upgrade your client computers, you can allow them to be authenticated by configuring SMB packet signing on all [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers so that SMB packet signing is allowed but not required.  
  
For more information about configuring SMB packet signing on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers, see [Modify Security Policies in Default Domain Controllers Policy](../Topic/Modify-Security-Policies-in-Default-Domain-Controllers-Policy.md).  
  
### Secure channel signing and encryption  
When a computer becomes a member of a domain, a computer account is created. Each time the computer starts, it uses the computer account password to create a secure channel with a domain controller for its domain. This secure channel is used to ensure secure communications between a domain member and a domain controller for its domain. Secure channel signing is required by default on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers; that is, all client computers must enable secure channel signing and encryption.  
  
Client computers running Windows NT 4.0 with Service Pack 3 \(SP3\) or earlier installed do not support secure channel signing. These client computers will not be able to establish communications with a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controller. To ensure successful communication, upgrade these client computers to a later version of the operating system or service pack. However, if you cannot upgrade your client computers, you must disable secure channel signing on all [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers so that the traffic passing through the secure channel is not required to be signed or encrypted.  
  
For more information about configuring secure channel signing on Windows Server 2003–based domain controllers, see [Modify Security Policies in Default Domain Controllers Policy](../Topic/Modify-Security-Policies-in-Default-Domain-Controllers-Policy.md).  
  
