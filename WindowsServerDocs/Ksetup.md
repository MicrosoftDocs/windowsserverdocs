---
title: Ksetup
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e046f8a-811b-48dc-9a69-18d8e097f353
---
# Ksetup
Performs tasks that are related to setting up and maintaining Kerberos protocol and the Key Distribution Center \(KDC\) to support Kerberos realms, which are not also Windows domains. For examples of how this command can be used, see the Examples section in each of the related subtopics.

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
[/addhosttorealmmap] <HostName> <RealmName>]  
[/delhosttorealmmap] <HostName> <RealmName>]  
[/setenctypeattr] <DomainName> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/getenctypeattr] <DomainName>
[/addenctypeattr] <DomainName> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
[/delenctypeattr] <DomainName>

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|[Ksetup:setrealm](Ksetup-setrealm.md)|Makes this computer a member of a Kerberos realm.|
|[Ksetup:mapuser](Ksetup-mapuser.md)|Maps a Kerberos principal to an account.|
|[Ksetup:addkdc](Ksetup-addkdc.md)|Defines a KDC entry for the given realm.|
|[Ksetup:delkdc](Ksetup-delkdc.md)|Deletes a KDC entry for the realm.|
|[Ksetup:addkpasswd](Ksetup-addkpasswd.md)|Adds a Kpasswd server address for a realm.|
|[Ksetup:delkpasswd](Ksetup-delkpasswd.md)|Deletes a Kpasswd server address for a realm.|
|[Ksetup:server](Ksetup-server.md)|Allows you to specify the name of a Windows computer on which to apply the changes.|
|[Ksetup:setcomputerpassword](Ksetup-setcomputerpassword.md)|Sets the password for the computer's domain account \(or host principal\).|
|[Ksetup:removerealm](Ksetup-removerealm.md)|Deletes all information for the specified realm from the registry.|
|[Ksetup:domain](Ksetup-domain.md)|Allows you to specify a domain \(if <DomainName> has not been set by using **\/domain**\).|
|[Ksetup:changepassword](Ksetup-changepassword.md)|Allows you to use the Kpasswd to change the logged on user's password.|
|[Ksetup:listrealmflags](Ksetup-listrealmflags.md)|Lists the available realm flags that **ksetup** can detect.|
|[Ksetup:setrealmflags](Ksetup-setrealmflags.md)|Sets realm flags for a specific realm.|
|[Ksetup:addrealmflags](Ksetup-addrealmflags.md)|Adds additional realm flags to a realm.|
|[Ksetup:delrealmflags](Ksetup-delrealmflags.md)|Deletes realm flags from a realm.|
|[Ksetup:dumpstate](Ksetup-dumpstate.md)|Analyzes the Kerberos configuration on the given computer. Adds a host to realm mapping to the registry.|
|[Ksetup:addhosttorealmmap](Ksetup-addhosttorealmmap.md)|Adds a registry value to map the host to the Kerberos realm.|
|[Ksetup:delhosttorealmmap](Ksetup-delhosttorealmmap.md)|Deletes the registry value that mapped the host computer to the Kerberos realm.|
|[Ksetup:setenctypeattr](Ksetup-setenctypeattr.md)|Sets one or more encryption types trust attributes for the domain.|
|[Ksetup:getenctypeattr](Ksetup-getenctypeattr.md)|Gets the encryption types trust attribute for the domain.|
|[Ksetup:addenctypeattr](Ksetup-addenctypeattr.md)|Adds encryption types to the encryption types trust attribute for the domain.|
|[Ksetup:delenctypeattr](Ksetup-delenctypeattr.md)|Deletes the encryption types trust attribute for the domain.|
|\/?|Displays Help at the command prompt.|

## Remarks
**Ksetup** is used to change the computer settings for locating Kerberos realms. In non\-Microsoft Kerberos–based implementations, this information is usually kept in the Krb5.conf file. In Windows Server operating systems, it is kept in the registry. You can use this tool to modify these settings. These settings are used by workstations to locate Kerberos realms and by domain controllers to locate Kerberos realms for cross\-realm trust relationships.

**Ksetup** initializes registry keys that the Kerberos Security Support Provider \(SSP\) uses to locate a KDC for the Kerberos realm if the computer is running Windows Server 2003, [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and is not a member of a Windows domain. After configuration, the user of a client computer that is running the Windows operating system can log on to accounts in the Kerberos realm.

The Kerberos version 5 protocol is the default for network authentication on computers running Windows XP Professional, Windows Vista, and [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)]. The Kerberos SSP searches the registry for the domain name of the user's realm and then resolves the name to an IP address by querying a DNS server. The Kerberos protocol can use DNS to locate KDCs by using only the realm name, but it must be specially configured to do so.

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


