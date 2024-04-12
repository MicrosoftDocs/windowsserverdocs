---
title: Dcpromo
description: Learn about SMB dialect management in Windows Server Insider builds 
ms.topic: reference
author: gswashington
ms.author: robinharwood
ms.date: 04/20/2024
---

# Dcpromo

Applies To: Windows Server (All supported versions)

The dcpromo command installs and removes Active Directory Domain Services (AD DS).

For examples of how to use **dcpromo**, see [Examples]().

## Syntax

    dcpromo [/answer[:<filename>] | /unattend[:<filename>] | /unattend | /adv] /uninstallBinaries [/CreateDCAccount | /UseExistingAccount:Attach] /? /?[:{Promotion | CreateDCAccount | UseExistingAccount | Demotion}]

## Dcpromo.exe parameters

| Parameter | Description |
|---|---|
| /answer[:<filename>] | Specifies an answer file that contains installation parameters and values. |
| /unattend[:<filename>] | Specifies an answer file that contains installation parameters and values. This command provides the same function as /answer[:<filename>]. |
| /unattend| Specifies an unattended installation in which you provide installation parameters and values at the command line. |
| /adv | Performs an install from media (IFM) operation. |
| /UninstallBinaries | Uninstalls AD DS binaries. |
| /CreateDCAccount | Creates a read-only domain controller (RODC) account. Only a member of the Domain Admins group or the Enterprise Admins group can run this command. |
| /UseExistingAccount:Attach | Attaches a server to an existing RODC account. A member of the Domain Admins group or a delegated user can run this command. |
| /? | Displays Help for Dcpromo parameters. |
| /?[:{Promotion \| CreateDCAccount \| UseExistingAccount \| Demotion}] | Displays parameters that apply to the dcpromo operation. For example, dcpromo /?:Promotion displays all of the parameters that you can use for a promotion operation. |

## dcpromo Promotion operation parameters

The following table shows the parameters that you can specify at a command prompt as part of an unattended installation of a domain controller that runs Windows Server.

For more information about creating a new forest, see [Installing a New Windows Server 2008 Forest](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772464(v=ws.10)).

For more information about creating a new domain, see [Installing a New Windows Server 2008 Child Domain](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731394(v=ws.10))

For more information about creating a new domain tree, see [Installing a New Windows Server 2008 Domain Tree](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733006(v=ws.10)).

For more information about creating an additional domain controller for a domain, see [Installing an Additional Windows Server 2008 Domain Controller](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc733027(v=ws.10)).

