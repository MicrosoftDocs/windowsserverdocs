---
title: dcpromo in Windows Server
description: Learn about using the dcpromo command to install, promote, demote, and remove Active Directory Domain Services (AD DS) from a Windows Server.
ms.topic: reference
author: robinharwood
ms.author: roharwoo
ms.date: 04/22/2024
---

# dcpromo

Applies To: Windows Server (All supported versions)

The dcpromo command installs, promotes, demotes, and removes Active Directory Domain Services (AD DS) from a Windows Server.

For examples of how to use **dcpromo**, see [Examples]().

## Syntax

`dcpromo [/answer[:\<filename>] | /unattend[:\<filename>] | /unattend | /adv] /uninstallBinaries [/CreateDCAccount | /UseExistingAccount:Attach] /? /?[:{Promotion | CreateDCAccount | UseExistingAccount | Demotion}]`

## Dcpromo.exe parameters

| Parameter | Description |
|---|---|
| /answer[:\<filename>] | Specifies an answer file that contains installation parameters and values. |
| /unattend[:\<filename>] | Specifies an answer file that contains installation parameters and values. This command provides the same function as /answer[:\<filename>]. |
| /unattend| Specifies an unattended installation in which you provide installation parameters and values at the command line. |
| /adv | Performs an install from media (IFM) operation. |
| /UninstallBinaries | Uninstalls AD DS binaries. |
| /CreateDCAccount | Creates a read-only domain controller (RODC) account. Only a member of the Domain Admins group or the Enterprise Admins group can run this command. |
| /UseExistingAccount:Attach | Attaches a server to an existing RODC account. A member of the Domain Admins group or a delegated user can run this command. |
| /? | Displays Help for Dcpromo parameters. |
| /?[:{Promotion \| CreateDCAccount \| UseExistingAccount \| Demotion}] | Displays parameters that apply to the dcpromo operation. For example, `dcpromo /?:Promotion displays` all of the parameters that you can use for a promotion operation. |

## dcpromo promotion operation parameters

The following table shows the parameters available when running `dcpromo.exe` from a command prompt for the unattended installation of a domain controller that runs Windows Server.

For more information about creating a new forest, see [Installing a New Windows Server 2008 Forest](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772464(v=ws.10)).

For more information about creating a new domain, see [Installing a New Windows Server 2008 Child Domain](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731394(v=ws.10)).

For more information about creating a new domain tree, see [Installing a New Windows Server 2008 Domain Tree](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733006(v=ws.10)).

For more information about creating another domain controller for a domain, see [Installing an Additional Windows Server 2008 Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733027(v=ws.10)).

