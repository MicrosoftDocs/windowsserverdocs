---
title: netsh branchcache
description: Reference article for the netsh branchcache command in Windows, which manages data access speeds in branch offices locally.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 07/24/2025
---

# netsh branchcache

The `netsh branchcache` command is used in Windows to manage BranchCache, a feature that speeds up access to data in branch offices.

## Syntax

```
netsh branchcache dump | exportkey | flush | help | importkey | reset | set | show | smb | ?
```

```
netsh branchcache exportkey [outputfile=]<File Path> [passphrase]=<Pass Phrase>
netsh branchcache importkey [inputfile=]<File Path> [passphrase]=<Pass Phrase>
```

```
netsh branchcache set [cachesize | key | localcache | publicationcache | publicationcachesize | service]
netsh branchcache set [cachesize | publicationcachesize] [size=]{DEFAULT|<number>} [[percent=]{TRUE|FALSE}]
netsh branchcache set key [[passphrase=]<Pass Phrase>]
netsh branchcache set [localcache | publicationcache] [directory=]{DEFAULT|<File Path>}
netsh branchcache set service [mode=]{DISABLED|LOCAL|DISTRIBUTED|HOSTEDSERVER|HOSTEDCLIENT}
                              [[location]=<Host Name>]
                              [[clientauthentication]={DOMAIN|NONE}]
                              [[serveonbattery]={TRUE|FALSE}]
```

```
netsh branchcache show [hostedcache | localcache | publicationcache | status]
netsh branchcache show status [[detail=]{BASIC|ALL}]
```

```
netsh branchcache smb [dump | help | set | show]
netsh branchcache smb set [latency=]<number>
```

## Parameters

| Parameter | Description |
|--|--|
| dump | Dumps the configuration details and settings related to BranchCache on your device. |
| exportykey `<FilePath>\<FileName>` `<Passphrase>` | Exports the key which the BranchCache service uses to protect content information. The key can later be imported on another device by using the `importkey` command. <br><br> The output file is a directory path and name of the file where the key should be exported. The passphrase is required to import the key. |
| flush | Clears or deletes the local cache of content that BranchCache stores on your device. |
| help *or* ? | Displays help information for the given command. |
| importkey `<FilePath>\<FileName>` `<Passphrase>` | Imports a key for the BranchCache service to use to protect content information. The key must be previously exported using the `exportkey` command. If the service is currently running, this command restarts it in order to begin using the new key. |
| reset | Restarts the BranchCache service and clears both the content cache on the client side and any locally stored publication data. This command resets configuration settings to their default settings. |
| set [cachesize \| publicationcachesize] [size=]{DEFAULT\|`<number>`} [[percent=]{`TRUE`\|`FALSE`}] | cachesize - Sets the size of the local cache. <br><br> publicationcachesize - Sets the size of the local publication cache. <br><br> size - Indicates the cache size as a percentage or an exact `<number>` of bytes. If set to `default`, the default configuration is restored. <br><br> percent - Specifies whether the size value is interpreted as a percentage of the hard disk size or in the exact `<number>` of bytes. This parameter is ignored if the size value is set to `default`. <br><br> `True` - Indicates the size is a percentage of the size of the hard disk. <br> `False` - Indicates the size is an exact number of bytes (default option). |
| set key [[passphrase=]\<Passphrase>] | key - Generates a new content information key. <br><br> A passphrase is used to generate the key. If a passphrase isn't provided, a random key is generated. If two keys generated using the same passphrase, they're identical. A passphrase can be used to duplicate the same key on another device. |
| set [localcache \| publicationcache] [directory=]{DEFAULT\|\<File Path>} | localcache - Sets the location of the local cache. <br><br> publicationcache - Sets the location of the local publication cache. <br><br> directory - Is the path to the directory in which the local cache or publication cache should be stored. When set to `default`, it restores the default cache location. This service is restarted, if necessary, in order to complete the change. Any existing cache files are moved to the new location. |
| set service [mode=]{DISABLED \| LOCAL \| DISTRIBUTED \| HOSTEDSERVER \| HOSTEDCLIENT} [[location]=\<Host Name>] [[clientauthentication]={DOMAIN\|NONE}] [[serveonbattery]={TRUE\|FALSE}] | mode - Configures the BranchCache service mode. <br><br><li> `disabled` - Disables the BranchCache service. <li> `local` - Enables caching of data on the local device only. <li> `distributed` - Activates distributed caching, allowing data to be cached across multiple computers in a peer-to-peer configuration. <li> `hostedserver` - Sets the device as a Hosted Cache Server to serve cached data to clients. <li> `hostedclient` - Sets the device as a client of a Hosted Cache Server to receive and store cached data. </li><br> location - Sets the location of the Hosted Cache Server, which is only necessary if the mode is set to `hostedclient` and is ignored in other modes. <br><br> clientauthentication - Sets the method used by a Hosted Cache Server to authenticate connected clients. This parameter is only relevant when the mode is set to `hostedserver` and is ignored otherwise. <br><li> `domain` - Requires clients to be members of the same domain as the Hosted Cache Server for authentication. <li> `none` - No authentication method is implemented for clients. </li><br> serveonbattery - Allows the local client to respond to peer requests for cached data while operating on battery power. This parameter is applicable only when the mode is set to `distributed` and is ignored otherwise. <li> `true` - Enables the servicer to provide cached data while on battery. <li> `false` - Disables the servicing of cached data requests when on battery power. </li> |
| show [hostedcache \| localcache \| publicationcache \| status] | `hostedcache` - Displays the configuration information status of the Hosted Cache server if the device is set up to function as one. <br><br> `localcache` - Provides details about the local cache on the device, such as the size of the cache on the hard disk and cache location. <br><br> `publicationcache` - Shows information about the publication cache settings and contents. <br><br> `status` - Provides a summary of the current BranchCache configuration and operational status, including the mode BranchCache is set to. |
| show status [[detail=]{`BASIC`\|`ALL`}] | detail - Specifies the level of detail for the displayed information. <br><br> `basic` - Shows only essential information (default option). <br> `all` - Displays comprehensive information available. |
| smb [dump] <br> smb [set \| show] latency [latency=]\\`<number>` | Manages the BranchCache settings related to the Server Message Block (SMB) protocol. <br><br> `dump` - Outputs a script that represents the current configuration settings. <br> `set` - Modifies or assigns values to specific configuration parameters. <br> `show` - Displays the current configuration parameters and their values. <br> `latency` - Specifies the minimum link latency, in milliseconds, to the branch office before SMB utilizes BranchCache for caching. |