| Parameter:value | Description and default |
|---|---|
| AllowDomainControllerReinstall:{Yes \| <No> \| NoAndNoPromptEither} | <p>Specifies whether to continue installing this domain controller, despite the fact that another domain controller account with the same name is detected.</p><p>Use Yes only if you are sure that the account is not currently used by another domain controller.</p><p>The default is <strong>No</strong>.</p> |
| AllowDomainReinstall:{Yes \| <No> \| NoAndNoPromptEither} | <p>Specifies whether an existing domain is recreated.</p><p>The default is <strong>No</strong>.</p> |
| ApplicationPartitionsToReplicate:"" | <p>Specifies the application directory partitions that dcpromo will replicate. Use the following format:</p><p>"<strong>partition1</strong>" "<strong>partition2</strong>" "<strong>partitionN</strong>"</p><p>Use * to replicate all application directory partitions.</p> |
| <p>AutoConfigDNS:{Yes \| No}</p><p>This parameter has been renamed to InstallDNS. | Specifies whether the DNS Server service should be installed. The default is automatically computed based on the environment. |
| ChildName:"child_domain_name" | Specifies the single-label Domain Name System (DNS) name of the child domain. |
| ConfirmGc:{Yes \| No} | Specifies whether you want the domain controller to be a global catalog server. |
| CreateDNSDelegation: { Yes \| No} | <p>Indicates whether to create a DNS delegation that references the new DNS server that you are installing along with the domain controller. Valid for Active Directory–integrated DNS only.</p><p>The default is computed automatically based on the environment.</p> |
| CriticalReplicationOnly:{Yes \| <No>} | <p>Specifies whether the AD DS installation operation performs only critical replication before reboot and then continues, skipping the noncritical (and potentially lengthy) portion of replication. The noncritical replication happens after the installation finishes and the computer reboots.</p><p>The default is <strong>No</strong>.</p> |
| DatabasePath:"path_to_database_files" | <p>Specifies the fully qualified, non–Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database, for example, <strong>C:\Windows\NTDS</strong>.</p><p>The default is <strong>%SYSTEMROOT%\NTDS</strong>.</p> |
| DelegatedAdmin:"name of user or group" | Specifies the name of the user or group that will install and administer the RODC. |
| DNSDelegationPassword:"password" | Specifies the password for the user name (account credentials) for creating DNS delegation. |
| DNSDelegationUserName:"user_name" | Specifies the user name (account credentials) for creating DNS delegation. |
| DNSOnNetwork:{<Yes> \| No} | <p>Specifies whether DNS service is available on the network. This parameter is used only when the IP setting of the network adapter for this computer is not configured with the name of a DNS server for name resolution. No indicates that a DNS server will be installed on this computer for name resolution. Otherwise, the IP settings of the network adapter must be configured with a DNS server name first.</p><p>The default is <strong>Yes</strong>.</p> |
| DomainLevel:{0 \| 2 \| 3 \| 4} | <p>Specifies the domain functional level during the creation of a new domain. A value of 0 specifies Windows 2000. A value of 2 specifies Windows Server 2003. A value of 3 specifies Windows Server 2008. A value of 4 specifies Windows Server 2008 R2.</p><p>The domain functional level cannot be lower than the forest functional level, but it can be higher.</p><p>The default is automatically computed and set to the existing forest functional level or the value that is set for <strong>/ForestLevel</strong>.</p> |
| DomainNetBiosName:"domain_NetBIOS_name" | Assigns a NetBIOS name to the new domain. |
| ForestLevel:{<0> \| <2> \| 3 \| 4} | <p>Specifies the forest functional level when you create a new forest. A value of 0 specifies Windows 2000. A value of 2 specifies Windows Server 2003. A value of 3 specifies Windows Server 2008. A value of 4 specifies Windows Server 2008 R2.</p><p>The default forest functional level in Windows Server 2008 when you create a new forest is Windows 2000 (0).</p><p>The default forest functional level in Windows Server 2008 R2 when you create a new forest is Windows Server 2003 (2).</p><p>Do not use this parameter when you install a domain controller in an existing forest.</p> |
| InstallDNS:{Yes \| No} | Specifies whether the DNS Server service should be installed. The default is automatically computed based on the environment. This parameter replaces <strong>AutoConfigDNS</strong>. |
| LogPath:"path_to_log_files" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, <strong>C:\Windows\Logs</strong>.</p><p>The default is <strong>%SYSTEMROOT%\NTDS</strong>.</p> |
| NewDomain:{Tree \| Child \| <Forest>} | <p>Indicates the type of domain that you want to create: a new domain tree in an existing forest, a child of an existing domain, or a new forest.</p><p>The default is new forest. |
| NewDomainDNSName:"DNS_name_of_domain" | Specifies the fully qualified domain name (FQDN) for the new domain. |
| ParentDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of an existing parent domain. You use this parameter when you install a child domain. |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter in conjunction with the UserName parameter.</p><p>Use * to prompt the user to supply a password.</p> |
| PasswordReplicationAllowed:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords can be replicated to this RODC. Use None if you want to keep the value empty. By default, only the Allowed RODC Password Replication Group is allowed, and it is originally created empty. |
| PasswordReplicationDenied:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords are not to be replicated to this RODC. Use None if you do not want to deny the replication of credentials of any users or computers. By default, Administrators, Server Operators, Backup Operators, Account Operators, and the Denied RODC Password Replication Group are denied. By default, the Denied RODC Password Replication Group includes Cert Publishers, Domain Admins, Enterprise Admins, Enterprise Domain Controllers, Enterprise Read-Only Domain Controllers, Group Policy Creator Owners, the krbtgt account, and Schema Admins. |
| RebootOnCompletion:{<Yes> \| No} | <p>Specifies whether to restart the computer upon completion of the command, regardless of success.</p><p>The default is <strong>Yes</strong>.</p> |
| RebootOnSuccess:{<Yes> \| No \| NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion of the command.</p><p>The default is <strong>Yes</strong>.</p> |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install an additional domain controller. |
| ReplicaOrNewDomain:{<Replica> \| ReadOnlyReplica \| Domain} | <p>Specifies whether to install an additional domain controller (a writable domain controller or an RODC) or to create a new domain.</p><p>The default is to install an additional writable domain controller.</p> |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| ReplicationSourcePath:"replication_source_path" | Indicates the location of the installation media that will be used to install a new domain controller. |
| SafeModeAdminPassword:"password" | <p>Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode.</p><p>The default is an empty password. You must supply a password.</p> |
| SiteName:"site_name" | <p>Specifies the name of an existing site where you can place the new domain controller.</p><p>The default value depends on the type of installation. For a new forest, the default is Default-First-Site-Name. For all other installations, the default is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller.</p> |
| SkipAutoConfigDns | Skips automatic configuration of DNS client settings, forwarders, and root hints. This parameter is in effect only if the DNS Server service is already installed. |
| Syskey:{<none> \| system key} | <p>Specifies the system key for the media from which you replicate the data.</p><p>The default is <strong>none</strong>.</p> |
| SysVolPath:"path_to_database_file" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer, for example, <strong>C:\Windows\SYSVOL</strong>.</p><p>The default is <strong>%SYSTEMROOT%\SYSVOL</strong>. |
| TransferIMRoleIfNecessary:{Yes \| <No>} | <p>Specifies whether to transfer the infrastructure master operations master role (also known as flexible single master operations or FSMO) to the domain controller that you are creating—in case it is currently hosted on a global catalog server—and you do not plan to make the domain controller that you are creating a global catalog server. Use Yes to transfer the infrastructure master role to the domain controller that you are creating in case the transfer is needed; in this case, make sure to use /ConfirmGC:No. Use No if you want the infrastructure master role to remain where it currently is.</p><p>The default is <strong>No</strong>.</p> |
| UserDomain:"domain_name" | <p>Specifies the domain name for the user name (account credentials) for installing a domain controller.</p><p>Use this parameter in conjunction with the UserName parameter.</p> |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo /CreateDCAccount operation parameters

The following table shows the parameters that you can use when you create an RODC account.

For more information about creating an RODC account, see [Performing a Staged RODC Installation](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770627(v=ws.10)).

| Parameter:value | Description and default |
|---|---|
| <p>PAutoConfigDNS:{Yes \| No}</p><p>This parameter has been renamed to InstallDNS.</p> | Specifies whether the DNS Server service should be installed. The default is computed automatically based on the environment. |
| ConfirmGc:{Yes \| No} | Specifies whether the domain controller will be a global catalog server. |
| DCAccountName:"name of the domain controller to create" | Specifies the name of the RODC account that you are creating. |
| DelegatedAdmin:"name of user or group" | Specifies the name of the user or group that will install and administer the RODC. |
| InstallDNS:{Yes \| No} | Specifies whether the DNS Server service should be installed. The default is computed automatically based on the environment. This parameter replaces <strong>/AutoConfigDNS</strong>. |
| password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter in conjunction with the UserName parameter.</p><p>Specify * to prompt the user to supply a password.</p> |
| PasswordReplicationAllowed:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords can be replicated to this RODC. Use None if you want to keep this value empty. By default, only the Allowed RODC Password Replication Group is allowed, and it is originally created empty. |
| PasswordReplicationDenied:{"security_principal" \| None} | Specifies the names of user accounts, group accounts, and computer accounts whose passwords are not to be replicated to this RODC. Use None if you do not want to deny the replication of credentials of any users or computers. By default, Administrators, Server Operators, Backup Operators, Account Operators, and the Denied RODC Password Replication Group are denied. By default, the Denied RODC Password Replication Group includes Cert Publishers, Domain Admins, Enterprise Admins, Enterprise Domain Controllers, Enterprise Read-Only Domain Controllers, Group Policy Creator Owners, the krbtgt account, and Schema Admins. |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install an additional domain controller. |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| SiteName:"site_name" | <p>Specifies the name of an existing site where you can place the new domain controller.</p><p>The default value depends on the type of installation. For a new forest, the default is Default-First-Site-Name. For all other installations, the default is the site that is associated with the subnet that includes the IP address of this server. If no such site exists, the default is the site of the replication source domain controller.</p> |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer is used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo /UseExistingAccount operation parameters

You can use parameters in the following list when you attach a server to an RODC account.

For more information about attaching a server to an RODC account, see [Performing a Staged RODC Installation](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770627(v=ws.10)).

| Parameter:value | Description and default |
|---|---|
| ApplicationPartitionsToReplicate:"" | <p>Specifies the application directory partitions that dcpromo will replicate. Use the following format:</p><p>"<strong>partition1</strong>" "<strong>partition2</strong>" "<strong>partitionN</strong>"</p><p>Use * to replicate all application directory partitions.</p> |
| CriticalReplicationOnly:{Yes \| <No>} | <p>Specifies whether the installation performs only critical replication before reboot and then continues, skipping the noncritical (and potentially lengthy) portion of replication. The noncritical replication happens after the role installation finishes and the computer reboots.</p><p>The default is No.</p> |
| DatabasePath:"path_to_database_files" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain database, for example, <strong>C:\Windows\NTDS</strong>.</p><p>The default is <strong>%SYSTEMROOT%\NTDS</strong>.</p> |
|  |  |
|  |  |
|  |  |
| DNSOnNetwork:{<Yes> \| No} | <p>Specifies whether the DNS Server service is available on the network. This parameter is used only when the IP setting of the network adapter for this computer is not configured with the name of a DNS server for name resolution. No indicates that DNS server will be installed on this computer for name resolution. Otherwise, the IP settings of network adapter must be configured with a DNS server name first.</p><p>The default is <strong>Yes</strong>.</p> 
| LogPath:"path_to_log_files" |<p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, C:\Windows\Logs.</p><p>The default is <strong>%SYSTEMROOT%\NTDS</strong>.</p> |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter in conjunction with the <strong>UserName</strong> parameter.</p><p>Use * to prompt the user to supply a password.</p> |
| RebootOnCompletion:{<Yes> \| No} | <p>Specifies whether to restart the computer upon completion, regardless of success.</p><p>The default is <strong>Yes</strong>.</p> |
| RebootOnSuccess:{<Yes> \| No | NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion.</p><p>The default is <strong>Yes</strong>.</p> |
| ReplicaDomainDNSName:"DNS_name_of_domain" | Specifies the FQDN of the domain in which you want to install an additional domain controller. |
| ReplicationSourceDC:"DNS_name_of_DC" | Indicates the FQDN of the partner domain controller from which you replicate the domain information. |
| ReplicationSourcePath:"replication_source_path" | Indicates the location of the installation media that will be used to install a new domain controller. |
| SafeModeAdminPassword:"password" | <p>Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Service Restore Mode.</p><p>The default is an empty password. You must supply a password.</p> |
| SkipAutoConfigDns | Skips automatic configuration of DNS client settings, forwarders, and root hints. This parameter is in effect only if the DNS Server service is already installed. |
| Syskey:{<none> \| system key} | <p>Specifies the system key for the media from which you replicate the data.</p><p>The default is <strong>none</strong>.</p> |
| SysVolPath:"path_to_database_file" | <p>Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer, for example, <strong>C:\Windows\SYSVOL</strong>.</p><p>The default is <strong>%SYSTEMROOT%\SYSVOL</strong>.</p> |
|  |  |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer will be used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## dcpromo Demotion operation parameters

You can use parameters in the following list when you remove AD Ds from a domain controller that runs Windows Server.

For more information about removing a domain controller from a domain, see [Removing a Windows Server 2008 Domain Controller from a Domain](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771844(v=ws.10)).

For more information about removing the last domain controller in a domain, see [Removing the Last Windows Server 2008 Domain Controller in a Domain](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771839(v=ws.10)).

For more information about removing the last domain controller in a forest, see [Removing the Last Windows Server 2008 Domain Controller in a Forest](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771835(v=ws.10)).

For more information about forcing the removal of a domain controller, see [Forcing the Removal of a Windows Server 2008 Domain Controller](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731871(v=ws.10)).

| Parameter:value | Description and default |
|---|---|
| AdministratorPassword:"administrator password" | Specifies a local administrator account password when AD DS is removed from a domain controller. The default is an empty password. |
| DemoteFSMO:{Yes \| <No>} | <p>Indicates that (forced) demotion should continue even if an operations master role is discovered on domain controller from which AD DS is being removed.</p><p>The default is <strong>No</strong>.</p> |
| DNSDelegationPassword {Password \| *} | Specifies the password to use for the user name (the account credentials) when you create or remove the DNS delegation. Specify * to prompt the user to enter credentials. |
| DNSDelegationUserName: "user_name" | Specifies the user name to use when you create or remove the DNS delegation. If you do not specify a value, then the account credentials that you specify for the AD DS installation or removal are used to for the DNS delegation. |
| IgnoreIsLastDcInDomainMismatch:{Yes \| <No>} | <p>Used in conjunction with /IsLastDCInDomain. This parameter specifies whether Dcpromo.exe ignores any inconsistency that it detects with the value that you specify for /IsLastDCInDomain. For example, if you specify /IsLastDCInDomain:Yes but dcpromo detects that there is actually another active domain controller in the domain, you can specify /IgnoreIsLastDcInDomainMismatch:Yes to have dcpromo continue the removal of AD DS from the domain controller despite the inconsistency that it has detected. Similarly, if you specify /IsLastDCInDomain:No but dcpromo cannot detect that another domain controller is in the domain, you can specify /IgnoreIsLastDcInDomainMismatch:Yes to have dcpromo continue to remove AD DS from the domain controller.</p><p>The default is <strong>No</strong>. The default causes the wizard to prompt the user to continue and causes the command-line tool to exit with an error. |
| IgnoreIsLastDNSServerForZone:{Yes \| <No>} | <p>Specifies whether to continue the removal of AD DS despite the fact that the domain controller is the last DNS server for one or more of the Active Directory–integrated DNS zones that it hosts.</p><p>The default is <strong>No</strong>.</p> |
| IsLastDCInDomain:{Yes \| <No>} | <p>Specifies whether the computer from which AD DS is being removed is the last domain controller in the domain.</p><p>The default is <strong>No</strong>.</p> |
| Password:"password" | <p>Specifies the password that corresponds to the user name (account credentials) that is used to install the domain controller. Use this parameter in conjunction with the UserName parameter.</p><p>Specify * to prompt the user to supply a password.</p> |
| RebootOnCompletion:{<Yes> \| No} | <p>Specifies whether to restart the computer upon completion, regardless of success.</p><p>The default is <strong>Yes</strong>.</p> |
| RebootOnSuccess:{<Yes> \| No \| NoAndNoPromptEither} | <p>Specifies whether to restart the computer upon successful completion.</p><p>The default is <strong>Yes</strong>.</p> |
| RemoveApplicationPartitions:{Yes \| <No>} | <p>Specifies whether to remove application partitions during the removal of AD DS from a domain controller.</p><p>The default is <strong>No</strong>.</p> |
| RemoveDNSDelegation:{<Yes> \| No} | <p>Specifies whether to remove DNS delegations that point to this DNS server from the parent DNS zone.</p><p>The default is <strong>Yes</strong>.</p> |
| RetainDCMetadata:{Yes \| <No>} | <p>Retains domain controller metadata in the domain after AD DS removal to allow a delegated administrator to remove AD DS from an RODC.</p><p><strong>The default is No</strong>.</p> |
| UserDomain:"domain_name" | Specifies the domain name for the user name (account credentials) for the operation. This parameter also helps to specify the forest where you plan to install the domain controller or create an RODC account. If no value is specified, the domain of the computer will be used. |
| UserName:"user_name" | Specifies the user name (account credentials) for the operation. If no value is specified, the credentials of the current user are used for the operation. |

## Examples

The following example supplies an answer file named **NewForestInstallation**:

    dcpromo /answer:NewForestInstallation

The following example creates the first domain controller in a new child domain where you expect to install at least some Windows Server 2003 domain controllers:

    dcpromo /unattend /InstallDns:yes /ParentDomainDNSName:contoso.com /replicaOrNewDomain:domain /newDomain:child /newDomainDnsName:east.contoso.com /childName:east /DomainNetbiosName:east /databasePath:"e:\ntds" /logPath:"e:\ntdslogs" /sysvolpath:"g:\sysvol" /safeModeAdminPassword:FH#3573.cK /forestLevel:2 /domainLevel:2 /rebootOnCompletion:yes

The following example creates an additional domain controller with the global catalog, and it installs and configures the DNS Server service:

    dcpromo /unattend /InstallDns:yes /confirmGC:yes /replicaOrNewDomain:replica /databasePath:"e:\ntds" /logPath:"e:\ntdslogs" /sysvolpath:"g:\sysvol" /safeModeAdminPassword:M6$,U8Gvx4 /rebootOnCompletion:yes

### Change History

| Date | Revision |
|---|---|
| 10/04/2010 | Removed the DNSDelegation, DNSDelegationUserName, DNSDelegationPassword, and TransferIMRoleIfNecessary parameters from the /UseExistingAccount operation.|
