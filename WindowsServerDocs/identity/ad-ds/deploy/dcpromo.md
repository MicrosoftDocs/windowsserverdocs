---
description: An overview of the syntax and structure of DCPROMO answer files.
title: DCPROMO answer file syntax
ms.author: daknappe
author: dknappettmsft
ms.date: 04/25/2024
ms.topic: reference
ms.custom: sfi-ropc-nochange
---

# DCPROMO answer file syntax

This article describes the parameters and options that the dcpromo answer file uses to install and remove Active Directory Domain Services (AD DS) on domain controllers. You can use this information to build answer files to perform unattended installations of AD DS on domain controllers. You can also use the answer files to remove AD DS in unattended mode.

## DCPROMO summary

Dcpromo.exe is a program you can use to promote and demote Active Directory domain controllers. Administrators can use dcpromo answer files to do the following unattended tasks:

- Promote workgroup and member servers to Active Directory domain controllers.
- Upgrade Microsoft Windows NT 4.0 domain controllers to Active Directory domain controllers.
- Demote domain controllers.

Windows Server 2000 and later support the dcpromo answer file syntax. However, while Windows Server 2012 and later still support the dcpromo answer file syntax, they replaced dcpromo.exe with PowerShell cmdlets. For more information, see the [Active Directory PowerShell module reference](/powershell/module/activedirectory/).

## Basic syntax

The dcpromo answer file is an ASCII text file that provides automated user input for each page of the Active Directory Domain Services Configuration Wizard.

To start `dcpromo` in unattended mode, go to **Start**, enter **dcpromo**, then run the following command in an elevated command prompt window:

```cmd
dcpromo /answer:<answer.txt>
```

> [!NOTE]  
> In this example command, `<answer.txt>` is a placeholder for the path and file name of the answer file that you plan to use for demotion or promotion.