| Parameter and value pair | Description and default |
|---|---|
| AllowDomainControllerReinstall:{Yes \| \<No> \| NoAndNoPromptEither} | <p>Specifies whether to continue installing this domain controller, even when another domain controller account with the same name is detected.</p><p>Use Yes only if you're sure that the account isn't currently used by another domain controller.</p><p>The default is **No**.</p> |
| AllowDomainReinstall:{Yes \| \<No> \| NoAndNoPromptEither} | <p>Specifies whether an existing domain is recreated.</p><p>The default is **No**.</p> |
| ApplicationPartitionsToReplicate:"" | <p>Specifies the application directory partitions that dcpromo will replicate. Use the following format:</p><p>"**partition1**" "**partition2**" "**partitionN**"</p><p>Use * to replicate all application directory partitions.</p> |
| <p>AutoConfigDNS:{Yes \| No}</p><p>This parameter has been renamed to **InstallDNS**. | Specifies whether the DNS Server service should be installed. The default is automatically computed based on the environment. |
| ChildName:"child_domain_name" | Specifies the single-label Domain Name System (DNS) name of the child domain. |
| ConfirmGc:{Yes \| No} | Specifies whether you want the domain controller to be a global catalog server. |
| CreateDNSDelegation: { Yes \| No} | <p>Indicates whether to create a DNS delegation that references the new DNS server that you're installing along with the domain controller. Valid for Active Directory-integrated DNS only.</p><p>The default is computed automatically based on the environment.</p> |
| CriticalReplicationOnly:{Yes \| \<No>} | <p>Specifies whether the AD DS installation operation performs only critical replication before reboot and then continues, skipping the noncritical (and potentially lengthy) portion of replication. The noncritical replication happens after the installation finishes and the computer reboots.</p><p>The default is **No**.</p> |
| DatabasePath:"path_to_database_files" | <p>Specifies the fully qualified, non-Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database, for example, **C:\Windows\NTDS**.</p><p>The default is **%SYSTEMROOT%\NTDS**.</p> |
| DelegatedAdmin:"name of user or group" | Specifies the name of the user or group that will install and administer the RODC. |
| DNSDelegationPassword:"password" | Specifies the password for the user name (account credentials) for creating DNS delegation. |
| DNSDelegationUserName:"user_name" | Specifies the user name (account credentials) for creating DNS delegation. |
| DNSOnNetwork:{\<Yes> \| No} | <p>Specifies whether DNS service is available on the network. This parameter is used only when the IP setting of the network adapter for this computer isn't configured with the name of a DNS server for name resolution. No indicates that a DNS server will be installed on this computer for name resolution. Otherwise, the IP settings of the network adapter must be configured with a DNS server name first.</p><p>The default is **Yes**.</p> |
| DomainLevel:{0 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 10} | <p>This entry specifies the domain functional level. This entry is based on the levels that exist in the forest when a new domain is created in an existing forest. Value descriptions are as follows: </br>- 0 = Windows 2000 Server native mode</br>- 2 = Windows Server 2003</br>- 3 = Windows Server 2008</br>- 4 = Windows Server 2008 R2</br>- 5 = Windows Server 2012</br>- 6 = Windows Server 2012 R2</br>- 7 = Windows Server 2016</br>- 10 = Windows Server 2025</p><p>The domain functional level can't be lower than the forest functional level, but it can be higher.</p><p>The default is automatically computed and set to the existing forest functional level or the value that is set for **/ForestLevel**.</p> |
| DomainNetBiosName:"domain_NetBIOS_name" | Assigns a NetBIOS name to the new domain. |
| ForestLevel:{ 0 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 10} | <p>This entry specifies the forest functional level when a new domain is created in a new forest as follows:</br>- 0 = Windows 2000 Server native mode</br>- 2 = Windows Server 2003</br>- 3 = Windows Server 2008</br>- 4 = Windows Server 2008 R2</br>- 5 = Windows Server 2012</br>- 6 = Windows Server 2012 R2</br>- 7 = Windows Server 2016</br>- 10 = Windows Server 2025</br></p><p>The default forest functional level in Windows Server 2008 when you create a new forest is Windows 2000 (0).</p><p>Don't use this parameter when you install a domain controller in an existing forest.</p> |
| InstallDNS:{Yes \| No} | Specifies whether the DNS Server service should be installed. The default is automatically computed based on the environment. This parameter replaces **AutoConfigDNS**. |
| LogPath:"path_to_log_files" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, **C:\Windows\Logs**.</p><p>The default is **%SYSTEMROOT%\NTDS**.</p> |
| NewDomain:{Tree \| Child \| \<Forest>} | <p>Indicates the type of domain that you want to create: a new domain tree in an existing forest, a child of an existing domain, or a new forest.</p><p>The default is new forest. |
| NewDomainDNSName:"DNS_name_of_domain" | Specifies the fully qualified domain name (FQDN) for the new domain. |
| ParentDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of an existing parent domain. You use this parameter when you install a child domain. |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter with the **UserName** parameter.</p><p>Use * to prompt the user to supply a password.</p> |
| PasswordReplicationAllowed:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords can be replicated to this RODC. Use None if you want to keep the value empty. By default, only the Allowed RODC Password Replication Group is allowed, and it's originally created empty. |
| PasswordReplicationDenied:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords aren't to be replicated to this RODC. Use None if you don't want to deny the replication of credentials of any users or computers. By default, Administrators, Server Operators, Backup Operators, Account Operators, and the Denied RODC Password Replication Group are denied. By default, the Denied RODC Password Replication Group includes: <ul><li>Cert Publishers</li><li>Domain Admins</li><li>Enterprise Admins</li><li>Enterprise Domain Controllers</li><li>Enterprise Read-Only Domain Controllers</li><li>Group Policy Creator Owners</li><li>The krbtgt account</li><li>Schema Admins</li></ul> |
| RebootOnCompletion:{\<Yes> \| No} | <p>Specifies whether to restart the computer upon completion of the command, regardless of success.</p><p>The default is **Yes**.</p> |
| RebootOnSuccess:{\<Yes> \| No \| NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion of the command.</p><p>The default is **Yes**.</p> |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install another domain controller. |
| ReplicaOrNewDomain:{\<Replica> \| ReadOnlyReplica \| Domain} | <p>Specifies whether to install another domain controller (a writable domain controller or an RODC) or to create a new domain.</p><p>The default is to install another writable domain controller.</p> |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| ReplicationSourcePath:"replication_source_path" | Indicates the location of the installation media that will be used to install a new domain controller. |
| SafeModeAdminPassword:"password" | <p>Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode.</p><p>The default is an empty password. You must supply a password.</p> |
| SiteName:"site_name" | <p>Specifies the name of an existing site where you can place the new domain controller.</p><p>The default value depends on the type of installation. For a new forest, the default is Default-First-Site-Name. For all other installations, the default is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller.</p> |
| SkipAutoConfigDns | Skips automatic configuration of DNS client settings, forwarders, and root hints. This parameter is in effect only if the DNS Server service is already installed. |
| Syskey:{\<none> \| system key} | <p>Specifies the system key for the media from which you replicate the data.</p><p>The default is **none**.</p> |
| SysVolPath:"path_to_database_file" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer, for example, **C:\Windows\SYSVOL**.</p><p>The default is **%SYSTEMROOT%\SYSVOL**. |
| TransferIMRoleIfNecessary:{Yes \| \<No>} | <p>Specifies whether to transfer the infrastructure master operations master role (also known as flexible single master operations or FSMO) to the domain controller that you're creating. Perform the transfer in case it's currently hosted on a global catalog server and you don't plan to make the domain controller that you're creating a global catalog server. Use **Yes** to transfer the infrastructure master role to the domain controller that you're creating in case the transfer is needed; in this case, make sure to use `/ConfirmGC:No`. Use **No** if you want the infrastructure master role to remain where it currently is.</p><p>The default is **No**.</p> |
| UserDomain:"domain_name" | <p>Specifies the domain name for the user name (account credentials) for installing a domain controller.</p><p>Use this parameter with the **UserName** parameter.</p> |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo /CreateDCAccount operation parameters

The following table shows the parameters that you can use when you create an RODC account.

For more information about creating an RODC account, see [Performing a Staged RODC Installation](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770627(v=ws.10)).

| Parameter and value pair | Description and default |
|---|---|
| <p>PAutoConfigDNS:{Yes \| No}</p><p>This parameter has been renamed to InstallDNS.</p> | Specifies whether the DNS Server service should be installed. The default is computed automatically based on the environment. |
| ConfirmGc:{Yes \| No} | Specifies whether the domain controller will be a global catalog server. |
| DCAccountName:"name of the domain controller to create" | Specifies the name of the RODC account that you're creating. |
| DelegatedAdmin:"name of user or group" | Specifies the name of the user or group that will install and administer the RODC. |
| InstallDNS:{Yes \| No} | Specifies whether the DNS Server service should be installed. The default is computed automatically based on the environment. This parameter replaces **/AutoConfigDNS**. |
| password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter with the **UserName** parameter.</p><p>Specify * to prompt the user to supply a password.</p> |
| PasswordReplicationAllowed:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords can be replicated to this RODC. Use None if you want to keep this value empty. By default, only the Allowed RODC Password Replication Group is allowed, and it's originally created empty. |
| PasswordReplicationDenied:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords aren't to be replicated to this RODC. Use None if you don't want to deny the replication of credentials of any users or computers. By default, Administrators, Server Operators, Backup Operators, Account Operators, and the Denied RODC Password Replication Group are denied. By default, the Denied RODC Password Replication Group includes: <ul><li>Cert Publishers</li><li>Domain Admins</li><li>Enterprise Admins</li><li>Enterprise Domain Controllers</li><li>Enterprise Read-Only Domain Controllers</li><li>Group Policy Creator Owners</li><li>The krbtgt account</li><li>Schema Admins</li></ul> |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install another domain controller. |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| SiteName:"site_name" | <p>Specifies the name of an existing site where you can place the new domain controller.</p><p>The default value depends on the type of installation. For a new forest, the default is Default-First-Site-Name. For all other installations, the default is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller.</p> |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer is used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo /UseExistingAccount operation parameters

You can use parameters in the following list when you attach a server to an RODC account.

For more information about attaching a server to an RODC account, see [Performing a Staged RODC Installation](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770627(v=ws.10)).

| Parameter and value pair | Description and default |
|---|---|
| ApplicationPartitionsToReplicate:"" | <p>Specifies the application directory partitions that dcpromo will replicate. Use the following format:</p><p>"**partition1**" "**partition2**" "**partitionN**"</p><p>Use * to replicate all application directory partitions.</p> |
| CriticalReplicationOnly:{Yes \| \<No>} | <p>Specifies whether the installation performs only critical replication before reboot and then continues, skipping the noncritical (and potentially lengthy) portion of replication. The noncritical replication happens after the role installation finishes and the computer reboots.</p><p>The default is No.</p> |
| DatabasePath:"path_to_database_files" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain database, for example, **C:\Windows\NTDS**.</p><p>The default is **%SYSTEMROOT%\NTDS**.</p> |
| DNSOnNetwork:{\<Yes> \| No} | <p>Specifies whether the DNS Server service is available on the network. This parameter is used only when the IP setting of the network adapter for this computer isn't configured with the name of a DNS server for name resolution. No indicates that DNS server will be installed on this computer for name resolution. Otherwise, the IP settings of network adapter must be configured with a DNS server name first.</p><p>The default is **Yes**.</p> 
| LogPath:"path_to_log_files" |<p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, C:\Windows\Logs.</p><p>The default is **%SYSTEMROOT%\NTDS**.</p> |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter with the **UserName** parameter.</p><p>Use * to prompt the user to supply a password.</p> |
| RebootOnCompletion:{\<Yes> \| No} | <p>Specifies whether to restart the computer upon completion, regardless of success.</p><p>The default is **Yes**.</p> |
| RebootOnSuccess:{\<Yes> \| No \| NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion.</p><p>The default is **Yes**.</p> |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install another domain controller. |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| ReplicationSourcePath:"replication_source_path" | Indicates the location of the installation media that will be used to install a new domain controller. |
| SafeModeAdminPassword:"password" | <p>Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Service Restore Mode.</p><p>The default is an empty password. You must supply a password.</p> |
| SkipAutoConfigDns | Skips automatic configuration of DNS client settings, forwarders, and root hints. This parameter is in effect only if the DNS Server service is already installed. |
| Syskey:{\<none> \| system key} | <p>Specifies the system key for the media from which you replicate the data.</p><p>The default is **none**.</p> |
| SysVolPath:"path_to_database_file" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer, for example, **C:\Windows\SYSVOL**.</p><p>The default is **%SYSTEMROOT%\SYSVOL**.</p> |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer will be used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo Demotion operation parameters

You can use parameters in the following list when you remove AD DS from a domain controller that runs Windows Server.

For more information about removing a domain controller from a domain, see [Removing a Windows Server 2008 Domain Controller from a Domain](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771844(v=ws.10)).

For more information about removing the last domain controller in a domain, see [Removing the Last Windows Server 2008 Domain Controller in a Domain](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771839(v=ws.10)).

For more information about removing the last domain controller in a forest, see [Removing the Last Windows Server 2008 Domain Controller in a Forest](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771835(v=ws.10)).

For more information about forcing the removal of a domain controller, see [Forcing the Removal of a Windows Server 2008 Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731871(v=ws.10)).

| Parameter and value pair | Description and default |
|---|---|
| AdministratorPassword:"administrator password" | Specifies a local administrator account password when AD DS is removed from a domain controller. The default is an empty password. |
| DemoteFSMO:{Yes \| \<No>} | <p>Indicates that (forced) demotion should continue, even if an operations master role is discovered on domain controller from which AD DS is being removed.</p><p>The default is **No**.</p> |
| DNSDelegationPassword {Password \| *} | Specifies the password to use for the user name (the account credentials) when you create or remove the DNS delegation. Specify `*` to prompt the user to enter credentials. |
| DNSDelegationUserName: "user_name" | Specifies the user name to use when you create or remove the DNS delegation. If you don't specify a value, then the account credentials that you specify for the AD DS installation or removal are used to for the DNS delegation. |
| IgnoreIsLastDcInDomainMismatch:{Yes \| \<No>} | <p>Used with `/IsLastDCInDomain`. This parameter specifies whether Dcpromo.exe ignores any inconsistency that it detects with the value that you specify for `/IsLastDCInDomain`. For example, if you specify `/IsLastDCInDomain:Yes` but dcpromo detects that there's actually another active domain controller in the domain, you can specify `/IgnoreIsLastDcInDomainMismatch:Yes` to have dcpromo continue the removal of AD DS from the domain controller despite the inconsistency that it has detected. Similarly, if you specify `/IsLastDCInDomain:No` but dcpromo can't detect that another domain controller is in the domain, you can specify `/IgnoreIsLastDcInDomainMismatch:Yes` to have dcpromo continue to remove AD DS from the domain controller.</p><p>The default is **No**. The default causes the wizard to prompt the user to continue and causes the command-line tool to exit with an error. |
| IgnoreIsLastDNSServerForZone:{Yes \| \<No>} | <p>Specifies whether to continue the removal of AD DS, even when the domain controller is the last DNS server for one or more of the Active Directory-integrated DNS zones that it hosts.</p><p>The default is **No**.</p> |
| IsLastDCInDomain:{Yes \| \<No>} | <p>Specifies whether the computer from which AD DS is being removed is the last domain controller in the domain.</p><p>The default is **No**.</p> |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter with the **UserName** parameter.</p><p>Specify `*` to prompt the user to supply a password.</p> |
| RebootOnCompletion:{\<Yes> \| No} | <p>Specifies whether to restart the computer upon completion, regardless of success.</p><p>The default is **Yes**.</p> |
| RebootOnSuccess:{\<Yes> \| No \| NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion.</p><p>The default is **Yes**.</p> |
| RemoveApplicationPartitions:{Yes \| \<No>} | <p>Specifies whether to remove application partitions during the removal of AD DS from a domain controller.</p><p>The default is **No**.</p> |
| RemoveDNSDelegation:{\<Yes> \| No} | <p>Specifies whether to remove DNS delegations that point to this DNS server from the parent DNS zone.</p><p>The default is **Yes**.</p> |
| RetainDCMetadata:{Yes \| \<No>} | <p>Retains domain controller metadata in the domain after AD DS removal to allow a delegated administrator to remove AD DS from an RODC.</p><p>**The default is No**.</p> |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer will be used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## Examples

The following example supplies an answer file named **NewForestInstallation**:

```cli
dcpromo /answer:NewForestInstallation
```

The following example creates the first domain controller in a new child domain where you expect to install at least some Windows Server 2025 domain controllers:

```cli
dcpromo /unattend /InstallDns:yes /ParentDomainDNSName:contoso.com /replicaOrNewDomain:domain /newDomain:child /newDomainDnsName:east.contoso.com /childName:east /DomainNetbiosName:east /databasePath:"e:\ntds" /logPath:"e:\ntdslogs" /sysvolpath:"g:\sysvol" /safeModeAdminPassword:FH#3573.cK /forestLevel:10 /domainLevel:10 /rebootOnCompletion:yes
```

The following example creates another domain controller with the global catalog, and it installs and configures the DNS Server service:

```cli
dcpromo /unattend /InstallDns:yes /confirmGC:yes /replicaOrNewDomain:replica /databasePath:"e:\ntds" /logPath:"e:\ntdslogs" /sysvolpath:"g:\sysvol" /safeModeAdminPassword:M6$,U8Gvx4 /rebootOnCompletion:yes
```

### Change History

| Date | Revision |
|---|---|
| 10/04/2010 | Removed the DNSDelegation, DNSDelegationUserName, DNSDelegationPassword, and TransferIMRoleIfNecessary parameters from the /UseExistingAccount operation.|
