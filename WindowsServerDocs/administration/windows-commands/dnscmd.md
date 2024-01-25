---
title: dnscmd
description: Reference article for the dnscmd command, which is a command-line interface for managing DNS servers.
ms.topic: reference
ms.assetid: e7f31cb5-a426-4e25-b714-88712b8defd5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Dnscmd

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A command-line interface for managing DNS servers. This utility is useful in scripting batch files to help automate routine DNS management tasks, or to perform simple unattended setup and configuration of new DNS servers on your network.

## Syntax

```
dnscmd <servername> <command> [<command parameters>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<servername>` | The IP address or host name of a remote or local DNS server. |

## dnscmd /ageallrecords command

Sets the current time on a time stamp on resource records at a specified zone or node on a DNS server.

### Syntax

```
dnscmd [<servername>] /ageallrecords <zonename>[<nodename>] | [/tree]|[/f]
```

#### Parameters

| Parameter | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server that the administrator plans to manage, represented by IP address, fully qualified domain name (FQDN), or Host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the FQDN of the zone. |
| `<nodename>` | Specifies a specific node or subtree in the zone, using the following:<ul><li>**@** for root zone or FQDN</li><li>The FQDN of a node (the name with a period (.) at the end)</li><li>A single label for the name relative to the zone root.</li></ul> |
| /tree | Specifies that all child nodes also receive the time stamp. |
| /f | Runs the command without asking for confirmation. |

##### Remarks

- The **ageallrecords** command is for backward compatibility between the current version of DNS and previous releases of DNS in which aging and scavenging were not supported. It adds a time stamp with the current time to resource records that do not have a time stamp, and it sets the current time on resource records that do have a time stamp.

- Record scavenging does not occur unless the records are time stamped. Name server (NS) resource records, start of authority (SOA) resource records, and Windows Internet Name Service (WINS) resource records are not included in the scavenging process, and they are not time stamped even when the **ageallrecords** command runs.

- This command fails unless scavenging is enabled for the DNS server and the zone. For information about how to enable scavenging for the zone, see the **aging** parameter, within the syntax of the `dnscmd /config` command in this article.

- The addition of a time stamp to DNS resource records makes them incompatible with DNS servers that run on operating systems other than Windows Server. A time stamp added by using the **ageallrecords** command can't be reversed.

- If none of the optional parameters are specified, the command returns all resource records at the specified node. If a value is specified for at least one of the optional parameters, **dnscmd** enumerates only the resource records that correspond to the value or values that are specified in the optional parameter or parameters.

### Examples

[Example 1: Set the current time on a time stamp to resource records](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-1-set-the-current-time-on-a-time-stamp-to-resource-records)

## dnscmd /clearcache command

Clears the DNS cache memory of resource records on the specified DNS server.

### Syntax

