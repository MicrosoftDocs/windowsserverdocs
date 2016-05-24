---
title: CreateDCAccount Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bfd42289-e34e-4b46-8114-4da82ba5fa17
author: Femila
---
# CreateDCAccount Operation
  The following options are available for the CreateDCAccount operation during an unattended installation of Active Directory Domain Services \(AD DS\). Options that are new in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] appear in bold text.  
  
|Parameter|Possible values|Default value|Description|  
|---------------|---------------------|-------------------|-----------------|  
|\/AutoconfigDNS<br /><br /> This parameter has been renamed to \/InstallDNS.|Yes &#124; No|Computed automatically based on the environment.|Specifies whether Domain Name System \(DNS\) is configured for a new domain if Dcpromo detects that the DNS dynamic update protocol is not available or if Dcpromo detects an insufficient number of DNS servers for an existing domain.|  
|\/ConfirmGc|Yes &#124; No|Yes, unless you are creating the first domain controller in a new child domain or new domain tree.|Specifies whether the domain controller is a global catalog server.|  
|**\/DCAccountName**|*Name of the domain controller account to create*||Specifies the name of the read\-only domain controller \(RODC\) account that you are creating.|  
|**\/DelegatedAdmin**|*User or group*||Specifies the name of the user or group who will install and administer the RODC. If no value is specified, only members of the Domain Admins group or Enterprise Admins group can install and administer the RODC.|  
|**\/InstallDNS**<br /><br /> This switch replaces \/AutoConfigDNS.|Yes &#124; No|Computed automatically based on the environment.|Specifies whether DNS is configured for a new domain if Dcpromo detects that the DNS dynamic update protocol is not available or if Dcpromo detects an insufficient number of DNS servers for an existing domain.|  
|\/Password|*password*||Specifies the password that corresponds to the user name \(account credentials\) that is used to promote the domain controller.|  
|**\/PasswordReplicationAllowed**|*Security\_Principal* &#124; None||Specifies the names of computer and user accounts whose passwords can be replicated to this RODC. Specify "None" if you want to keep the value empty. By default, no user credentials will be cached on this RODC. To specify more than one security principal, add the entry multiple times.|  
|**\/PasswordReplicationDenied**|*Security\_Principal* &#124; NONE||Specifies the names of user, group, and computer accounts whose passwords are not to be replicated to this RODC. Specify "None" if you do not want to deny the replication of credentials of any users or computers. To specify more than one security principal, add the entry multiple times.|  
|\/ReplicaDomainDNSName|*DNS\_domain\_name*||Specifies the fully qualified domain name \(FQDN\) of the domain in which you want to promote an additional domain controller.|  
|\/ReplicationSourceDC|DNS\_name\_of\_source||Indicates the FQDN of the partner domain controller from which Active Directory data is replicated to create the new domain controller.|  
|\/SiteName|*site\_name*|See the note below this table|The name of an existing site where you can place the new domain controller.|  
|\/UserDomain|*domain\_name*||Specifies the domain name for the user name \(account credentials\) that is used for promoting a domain controller.|  
|\/UserName|*Domain\\user\_name*||Specifies the user name \(account credentials\) that is used for promoting a domain controller. We recommend that you specify the account credentials in the domain\\user\_name format.|  
  
> [!NOTE]  
>  The default value for the \/SiteName parameter depends on the type of installation. For a new forest, the default value is Default\-First\-Site\-Name. For all other writable domain controller installations, the default is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller. For an RODC installation, you must specify the site name where the RODC will be installed.  
  
  