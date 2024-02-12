---
title: ksetup
description: Reference article for the ksetup command, which performs tasks related to setting up and maintaining Kerberos protocol and the Key Distribution Center (KDC) to support Kerberos realms.
ms.topic: reference
ms.assetid: 4e046f8a-811b-48dc-9a69-18d8e097f353
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup

Performs tasks related to setting up and maintaining Kerberos protocol and the Key Distribution Center (KDC) to support Kerberos realms. Specifically, this command is used to:

- Change the computer settings for locating Kerberos realms. In non-Microsoft, Kerberos–based implementations, this information is usually kept in the Krb5.conf file. In Windows Server operating systems, it's kept in the registry. You can use this tool to modify these settings. These settings are used by workstations to locate Kerberos realms and by domain controllers to locate Kerberos realms for cross-realm trust relationships.

- Initialize registry keys that the Kerberos Security Support Provider (SSP) uses to locate a KDC for the Kerberos realm, if the computer is isn't a member of a Windows domain. After configuration, the user of a client computer running the Windows operating system can log on to accounts in the Kerberos realm.

- Search the registry for the domain name of the user's realm and then resolves the name to an IP address by querying a DNS server. The Kerberos protocol can use DNS to locate KDCs by using only the realm name, but it must be specially configured to do so.

## Syntax

```
ksetup
[/setrealm <DNSdomainname>]
[/mapuser <principal> <account>]
[/addkdc <realmname> <KDCname>]
[/delkdc <realmname> <KDCname>]
[/addkpasswd <realmname> <KDCPasswordName>]
[/delkpasswd <realmname> <KDCPasswordName>]
[/server <servername>]
[/setcomputerpassword <password>]
[/removerealm <realmname>]
[/domain <domainname>]
[/changepassword <oldpassword> <newpassword>]
[/listrealmflags]
[/setrealmflags <realmname> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]]
[/addrealmflags <realmname> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]]
[/delrealmflags [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]]
[/dumpstate]
[/addhosttorealmmap] <hostname> <realmname>]
[/delhosttorealmmap] <hostname> <realmname>]
[/setenctypeattr] <domainname> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/getenctypeattr] <domainname>
[/addenctypeattr] <domainname> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/delenctypeattr] <domainname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [ksetup setrealm](ksetup-setrealm.md) | Makes this computer a member of a Kerberos realm. |
| [ksetup addkdc](ksetup-addkdc.md) | Defines a KDC entry for the given realm. |
| [ksetup delkdc](ksetup-delkdc.md) | Deletes a KDC entry for the realm. |
| [ksetup addkpasswd](ksetup-addkpasswd.md) | Adds a kpasswd server address for a realm. |
| [ksetup delkpasswd](ksetup-delkpasswd.md) | Deletes a kpasswd server address for a realm. |
| [ksetup server](ksetup-server.md) | Allows you to specify the name of a Windows computer on which to apply the changes. |
| [ksetup setcomputerpassword](ksetup-setcomputerpassword.md) | Sets the password for the computer's domain account (or host principal). |
| [ksetup removerealm](ksetup-removerealm.md) | Deletes all information for the specified realm from the registry. |
| [ksetup domain](ksetup-domain.md) | Allows you to specify a domain (if the `<domainname>` hasn't already been set by the **/domain** parameter). |
| [ksetup changepassword](ksetup-changepassword.md) | Allows you to use the kpasswd to change the logged on user's password. |
| [ksetup listrealmflags](ksetup-listrealmflags.md) | Lists the available realm flags that **ksetup** can detect. |
| [ksetup setrealmflags](ksetup-setrealmflags.md) | Sets realm flags for a specific realm. |
| [ksetup addrealmflags](ksetup-addrealmflags.md) | Adds additional realm flags to a realm. |
| [ksetup delrealmflags](ksetup-delrealmflags.md) | Deletes realm flags from a realm. |
| [ksetup dumpstate](ksetup-dumpstate.md) | Analyzes the Kerberos configuration on the given computer. Adds a host to realm mapping to the registry. |
| [ksetup addhosttorealmmap](ksetup-addhosttorealmmap.md) | Adds a registry value to map the host to the Kerberos realm. |
| [ksetup delhosttorealmmap](ksetup-delhosttorealmmap.md) | Deletes the registry value that mapped the host computer to the Kerberos realm. |
| [ksetup setenctypeattr](ksetup-setenctypeattr.md) | Sets one or more encryption types trust attributes for the domain. |
| [ksetup getenctypeattr](ksetup-getenctypeattr.md) | Gets the encryption types trust attribute for the domain. |
| [ksetup addenctypeattr](ksetup-addenctypeattr.md) | Adds encryption types to the encryption types trust attribute for the domain. |
| [ksetup delenctypeattr](ksetup-delenctypeattr.md) | Deletes the encryption types trust attribute for the domain. |
| /? | Displays Help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)