```
dnscmd [<servername>] /clearcache
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |

### Example

```
dnscmd dnssvr1.contoso.com /clearcache
```

## dnscmd /config command

Changes values in the registry for the DNS server and individual zones. This command also modifies the configuration of the specified server. Accepts server-level and zone-level settings.

> [!CAUTION]
> Don't edit the registry directly unless you have no alternative. The registry editor bypasses standard safeguards, allowing settings that can degrade performance, damage your system, or even require you to reinstall Windows. You can safely alter most registry settings by using the programs in Control Panel or Microsoft Management Console (mmc). If you must edit the registry directly, back it up first. Read the registry editor help for more information.

### Server-level syntax

```
dnscmd [<servername>] /config <parameter>
```

#### Parameters

> [!NOTE]
> This article contains references to the term slave, a term that Microsoft no longer uses. When the term is removed from the software, we’ll remove it from this article.

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server that you are planning to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<parameter>` | Specify a setting and, as an option, a value. Parameter values use this syntax: *parameter* [*value*]. |
| /addressanswerlimit`[0|5-28]` | Specifies the maximum number of host records that a DNS server can send in response to a query. The value can be zero (0), or it can be in the range of 5 through 28 records. The default value is zero (0). |
| /bindsecondaries`[0|1]` | Changes the format of the zone transfer so that it can achieve maximum compression and efficiency. Accepts the values:<ul><li>**0** - Uses maximum compression and is compatible with BIND versions 4.9.4 and later only</li><li>**1** - Sends only one resource record per message to non-Microsoft DNS servers and is compatible with BIND versions earlier than 4.9.4. This is the default setting.</li></ul> |
| /bootmethod`[0|1|2|3]` | Determines the source from which the DNS server gets its configuration information. Accepts the values:<ul><li>**0** - Clears the source of configuration information.</li><li>**1** - Loads from the BIND file that is located in the DNS directory, which is `%systemroot%\System32\DNS` by default.</li><li>**2** - Loads from the registry.</li><li>**3** - Loads from AD DS and the registry. This is the default setting.</li></ul> |
| /defaultagingstate`[0|1]` | Determines whether the DNS scavenging feature is enabled by default on newly created zones. Accepts the values:<ul><li>**0** - Disables scavenging. This is the default setting.</li><li>**1** - Enables scavenging.</li></ul> |
| /defaultnorefreshinterval`[0x1-0xFFFFFFFF|0xA8]` | Sets a period of time in which no refreshes are accepted for dynamically updated records. Zones on the server inherit this value automatically.<p>To change the default value, type a value in the range of **0x1-0xFFFFFFFF**. The default value from the server is **0xA8**. |
| /defaultrefreshinterval `[0x1-0xFFFFFFFF|0xA8]` | Sets a period of time that is allowed for dynamic updates to DNS records. Zones on the server inherit this value automatically.<p>To change the default value, type a value in the range of **0x1-0xFFFFFFFF**. The default value from the server is **0xA8**. |
| /disableautoreversezones `[0|1]` | Enables or disables the automatic creation of reverse lookup zones. Reverse lookup zones provide resolution of Internet Protocol (IP) addresses to DNS domain names. Accepts the values:<ul><li>**0** - Enables the automatic creation of reverse lookup zones. This is the default setting.</li><li>**1** - Disables the automatic creation of reverse lookup zones.</li></ul> |
| /disablensrecordsautocreation `[0|1]` | Specifies whether the DNS server automatically creates name server (NS) resource records for zones that it hosts. Accepts the values:<ul><li>**0** - Automatically creates name server (NS) resource records for zones that the DNS server hosts.</li><li>**1** - Doesn't automatically create name server (NS) resource records for zones that the DNS server hosts.</li></ul> |
| /dspollinginterval `[0-30]` | Specifies how often the DNS server polls AD DS for changes in active directory integrated zones. |
| /dstombstoneinterval `[1-30]` |The amount of time in seconds to retain deleted records in AD DS. |
| /ednscachetimeout `[3600-15724800]` | Specifies the number of seconds that extended DNS (EDNS) information is cached. The minimum value is **3600**, and the maximum value is **15,724,800**. The default value is **604,800** seconds (one week). |
| /enableednsprobes `[0|1]` | Enables or disables the server to probe other servers to determine if they support EDNS. Accepts the values:<ul><li>**0** - Disables active support for EDNS probes.</li><li>**1** - Enables active support for EDNS probes.</li></ul> |
| /enablednssec `[0|1]` | Enables or disables support for DNS Security Extensions (DNSSEC). Accepts the values:<ul><li>**0** - Disables DNSSEC.</li><li>**1** - Enables DNSSEC.</li></ul> |
| /enableglobalnamessupport `[0|1]` | Enables or disables support for the GlobalNames zone. The GlobalNames zone supports resolution of single-label DNS names across a forest. Accepts the values:<ul><li>**0** - Disables support for the GlobalNames zone. When you set the value of this command to 0, the DNS Server service does not resolve single-label names in the GlobalNames zone.</li><li>**1** - Enables support for the GlobalNames zone. When you set the value of this command to 1, the DNS Server service resolves single-label names in the GlobalNames zone.</li></ul> |
| /enableglobalqueryblocklist `[0|1]` | Enables or disables support for the global query block list that blocks name resolution for names in the list. The DNS Server service creates and enables the global query block list by default when the service starts the first time. To view the current global query block list, use the dnscmd /info **/globalqueryblocklist** command. Accepts the values:<ul><li>**0** - Disables support for the global query block list. When you set the value of this command to 0, the DNS Server service responds to queries for names in the block list.</li><li>**1** - Enables support for the global query block list. When you set the value of this command to 1, the DNS Server service does not respond to queries for names in the block list.</li></ul> |
| /eventloglevel `[0|1|2|4]` | Determines which events are logged in the DNS server log in Event Viewer. Accepts the values:<ul><li>**0** - Logs no events.</li><li>**1** - Logs only errors.</li><li>**2** - Logs only errors and warnings.</li><li>**4** - Logs errors, warnings, and informational events. This is the default setting.</li></ul> |
| /forwarddelegations `[0|1]` | Determines how the DNS server handles a query for a delegated subzone. These queries can be sent either to the subzone that is referred to in the query or to the list of forwarders that is named for the DNS server. Entries in the setting are used only when forwarding is enabled. Accepts the values:<ul><li>**0** - Automatically sends queries that refer to delegated subzones to the appropriate subzone. This is the default setting.</li><li>**1** - Forwards queries that refer to the delegated subzone to the existing forwarders.</li></ul> |
| /forwardingtimeout `[<seconds>]` | Determines how many seconds (**0x1-0xFFFFFFFF**) a DNS server waits for a forwarder to respond before trying another forwarder. The default value is **0x5**, which is 5 seconds. |
| /globalneamesqueryorder `[0|1]` | Specifies whether the DNS Server service looks first in the GlobalNames zone or local zones when it resolves names. Accepts the values:<ul><li>**0** - The DNS Server service attempts to resolve names by querying the GlobalNames zone before it queries the zones for which it is authoritative.</li><li>**1** - The DNS Server service attempts to resolve names by querying the zones for which it is authoritative before it queries the GlobalNames zone.</li></ul> |
| /globalqueryblocklist`[[<name> [<name>]...]` | Replaces the current global query block list with a list of the names that you specify. If you do not specify any names, this command clears the block list. By default, the global query block list contains the following items:<ul><li>isatap</li><li>wpad</li></ul>The DNS Server service can remove either or both of these names when it starts the first time, if it finds these names in an existing zone. |
| /isslave `[0|1]` | Determines how the DNS server responds when queries that it forwards receive no response. Accepts the values:<ul><li>**0** - Specifies that the DNS server is not a subordinate. If the forwarder does not respond, the DNS server attempts to resolve the query itself. This is the default setting.</li><li>**1** - Specifies that the DNS server is a subordinate. If the forwarder does not respond, the DNS server terminates the search and sends a failure message to the resolver.</li></ul> |
| /localnetpriority `[0|1]` | Determines the order in which host records are returned when the DNS server has multiple host records for the same name. Accepts the values:<ul><li>**0** - Returns the records in the order in which they are listed in the DNS database.</li><li>**1** - Returns the records that have similar IP network addresses first. This is the default setting.</li></ul> |
| /logfilemaxsize `[<size>]` | Specifies the maximum size in bytes (**0x10000-0xFFFFFFFF**) of the Dns.log file. When the file reaches its maximum size, DNS overwrites the oldest events. The default size is **0x400000**, which is 4 megabytes (MB). |
| /logfilepath `[<path+logfilename>]` | Specifies the path of the Dns.log file. The default path is `%systemroot%\System32\Dns\Dns.log`. You can specify a different path by using the format `path+logfilename`. |
| /logipfilterlist `<IPaddress> [,<IPaddress>...]` | Specifies which packets are logged in the debug log file. The entries are a list of IP addresses. Only packets going to and from the IP addresses in the list are logged. |
| /loglevel `[<eventtype>]` | Determines which types of events are recorded in the Dns.log file. Each event type is represented by a hexadecimal number. If you want more than one event in the log, use hexadecimal addition to add the values, and then enter the sum. Accepts the values:<ul><li>**0x0** - The DNS server does not create a log. This is the default entry.</li><li>**0x10** - Logs queries and notifications.</li><li>**0x20** - Logs updates.</li><li>**0xFE** - Logs nonquery transactions.</li><li>**0x100** - Logs question transactions.</li><li>**0x200** - Logs answers.</li><li>**0x1000** - Logs send packets.</li><li>**0x2000** - Logs receive packets.</li><li>**0x4000** - Logs User Datagram Protocol (UDP) packets.</li><li>**0x8000** - Logs Transmission Control Protocol (TCP) packets.</li><li>**0xFFFF** - Logs all packets.</li><li>**0x10000** - Logs active directory write transactions.</li><li>**0x20000** - Logs active directory update transactions.</li><li>**0x1000000** - Logs full packets.</li><li>**0x80000000** - Logs write-through transactions.</li><li></ul> |
| /maxcachesize | Specifies the maximum size, in kilobytes (KB), of the DNS server s memory cache. |
| /maxcachettl `[<seconds>]` | Determines how many seconds (**0x0-0xFFFFFFFF**) a record is saved in the cache. If the **0x0** setting is used, the DNS server doesn't cache records. The default setting is **0x15180** (86,400 seconds or 1 day). |
| /maxnegativecachettl `[<seconds>]` | Specifies how many seconds (**0x1-0xFFFFFFFF**) an entry that records a negative answer to a query remains stored in the DNS cache. The default setting is **0x384** (900 seconds). |
| /namecheckflag `[0|1|2|3]` | Specifies which character standard is used when checking DNS names. Accepts the values:<ul><li>**0** - Uses ANSI characters that comply with Internet Engineering Task force (IETF) Request for Comments (Rfcs).</li><li>**1** - Uses ANSI characters that do not necessarily comply with IETF Rfcs.</li><li>**2** - Uses multibyte UCS Transformation format 8 (UTF-8) characters. This is the default setting.</li><li>**3** - Uses all characters.</li></ul> |
| /norecursion `[0|1]` | Determines whether a DNS server performs recursive name resolution. Accepts the values:<ul><li>**0** - The DNS server performs recursive name resolution if it is requested in a query. This is the default setting.</li><li>**1** - The DNS server does not perform recursive name resolution.</li></ul> |
| /notcp | This parameter is obsolete, and it has no effect in current versions of Windows Server. |
| /recursionretry `[<seconds>]` | Determines the number of seconds (**0x1-0xFFFFFFFF**) that a DNS server waits before again trying to contact a remote server. The default setting is **0x3** (three seconds). This value should be increased when recursion occurs over a slow wide area network (WAN) link. |
| /recursiontimeout `[<seconds>]` | Determines the number of seconds (**0x1-0xFFFFFFFF**) that a DNS server waits before discontinuing attempts to contact a remote server. The settings range from **0x1** through **0xFFFFFFFF**. The default setting is **0xF** (15 seconds). This value should be increased when recursion occurs over a slow WAN link. |
| /roundrobin `[0|1]` | Determines the order in which host records are returned when a server has multiple host records for the same name. Accepts the values:<ul><li>**0** - The DNS server does not use round robin. Instead, it returns the first record to every query.</li><li>**1** - The DNS server rotates among the records that it returns from the top to the bottom of the list of matching records. This is the default setting.</li></ul> |
| /rpcprotocol `[0x0|0x1|0x2|0x4|0xFFFFFFFF]` | Specifies the protocol that remote procedure call (RPC) uses when it makes a connection from the DNS server. Accepts the values:<ul><li>**0x0** - Disables RPC for DNS.</li><li>**0x01** - Uses TCP/IP</li><li>**0x2** - Uses named pipes.</li><li>**0x4** - Uses local procedure call (LPC).</li><li>**0xFFFFFFFF** - All protocols. This is the default setting.</li></ul> |
| /scavenginginterval `[<hours>]` | Determines whether the scavenging feature for the DNS server is enabled, and sets the number of hours (**0x0-0xFFFFFFFF**) between scavenging cycles. The default setting is **0x0**, which disables scavenging for the DNS server. A setting greater than **0x0** enables scavenging for the server and sets the number of hours between scavenging cycles. |
| /secureresponses `[0|1]` | Determines whether DNS filters records that are saved in a cache. Accepts the values:<ul><li>**0** - Saves all responses to name queries to a cache. This is the default setting.</li><li>**1** - Saves only the records that belong to the same DNS subtree to a cache.</li></ul> |
| /sendport `[<port>]` | Specifies the port number (**0x0-0xFFFFFFFF**) that DNS uses to send recursive queries to other DNS servers. The default setting is **0x0**, which means that the port number is selected randomly. |
| /serverlevelplugindll`[<dllpath>]` | Specifies the path of a custom plug-in. When Dllpath specifies the fully qualified path name of a valid DNS server plug-in, the DNS server calls functions in the plug-in to resolve name queries that are outside the scope of all locally hosted zones. If a queried name is out of the scope of the plug-in, the DNS server performs name resolution using forwarding or recursion, as configured. If Dllpath is not specified, the DNS server ceases to use a custom plug-in if a custom plug-in was previously configured. |
| /strictfileparsing `[0|1]` | Determines a DNS server's behavior when it encounters an erroneous record while loading a zone. Accepts the values:<ul><li>**0** - The DNS server continues to load the zone even if the server encounters an erroneous record. The error is recorded in the DNS log. This is the default setting.</li><li>**1** - The DNS server stops loading the zone, and it records the error in the DNS log.</li></ul> |
| /updateoptions `<RecordValue>` | Prohibits dynamic updates of specified types of records. If you want more than one record type to be prohibited in the log, use hexadecimal addition to add the values, and then enter the sum. Accepts the values:<ul><li>**0x0** - Doesn't restrict any record types.</li><li>**0x1** - Excludes start of authority (SOA) resource records.</li><li>**0x2** - Excludes name server (NS) resource records.</li><li>**0x4** - Excludes delegation of name server (NS) resource records.</li><li>**0x8** - Excludes server host records.</li><li>**0x100** - During secure dynamic update, excludes start of authority (SOA) resource records.</li><li>**0x200** - During secure dynamic update, excludes root name server (NS) resource records.</li><li>**0x30F** - During standard dynamic update, excludes name server (NS) resource records, start of authority (SOA) resource records, and server host records. During secure dynamic update, excludes root name server (NS) resource records and start of authority (SOA) resource records. Allows delegations and server host updates.</li><li>**0x400** - During secure dynamic update, excludes delegation name server (NS) resource records.</li><li>**0x800** - During secure dynamic update, excludes server host records.</li><li>**0x1000000** - Excludes delegation signer (DS) records.</li><li>**0x80000000** - Disables DNS dynamic update.</li></ul> |
| /writeauthorityns `[0|1]` | Determines when the DNS server writes name server (NS) resource records in the Authority section of a response. Accepts the values:<ul><li>**0** - Writes name server (NS) resource records in the Authority section of referrals only. This setting complies with Rfc 1034, Domain names concepts and facilities, and with Rfc 2181, Clarifications to the DNS Specification. This is the default setting.</li><li>**1** - Writes name server (NS) resource records in the Authority section of all successful authoritative responses.</li></ul> |
| /xfrconnecttimeout `[<seconds>]` | Determines the number of seconds (**0x0-0xFFFFFFFF**) a primary DNS server waits for a transfer response from its secondary server. The default value is **0x1E** (30 seconds). After the time-out value expires, the connection is terminated. |