## Examples

**dump**

To dump the BranchCache configuration to a file, type the following command:

```cmd
netsh branchcache dump > C:\BranchCacheConfig.txt
```

**exportkey**

To export the client key to a file, type the following command:

```cmd
netsh branchcache exportkey C:\Keys\BranchCacheKey.bckey
```

To export a specific key with a password, type the following command:

```cmd
netsh branchcache exportkey C:\Keys\BranchCacheKey.bckey mypassword
```

**flush**

To clear all cached content, type the following command:

```cmd
netsh branchcache flush
```

**help**

To display help for a specific BranchCache command, such as exportkey, type the following command:

```cmd
netsh branchcache exportkey help
```

> [!NOTE]
> Both the `help` and `?` commands are used interchangeably.

**importkey**

To import a BranchCache key from a file, type the following command:

```cmd
netsh branchcache importkey C:\Keys\BranchCacheKey.bckey
```

To import a key from a file with a password, type the following command:

```cmd
netsh branchcache importkey C:\Keys\BranchCacheKey.bckey mypassword
```

**reset**

To reset BranchCache to its default state, type the following command:

```cmd
netsh branchcache reset
```

**set**

To set the BranchCache mode to `distributed`, type the following command:

```cmd
netsh branchcache set mode=distributed
```

To set the cache size to a specific percentage, such as `10%`, type the following command:

```cmd
netsh branchcache set cachesize=10%
```

To configure a client to use a hosted cache server, type the following command:

```cmd
netsh branchcache set service mode=HOSTEDCLIENT location=HOSTEDSERVERNAME
```

**show**

To show the current BranchCache status, type the following command:

```cmd
netsh branchcache show status
```

To show the current BranchCache configuration, type the following command:

```cmd
netsh branchcache show configuration
```

**smb**

To set the latency threshold to `80` milliseconds, type the following command:

```cmd
netsh branchcache smb set latency=80
```

## See also

- [BranchCache](/windows-server/networking/branchcache/branchcache)

- [BranchCache PowerShell module](/powershell/module/branchcache)