Each dcpromo operation requires answers to specific fields in the [DCInstall] section of the answer file. The following list provides the required fields for each operation. The default values are used if the option is not specified. The default values for these fields are described in [Field Definitions](#field-definitions).

- For new forest installations, the following options apply:

    ```txt
    [DCINSTALL]
    InstallDNS=yes  
    NewDomain=forest  
    NewDomainDNSName=\<The fully qualified Domain Name System (DNS) name>  
    DomainNetBiosName=\<By default, the first label of the fully qualified DNS name>  
    SiteName=\<Default-First-Site-Name>  
    ReplicaOrNewDomain=domain  
    ForestLevel=\<The forest functional level number>  
    DomainLevel=\<The domain functional level number>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    RebootOnCompletion=yes  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    ```

- For child domain installations, the following options apply:

    ```txt
    [DCINSTALL]  
    ParentDomainDNSName=\<Fully qualified DNS name of parent domain>  
    UserName=\<The administrative account in the parent domain>  
    UserDomain=\<The name of the domain of the user account>  
    Password=\<The password for the user account> Specify * to prompt the user for credentials during the installation.  
    NewDomain=child  

    ChildName=\<The single-label DNS name of the new domain>  
    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  
    DomainNetBiosName=\<The first label of the fully qualified DNS name>  
    ReplicaOrNewDomain=domain  
    DomainLevel=\<The domain functional level number> This value can't be less than the current value of the forest functional level.  

    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  

    CreateDNSDelegation=yes  
    DNSDelegationUserName= \<The account that has permissions to create a DNS delegation> The account that is being used to install AD DS may differ from the account in the parent domain that has the permissions that are required to create a DNS delegation. In this case, specify the account that can create the DNS delegation for this parameter. Specify \* to prompt the user for credentials during the installation.  
    DNSDelegationPassword= \<The password for the account that is specified for DNSDelegationUserName> Specify * to prompt the user for a password during the installation.  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes 
    ```

- For a new tree in existing forest installations, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The name of the domain of the user account>  
    Password=\<The password for the adminstrative account> Specify \* to prompt the user for credentials during the installation.  
    NewDomain=tree  
    NewDomainDNSName=\<The fully qualified DNS name of the new domain>  
    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  
    DomainNetBiosName=\<The first label of the fully qualified DNS name>  
    ReplicaOrNewDomain=domain  
    DomainLevel=\<The domain functional level number>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  
    CreateDNSDelegation=yes  
    DNSDelegationUserName= \<The account that has permissions to create a DNS delegation> The account that is being used to install AD DS may differ from the account in the parent domain that has the permissions that are required to create a DNS delegation. In this case, specify the account that can create the DNS delegation for this parameter. Specify \* to prompt the user for credentials during the installation.  
    DNSDelegationPassword=\<The password for the account that is specified for DNSDelegationUserName> Specify * to prompt the user for a password during the installation.  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  
    ```

- For additional domain controller installations, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  
    UserDomain=\<The name of the domain of the new domain controller>  
    Password=\<The password for the UserName account>  
    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  
    ReplicaOrNewDomain=replica  
    ReplicaDomainDNSName=\<The fully qualified domain name (FQDN) of the domain in which you want to add an additional domain controller>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  
    ConfirmGC=yes  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  
    ```

- For additional domain controller installations that use the Install From Media (IFM) method, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  
    Password=\<The password for the UserName account>  
    UserDomain=\<The name of the domain of the UserName account>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    SafeModeAdminPassword=\<The password of an offline administrator account>  

    CriticalReplicationOnly=no  
    SiteName=\<The name of the AD DS site in which this domain controller will reside>  
    This site must be created in advance in the Dssites.msc snap-in.  

    ReplicaOrNewDomain=replica  
    ReplicaDomainDNSName=\<The fully qualified domain name (FQDN) of the domain in which you want to add an additional domain controller>  
    ReplicationSourceDC=\<An existing domain controller in the domain>  

    ReplicationSourcePath=\<The local drive and the path of the backup>  

    RebootOnCompletion=yes 
    ``` 

- For read-only domain controller (RODC) installations, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  
    UserDomain=\<The name of the domain of the user account>  
    PasswordReplicationDenied=\<The names of the user, group, and computer accounts whose passwords are not to be replicated to this RODC>  
    PasswordReplicationAllowed =\<The names of the user, group, and computer accounts whose passwords can be replicated to this RODC>  
    DelegatedAdmin=\<The user or group account name that will install and administer the RODC>  
    SiteName=Default-First-Site-Name  
    CreateDNSDelegation=no  
    CriticalReplicationOnly=yes  

    Password=\<The password for the UserName account>  
    ReplicaOrNewDomain=ReadOnlyReplica  
    ReplicaDomainDNSName=\<The FQDN of the domain in which you want to add an additional domain controller>  
    DatabasePath= "\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  
    ConfirmGC=yes  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  
    ```

- For removal of AD DS, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<An administrative account in the domain>  
    UserDomain=\<The domain name of the administrative account>  
    Password=\<The password for the UserName account>  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=yes  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNSDelegationUserName account>  
    RebootOnCompletion=yes  
    ```

- For removal of AD DS from the last domain controller in a domain, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The domain name of the UserName account>  
    Password=\<The password for the UserName account> Specify * to prompt the user for credentials during the installation.  
    IsLastDCInDomain=yes  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=If you want to remove the partitions, specify "yes" (no quotation marks) for this entry. If you want to keep the partitions, this entry is optional.  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNS server administrative account>  
    RebootOnCompletion=yes  
    ```

- For removal of the last domain controller in a forest, the following options apply:

    ```txt
    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The domain name of the UserName account>  
    Password=\<The password for the UserName account> Specify * to prompt the user for credentials during the installation.  
    IsLastDCInDomain=yes  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=If you want to remove the partitions, specify "yes" (no quotation marks) for this entry. If you want to keep the partitions, this entry is optional.  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNS server administrative account>  
    RebootOnCompletion=yes  
    ```

### Field definitions

This section describes the fields and the entries that you can use in the answer file.

#### Installation operation parameters

| Parameter | Default value | Description |
|-----|------|-----|
| AllowDomainReinstall | Yes \| No | This entry specifies whether an existing domain is a recreated one. |
| AllowDomainControllerReinstall | Yes \| No | This entry specifies whether to continue to install this domain controller even though the service detects an active domain controller account that uses the same name. Specify **Yes** only if you're sure that the existing account is no longer active. |
| ApplicationPartitionsToReplicate | No default | This entry specifies the application partitions that have to be replicated in the format `"partition1 partition2"`. If you specify \*, the service replicates all application partitions. Use space-separated or comma-and-space-separated distinguished names. Enclose the whole string in quotation marks. |
| ChildName | No default | This is the name of the subordinate domain appended to the ParentDomainDNSName entry. If the parent domain is A.COM and the subordinate domain is B, enter `B.A.COM and B` for ChildName. |
| ConfirmGc | Yes \| No | This entry specifies whether the replica is also a global catalog. Yes makes the replica a global catalog if the backup was a global catalog. No doesn't make the replica a global catalog. These entries don't require quotation marks. |
| CreateDNSDelegation | Yes \| No, no default | This entry indicates whether to create a DNS delegation that references this new DNS server. This entry is valid for AD DS-integrated DNS only. |
| CriticalReplicationOnly | Yes \| No | This entry specifies whether the installation operation performs only important replication before a restart, then skips the noncritical parts of replication to save time. The noncritical replication occurs after the role installation is complete, and the computer restarts. |
| DatabasePath | `%systemroot%\\NTDS` | This entry is the path of the fully qualified, non-Universal Naming Convention (UNC) directory on a hard disk of the local computer. This directory hosts the AD DS database (NTDS.DIT). If the directory exists, it must be empty. If it doesn't exist, this entry creates it. Free disk space on the logical drive you select to store the directory must be 200 MB. To accommodate rounding errors or all objects in the domain, free disk space may have to be larger. For best performance, locate the directory on a dedicated hard disk. |
| DelegatedAdmin | No default | This entry specifies the name of the user or group who installs and administers the RODC. If there's no specified value, only members of the Domain Admins group or the Enterprise Admins group can install and administer the RODC. |
| DNSDelegationPassword | \<Password> \| \*, no default | This entry specifies the password for the user account that creates or removes the DNS delegation. Specify \* to prompt the user to enter credentials. |
| DNSDelegationUserName | No default | This entry specifies the user name the service uses when it creates or removes the DNS delegation. If you don't specify a value, the service uses the account credentials that you specify for the installation or removal of AD DS for the DNS delegation. |
| DNSOnNetwork | Yes \| No | This entry specifies whether the DNS service is available on the network. The service only uses this entry when the network adapter for this computer isn't configured to use the name of a DNS server for name resolution. Specify No to indicate that DNS is installed on this computer for name resolution. Otherwise, you must configure the network adapter to use a DNS server name first. |
| DomainLevel | 0 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 10, no default | This entry specifies the domain functional level. This entry is based on the levels that exist in the forest when a new domain is created in an existing forest. Value descriptions are as follows: </br>- 0 = Windows 2000 Server native mode</br>- 2 = Windows Server 2003</br>- 3 = Windows Server 2008</br>- 4 = Windows Server 2008 R2</br>- 5 = Windows Server 2012</br>- 6 = Windows Server 2012 R2</br>- 7 = Windows Server 2016</br>- 10 = Windows Server 2025  |
| DomainNetbiosName | No default | This entry is the NetBIOS name that is used by pre-AD DS clients to access the domain. The DomainNetbiosName must be unique on the network. |
| ForestLevel | 0 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 10 | This entry specifies the forest functional level when a new domain is created in a new forest as follows:</br>- 0 = Windows 2000 Server native mode</br>- 2 = Windows Server 2003</br>- 3 = Windows Server 2008</br>- 4 = Windows Server 2008 R2</br>- 5 = Windows Server 2012</br>- 6 = Windows Server 2012 R2</br>- 7 = Windows Server 2016</br>- 10 = Windows Server 2025</br>You must not use this entry when you install a new domain controller in an existing forest. The ForestLevel entry replaces the SetForestVersion entry that is available in Windows Server 2003. |
| InstallDNS | Yes \| No, default value changes depending on the operation<sup>1</sup>. | This entry specifies whether the service configures DNS for a new domain if the Active Directory Domain Services Installation Wizard detects that the DNS dynamic update protocol isn't available. This entry also applies if the wizard detects an insufficient number of DNS servers for an existing domain. |
| LogPath | `%systemroot%\\NTDS` | This is the path of the fully qualified, non-UNC directory on a hard disk on the local computer that hosts the AD DS log files. If the directory exists, it must be empty. If it doesn't exist, the service will create it. |
| NewDomain | Tree \| Child \| Forest | Tree means the new domain is the root of a new tree in an existing forest. Child means the new domain is a child of an existing domain. Forest means the new domain is the first domain in a new forest of domain trees. |
| NewDomainDNSName | No default | This entry is used in "new tree in existing forest" or "new forest" installations. The value is an unused DNS domain. |
| ParentDomainDNSName | No default | This entry specifies the name of an existing parent DNS domain for a child domain installation. |
| Password | \<Password> \| \*, no default | This entry specifies the password that corresponds to the user account that configures the domain controller. Specify \* to prompt the user to enter credentials. For protection, passwords are removed from the answer file following an installation. Passwords must be redefined every time a user uses the answer file. |
| PasswordReplicationAllowed | \<Security_Principal> \| NONE, no default | This entry specifies the names of computer accounts and user accounts whose passwords can be replicated to this RODC. Specify NONE if you want to keep the value empty. By default, no user credentials will be cached on this RODC. To specify more than one security principal, add the entry multiple times. |
| PasswordReplicationDenied | \<Security_Principal> \| NONE | This entry specifies the names of the user, group, and computer accounts whose passwords aren't to be replicated to the RODC. Specify NONE if you don't want to deny the replication of credentials for any users or computers. To specify more than one security principal, add the entry multiple times. |
| RebootOnCompletion | Yes \| No | This entry specifies whether to restart the computer after you install or remove AD DS regardless of whether the operation succeeded. |
| RebootOnSuccess | Yes \| No \| NoAndNoPromptEither | This entry specifies whether the computer must be restarted after AD DS has been installed or removed successfully. A restart is always required to complete a change in an AD DS role. |
| ReplicaDomainDNSName | No default | This entry specifies the FQDN of the domain in which you want to configure an additional domain controller. |
| ReplicaOrNewDomain | Replica \| ReadOnlyReplica \| Domain | This entry is used only for new installations. Domain converts the server into the first domain controller of a new domain. ReadOnlyReplica converts the server into a RODC. Replica converts the server into an additional domain controller. |
| ReplicationSourceDC | No default | This entry specifies the FQDN of the partner domain controller you replicate the AD DS data from to create the new domain controller. |
| ReplicationSourcePath | No default | This entry specifies the location of the installation files you use to create a new domain controller. |
| SafeModeAdminPassword | \<Password> \| NONE, no default | This entry supplies the password for the offline administrator account used for Directory Service Restore Mode. You can't specify an empty password. |
| SiteName | Default-First-Site-Name | This entry specifies the site name when you install a new forest. For a new forest, the default is `Default-First-Site-Name`. For all other scenarios, the service selects the site using the current site and the subnet configuration of the forest. |
| SkipAutoConfigDNS | No default | This entry is for expert users who want to skip automatic configuration of client settings, forwarders, and root hints. The entry is only in effect if the DNS Server service is already installed on the server. In this case, you receive a notification that confirms the service skipped automatic configuration for DNS. Otherwise, the service ignores this entry. If you specify this switch, make sure you created and configured the zones correctly before you install AD DS, or the domain controller won't operate as intended. This entry doesn't skip automatic creation of the DNS delegation in the parent DNS zone. To control DNS delegation creation, use the DNSDelegation entry. |
| Syskey | \<system_key> \| NONE | This entry specifies the system key for the media from which you replicate the data. |
| SYSVOLPath | `%systemroot%\\SYSVOL` | This entry specifies a fully qualified, non-UNC directory on the hard disk of the local computer. This directory will host the AD DS log files. If the directory already exists, it must be empty. If it doesn't already exist, the service creates it. The directory must be located on a partition that was formatted using the NTFS 5.0 file system. For best performance, locate the directory on a different physical hard disk than the operating system. |
| TransferIMRoleIfNeeded | Yes \| No | This entry specifies whether to transfer the infrastructure master role to this domain controller. This entry is useful if the domain controller is currently hosted on a global catalog server and you don't plan to make the domain controller a global catalog server. Specify Yes to transfer the infrastructure master role to this domain controller. If you specify Yes, make sure to also specify the ConfirmGC=No entry. |
| UserDomain | No default | This entry specifies the domain name for the user account you plan to use to install AD DS on a server. |
| UserName | No default | This entry specifies the user account name that is used for installing AD DS on a server. We recommend that you specify the account credentials in the `\<domain>\\<user_name>` format. |

>[!NOTE]
><sup>1</sup> For a new forest, the DNS server role is installed by default. For a new tree, a new child domain, or a replica, a DNS server is installed by default if an existing DNS infrastructure is detected by the Active Directory Domain Services Installation Wizard. If no existing DNS infrastructure is detected by the wizard, a DNS server isn't installed by default.

#### Removal operation parameters

| Parameter | Default value | Description |
|-----|------|-----|
| AdministratorPassword | No default | This entry is used to specify the local administrator password when you remove AD DS from a domain controller. |
| DemoteFSMO | Yes \| No | This entry indicates whether a forced removal happens even if the domain controller holds an operations master role. |
| DNSDelegationPassword | \<Password> \| \*, no default | This entry specifies the password for the user account you plan to use to create or to remove the DNS delegation. Specify \* to prompt the user to enter credentials. |
| DNSDelegationUserName | No default | This entry specifies the user name you plan to use when creating or removing DNS delegation. If you don't specify a value, the service uses the account credentials that you specify for the AD DS installation or for the AD DS removal for the DNS delegation. |
| IgnoreIsLastDcInDomainMismatch | Yes \| No | This entry specifies whether to continue the removal of AD DS from the domain controller when you either specify the IsLastDCInDomain=Yes entry or the Active Directory Domain Services Installation Wizard detects that there's another active domain controller in the domain. This entry also applies to a scenario in which you specify the IsLastDCInDomain=No entry and the wizard can't contact any other domain controller in the domain. |
| IgnoreIsLastDNSServerForZone | Yes \| No | This entry specifies whether to continue removing AD DS even though the domain controller is the last DNS server for one or more AD DS-integrated DNS zones that the domain controller hosts. |
| IsLastDCInDomain | Yes \| No | This entry specifies whether the domain controller from which you remove AD DS is the last domain controller in the domain. |
| Password | \<Password> \| \*, no default | This entry specifies the password that corresponds to the user account that you plan to use to configure the domain controller. Specify \* to prompt the user to enter credentials. For protection, the service removes passwords from the answer file after you install AD DS. Passwords must be redefined every time someone uses an answer file. |
| RebootOnCompletion | Yes \| No | This entry specifies whether to restart the computer after you install or remove AD DS regardless of whether the operation succeeded. |
| RebootOnSuccess | Yes \| No \| NoAndNoPromptEither | Determines whether the user must restart the computer after successfully installing or removing AD DS. A restart is always required to complete a change in an AD DS role. |
| RemoveApplicationPartitions | Yes \| No | This entry specifies whether to remove application partitions when you remove AD DS from a domain controller. Specifying Yes removes application partitions on the domain controller. Specifying No doesn't remove application partitions on the domain controller. If the domain controller hosts the last replica of any application directory partition, you must manually confirm that you need to remove these partitions. |
| RemoveDNSDelegation | Yes \| No | This entry specifies whether to remove DNS delegations that point to this DNS server from the parent DNS zone. |
| RetainDCMetadata | Yes \| No | This entry specifies whether domain controller metadata is retained in the domain after AD DS removal so that a delegated administrator can remove AD DS from an RODC. |
| UserDomain | No default | This entry specifies the domain name for the user account that you plan to use to install AD DS. |
| UserName | No default | This entry specifies the user account name that you plan to use to install AD DS on a server. We recommend that you specify the account credentials in the `\<domain>\\<user_name>` format. |

### Unattended installation return codes

The Active Directory Domain Services Installation Wizard returns either a success or failure code after you complete the unattended installation of a Windows Server 2008-based domain controller. For more information about the unattended installation return codes, see [Unattended Installation Return Codes](https://technet.microsoft.com/library/cc754937%28ws.10%29.aspx).

## Related content

- [AD DS Deployment](AD-DS-Deployment.md)

- [Demoting Domain Controllers](Demoting-Domain-Controllers-and-Domains--Level-200-.md)