### Zone-level syntax

Modifies the configuration of the specified zone. The zone name must be specified only for zone-level parameters.

```
dnscmd /config <parameters>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<parameter>` | Specify a setting, a zone name, and, as an option, a value. Parameter values use this syntax: `zonename parameter [value]`. |
| /aging `<zonename>`| Enables or disables scavenging in a specific zone. |
| /allownsrecordsautocreation `<zonename>` `[value]` | Overrides the DNS server's name server (NS) resource record autocreation setting. Name server (NS) resource records that were previously registered for this zone are not affected. Therefore, you must remove them manually if you do not want them. |
| /allowupdate `<zonename>` | Determines whether the specified zone accepts dynamic updates. |
| /forwarderslave `<zonename>` | Overrides the DNS server **/isslave** setting. |
| /forwardertimeout `<zonename>` | Determines how many seconds a DNS zone waits for a forwarder to respond before trying another forwarder. This value overrides the value that is set at the server level. |
| /norefreshinterval `<zonename>` | Sets a time interval for a zone during which no refreshes can dynamically update DNS records in a specified zone. |
| /refreshinterval `<zonename>` | Sets a time interval for a zone during which refreshes can dynamically update DNS records in a specified zone. |
| /securesecondaries `<zonename>` | Determines which secondary servers can receive zone updates from the primary server for this zone. |

