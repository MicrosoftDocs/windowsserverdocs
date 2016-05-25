---
title: UseExistingAccount Operation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bbf77b4c-3704-4600-a4f1-e9f602157bcd
author: Femila
---
# UseExistingAccount Operation
  The following options are available for the UseExistingAccount operation during an unattended installation of Active Directory Domain Services \(AD DS\). Options that are new in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] appear in bold text.  
  
|Parameter|Possible values|Default value|Description|  
|---------------|---------------------|-------------------|-----------------|  
|\/ApplicationPartitionsToReplicate|"*partition\_DN\_1 partition\_DN\_2 ...partition\_DN\_n*"||Specifies application partitions to be replicated in the format of "partition1" "partition2". If \* is specified, all application partitions will be replicated.<br /><br /> Use space\-separated \(or comma\-and\-space\-separated\) distinguished names, with the entire string enclosed in quotation marks.|  
|\/CriticalReplicationOnly|Yes &#124; No|No|Specifies whether the promotion operation performs only critical replication before reboot and then continues, skipping the noncritical \(and potentially lengthy\) portion of replication. The noncritical replication happens after the role installation finishes and the computer restarts.|  
|\/DatabasePath|*path\_to\_database\_files*|%systemroot%\\NTDS|Specifies the fully qualified, non–Universal Naming Convention \(UNC\) path to a directory on a fixed disk of the local computer that contains the domain database, for example, C:\\Windows\\NTDS.|  
|\/DNSOnNetwork|Yes &#124; No|Yes|Specifies whether the DNS Server service is available on the network. This is used only when the network adapter for this computer is not configured with the name of a DNS server for name resolution. Specifying No indicates that DNS server will be installed on this computer for name resolution. Otherwise, the network adapter must be configured with a DNS server name first.|  
|\/LogPath|Path\_to\_log\_files|%systemroot%\\ NTDS|Specifies the fully qualified, non\-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, C:\\Windows\\NTDS.|  
|\/Password|*password*||Specifies the password that corresponds to the user name \(account credentials\) that is used to promote the domain controller.|  
|**\/RebootOnCompletion**|Yes &#124; No|Yes|Specifies whether to restart the computer upon completion, regardless of success.|  
|**\/RebootOnSuccess**|Yes &#124; No|Yes|Specifies whether to restart the computer upon successful completion of an operation.|  
|\/ReplicaDomainDNSName|*DNS\_domain\_name*||Specifies the fully qualified domain name \(FQDN\) of the domain in which you want to promote an additional domain controller.|  
|\/ReplicationSourceDC|DNS\_name\_of\_source||Indicates the FQDN of the partner domain controller from which Active Directory data is replicated to create the new domain controller.|  
|\/ReplicationSourcePath|*path\_to\_installation\_media*||Indicates the location of the installation media that will be used to install a new domain controller.|  
|\/SafeModeAdminPassword|*password* &#124; None||The password for the administrator account to use when you start the computer in Safe Mode or a variant of Safe Mode, such as Directory Service Restore Mode \(DSRM\). You cannot specify a blank password.|  
|**\/SkipAutoConfigDNS**|No value is required.||This switch is for expert users who want to skip automatic configuration of client settings, forwarders, and root hints. The switch is in effect only if the DNS Server service is already installed on the server. If you specify this switch, ensure that zones are created and properly configured before you install AD DS. Otherwise, this domain controller will not operate correctly. If the DNS Server service is not installed on this server, this switch is ignored.|  
|\/Syskey|NONE &#124; *system key*||Specifies the system key for the media from which you replicate the data.|  
|\/SysVolPath|*path\_to\_SYSVOL\_folder*|%systemroot%\\ sysvol|Specifies the fully qualified, non\-UNC path to a directory on a fixed disk of the local computer, for example, C:\\\\Windows\\SYSVOL.|  
|\/UserDomain|*domain\_name*||Specifies the domain name for the user name \(account credentials\) that is used for promoting a domain controller.|  
|\/UserName|*Domain\\user\_name*||Specifies the user name \(account credentials\) that is used for promoting a domain controller. We recommend that you specify the account credentials in the domain\\user\_name format.|  
  
  