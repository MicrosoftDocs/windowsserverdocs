---
title: Setspn
description: The setspn command reads, modifies, and deletes the Service Principal Names (SPN) directory property for an Active Directory service account.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 03/24/2025
---

# setspn

The `setspn` command line utility reads, modifies, and deletes the Service Principal Names (SPN) directory property for an Active Directory (AD) service account. You use SPNs to locate a target principal name for running a service. You can use `setspn` to view the current SPNs, reset the account's default SPNs, and add or delete supplemental SPNs. `Setspn` is available if you have the Active Directory Domain Services (AD DS) server role installed. `Setspn` must be ran through an elevated command prompt.

## Syntax

```
setspn <modifiers switch> <accountname> [-R] [-S] [-D] [-L] [-C] [-U] [-Q] [-X] [-P] [-F] [-T] [-?] [/?]
```

> [!NOTE]
> The \<accountname> can be the computer name or domain\\name of the target computer or a user account. You can run `setspn -A` to add SPNs, but you should use `setspn -S` instead because it verifies that there are no duplicate SPNs.

## Parameters

| Parameters | Description |
|--|--|
| `<accountname>` | Specifies the desired AD account object for which to configure the SPN. Normally, the SPN is the NetBIOS name of the computer and optionally the domain that contains the computer account. However, any desired AD object name can be used. |
| `-R` | Resets the default SPN registrations for the host names for the computer. |
| `-S` | Adds the specified SPN for the computer, after verifying that no duplicates exist. |
| `-D` | Deletes the specified SPN for the computer. |
| `-L` | Lists the currently registered SPN for the computer. |
| `-C` | Specifies that `accountname` is a computer account. |
| `-U` | Specifies that `accountname` is a user account. |
| `-Q` | Queries for any existing SPNs. |
| `-X` | Performs a search of duplicate SPNs. |
| `-P` | Suppresses progress to the console and can be used when redirecting output to a file or when used in an unattended script. No output is displayed until the command is complete. |
| `-F` | Performs queries at the forest, rather than domain level. |
| `-T` | Performs a query on the specified domain (or forest when `-F` is used). |
| `-?` or <br>`/?` | Displays the command-line help information. If you run `setspn` without this parameter, it also displays the command-line help information. |

> [!NOTE]
> `-C` and `-U` are exclusive. If neither is specified, the tool interprets `accountname` as a computer name if such a computer exists, and a user name if it doesn't.

## Remarks

Query Mode modifiers can be used with the `-S` switch in order to specify where the check for duplicates should be performed before adding the SPN.

- `-T` can be specified multiple times. To indicate the current domain or a forest, use `""` or `*`.

- `-Q` executes on each target domain or forest.

- `-X` returns duplicates that exist across all targets. SPNs aren't required to be unique across forests, but duplicate SPNs can cause authentication issues during cross-forest authentication.

- SPNs must be constructed using the base name of the account specified as the _accountname_ parameter. If this condition isn't met, the directory service returns a constraint violation error.

You might not have the rights to access or modify this property on some account objects. You can determine what your access rights are by viewing the security attributes of the account object using the Microsoft Management Console (MMC) in Active Directory Users and Computers. You can also delegate the permission by assigning the Validated write to service principal name permission to the desired user or group.

The built-in SPNs that are recognized for computer accounts are:

```
alerter         eventlog        netlogon             rpc            snmp
appmgmt         eventsystem     netman               rpclocator     spooler
browser         fax             nmagent              rpcss          tapisrv
cifs            http            oakley               rsvp           time
cisvc           ias             plugplay             samss          trksvr
clipsrv         iisadmin        policyagent          scardsvr       trkwks
dcom            messenger       protectedstorage     scesrv         ups
dhcp            msiserver       rasman               schedule       w3svc
dmserver        mcsvc           remoteaccess         scm            wins
dns             netdde          replicator           seclogon       www
dnscache        netddedsm
```

These SPNs are recognized for computer accounts if the computer has a host SPN. Unless they're explicitly placed on objects, a host SPN can substitute for any of the mentioned SPNs.

SPNs aren't case sensitive when used by Microsoft Windows-based computers. Any type of computer system can use an SPN. Many of these computer systems, especially UNIX-based systems, are case-sensitive, and require the proper case to function properly. Care should be taken to use the proper case particularly when an SPN is used by a non-Windows-based computer.

## Examples

To list all the registered SPNs for an account, type:

```cmd
setspn -L <accountname>
```

To reset the SPNs for a computer account, type:

```cmd
setspn -R <accountname>
```

To register the SPN _http/MyServer_ for user account _User01_, type:

```
setspn -U -S http/MyServer User01
```

To add a new SPN to a domain account that doesn't have one set, type:

```cmd
setspn -S http/myserver.mydomain.com myDomain\myServer
```

To remove an SPN from an account, type:

```cmd
setspn -D http/myserver.mydomain.com myDomain\myServer
```

To query all duplicate SPNs in your domain and the _contoso_ domain, type:

```
setspn -T * -T contoso -X
```

To find all the SPNs associated with _MyServer_ registered in the _contoso_ domain forest, type:

```
setspn -T contoso -F -Q */MyServer
```

## See also

- [Command-Line Syntax Key](/windows-server/administration/windows-commands/command-line-syntax-key)

- [How to configure SPN](/windows-server/identity/ad-ds/manage/how-to-configure-spn)