## dnscmd /createbuiltindirectorypartitions command

Creates a DNS application directory partition. When DNS is installed, an application directory partition for the service is created at the forest and domain levels. Use this command to create DNS application directory partitions that were deleted or never created. With no parameter, this command creates a built-in DNS directory partition for the domain.

### Syntax

```
dnscmd [<servername>] /createbuiltindirectorypartitions [/forest] [/alldomains]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| /forest | Creates a DNS directory partition for the forest. |
| /alldomains | Creates DNS partitions for all domains in the forest. |

## dnscmd /createdirectorypartition command

Creates a DNS application directory partition. When DNS is installed, an application directory partition for the service is created at the forest and domain levels. This operation creates additional DNS application directory partitions.

### Syntax

```
dnscmd [<servername>] /createdirectorypartition <partitionFQDN>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<partitionFQDN>` | The FQDN of the DNS application directory partition that will be created. |

## dnscmd /deletedirectorypartition command

Removes an existing DNS application directory partition.

### Syntax

```
dnscmd [<servername>] /deletedirectorypartition <partitionFQDN>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<partitionFQDN>` | The FQDN of the DNS application directory partition that will be removed. |

## dnscmd /directorypartitioninfo command

Lists information about a specified DNS application directory partition.

### Syntax

```
dnscmd [<servername>] /directorypartitioninfo <partitionFQDN> [/detail]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<partitionFQDN>` | The FQDN of the DNS application directory partition. |
| /detail | Lists all information about the application directory partition. |

## dnscmd /enlistdirectorypartition command

Adds the DNS server to the specified directory partition's replica set.

### Syntax

```
dnscmd [<servername>] /enlistdirectorypartition <partitionFQDN>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<partitionFQDN>` | The FQDN of the DNS application directory partition. |

## dnscmd /enumdirectorypartitions command

Lists the DNS application directory partitions for the specified server.

### Syntax

```
dnscmd [<servername>] /enumdirectorypartitions [/custom]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| /custom | Lists only user-created directory partitions. |

## dnscmd /enumrecords command

Lists the resource records of a specified node in a DNS zone.

### Syntax

