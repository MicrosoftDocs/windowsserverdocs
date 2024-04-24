---
title: wdsutil set-transportserver
description: Reference article for Subcommand set-TransportServer, which sets configuration settings for a Transport Server.
ms.topic: reference
ms.assetid: 7863225c-f4b2-4cd0-b929-78a454bef249
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# wdsutil set-transportserver

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets configuration settings for a Transport Server.

## Syntax
```
wdsutil [Options] /Set-TransportServer [/Server:<Server name>]
     [/ObtainIpv4From:{Dhcp | Range}]
        [/start:<starting IP address>]
        [/End:<Ending IP address>]
     [/ObtainIpv6From:Range]\n\
        [/start:<start IP address>]\n\
        [/End:<End IP address>]
     [/startPort:<starting port>
        [/EndPort:<starting port>
     [/Profile:{10Mbps | 100Mbps | 1Gbps | Custom}]
     [/MulticastSessionPolicy]
             [/Policy:{None | AutoDisconnect | Multistream}]
                 [/Threshold:<Speed in KBps>]
                 [/StreamCount:{2 | 3}]
                 [/Fallback:{Yes | No}]
```
### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the Transport Server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no Transport Server name is specified, the local server is used.|
|[/ObtainIpv4From:{Dhcp \| Range}]|Sets the source of the IPv4 addresses as follows:<p>-   [/start: \<IP address\>]  Sets the start of the IP address range. This is required and valid only if this option is set to **Range**.<br />-   [/End: \<IP address\>]  Sets the end of the IP address range. This is required and valid only if this option is set to **Range**.<br />-   [/startPort: \<port\>]  Sets the start of the port range.<br />-   [/EndPort: \<port\>]  Sets the end of the port range.|
|[/ObtainIpv6From:Range]|Specifies the source of IPv6 addresses. This option only applies to Windows Server 2008 R2 and the only supported value is **Range**.<p>-   [/start: \<IP address\>]  Sets the start of the IP address range. This is required and valid only if this option is set to **Range**.<br />-   [/End: \<IP address\>]  Sets the end of the IP address range. This is required and valid only if this option is set to **Range**.<br />-   [/startPort: \<port\>]  Sets the start of the port range.<br />-   [/EndPort: \<port\>]  Sets the end of the port range.|
|[/Profile: {10Mbps \| 100Mbps \| 1Gbps \| Custom}]|Specifies the network profile to be used. This option is only available for servers running Windows Server 2008 or Windows Server 2003.|
|[/MulticastSessionPolicy]|Configures the transfer settings for multicast transmissions. This command is only available for Windows Server 2008 R2.<p>-   [/Policy:{None \| AutoDisconnect \| Multistream}]  Determines how to handle slow clients. **None** means to keep all clients in one session at the same speed. **AutoDisconnect** means that any clients that drop below the specified **/Threshold** are disconnected. **Multistream** means clients will be separated into multiple sessions as specified by **/StreamCount**.<br />-   [/Threshold:\<Speed in KBps\>]  Sets the minimum transfer rate in KBps for **/Policy:AutoDisconnect**. Clients that drop below this rate are disconnected from multicast transmissions.<br />-   [/StreamCount:{2 \| 3}] [/Fallback:{Yes \| No}]  Determines the number of sessions for **/Policy:Multistream**. **2** means two sessions (fast and slow), and **3** means three sessions (slow, medium, fast).<br />-   [/Fallback:{Yes \| No}]  Determines whether clients tha are disconnected will continue the transfer by using another method (if supported by the client). If you are using the WDS client, the computer will fall back to unicasting. Wdsmcast.exe does not support a fallback mechanism. This option also applies to clients that do not support **Multistream**. In that case, the computer will fall back to another method instead of moving to a slower transfer session.|

## Examples
To set the IPv4 address range for the server, type:
```
wdsutil /Set-TransportServer /ObtainIpv4From:Range /start:239.0.0.1 /End:239.0.0.100
```
To set the IPv4 address range, port range, and profile for the server, type:
```
wdsutil /Set-TransportServer /Server:MyWDSServer /ObtainIpv4From:Range /start:239.0.0.1 /End:239.0.0.100 /startPort:12000 /EndPort:50000 /Profile:10mbps
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-transportserver command](wdsutil-disable-transportserver.md)
- [wdsutil enable-transportserver command](wdsutil-enable-transportserver.md)
- [wdsutil get-transportserver command](wdsutil-get-transportserver.md)
- [wdsutil start-transportserver command](wdsutil-start-transportserver.md)
- [wdsutil stop-transportserver command](wdsutil-stop-transportserver.md)
