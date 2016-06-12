---
title: ksetup
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e046f8a-811b-48dc-9a69-18d8e097f353
---
# ksetup
Performs tasks that are related to setting up and maintaining Kerberos protocol and the Key Distribution Center \(KDC\) to support Kerberos realms, which are not also Windows domains. for examples of how this command can be used, see the Examples section in each of the related subtopics.

## Syntax

```
ksetup 
[/setrealm <DNSDomainName>] 
[/mapuser <Principal> <Account>] 
[/addkdc <RealmName> <KDCName>] 
[/delkdc <RealmName> <KDCName>]
[/addkpasswd <RealmName> <KDCPasswordName>] 
[/delkpasswd <RealmName> <KDCPasswordName>]
[/server <ServerName>] 
[/setcomputerpassword <Password>]
[/removerealm <RealmName>]  
[/domain <DomainName>] 
[/changepassword <OldPassword> <NewPassword>] 
[/listrealmflags] 
[/setrealmflags <RealmName> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]] 
[/addrealmflags <RealmName> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]] 
[/delrealmflags [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]] 
[/dumpstate]
[/addhosttorealmmap] <hostname> <RealmName>]  
[/delhosttorealmmap] <hostname> <RealmName>]  
[/setenctypeattr] <DomainName> {DES-CBC-CRC | DES-CBC-md5 | RC4-HMAC-md5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/getenctypeattr] <DomainName>
[/addenctypeattr] <DomainName> {DES-CBC-CRC | DES-CBC-md5 | RC4-HMAC-md5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/delenctypeattr] <DomainName>

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|[ksetup:setrealm](ksetup/ksetupsetrealm.md)|Makes this computer a member of a Kerberos realm.|
|[ksetup:mapuser](ksetup/ksetupmapuser.md)|Maps a Kerberos principal to an account.|
|[ksetup:addkdc](ksetup/ksetupaddkdc.md)|Defines a KDC entry for the given realm.|
|[ksetup:delkdc](ksetup/ksetupdelkdc.md)|deletes a KDC entry for the realm.|
|[ksetup:addkpasswd](ksetup/ksetupaddkpasswd.md)|adds a Kpasswd server address for a realm.|
|[ksetup:delkpasswd](ksetup/ksetupdelkpasswd.md)|deletes a Kpasswd server address for a realm.|
|[ksetup:server](ksetup/ksetupserver.md)|Allows you to specify the name of a Windows computer on which to apply the changes.|
|[ksetup:setcomputerpassword](ksetup/ksetupsetcomputerpassword.md)|Sets the password for the computer's domain account \(or host principal\).|
|[ksetup:removerealm](ksetup/ksetupremoverealm.md)|deletes all information for the specified realm from the registry.|
|[ksetup:domain](ksetup/ksetupdomain.md)|Allows you to specify a domain \(if <DomainName> has not been set by using **\/domain**\).|
|[ksetup:changepassword](ksetup/ksetupchangepassword.md)|Allows you to use the Kpasswd to change the logged on user's password.|
|[ksetup:listrealmflags](ksetup/ksetuplistrealmflags.md)|lists the available realm flags that **ksetup** can detect.|
|[ksetup:setrealmflags](ksetup/ksetupsetrealmflags.md)|Sets realm flags for a specific realm.|
|[ksetup:addrealmflags](ksetup/ksetupaddrealmflags.md)|adds additional realm flags to a realm.|
|[ksetup:delrealmflags](ksetup/ksetupdelrealmflags.md)|deletes realm flags from a realm.|
|[ksetup:dumpstate](ksetup/ksetupdumpstate.md)|Analyzes the Kerberos configuration on the given computer. adds a host to realm mapping to the registry.|
|[ksetup:addhosttorealmmap](ksetup/ksetupaddhosttorealmmap.md)|adds a registry value to map the host to the Kerberos realm.|
|[ksetup:delhosttorealmmap](ksetup/ksetupdelhosttorealmmap.md)|deletes the registry value that mapped the host computer to the Kerberos realm.|
|[ksetup:setenctypeattr](ksetup/ksetupsetenctypeattr.md)|Sets one or more encryption types trust attributes for the domain.|
|[ksetup:getenctypeattr](ksetup/ksetupgetenctypeattr.md)|Gets the encryption types trust attribute for the domain.|
|[ksetup:addenctypeattr](ksetup/ksetupaddenctypeattr.md)|adds encryption types to the encryption types trust attribute for the domain.|
|[ksetup:delenctypeattr](ksetup/ksetupdelenctypeattr.md)|deletes the encryption types trust attribute for the domain.|
|\/?|Displays help at the command prompt.|

## remarks
**ksetup** is used to change the computer settings for locating Kerberos realms. In non\-Microsoft Kerberos–based implementations, this information is usually kept in the Krb5.conf file. In Windows Server operating systems, it is kept in the registry. You can use this tool to modify these settings. These settings are used by workstations to locate Kerberos realms and by domain controllers to locate Kerberos realms for cross\-realm trust relationships.

**ksetup** initializes registry keys that the Kerberos Security Support Provider \(SSP\) uses to locate a KDC for the Kerberos realm if the computer is running Windows Server 2003,  Windows Server 2008 , or  Windows Server 2008 R2  and is not a member of a Windows domain. After configuration, the user of a client computer that is running the Windows operating system can log on to accounts in the Kerberos realm.

The Kerberos version 5 protocol is the default for network authentication on computers running Windows XP Professional, Windows Vista, and  Windows 7 . The Kerberos SSP searches the registry for the domain name of the user's realm and then resolves the name to an IP address by querying a DNS server. The Kerberos protocol can use DNS to locate KDCs by using only the realm name, but it must be specially configured to do so.

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)