```
dnscmd [<servername>] /enumrecords <zonename> <nodename> [/type <rrtype> <rrdata>] [/authority] [/glue] [/additional] [/node | /child | /startchild<childname>] [/continue | /detail]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| /enumrecords | Lists resource records in the specified zone. |
| `<zonename>` | Specifies the name of the zone to which the resource records belong. |
| `<nodename>` | Specifies the name of the node of the resource records. |
| `[/type <rrtype> <rrdata>]` | Specifies the type of resource records to be listed and the type of data that is expected. Accepts the values:<ul><li>`<rrtype>` -  Specifies the type of resource records to be listed.</li><li>`<rrdata>` - Specifies the type of data that is expected record.</li></ul> |
| /authority | Includes authoritative data. |
| /glue | Includes glue data. |
| /additional | Includes all additional information about the listed resource records. |
| /node | Lists only the resource records of the specified node. |
| /child | Lists only the resource records of a specified child domain. |
| /startchild`<childname>` | Begins the list at the specified child domain. |
| /continue | Lists only the resource records with their type and data. |
| /detail | Lists all information about the resource records. |

#### Example

```
dnscmd /enumrecords test.contoso.com test /additional
```

## dnscmd /enumzones command

Lists the zones that exist on the specified DNS server. The **enumzones** parameters act as filters on the list of zones. If no filters are specified, a complete list of zones is returned. When a filter is specified, only the zones that meet that filter's criteria are included in the returned list of zones.

### Syntax

```
dnscmd [<servername>] /enumzones [/primary | /secondary | /forwarder | /stub | /cache | /auto-created] [/forward | /reverse | /ds | /file] [/domaindirectorypartition | /forestdirectorypartition | /customdirectorypartition | /legacydirectorypartition | /directorypartition <partitionFQDN>]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| /primary | Lists all zones that are either standard primary zones or active directory integrated zones. |
| /secondary | Lists all standard secondary zones. |
| /forwarder | Lists zones that forward unresolved queries to another DNS server. |
| /stub | Lists all stub zones. |
| /cache | Lists only the zones that are loaded into the cache. |
| /auto-created] | Lists the zones that were created automatically during the DNS server installation. |
| /forward | Lists forward lookup zones. |
| /reverse | Lists reverse lookup zones. |
| /ds | Lists active directory integrated zones. |
| /file | Lists zones that are backed by files. |
| /domaindirectorypartition | Lists zones that are stored in the domain directory partition. |
| /forestdirectorypartition | Lists zones that are stored in the forest DNS application directory partition. |
| /customdirectorypartition | Lists all zones that are stored in a user-defined application directory partition. |
| /legacydirectorypartition | Lists all zones that are stored in the domain directory partition. |
| /directorypartition `<partitionFQDN>` | Lists all zones that are stored in the specified directory partition. |

#### Examples

- [Example 2: Display a complete list of zones on a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-2-display-a-complete-list-of-zones-on-a-dns-server))

- [Example 3: Display a list of autocreated zones on a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-3-display-a-list-of-autocreated-zones-on-a-dns-server)

## dnscmd /exportsettings command

Creates a text file that lists the configuration details of a DNS server. The text file is named *DnsSettings.txt*. It is located in the `%systemroot%\system32\dns` directory of the server. You can use the information in the file that **dnscmd /exportsettings** creates to troubleshoot configuration problems or to ensure that you have configured multiple servers identically.

### Syntax

```
dnscmd [<servername>] /exportsettings
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |

## dnscmd /info command

Displays settings from the DNS section of the registry of the specified server `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters`. To display zone-level registry settings, use the `dnscmd zoneinfo` command.

### Syntax

```
dnscmd [<servername>] /info [<settings>]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<settings>` | Any setting that the **info** command returns can be specified individually. If a setting is not specified, a report of common settings is returned. |

#### Example

- [Example 4: Display the IsSlave setting from a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-4-display-the-isslave-setting-from-a-dns-server)

- [Example 5: Display the RecursionTimeout setting from a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-5-display-the-recursiontimeout-setting-from-a-dns-server)

## dnscmd /ipvalidate command

Tests whether an IP address identifies a functioning DNS server or whether the DNS server can act as a forwarder, a root hint server, or a primary server for a specific zone.

### Syntax

```
dnscmd [<servername>] /ipvalidate <context> [<zonename>] [[<IPaddress>]]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<context>` | Specifies the type of test to perform. You can specify any of the following tests:<ul><li>**/dnsservers** - Tests that the computers with the addresses that you specify are functioning DNS servers.</li><li>**/forwarders** - Tests that the addresses that you specify identify DNS servers that can act as forwarders.</li><li>**/roothints** - Tests that the addresses that you specify identify DNS servers that can act as root hint name servers.</li><li>**/zonemasters** - Tests that the addresses that you specify identify DNS servers that are primary servers for *zonename*. |
| `<zonename>` | Identifies the zone. Use this parameter with the **/zonemasters** parameter. |
| `<IPaddress>` | Specifies the IP addresses that the command tests. |

#### Examples

```
nscmd dnssvr1.contoso.com /ipvalidate /dnsservers 10.0.0.1 10.0.0.2
dnscmd dnssvr1.contoso.com /ipvalidate /zonemasters corp.contoso.com 10.0.0.2
```

## dnscmd /nodedelete command

Deletes all records for a specified host.

### Syntax

```
dnscmd [<servername>] /nodedelete <zonename> <nodename> [/tree] [/f]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone. |
| `<nodename>` | Specifies the host name of the node to delete. |
| /tree | Deletes all the child records. |
| /f | Executes the command without asking for confirmation. |

#### Example

[Example 6: Delete the records from a node](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-6-delete-the-records-from-a-node)

## dnscmd /recordadd command

Adds a record to a specified zone in a DNS server.

### Syntax

```
dnscmd [<servername>] /recordadd <zonename> <nodename> <rrtype> <rrdata>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the zone in which the record resides. |
| `<nodename>` | Specifies a specific node in the zone. |
| `<rrtype>` | Specifies the type of record to be added. |
| `<rrdata>` | Specifies the type of data that is expected. |

> [!NOTE]
> After you add a record, make sure that you use the correct data type and data format. For a list of resource record types and the appropriate data types, see [Dnscmd Examples](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)).

#### Examples

```
dnscmd dnssvr1.contoso.com /recordadd test A 10.0.0.5
dnscmd /recordadd test.contoso.com test MX 10 mailserver.test.contoso.com
```

## dnscmd /recorddelete command

Deletes a resource record to a specified zone.

### Syntax

```
dnscmd [<servername>] /recorddelete <zonename> <nodename> <rrtype> <rrdata> [/f]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the zone in which the resource record resides. |
| `<nodename>` | Specifies a name of the host. |
| `<rrtype>` | Specifies the type of resource record to be deleted. |
| `<rrdata>` | Specifies the type of data that is expected. |
| /f | Executes the command without asking for confirmation. Because nodes can have more than one resource record, this command requires you to be very specific about the type of resource record that you want to delete. If you specify a data type and you do not specify a type of resource record data, all records with that specific data type for the specified node are deleted. |

