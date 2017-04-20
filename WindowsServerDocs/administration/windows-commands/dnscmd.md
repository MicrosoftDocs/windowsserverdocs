---
title: Dnscmd
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e7f31cb5-a426-4e25-b714-88712b8defd5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Dnscmd

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A command-line interface for managing DNS servers. This utility is useful in scripting batch files to help automate routine DNS management tasks, or to perform simple unattended setup and configuration of new DNS servers on your network.  
## Syntax  
```  
dnscmd <ServerName> <command> [<command parameters>]  
```  
## Parameters  
|Parameter|Description|  
|-------|--------|  
|<ServerName>|The IP address or host name of a remote or local DNS server.|  
## Commands  
|Command|Description|  
|------|--------|  
|[dnscmd /ageallrecords](#BKMK_1)|Sets the current time on all time stamps in a zone or node.|  
|[dnscmd /clearcache](#BKMK_2)|Clears the DNS server cache.|  
|[dnscmd /config](#BKMK_3)|resets the DNS server or zone configuration.|  
|[dnscmd /createbuiltindirectorypartitions](#BKMK_4)|creates the built-in DNS application directory partitions.|  
|[dnscmd /createdirectorypartition](#BKMK_5)|creates a DNS application directory partition.|  
|[dnscmd /deletedirectorypartition](#BKMK_6)|deletes a DNS application directory partition.|  
|[dnscmd /directorypartitioninfo](#BKMK_7)|lists information about a DNS application directory partition.|  
|[dnscmd /enlistdirectorypartition](#BKMK_8)|adds a DNS server to the replication set of a DNS application directory partition.|  
|[dnscmd /enumdirectorypartitions](#BKMK_9)|lists the DNS application directory partitions for a server.|  
|[dnscmd /enumrecords](#BKMK_10)|lists the resource records in a zone.|  
|[dnscmd /enumzones](#BKMK_11)|lists the zones hosted by the specified server.|  
|[dnscmd /exportsettings](#BKMK_25a)|Writes server configuration information to a text file.|  
|[dnscmd /info](#BKMK_12)|Gets server information.|  
|[dnscmd /ipvalidate](#BKMK_29a)|Validates remote DNS servers.|  
|[dnscmd /nodedelete](#BKMK_13)|deletes all records for a node in a zone.|  
|[dnscmd /recordadd](#BKMK_14)|adds a resource record to a zone.|  
|[dnscmd /recorddelete](#BKMK_15)|removes a resource record from a zone.|  
|[dnscmd /resetforwarders](#BKMK_16)|Sets DNS servers to forward recursive queries.|  
|[dnscmd /resetlistenaddresses](#BKMK_17)|Sets server IP addresses to serve DNS requests.|  
|[dnscmd /startscavenging](#BKMK_18)|Initiates server scavenging.|  
|[dnscmd /statistics](#BKMK_19)|Queries or clears server statistics data.|  
|[dnscmd /unenlistdirectorypartition](#BKMK_20)|removes a DNS server from the replication set of a DNS application directory partition.|  
|[dnscmd /writebackfiles](#BKMK_21)|Saves all zone or root-hint data to a file.|  
|[dnscmd /zoneadd](#BKMK_22)|creates a new zone on the DNS server.|  
|[dnscmd /zonechangedirectorypartition](#BKMK_23)|changes the directory partition on which a zone resides.|  
|[dnscmd /zonedelete](#BKMK_24)|deletes a zone from the DNS server.|  
|[dnscmd /zoneexport](#BKMK_25)|Writes the resource records of a zone to a text file.|  
|[dnscmd /zoneinfo](#BKMK_26)|Displays zone information.|  
|[dnscmd /zonepause](#BKMK_27)|pauses a zone.|  
|[dnscmd /zoneprint](#BKMK_28)|Displays all records in the zone.|  
|[dnscmd /zonerefresh](#BKMK_30)|forces a refresh of the secondary zone from the master zone.|  
|[dnscmd /zonereload](#BKMK_31)|Reloads a zone from its database.|  
|[dnscmd /zoneresetmasters](#BKMK_32)|changes the master servers that provide zone transfer information to a secondary zone.|  
|[dnscmd /zoneresetscavengeservers](#BKMK_33)|changes the servers that can scavenge a zone.|  
|[dnscmd /zoneresetsecondaries](#BKMK_34)|resets secondary information for a zone.|  
|[dnscmd /zoneresettype](#BKMK_29)|changes the zone type.|  
|[dnscmd /zoneresume](#BKMK_35)|Resumes a zone.|  
|[dnscmd /zoneupdatefromds](#BKMK_36)|Updates an active directory integrated zone with data from active directory Domain Services (AD DS).|  
|[dnscmd /zonewriteback](#BKMK_37)|Saves zone data to a file.|  
### <a name="BKMK_1"></a>dnscmd /ageallrecords  
Sets the current time on a time stamp on resource records at a specified zone or node on a DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /ageallrecords <ZoneName>[<NodeName>] | [/tree]|[/f]  
```  
#### Parameters  
<ServerName>  
Specifies the DNS server that the administrator plans to manage, represented by IP address, fully qualified domain name (FQDN), or Host name. If this parameter is omitted, the local server is used.  
<ZoneName>  
Specifies the FQDN of the zone.  
<NodeName>  
Specifies a specific node or subtree in the zone. *NodeName* specifies the node or subtree in the zone using the following:  
-   @ for root zone or FQDN  
-   The FQDN of a node (the name with a period (.) at the end)  
-   A single label for the name relative to the zone root  
/tree  
Specifies that all child nodes also receive the time stamp.  
/f  
Runs the command without asking for confirmation.  
#### remarks  
-   The **ageallrecords** command is for backward compatibility between the current version of DNS and previous releases of DNS in which aging and scavenging were not supported. It adds a time stamp with the current time to resource records that do not have a time stamp, and it sets the current time on resource records that do have a time stamp.  
-   Record scavenging does not occur unless the records are time stamped. Name server (NS) resource records, start of authority (SOA) resource records, and Windows Internet Name Service (WINS) resource records are not included in the scavenging process, and they are not time stamped even when the **ageallrecords** command runs.  
-   This command fails unless scavenging is enabled for the DNS server and the zone. For information about how to enable scavenging for the zone, see the **aging** parameter under Zone-Level Syntax in the [config](#BKMK_3) command.  
-   The addition of a time stamp to DNS resource records makes them incompatible with DNS servers that run on operating systems other than Windows 2000, Windows XP, or Windows Server 2003. A time stamp that you add by using the **ageallrecords** command cannot be reversed.  
-   if none of the optional parameters are specified, the command returns all resource records at the specified node. If a value is specified for at least one of the optional parameters, **dnscmd** enumerates only the resource records that correspond to the value or values that are specified in the optional parameter or parameters.  
#### Example  
See [Example 1: Set the current time on a time stamp to resource records](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_2"></a>dnscmd /clearcache  
Clears the DNS cache memory of resource records on the specified DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /clearcache  
```  
#### Parameters  
<ServerName>  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /clearcache`  
### <a name="BKMK_3"></a>dnscmd /config  
changes values in the registry for the DNS server and individual zones. Accepts server-level settings and zone-level settings.  
> [!CAUTION]  
> Do not edit the registry directly unless you have no alternative. The registry editor bypasses standard safeguards, allowing settings that can degrade performance, damage your system, or even require you to reinstall Windows. You can safely alter most registry settings by using the programs in Control Panel or Microsoft Management Console (mmc). If you must edit the registry directly, back it up first. Read the registry editor help for more information.  
#### Server-level syntax  
```  
dnscmd [<ServerName>] /config <Parameter>  
```  
#### dnscmd /config  
Modifies the configuration of the specified server.  
#### Parameters  
<ServerName>  
Specifies the DNS server that you are planning to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
<Parameter>  
Specify a setting and, as an option, a value. Parameter values use this syntax: *Parameter* [*Value*]  
The following parameter values are described in the remainder of this section:  
-   **/addressanswerlimit**  
-   **/bindsecondaries**  
-   **/bootmethod**  
-   **/defaultagingstate**  
-   **/defaultnorefreshinterval**  
-   **/defaultrefreshinterval**  
-   **/disableautoreversezones**  
-   **/disablensrecordsautocreation**  
-   **/dspollinginterval**  
-   **/dstombstoneinterval**  
-   **/ednscachetimeout**  
-   **/enablednsprobes**  
-   **/enablednssec**  
-   **/enableglobalnamessupport**  
-   **/enableglobalqueryblocklist**  
-   **/eventloglevel**  
-   **/forwarddelegations**  
-   **/forwardingtimeout**  
-   **/globalnamesqueryorder**  
-   **/globalqueryblocklist**  
-   **/isslave**  
-   **/localnetpriority**  
-   **/logfilemaxsize**  
-   **/logfilepath**  
-   **/logipfilterlist**  
-   **/loglevel**  
-   **/maxcachesize**  
-   **/maxcachettl**  
-   **/namecheckflag**  
-   **/notcp**  
-   **/norecursion**  
-   **/recursionretry**  
-   **/recursiontimeout**  
-   **/roundrobin**  
-   **/rpcprotocol**  
-   **/scavenginginterval**  
-   **/secureresponses**  
-   **/sendport**  
-   **/strictfileparsing**  
-   **/updateoptions**  
-   **/writeauthorityns**  
-   **/xfrconnecttimeout**  
**/addressanswerlimit [0|5-28]**  
Specifies the maximum number of host records that a DNS server can send in response to a query. The value can be zero (0), or it can be in the range of 5 through 28 records. The default value is zero (0).  
**/bindsecondaries[0|1]**  
changes the format of the zone transfer so that it can achieve maximum compression and efficiency. However, this format is not compatible with earlier versions of Berkeley Internet Name Domain (BIND).  
**0**  
Uses maximum compression. This format is compatible with BIND versions 4.9.4 and later only.  
**1**  
Sends only one resource record per message to non-Microsoft DNS servers. This format is compatible with BIND versions earlier than 4.9.4. This is the default setting.  
**/bootmethod[0|1|2|3]**  
Determines the source from which the DNS server gets its configuration information.  
**0**  
Clears the source of configuration information.  
**1**  
Loads from the BIND file that is located in the DNS directory, which is %systemroot%\System32\DNS by default.  
**2**  
Loads from the registry.  
**3**  
Loads from AD DS and the registry. This is the default setting.  
**/defaultagingstate[0|1]**  
Determines whether the DNS scavenging feature is enabled by default on newly created zones.  
**0**  
Disables scavenging. This is the default setting.  
**1**  
Enables scavenging.  
**/defaultnorefreshinterval[0x1-0xFFFFFFFF|0xA8]**  
Sets a period of time in which no refreshes are accepted for dynamically updated records. Zones on the server inherit this value automatically. To change the default value, type a value in the range of **0x1-0xFFFFFFFF**. The default value from the server is **0xA8**.  
**/defaultrefreshinterval [0x1-0xFFFFFFFF|0xA8]**  
Sets a period of time that is allowed for dynamic updates to DNS records. Zones on the server inherit this value automatically. To change the default value, type a value in the range of **0x1-0xFFFFFFFF**. The default value from the server is **0xA8**.  
**/disableautoreversezones [0|1]**  
Enables or disables the automatic creation of reverse lookup zones. Reverse lookup zones provide resolution of Internet Protocol (IP) addresses to DNS domain names.  
**0**  
Enables the automatic creation of reverse lookup zones. This is the default setting.  
**1**  
Disables the automatic creation of reverse lookup zones.  
**/disablensrecordsautocreation {0|1}**  
Specifies whether the DNS server automatically creates name server (NS) resource records for zones that it hosts.  
**0**  
Automatically creates name server (NS) resource records for zones that the DNS server hosts.  
**1**  
Does not automatically create name server (NS) resource records for zones that the DNS server hosts.  
**/dspollinginterval 0-30**  
Specifies how often the DNS server polls AD DS for changes in active directory integrated zones.  
**/dstombstoneinterval [1-30]**  
The amount of time in seconds to retain deleted records in AD DS.  
**/ednscachetimeout [<seconds>]**  
Specifies the number of seconds that extended DNS (EDNS) information is cached. The minimum value is 3600, and the maximum value is 15,724,800. The default value is 604,800 seconds (one week).  
**/enableednsprobes {0|1}**  
Enables or disables the server to probe other servers to determine if they support EDNS.  
**0**  
Disables active support for EDNS probes.  
**1**  
Enables active support for EDNS probes.  
**/enablednssec {0|1}**  
Enables or disables support for DNS Security Extensions (DNSSEC).  
**0**  
Disables DNSSEC.  
**1**  
Enables DNSSEC.  
**/enableglobalnamessupport {0|1}**  
Enables or disables support for the GlobalNames zone. The GlobalNames zone supports resolution of single-label DNS names across a forest.  
**0**  
Disables support for the GlobalNames zone. When you set the value of this command to **0**, the DNS Server service does not resolve single-label names in the GlobalNames zone.  
**1**  
Enables support for the GlobalNames zone. When you set the value of this command to **1**, the DNS Server service resolves single-label names in the GlobalNames zone.  
**/enableglobalqueryblocklist {0|1}**  
Enables or disables support for the global query block list that blocks name resolution for names in the list. The DNS Server service creates and enables the global query block list by default when the service starts the first time. To view the current global query block list, use the **dnscmd /info /globalqueryblocklist** command.  
**0**  
Disables support for the global query block list. When you set the value of this command to **0**, the DNS Server service responds to queries for names in the block list.  
**1**  
Enables support for the global query block list. When you set the value of this command to **1**, the DNS Server service does not respond to queries for names in the block list.  
**/eventloglevel [0|1|2|4]**  
Determines which events are logged in the DNS server log in Event Viewer.  
**0**  
Logs no events.  
**1**  
Logs only errors.  
**2**  
Logs only errors and warnings.  
**4**  
Logs errors, warnings, and informational events. This is the default setting.  
**/forwarddelegations [0|1]**  
Determines how the DNS server handles a query for a delegated subzone. These queries can be sent either to the subzone that is referred to in the query or to the list of forwarders that is named for the DNS server. Entries in the setting are used only when forwarding is enabled.  
**0**  
Automatically sends queries that refer to delegated subzones to the appropriate subzone. This is the default setting.  
**1**  
forwards queries that refer to the delegated subzone to the existing forwarders.  
**/forwardingtimeout [<seconds>]**  
Determines how many seconds (0x1-0xFFFFFFFF) a DNS server waits for a forwarder to respond before trying another forwarder. The default value is **0x5**, which is 5 seconds.  
**/globalneamesqueryorder** {**0|1**}  
Specifies whether the DNS Server service looks first in the GlobalNames zone or local zones when it resolves names.  
**0**  
The DNS Server service attempts to resolve names by querying the GlobalNames zone before it queries the zones for which it is authoritative.  
**1**  
The DNS Server service attempts to resolve names by querying the zones for which it is authoritative before it queries the GlobalNames zone.  
**/globalqueryblocklist[[<name> [<name>]...]**  
replaces the current global query block list with a list of the names that you specify. If you do not specify any names, this command clears the block list. By default, the global query block list contains the following items:  
-   isatap  
-   wpad  
The DNS Server service can remove either or both of these names when it starts the first time, if it finds these names in an existing zone.  
**/isslave [0|1]**  
Determines how the DNS server responds when queries that it forwards receive no response.  
**0**  
Specifies that the DNS server is not a subordinate (also known as a *slave*). If the forwarder does not respond, the DNS server attempts to resolve the query itself. This is the default setting.  
**1**  
Specifies that the DNS server is a subordinate. If the forwarder does not respond, the DNS server terminates the search and sends a failure message to the resolver.  
**/localnetpriority [0|1]**  
Determines the order in which host records are returned when the DNS server has multiple host records for the same name.  
**0**  
Returns the records in the order in which they are listed in the DNS database.  
**1**  
Returns the records that have similar IP network addresses first. This is the default setting.  
**/logfilemaxsize [<size>]**  
Specifies the maximum size in bytes (0x10000-0xFFFFFFFF) of the Dns.log file. When the file reaches its maximum size, DNS overwrites the oldest events. The default size is 0x400000, which is 4 megabytes (MB).  
**/logfilepath [<path+LogFileName>]**  
Specifies the path of the Dns.log file. The default path is %systemroot%\System32\Dns\Dns.log. You can specify a different path by using the format *path+LogFileName*.  
**/logipfilterlist <IPaddress> [,<IPaddress>...]**  
Specifies which packets are logged in the debug log file. The entries are a list of IP addresses. Only packets going to and from the IP addresses in the list are logged.  
**/loglevel [<Eventtype>]**  
Determines which types of events are recorded in the Dns.log file. Each event type is represented by a hexadecimal number. If you want more than one event in the log, use hexadecimal addition to add the values, and then enter the sum.  
**0x0**  
The DNS server does not create a log. This is the default entry.  
**0x10**  
Logs queries.  
**0x10**  
Logs notifications.  
**0x20**  
Logs updates.  
**0xFE**  
Logs nonquery transactions.  
**0x100**  
Logs question transactions.  
**0x200**  
Logs answers.  
**0x1000**  
Logs send packets.  
**0x2000**  
Logs receive packets.  
**0x4000**  
Logs User Datagram Protocol (UDP) packets.  
**0x8000**  
Logs Transmission Control Protocol (TCP) packets.  
**0xFFFF**  
Logs all packets.  
**0x10000**  
Logs active directory write transactions.  
**0x20000**  
Logs active directory update transactions.  
**0x1000000**  
Logs full packets.  
**0x80000000**  
Logs write-through transactions.  
**/maxcachesize**  
Specifies the maximum size, in kilobytes (KB), of the DNS server s memory cache.  
**/maxcachettl [<seconds>]**  
Determines how many seconds (0x0-0xFFFFFFFF) a record is saved in the cache. If the **0x0** setting is used, the DNS server does not cache records. The default setting is **0x15180** (86,400 seconds or 1 day).  
**/maxnegativecachettl [<seconds>]**  
Specifies how many seconds (0x1-0xFFFFFFFF) an entry that records a negative answer to a query remains stored in the DNS cache. The default setting is **0x384** (900 seconds).  
**/namecheckflag [0|1|2|3]**  
Specifies which character standard is used when checking DNS names.  
**0**  
Uses ANSI characters that comply with Internet Engineering Task force (IETF) Request for Comments (Rfcs).  
**1**  
Uses ANSI characters that do not necessarily comply with IETF Rfcs.  
**2**  
Uses multibyte UCS Transformation format 8 (UTF-8) characters. This is the default setting.  
**3**  
Uses all characters.  
**/norecursion [0|1]**  
Determines whether a DNS server performs recursive name resolution.  
**0**  
The DNS server performs recursive name resolution if it is requested in a query. This is the default setting.  
**1**  
The DNS server does not perform recursive name resolution.  
**/notcp**  
This parameter is obsolete, and it has no effect in current versions of Windows Server.  
**/recursionretry [<seconds>]**  
Determines the number of seconds (0x1-0xFFFFFFFF) that a DNS server waits before again trying to contact a remote server. The default setting is 0x3 (three seconds). This value should be increased when recursion occurs over a slow wide area network (WAN) link.  
**/recursiontimeout [<seconds>]**  
Determines the number of seconds (0x1-0xFFFFFFFF) that a DNS server waits before discontinuing attempts to contact a remote server. The settings range from **0x1** through **0xFFFFFFFF**. The default setting is **0xF** (15 seconds). This value should be increased when recursion occurs over a slow WAN link.  
**/roundrobin [0|1]**  
Determines the order in which host records are returned when a server has multiple host records for the same name.  
0  
The DNS server does not use round robin. Instead, it returns the first record to every query.  
**1**  
The DNS server rotates among the records that it returns from the top to the bottom of the list of matching records. This is the default setting.  
**/rpcprotocol [0x0|0x1|0x2|0x4|0xFFFFFFFF]**  
Specifies the protocol that remote procedure call (RPC) uses when it makes a connection from the DNS server.  
**0x0**  
Disables RPC for DNS.  
**0x1**  
Uses TCP/IP.  
**0x2**  
Uses named pipes.  
**0x4**  
Uses local procedure call (LPC).  
**0xFFFFFFFF**  
All protocols. This is the default setting.  
**/scavenginginterval [<hours>]**  
Determines whether the scavenging feature for the DNS server is enabled, and sets the number of hours (0x0-0xFFFFFFFF) between scavenging cycles. The default setting is **0x0**, which disables scavenging for the DNS server. A setting greater than **0x0** enables scavenging for the server and sets the number of hours between scavenging cycles.  
**/secureresponses [0|1]**  
Determines whether DNS filters records that are saved in a cache.  
**0**  
Saves all responses to name queries to a cache. This is the default setting.  
**1**  
Saves only the records that belong to the same DNS subtree to a cache.  
**/sendport [<port>]**  
Specifies the port number (0x0-0xFFFFFFFF) that DNS uses to send recursive queries to other DNS servers. The default setting is **0x0**, which means that the port number is selected randomly.  
**/serverlevelplugindll[<Dllpath>]**  
Specifies the path of a custom plug-in. When *Dllpath* specifies the fully qualified path name of a valid DNS server plug-in, the DNS server calls functions in the plug-in to resolve name queries that are outside the scope of all locally hosted zones. If a queried name is out of the scope of the plug-in, the DNS server performs name resolution using forwarding or recursion, as configured. If *Dllpath* is not specified, the DNS server ceases to use a custom plug-in if a custom plug-in was previously configured.  
**/strictfileparsing [0|1]**  
Determines a DNS server's behavior when it encounters an erroneous record while loading a zone.  
**0**  
The DNS server continues to load the zone even if the server encounters an erroneous record. The error is recorded in the DNS log. This is the default setting.  
**1**  
The DNS server stops loading the zone, and it records the error in the DNS log.  
**/updateoptions <RecordValue>**  
Prohibits dynamic updates of specified types of records. If you want more than one record type to be prohibited in the log, use hexadecimal addition to add the values, and then enter the sum.  
**0x0**  
Does not restrict any record types.  
**0x1**  
Excludes start of authority (SOA) resource records.  
**0x2**  
Excludes name server (NS) resource records.  
**0x4**  
Excludes delegation of name server (NS) resource records.  
**0x8**  
Excludes server host records.  
**0x100**  
During secure dynamic update, excludes start of authority (SOA) resource records.  
**0x200**  
During secure dynamic update, excludes root name server (NS) resource records.  
**0x30F**  
During standard dynamic update, excludes name server (NS) resource records, start of authority (SOA) resource records, and server host records. During secure dynamic update, excludes root name server (NS) resource records and start of authority (SOA) resource  records. Allows delegations and server host updates.  
**0x400**  
During secure dynamic update, excludes delegation name server (NS) resource records.  
**0x800**  
During secure dynamic update, excludes server host records.  
**0x1000000**  
Excludes delegation signer (DS) records.  
**0x80000000**  
Disables DNS dynamic update.  
**/writeauthorityns [0|1]**  
Determines when the DNS server writes name server (NS) resource records in the Authority section of a response.  
**0**  
Writes name server (NS) resource records in the Authority section of referrals only. This setting complies with Rfc 1034, Domain names concepts and facilities, and with Rfc 2181, Clarifications to the DNS Specification. This is the default setting.  
**1**  
Writes name server (NS) resource records in the Authority section of all successful authoritative responses.  
**/xfrconnecttimeout [<seconds>]**  
Determines the number of seconds (0x0-0xFFFFFFFF) a primary DNS server waits for a transfer response from its secondary server. The default value is **0x1E** (30 seconds). After the time-out value expires, the connection is terminated.  
#### Zone-level syntax  
```  
dnscmd /config <Parameters>  
```  
#### dnscmd /config  
Modifies the configuration of the specified zone.  
#### Parameters  
**<Parameters>**  
Specify a setting, a zone name, and, as an option, a value. Parameter values use this syntax: *ZoneName Parameter* [*Value*]  
The following parameter values are documented in the remainder of this section:  
-   **/aging**  
-   **/allownsrecordsautocreation**  
-   **/allowupdate**  
-   **/forwarderslave**  
-   **/forwardertimeout**  
-   **/norefreshinterval**  
-   **/refreshinterval**  
-   **/securesecondaries**  
**/aging <ZoneName>**  
Enables or disables scavenging in a specific zone.  
**/allownsrecordsautocreation  <ZoneName> [<Value>]**  
Overrides the DNS server's name server (NS) resource record autocreation setting. Name server (NS) resource records that were previously registered for this zone are not affected. Therefore, you must remove them manually if you do not want them.  
**/allowupdate <ZoneName>**  
Determines whether the specified zone accepts dynamic updates.  
**/forwarderslave <ZoneName>**  
Overrides the DNS server **/isslave** setting.  
**/forwardertimeout <ZoneName>**  
Determines how many seconds a DNS zone waits for a forwarder to respond before trying another forwarder. This value overrides the value that is set at the server level.  
**/norefreshinterval <ZoneName>**  
Sets a time interval for a zone during which no refreshes can dynamically update DNS records in a specified zone.  
**/refreshinterval <ZoneName>**  
Sets a time interval for a zone during which refreshes can dynamically update DNS records in a specified zone.  
**/securesecondaries <ZoneName>**  
Determines which secondary servers can receive zone updates from the master server for this zone.  
#### remarks  
-   The zone name must be specified only for zone-level parameters.  
### <a name="BKMK_4"></a>dnscmd /createbuiltindirectorypartitions  
creates a DNS application directory partition. When DNS is installed, an application directory partition for the service is created at the forest and domain levels. Use this command to create DNS application directory partitions that were deleted or never created. With no parameter, this command creates a built-in DNS directory partition for the domain.  
#### Syntax  
```  
dnscmd [<ServerName>] /createbuiltindirectorypartitions [/forest] [/alldomains]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**/forest**  
creates a DNS directory partition for the forest.  
**/alldomains**  
creates DNS partitions for all domains in the forest.  
### <a name="BKMK_5"></a>dnscmd /createdirectorypartition  
creates a DNS application directory partition. When DNS is installed, an application directory partition for the service is created at the forest and domain levels. This operation creates additional DNS application directory partitions.  
#### Syntax  
```  
dnscmd [<ServerName>] /createdirectorypartition <PartitionFQDN>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<PartitionFQDN>**  
The FQDN of the DNS application directory partition that will be created.  
### <a name="BKMK_6"></a>dnscmd /deletedirectorypartition  
removes an existing DNS application directory partition.  
#### Syntax  
```  
dnscmd [<ServerName>] /deletedirectorypartition <PartitionFQDN>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<PartitionFQDN>**  
The FQDN of the DNS application directory partition that will be removed.  
### <a name="BKMK_7"></a>dnscmd /directorypartitioninfo  
lists information about a specified DNS application directory partition.  
#### Syntax  
```  
dnscmd [<ServerName>] /directorypartitioninfo <PartitionFQDN> [/detail]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<PartitionFQDN>**  
The FQDN of the DNS application directory partition.  
**/detail**  
lists all information about the application directory partition.  
### <a name="BKMK_8"></a>dnscmd /enlistdirectorypartition  
adds the DNS server to the specified directory partition's replica set.  
#### Syntax  
```  
dnscmd [<ServerName>] /enlistdirectorypartition <PartitionFQDN>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<PartitionFQDN>**  
The FQDN of the DNS application directory partition.  
### <a name="BKMK_9"></a>dnscmd /enumdirectorypartitions  
lists the DNS application directory partitions for the specified server.  
#### Syntax  
```  
dnscmd [<ServerName>] /enumdirectorypartitions [/custom]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**/custom**  
lists only user-created directory partitions.  
### <a name="BKMK_10"></a>dnscmd /enumrecords  
lists the resource records of a specified node in a DNS zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /enumrecords <ZoneName> <NodeName> [/type <RRtype> <Rrdata>] [/authority] [/glue] [/additional] [/node | /child | /startchild<ChildName>] [/continue | /detail]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server that you plan to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**/enumrecords**  
lists resource records in the specified zone.  
**<ZoneName>**  
Specifies the name of the zone to which the resource records belong.  
**<NodeName>**  
Specifies the name of the node of the resource records.  
**/type <RRtype> <Rrdata>**  
Specifies the type of resource records to be listed and the type of data that is expected:  
**<RRtype>**  
Specifies the type of resource records to be listed.  
**<Rrdata>**  
Specifies the type of data that is expected record.  
**/authority**  
Includes authoritative data.  
**/glue**  
Includes glue data.  
**/additional**  
Includes all additional information about the listed resource records.  
**{/node | /child | /startchild <ChildName>}**  
Filters or adds information to the resource record display:  
**/node**  
lists only the resource records of the specified node.  
**/child**  
lists only the resource records of a specified child domain.  
**/startchild <ChildName>**  
Begins the list at the specified child domain.  
**/continue | /detail**  
Specifies how the returned data is displayed.  
**/continue**  
lists only the resource records with their type and data.  
**/detail**  
lists all information about the resource records.  
#### Sample usage  
`dnscmd /enumrecords test.contoso.com test /additional`  
### <a name="BKMK_11"></a>dnscmd /enumzones  
lists the zones that exist on the specified DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /enumzones [/primary | /secondary | /forwarder | /stub | /cache | /auto-created] [/forward | /reverse | /ds | /file] [/domaindirectorypartition | /forestdirectorypartition | /customdirectorypartition | /legacydirectorypartition | /directorypartition <PartitionFQDN>]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**/primary | /secondary | /forwarder | /stub | /cache | /auto-created**  
Filters the types of zones to display:  
**/primary**  
lists all zones that are either standard primary zones or active directory integrated zones.  
**/secondary**  
lists all standard secondary zones.  
**/forwarder**  
lists zones that forward unresolved queries to another DNS server.  
**/stub**  
lists all stub zones.  
**/cache**  
lists only the zones that are loaded into the cache.  
**/auto-created**  
lists the zones that were created automatically during the DNS server installation.  
**/forward | /reverse | /ds | /file**  
Specifies additional filters of the types of zones to display:  
**/forward**  
lists forward lookup zones.  
**/reverse**  
lists reverse lookup zones.  
**/ds**  
lists active directory integrated zones.  
**/file**  
lists zones that are backed by files.  
**/domaindirectorypartition**  
lists zones that are stored in the domain directory partition.  
**/forestdirectorypartition**  
lists zones that are stored in the forest DNS application directory partition.  
**/customdirectorypartition**  
lists all zones that are stored in a user-defined application directory partition.  
**/legacydirectorypartition**  
lists all zones that are stored in the domain directory partition.  
**/directorypartition <PartitionFQDN>**  
lists all zones that are stored in the specified directory partition.  
#### remarks  
-   The **enumzones** parameters act as filters on the list of zones. If no filters are specified, a complete list of zones is returned. When a filter is specified, only the zones that meet that filter's criteria are included in the returned list of zones.  
#### Example  
See [Example 2: Display a complete list of zones on a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx) or [Example 3: Display a list of autocreated zones on a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_25a"></a>dnscmd /exportsettings  
creates a text file that lists the configuration details of a DNS server. The text file is named DnsSettings.txt. It is located in the %systemroot%\system32\dns directory of the server.  
#### Syntax  
```  
dnscmd [<ServerName>] /exportsettings   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
#### remarks  
-   You can use the information in the file that **dnscmd /exportsettings** creates to troubleshoot configuration problems or to ensure that you have configured multiple servers identically.  
### <a name="BKMK_12"></a>dnscmd /info  
Displays settings from the DNS section of the registry of the specified server: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters**  
#### Syntax  
```  
dnscmd [<ServerName>] /info [<Setting>]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<Setting>**  
Any setting that the **info** command returns can be specified individually. If a setting is not specified, a report of common settings is returned.  
#### remarks  
-   This command displays registry settings that are at the DNS server level. To display zone-level registry settings, use the [zoneinfo](#BKMK_26) command. To see a list of settings that can be displayed with this command, see the [config](#BKMK_3) description.  
#### Example  
See [Example 4: Display the IsSlave setting from a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx) or [Example 5: Display the Recursiontimeout setting from a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_29a"></a>dnscmd /ipvalidate  
Tests whether an IP address identifies a functioning DNS server or whether the DNS server can act as a forwarder, a root hint server, or a master server for a specific zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /ipvalidate <Context> [<ZoneName>] [[<IPaddress>]]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<Context>**  
Specifies the type of test to perform. You can specify any of the following tests:  
-   **/dnsservers** tests that the computers with the addresses that you specify are functioning DNS servers.  
-   **/forwarders** tests that the addresses that you specify identify DNS servers that can act as forwarders.  
-   **/roothints** tests that the addresses that you specify identify DNS servers that can act as root hint name servers.  
-   **/zonemasters** tests that the addresses that you specify identify DNS servers that are master servers for *ZoneName*.  
**<ZoneName>**  
Identifies the zone. Use this parameter with the **/zonemasters** parameter.  
**<IPaddress>**  
Specifies the IP addresses that the command tests.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /ipvalidate /dnsservers 10.0.0.1 10.0.0.2  
dnscmd dnssvr1.contoso.com /ipvalidate /zonemasters corp.contoso.com 10.0.0.2</pre>  
### <a name="BKMK_13"></a>dnscmd /nodedelete  
deletes all records for a specified host.  
#### Syntax  
```  
dnscmd [<ServerName>] /nodedelete <ZoneName> <NodeName> [/tree] [/f]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone.  
**<NodeName>**  
Specifies the host name of the node to delete.  
**/tree**  
deletes all the child records.  
**/f**  
executes the command without asking for confirmation.  
#### Example  
See [Example 6: delete the records from a node](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_14"></a>dnscmd /recordadd  
adds a record to a specified zone in a DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /recordadd <ZoneName> <NodeName> <RRtype> <Rrdata>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the zone in which the record resides.  
**<NodeName>**  
Specifies a specific node in the zone.  
**<RRtype>**  
Specifies the type of record to be added.  
**<Rrdata>**  
Specifies the type of data that is expected.  
> [!NOTE]  
> When you add a record, make sure that you use the correct data type and data format. For a list of resource record types and the appropriate data types, see [Resource records reference](https://technet.microsoft.com/library/cc758321(v=ws.10).aspx).  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /recordadd test A 10.0.0.5  
dnscmd /recordadd test.contoso.com test MX 10 mailserver.test.contoso.com</pre>  
### <a name="BKMK_15"></a>dnscmd /recorddelete  
deletes a resource record from a specified zone.  
#### Syntax  
```  
dnscmd <ServerName> /recorddelete <ZoneName> <NodeName> <RRtype> <Rrdata>[/f]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the zone in which the resource record resides.  
**<NodeName>**  
Specifies the name of the host.  
**<RRtype>**  
Specifies the type of resource record to be deleted.  
**<Rrdata>**  
Specifies the type of data that is expected.  
**/f**  
executes the command without asking for confirmation:  
-   Because nodes can have more than one resource record, this command requires you to be very specific about the type of resource record that you want to delete.  
-   if you specify a data type and you do not specify a type of resource record data, all records with that specific data type for the specified node are deleted.  
#### Sample usage  
`dnscmd /recorddelete test.contoso.com test MX 10 mailserver.test.contoso.com`  
### <a name="BKMK_16"></a>dnscmd /resetforwarders  
selects or resets the IP addresses to which the DNS server forwards DNS queries when it cannot resolve them locally.  
#### Syntax  
```  
dnscmd [<ServerName>] /resetforwarders [<IPaddress> [,<IPaddress>]...][/timeout <timeOut>] [/slave|/noslave]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<IPaddress>**  
lists the IP addresses to which the DNS server forwards unresolved queries.  
**/timeout <timeOut>**  
Sets the number of seconds that the DNS server waits for a response from the forwarder. By default, this value is five seconds.  
**/slave|/noslave**  
Determines whether the DNS server performs its own iterative queries if the forwarder fails to resolve a query:  
**/slave**  
Prevents the DNS server from performing its own iterative queries if the forwarder fails to resolve a query.  
**/noslave**  
Allows the DNS server to perform its own iterative queries if the forwarder fails to resolve a query. This is the default setting.  
#### remarks  
-   By default, a DNS server performs iterative queries when it cannot resolve a query.  
-   Setting IP addresses by using the **resetforwarders** command causes the DNS server to perform recursive queries to the DNS servers at the specified IP addresses. If the forwarders do not resolve the query, the DNS server can then perform its own iterative queries.  
-   if the **/slave** parameter is used, the DNS server does not perform its own iterative queries. This means that the DNS server forwards unresolved queries only to the DNS servers in the list, and it does not attempt iterative queries if the forwarders do not resolve them. It is more efficient to set one IP address as a forwarder for a DNS server. You can use the **resetforwarders** command for internal servers in a network to forward their unresolved queries to one DNS server that has an external connection.  
-   listing a forwarder s IP address twice causes the DNS server to attempt to forward to that server twice.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /resetforwarders 10.0.0.1 /timeout 7 /slave  
dnscmd dnssvr1.contoso.com /resetforwarders /noslave</pre>  
### <a name="BKMK_17"></a>dnscmd /resetlistenaddresses  
Specifies the IP addresses on a server that listens for DNS client requests.  
#### Syntax  
```  
dnscmd [<ServerName>] /resetlistenaddresses [<listenaddress>]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<listenaddress>**  
Specifies an IP address on the DNS server that listens for DNS client requests. If no listen address is specified, all IP addresses on the server listen for client requests.  
#### remarks  
-   By default, all IP addresses on a DNS server listen for client DNS requests.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /resetlistenaddresses 10.0.0.1`  
### <a name="BKMK_18"></a>dnscmd /startscavenging  
Tells a DNS server to attempt an immediate search for stale resource records in a specified DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /startscavenging  
```  
#### Parameter  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
#### remarks  
-   Successful completion of this command starts a scavenge immediately.  
-   Although the command to start the scavenge appears to complete successfully, the scavenge does not start unless the following preconditions are met:  
    -   Scavenging is enabled for both the server and the zone.  
    -   The zone is started.  
    -   The resource records have a time stamp.  
-   for information about how to enable scavenging for the server, see the **scavenginginterval** parameter under Server-level syntax in the [config](#BKMK_3) section.  
-   for information about how to enable scavenging for the zone, see the **aging** parameter under Zone-level syntax in the [config](#BKMK_3) section.  
-   for information about how to start a zone that is paused, see the [zoneresume](#BKMK_35) section.  
-   for information about how to check resource records for a time stamp, see the [ageallrecords](#BKMK_1) section.  
-   if the scavenge fails, no warning message appears.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /startscavenging`  
### <a name="BKMK_19"></a>dnscmd /statistics  
Displays or clears data for a specified DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /statistics [<StatID>] [/clear]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<StatID>**  
Specifies which statistic or combination of statistics to display. An identification number is used to identify a statistic. If no statistic ID number is specified, all statistics display.  
The following is a list of numbers that can be specified and the corresponding statistic that displays:  
**00000001**  
time  
**00000002**  
query  
**00000004**  
query2  
**00000008**  
Recurse  
**00000010**  
Master  
**00000020**  
Secondary  
**00000040**  
WINS  
**00000100**  
Update  
**00000200**  
SkwanSec  
**00000400**  
Ds  
**00010000**  
Memory  
**00100000**  
PacketMem  
**00040000**  
Dbase  
**00080000**  
Records  
**00200000**  
NbstatMem  
**/clear**  
resets the specified statistics counter to zero.  
#### remarks  
-   The **statistics** command displays counters that begin on the DNS server when it is started or resumed.  
#### Examples  
See [Example 7: Display time statistics for a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx) or [Example 8: Display NbstatMem statistics for a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_20"></a>dnscmd /unenlistdirectorypartition  
removes the DNS server from the specified directory partition's replica set.  
#### Syntax  
```  
dnscmd [<ServerName>] /unenlistdirectorypartition <PartitionFQDN>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<PartitionFQDN>**  
The FQDN of the DNS application directory partition that will be removed.  
### <a name="BKMK_21"></a>dnscmd /writebackfiles  
Checks the DNS server memory for changes, and writes them to persistent storage.  
#### Syntax  
```  
dnscmd [<ServerName>] /writebackfiles [<ZoneName>]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be updated.  
#### remarks  
-   The **writebackfiles** command updates all dirty zones or a specified zone. A zone is dirty when there are changes in memory that have not yet been written to persistent storage. This is a server-level operation that checks all zones. You can specify one zone in this operation or you can use the [zonewriteback](#BKMK_37) operation.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /writebackfiles`  
### <a name="BKMK_22"></a>dnscmd /zoneadd  
adds a zone to the DNS server.  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneadd <ZoneName> <Zonetype> [/dp <FQDN>| {/domain|/enterprise|/legacy}]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone.  
**<Zonetype>**  
Specifies the type of zone to create. Each zone type has different required parameters:  
**/dsprimary**  
creates an active directory integrated zone.  
**/primary /file <FileName>**  
creates a standard primary zone, and specifies the name of the file that will store the zone information.  
**/secondary <MasterIPaddress> [<MasterIPaddress>...]**  
creates a standard secondary zone.  
**/stub <MasterIPaddress> [<MasterIPaddress>...] /file <FileName>**  
creates a file-backed stub zone.  
**/dsstub <MasterIPaddress> [<MasterIPaddress>...]**  
creates an active directory integrated stub zone.  
**/forwarder <MasterIPaddress> [<MasterIPaddress>]... /file <FileName>**  
Specifies that the created zone forwards unresolved queries to another DNS server.  
**/dsforwarder**  
Specifies that the created active directory integrated zone forwards unresolved queries to another DNS server.  
**/dp <FQDN> {/domain | /enterprise | /legacy}**  
Specifies the directory partition on which to store the zone.  
**<FQDN>**  
Specifies FQDN of the directory partition.  
**/domain**  
Stores the zone on the domain directory partition.  
**/enterprise**  
Stores the zone on the enterprise directory partition.  
**/legacy**  
Stores the zone on a legacy directory partition.  
#### remarks  
-   Specifying a zone type of **/forwarder** or **/dsforwarder** creates a zone that performs conditional forwarding.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /zoneadd test.contoso.com /dsprimary  
dnscmd dnssvr1.contoso.com /zoneadd secondtest.contoso.com /secondary 10.0.0.2</pre>  
### <a name="BKMK_23"></a>dnscmd /zonechangedirectorypartition  
changes the directory partition on which the specified zone resides.  
#### Syntax  
```  
dnscmd [<ServerName>] /zonechangedirectorypartition <ZoneName>] {[<NewPartitionName>] | [<Zonetype>] }  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
The FQDN of the current directory partition on which the zone resides.  
**<NewPartitionName>**  
The FQDN of the directory partition that the zone will be moved to.  
**<Zonetype>**  
Specifies the type of directory partition that the zone will be moved to.  
**/domain**  
moves the zone to the built-in domain directory partition.  
**/forest**  
moves the zone to the built-in forest directory partition.  
**/legacy**  
moves the zone to the directory partition that is created for pre active directory domain controllers. These directory partitions are not necessary for native mode.  
### <a name="BKMK_24"></a>dnscmd /zonedelete  
deletes a specified zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /zonedelete <ZoneName> [/dsdel] [/f]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be deleted.  
**/dsdel**  
deletes the zone from AD DS.  
**/f**  
Runs the command without asking for confirmation.  
#### Example  
See [Example 9: delete a zone from a DNS server](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_25"></a>dnscmd /zoneexport  
creates a text file that lists the resource records of a specified zone.  
#### Syntax  
`dnscmd [<ServerName>] /zoneexport <ZoneName> <ZoneExportFile>`  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone.  
**<ZoneExportFile>**  
Specifies the name of the file to create.  
#### remarks  
-   The **zoneexport** operation creates a file of resource records for an active directory integrated zone for troubleshooting purposes. By default, the file that this command creates is placed in the DNS directory, which is by default the %systemroot%/System32/Dns directory.  
#### Example  
See [Example 10: Export zone resource records list to a file](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_26"></a>dnscmd /zoneinfo  
Displays settings from the section of the registry of the specified zone: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters\Zones\\<ZoneName>**  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneinfo <ZoneName>  [<Setting>]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone.  
**<Setting>**  
You can individually specify any setting that the **zoneinfo** command returns. If you do not specify a setting, all settings are returned.  
#### remarks  
-   The **zoneinfo** command displays registry settings that are at the DNS zone level at **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters\Zones\\<ZoneName>**.  
-   To display server-level registry settings, use the [info](#BKMK_12) command.  
-   To see a list of settings that you can display with this command, see the [config](#BKMK_3) command.  
#### Example  
See [Example 11: Display RefreshInterval setting from the registry](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx) or [Example 12: Display Aging setting from the registry](https://technet.microsoft.com/library/cc784399(v=ws.10).aspx).  
### <a name="BKMK_27"></a>dnscmd /zonepause  
pauses the specified zone, which then ignores query requests.  
#### Syntax  
```  
dnscmd [<ServerName>] /zonepause <ZoneName>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be paused.  
#### remarks  
-   To resume a zone and make it available after it has been paused, use the [zoneresume](#BKMK_35) command.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zonepause test.contoso.com`  
### <a name="BKMK_28"></a>dnscmd /zoneprint  
lists the records in a zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneprint <ZoneName>  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Identifies the zone to be listed.  
### <a name="BKMK_30"></a>dnscmd /zonerefresh  
forces a secondary DNS zone to update from the master zone.  
#### Syntax  
```  
dnscmd <ServerName> /zonerefresh <ZoneName>   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be refreshed.  
#### remarks  
-   The **zonerefresh** command forces a check of the version number in the master server s start of authority (SOA) resource record. If the version number on the master server is higher than the secondary server's version number, a zone transfer is initiated that updates the secondary server. If the version number is the same, no zone transfer occurs.  
-   The forced check occurs by default every 15 minutes. To change the default, use the **dnscmd config refreshinterval** command.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zonerefresh test.contoso.com`  
### <a name="BKMK_31"></a>dnscmd /zonereload  
Copies zone information from its source.  
#### Syntax  
```  
dnscmd <ServerName> /zonereload <ZoneName>   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be reloaded.  
#### remarks  
-   if the zone is active directory integrated, it reloads from AD DS.  
-   if the zone is a standard file-backed zone, it reloads from a file.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zonereload test.contoso.com`  
### <a name="BKMK_32"></a>dnscmd /zoneresetmasters  
resets the IP addresses of the master server that provides zone transfer information to a secondary zone.  
#### Syntax  
```  
dnscmd <ServerName> /zoneresetmasters <ZoneName> [/local] [<IPaddress> [<IPaddress>]...]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to be reloaded.  
**/local**  
Sets a local master list. This parameter is used for active directory integrated zones.  
**<IPaddress>**  
The IP addresses of the master servers of the secondary zone.  
#### remarks  
-   This value is originally set when the secondary zone is created. Use the **zoneresetmasters** command on the secondary server. This value has no effect if it is set on the master DNS server.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /zoneresetmasters test.contoso.com 10.0.0.1  
dnscmd dnssvr1.contoso.com /zoneresetmasters test.contoso.com /local</pre>  
### <a name="BKMK_33"></a>dnscmd /zoneresetscavengeservers  
changes the IP addresses of the servers that can scavenge the specified zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneresetscavengeservers <ZoneName> [<IPaddress> [<IPaddress>]...]  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Identifies the zone to scavenge.  
**<IPaddress>**  
lists the IP addresses of the servers that can perform the scavenge. If this parameter is omitted, all servers that host this zone can scavenge it.  
#### remarks  
-   By default, all servers that host a zone can scavenge that zone.  
-   if a zone is hosted on more than one DNS server, you can use this command to reduce the number of times a zone is scavenged.  
-   Scavenging must be enabled on the DNS server and zone that is affected by this command.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zoneresetscavengeservers test.contoso.com 10.0.0.1 10.0.0.2`  
### <a name="BKMK_34"></a>dnscmd /zoneresetsecondaries  
Specifies a list of IP addresses of secondary servers to which a master server responds when it is asked for a zone transfer.  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneresetsecondaries <ZoneName> {/noxfr | /nonsecure | /securens | /securelist <SecurityIPaddresses>} {/nonotify | /notify | /notifylist <NotifyIPaddresses>}  
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If the is parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone that will have its secondary servers reset.  
**/noxfr | /nonsecure | /securens | /securelist <SecurityIPaddresses>**  
Specifies whether all or only some of the secondary servers requesting an update get an update.  
**/noxfr**  
Specifies that no zone transfers are allowed.  
**/nonsecure**  
Specifies that all zone transfer requests are granted.  
**/securens**  
Specifies that only the server that is listed in the name server (NS) resource record for the zone is granted a transfer.  
**/securelist**  
Specifies that zone transfers are granted only to the list of servers. This parameter must be followed by an IP address or addresses that the master server uses.  
**<SecurityIPaddresses>**  
lists the IP addresses that receive zone transfers from the master server. This parameter is used only with the **/securelist** parameter.  
**/nonotify | /notify | /notifylist <NotifyIPaddresses>**  
Specifies that a change notification is sent only to certain secondary servers:  
**/nonotify**  
Specifies that no change notifications are sent to secondary servers.  
**/notify**  
Specifies that change notifications are sent to all secondary servers.  
**/notifylist**  
Specifies that change notifications are sent to only the list of servers. This command must be followed by an IP address or addresses that the master server uses.  
**<NotifyIPaddresses>**  
Specifies the IP address or addresses of the secondary server or servers to which change notifications are sent. This list is used only with the **/notifylist** parameter.  
#### remarks  
-   Use the **zoneresetsecondaries** command on the master server to specify how it responds to zone transfer requests from secondary servers.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /zoneresetsecondaries test.contoso.com /noxfr /nonotify  
dnscmd dnssvr1.contoso.com /zoneresetsecondaries test.contoso.com /securelist 11.0.0.2</pre>  
### <a name="BKMK_29"></a>dnscmd /zoneresettype  
changes the type of the zone.  
#### Syntax  
```  
dnscmd [<ServerName>] /zoneresettype <ZoneName> <Zonetype> [/overwrite_mem | /overwrite_ds]   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by local computer syntax, IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Identifies the zone on which the type will be changed.  
**<Zonetype>**  
Specifies the type of zone to create. Each type has different required parameters:  
**/dsprimary**  
creates an active directory integrated zone.  
**/primary /file <FileName>**  
creates a standard primary zone.  
**/secondary <MasterIPaddress> [,<MasterIPaddress>...]**  
creates a standard secondary zone.  
**/stub <MasterIPaddress>[,<MasterIPaddress>...] /file <FileName>**  
creates a file-backed stub zone.  
**/dsstub <MasterIPaddress>[,<MasterIPaddress>...]**  
creates an active directory integrated stub zone.  
**/forwarder <MasterIPaddress[,<MasterIPaddress>]... /file<FileName>**  
Specifies that the created zone forwards unresolved queries to another DNS server.  
**/dsforwarder**  
Specifies that the created active directory integrated zone forwards unresolved queries to another DNS server.  
**/overwrite_mem | /overwrite_ds**  
Specifies how to overwrite existing data:  
**/overwrite_mem**  
Overwrites DNS data from data in AD DS.  
**/overwrite_ds**  
Overwrites existing data in AD DS.  
#### remarks  
-   Setting the zone type as **/dsforwarder** creates a zone that performs conditional forwarding.  
#### Sample usage  
<pre>dnscmd dnssvr1.contoso.com /zoneresettype test.contoso.com /primary /file test.contoso.com.dns  
dnscmd dnssvr1.contoso.com /zoneresettype second.contoso.com /secondary 10.0.0.2</pre>  
### <a name="BKMK_35"></a>dnscmd /zoneresume  
starts a specified zone that was previously paused.  
#### Syntax  
```  
dnscmd <ServerName> /zoneresume <ZoneName>   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to resume.  
#### remarks  
-   You can use this operation to reverse the [zonepause](#BKMK_27) operation.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zoneresume test.contoso.com`  
### <a name="BKMK_36"></a>dnscmd /zoneupdatefromds  
Updates the specified active directory integrated zone from AD DS.  
#### Syntax  
```  
dnscmd <ServerName> /zoneupdatefromds <ZoneName>   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to update.  
#### remarks  
-   active directory integrated zones perform this update by default every five minutes. To change this parameter, use the **dnscmd config dspollinginterval** command.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zoneupdatefromds`  
### <a name="BKMK_37"></a>dnscmd /zonewriteback  
Checks DNS server memory for changes that are relevant to a specified zone, and writes them to persistent storage.  
#### Syntax  
```  
dnscmd <ServerName> /zonewriteback <ZoneName>   
```  
#### Parameters  
**<ServerName>**  
Specifies the DNS server to manage, represented by IP address, FQDN, or host name. If this parameter is omitted, the local server is used.  
**<ZoneName>**  
Specifies the name of the zone to update.  
#### remarks  
-   This is a zone-level operation. You can update all zones on a DNS server with the [writebackfiles](#BKMK_21) operation.  
#### Sample usage  
`dnscmd dnssvr1.contoso.com /zonewriteback test.contoso.com`  