#### Examples

```
dnscmd /recorddelete test.contoso.com test MX 10 mailserver.test.contoso.com
```

## dnscmd /resetforwarders command

Selects or resets the IP addresses to which the DNS server forwards DNS queries when it cannot resolve them locally.

### Syntax

```
dnscmd [<servername>] /resetforwarders <IPaddress> [,<IPaddress>]...][/timeout <timeout>] [/slave | /noslave]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<IPaddress>` | Lists the IP addresses to which the DNS server forwards unresolved queries. |
| /timeout `<timeout>` | Sets the number of seconds that the DNS server waits for a response from the forwarder. By default, this value is five seconds. |
| /slave | Prevents the DNS server from performing its own iterative queries if the forwarder fails to resolve a query. |
| /noslave | Allows the DNS server to perform its own iterative queries if the forwarder fails to resolve a query. This is the default setting. |
| /f | Executes the command without asking for confirmation. Because nodes can have more than one resource record, this command requires you to be very specific about the type of resource record that you want to delete. If you specify a data type and you do not specify a type of resource record data, all records with that specific data type for the specified node are deleted. |

##### Remarks

- By default, a DNS server performs iterative queries when it cannot resolve a query.

- Setting IP addresses by using the **resetforwarders** command causes the DNS server to perform recursive queries to the DNS servers at the specified IP addresses. If the forwarders don't resolve the query, the DNS server can then perform its own iterative queries.

- If the **/slave** parameter is used, the DNS server does not perform its own iterative queries. This means that the DNS server forwards unresolved queries only to the DNS servers in the list, and it does not attempt iterative queries if the forwarders do not resolve them. It is more efficient to set one IP address as a forwarder for a DNS server. You can use the **resetforwarders** command for internal servers in a network to forward their unresolved queries to one DNS server that has an external connection.

- Listing a forwarder's IP address twice causes the DNS server to attempt to forward to that server twice.

#### Examples

```
dnscmd dnssvr1.contoso.com /resetforwarders 10.0.0.1 /timeout 7 /slave
dnscmd dnssvr1.contoso.com /resetforwarders /noslave
```

## dnscmd /resetlistenaddresses command

Specifies the IP addresses on a server that listens for DNS client requests. By default, all IP addresses on a DNS server listen for client DNS requests.

### Syntax

```
dnscmd [<servername>] /resetlistenaddresses <listenaddress>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<listenaddress>` | Specifies an IP address on the DNS server that listens for DNS client requests. If no listen address is specified, all IP addresses on the server listen for client requests. |

#### Examples

```
dnscmd dnssvr1.contoso.com /resetlistenaddresses 10.0.0.1
```

## dnscmd /startscavenging command

Tells a DNS server to attempt an immediate search for stale resource records in a specified DNS server.

### Syntax

```
dnscmd [<servername>] /startscavenging
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |

##### Remarks

- Successful completion of this command starts a scavenge immediately. If the scavenge fails, no warning message appears.

- Although the command to start the scavenge appears to complete successfully, the scavenge does not start unless the following preconditions are met:

    - Scavenging is enabled for both the server and the zone.

    - The zone is started.

    - The resource records have a time stamp.

- For information about how to enable scavenging for the server, see the **scavenginginterval** parameter under **Server-level syntax** in the **/config** section.

- For information about how to enable scavenging for the zone, see the **aging** parameter under **Zone-level syntax** in the **/config** section.

- For information about how to restart a paused zone, see the **zoneresume** parameter in this article.

- For information about how to check resource records for a time stamp, see the **ageallrecords** parameter in this article.

#### Examples

```
dnscmd dnssvr1.contoso.com /startscavenging
```

## dnscmd /statistics command

Displays or clears data for a specified DNS server.

### Syntax

```
dnscmd [<servername>] /statistics [<statid>] [/clear]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<statid>` | Specifies which statistic or combination of statistics to display. The **statistics** command displays counters that begin on the DNS server when it is started or resumed. An identification number is used to identify a statistic. If no statistic ID number is specified, all statistics display. The numbers that can be specified, along with the corresponding statistic that displays, can include:<ul><li>**00000001** - Time</li><li>**00000002** - Query</li><li>**00000004** - Query2</li><li>**00000008** - Recurse</li><li>**00000010** - Master</li><li>**00000020** - Secondary</li><li>**00000040** - WINS</li><li>**00000100** - Update</li><li>**00000200** - SkwanSec</li><li>**00000400** - Ds</li><li>**00010000** - Memory</li><li>**00100000** - PacketMem</li><li>**00040000** - Dbase</li><li>**00080000** - Records</li><li>**00200000** - NbstatMem</li><li>**/clear** - Resets the specified statistics counter to zero.</li></ul> |

#### Examples

- [Example 7: ](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-7-display-time-statistics-for-a-dns-server)

- [Example 8: Display NbstatMem statistics for a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-8-display-nbstatmem-statistics-for-a-dns-server)

## dnscmd /unenlistdirectorypartition command

Removes the DNS server from the specified directory partition's replica set.

### Syntax

```
dnscmd [<servername>] /unenlistdirectorypartition <partitionFQDN>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<partitionFQDN>` | The FQDN of the DNS application directory partition that will be removed. |

## dnscmd /writebackfiles command

Checks the DNS server memory for changes, and writes them to persistent storage. The **writebackfiles** command updates all dirty zones or a specified zone. A zone is dirty when there are changes in memory that haven't yet been written to persistent storage. This is a server-level operation that checks all zones. You can specify one zone in this operation or you can use the **zonewriteback** operation.

### Syntax

```
dnscmd [<servername>] /writebackfiles <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be updated. |

#### Examples

```
dnscmd dnssvr1.contoso.com /writebackfiles
```

## dnscmd /zoneadd command

Adds a zone to the DNS server.

### Syntax

```
dnscmd [<servername>] /zoneadd <zonename> <zonetype> [/dp <FQDN> | {/domain | enterprise | legacy}]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone. |
| `<zonetype>` | Specifies the type of zone to create. Specifying a zone type of **/forwarder** or **/dsforwarder** creates a zone that performs conditional forwarding. Each zone type has different required parameters:<ul><li>**/dsprimary** - Creates an active directory integrated zone.</li><li>**/primary /file `<filename>`** - Creates a standard primary zone, and specifies the name of the file that will store the zone information.</li><li>**/secondary `<masterIPaddress> [<masterIPaddress>...]`** - Creates a standard secondary zone.</li><li>**/stub `<masterIPaddress> [<masterIPaddress>...]` /file `<filename>`** - Creates a file-backed stub zone.</li><li>**/dsstub `<masterIPaddress> [<masterIPaddress>...]`** - Creates an active directory integrated stub zone.</li><li>**/forwarder `<masterIPaddress> [<masterIPaddress>]`... /file `<filename>`** - Specifies that the created zone forwards unresolved queries to another DNS server.</li><li>**/dsforwarder** - Specifies that the created active directory integrated zone forwards unresolved queries to another DNS server.</li></ul> |
| `<FQDN>` | Specifies FQDN of the directory partition. |
| /domain | Stores the zone on the domain directory partition. |
| /enterprise | Stores the zone on the enterprise directory partition. |
| /legacy | Stores the zone on a legacy directory partition. |

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneadd test.contoso.com /dsprimary
dnscmd dnssvr1.contoso.com /zoneadd secondtest.contoso.com /secondary 10.0.0.2
```

## dnscmd /zonechangedirectorypartition command

Changes the directory partition on which the specified zone resides.

### Syntax

```
dnscmd [<servername>] /zonechangedirectorypartition <zonename> {[<newpartitionname>] | [<zonetype>]}
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | The FQDN of the current directory partition on which the zone resides. |
| `<newpartitionname>` | The FQDN of the directory partition that the zone will be moved to. |
| `<zonetype>` | Specifies the type of directory partition that the zone will be moved to. |
| /domain | Moves the zone to the built-in domain directory partition. |
| /forest | Moves the zone to the built-in forest directory partition. |
| /legacy | Moves the zone to the directory partition that is created for pre active directory domain controllers. These directory partitions are not necessary for native mode. |

## dnscmd /zonedelete command

Deletes a specified zone.

### Syntax

```
dnscmd [<servername>] /zonedelete <zonename> [/dsdel] [/f]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be deleted. |
| /dsdel | Deletes the zone from Azure Directory Domain Services (AD DS). |
| /f | Runs the command without asking for confirmation. |

#### Examples

- [Example 9: Delete a zone from a DNS server](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-9-delete-a-zone-from-a-dns-server)

## dnscmd /zoneexport command

Creates a text file that lists the resource records of a specified zone. The **zoneexport** operation creates a file of resource records for an active directory integrated zone for troubleshooting purposes. By default, the file that this command creates is placed in the DNS directory, which is by default the `%systemroot%/System32/Dns` directory.

### Syntax

```
dnscmd [<servername>] /zoneexport <zonename> <zoneexportfile>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone. |
| `<zoneexportfile>` | Specifies the name of the file to create. |

#### Examples

- [Example 10: Export zone resource records list to a file](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-10-export-zone-resource-records-list-to-a-file)

## dnscmd /zoneinfo

Displays settings from the section of the registry of the specified zone: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters\Zones\<zonename>`

### Syntax

```
dnscmd [<servername>] /zoneinfo <zonename> [<setting>]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone. |
| `<setting>` | You can individually specify any setting that the **zoneinfo** command returns. If you don't specify a setting, all settings are returned. |

##### Remarks

- To display server-level registry settings, use the **/info** command.

- To see a list of settings that you can display with this command, see the **/config** command.

#### Examples

- [Example 11: Display RefreshInterval setting from the registry](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-11-display-refreshinterval-setting-from-the-registry)

- [Example 12: Display Aging setting from the registry](/previous-versions/windows/it-pro/windows-server-2003/cc784399(v=ws.10)#example-12-display-aging-setting-from-the-registry)

## dnscmd /zonepause command

Pauses the specified zone, which then ignores query requests.

### Syntax

```
dnscmd [<servername>] /zonepause <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be paused. |

##### Remarks

- To resume a zone and make it available after it has been paused, use the **/zoneresume** command.

#### Examples

```
dnscmd dnssvr1.contoso.com /zonepause test.contoso.com
```

## dnscmd /zoneprint command

Lists the records in a zone.

### Syntax

```
dnscmd [<servername>] /zoneprint <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be listed. |







## dnscmd /zonerefresh command

Forces a secondary DNS zone to update from the master zone.

### Syntax

```
dnscmd [<servername>] /zonerefresh <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be refreshed. |

##### Remarks

- The **zonerefresh** command forces a check of the version number in the primary server s start of authority (SOA) resource record. If the version number on the primary server is higher than the secondary server's version number, a zone transfer is initiated that updates the secondary server. If the version number is the same, no zone transfer occurs.

- The forced check occurs by default every 15 minutes. To change the default, use the `dnscmd config refreshinterval` command.

#### Examples

```
dnscmd dnssvr1.contoso.com /zonerefresh test.contoso.com
```

## dnscmd /zonereload command

Copies zone information from its source.

### Syntax

```
dnscmd [<servername>] /zonereload <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be reloaded. |

##### Remarks

- If the zone is active directory integrated, it reloads from Active Directory Domain Services (AD DS).

- If the zone is a standard file-backed zone, it reloads from a file.

#### Examples

```
dnscmd dnssvr1.contoso.com /zonereload test.contoso.com
```

## dnscmd /zoneresetmasters command

Resets the IP addresses of the primary server that provides zone transfer information to a secondary zone.

### Syntax

```
dnscmd [<servername>] /zoneresetmasters <zonename> [/local] [<IPaddress> [<IPaddress>]...]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to be reset. |
| /local | Sets a local master list. This parameter is used for active directory integrated zones. |
| `<IPaddress>` | The IP addresses of the primary servers of the secondary zone. |

##### Remarks

- This value is originally set when the secondary zone is created. Use the **zoneresetmasters** command on the secondary server. This value has no effect if it is set on the master DNS server.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneresetmasters test.contoso.com 10.0.0.1
dnscmd dnssvr1.contoso.com /zoneresetmasters test.contoso.com /local
```

## dnscmd /zoneresetscavengeservers command

Changes the IP addresses of the servers that can scavenge the specified zone.

### Syntax

```
dnscmd [<servername>] /zoneresetscavengeservers <zonename> [/local] [<IPaddress> [<IPaddress>]...]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the zone to scavenge. |
| /local | Sets a local master list. This parameter is used for active directory integrated zones. |
| `<IPaddress>` | Lists the IP addresses of the servers that can perform the scavenge. If this parameter is omitted, all servers that host this zone can scavenge it. |

##### Remarks

- By default, all servers that host a zone can scavenge that zone.

- If a zone is hosted on more than one DNS server, you can use this command to reduce the number of times a zone is scavenged.

- Scavenging must be enabled on the DNS server and zone that is affected by this command.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneresetscavengeservers test.contoso.com 10.0.0.1 10.0.0.2
```

## dnscmd /zoneresetsecondaries command

Specifies a list of IP addresses of secondary servers to which a primary server responds when it is asked for a zone transfer.

### Syntax

```
dnscmd [<servername>] /zoneresetsecondaries <zonename> {/noxfr | /nonsecure | /securens | /securelist <securityIPaddresses>} {/nonotify | /notify | /notifylist <notifyIPaddresses>}
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone that will have its secondary servers reset. |
| /local | Sets a local master list. This parameter is used for active directory integrated zones. |
| /noxfr | Specifies that no zone transfers are allowed. |
| /nonsecure | Specifies that all zone transfer requests are granted. |
| /securens | Specifies that only the server that is listed in the name server (NS) resource record for the zone is granted a transfer. |
| /securelist | Specifies that zone transfers are granted only to the list of servers. This parameter must be followed by an IP address or addresses that the primary server uses. |
| `<securityIPaddresses>` | Lists the IP addresses that receive zone transfers from the primary server. This parameter is used only with the **/securelist** parameter. |
| /nonotify | Specifies that no change notifications are sent to secondary servers. |
| /notify | Specifies that change notifications are sent to all secondary servers. |
| /notifylist | Specifies that change notifications are sent to only the list of servers. This command must be followed by an IP address or addresses that the primary server uses. |
| `<notifyIPaddresses>` | Specifies the IP address or addresses of the secondary server or servers to which change notifications are sent. This list is used only with the **/notifylist** parameter. |

##### Remarks

- Use the **zoneresetsecondaries** command on the primary server to specify how it responds to zone transfer requests from secondary servers.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneresetsecondaries test.contoso.com /noxfr /nonotify
dnscmd dnssvr1.contoso.com /zoneresetsecondaries test.contoso.com /securelist 11.0.0.2
```

## dnscmd /zoneresettype command

Changes the type of the zone.

### Syntax

```
dnscmd [<servername>] /zoneresettype <zonename> <zonetype> [/overwrite_mem | /overwrite_ds]
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Identifies the zone on which the type will be changed. |
| `<zonetype>` | Specifies the type of zone to create. Each type has different required parameters, including:<ul><li>**/dsprimary** - Creates an active directory integrated zone.</li><li>**/primary /file `<filename>`** - Creates a standard primary zone.</li><li>**/secondary `<masterIPaddress> [,<masterIPaddress>...]`** - Creates a standard secondary zone.</li><li>**/stub `<masterIPaddress>[,<masterIPaddress>...]` /file `<filename>`** - Creates a file-backed stub zone.</li><li>**/dsstub `<masterIPaddress>[,<masterIPaddress>...]`** - Creates an active directory integrated stub zone.</li><li>**/forwarder `<masterIPaddress[,<masterIPaddress>]`... /file`<filename>`** - Specifies that the created zone forwards unresolved queries to another DNS server.</li><li>**/dsforwarder** - Specifies that the created active directory integrated zone forwards unresolved queries to another DNS server.</li></ul> |
| /overwrite_mem | Overwrites DNS data from data in AD DS. |
| /overwrite_ds | Overwrites existing data in AD DS. |

##### Remarks

- Setting the zone type as **/dsforwarder** creates a zone that performs conditional forwarding.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneresettype test.contoso.com /primary /file test.contoso.com.dns
dnscmd dnssvr1.contoso.com /zoneresettype second.contoso.com /secondary 10.0.0.2
```

## dnscmd /zoneresume command

Starts a specified zone that was previously paused.

### Syntax

```
dnscmd [<servername>] /zoneresume <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to resume. |

##### Remarks

- You can use this operation to restart from the **/zonepause** operation.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneresume test.contoso.com
```

## dnscmd /zoneupdatefromds command

Updates the specified active directory integrated zone from AD DS.

### Syntax

```
dnscmd [<servername>] /zoneupdatefromds <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to update. |

##### Remarks

- Active directory integrated zones perform this update by default every five minutes. To change this parameter, use the `dnscmd config dspollinginterval` command.

#### Examples

```
dnscmd dnssvr1.contoso.com /zoneupdatefromds
```

## dnscmd /zonewriteback command

Checks DNS server memory for changes that are relevant to a specified zone, and writes them to persistent storage.

### Syntax

```
dnscmd [<servername>] /zonewriteback <zonename>
```

#### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `<servername>` | Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used. |
| `<zonename>` | Specifies the name of the zone to update. |

##### Remarks

- This is a zone-level operation. You can update all zones on a DNS server by using the **/writebackfiles** operation.

#### Examples

```
dnscmd dnssvr1.contoso.com /zonewriteback test.contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
