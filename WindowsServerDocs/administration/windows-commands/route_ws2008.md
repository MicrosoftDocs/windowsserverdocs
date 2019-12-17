---
title: route_ws2008
description: Learn how to modify and display entries in the local IP routing table.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afcd666c-0cef-47c2-9bcc-02d202b983b3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# route_ws2008

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays and modifies the entries in the local IP routing table. Used without parameters, **route** displays help.   

## Syntax  
```  
route [/f] [/p] [<Command> [<Destination>] [mask <Netmask>] [<Gateway>] [metric <Metric>]] [if <Interface>]]  
```  

### Parameters  

|Parameter|Description|  
|-------|--------|  
|/f|Clears the routing table of all entries that are not host routes (routes with a netmask of 255.255.255.255), the loopback network route (routes with a destination of 127.0.0.0 and a netmask of 255.0.0.0), or a multicast route (routes with a destination of 224.0.0.0 and a netmask of 240.0.0.0). If this is used in conjunction with one of the commands (such as add, change, or delete), the table is cleared prior to running the command.|  
|/p|When used with the add command, the specified route is added to the registry and is used to initialize the IP routing table whenever the TCP/IP protocol is started. By default, added routes are not preserved when the TCP/IP protocol is started. When used with the print command, the list of persistent routes is displayed. This parameter is ignored for all other commands. Persistent routes are stored in the registry location **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\PersistentRoutes**.|  
|\<Command>|Specifies the command you want to run. The following table lists valid commands:<br /><br />-   **add:** adds a route.<br />-   **change:** modifies an existing route.<br />-   **delete:** deletes a route or routes.<br />-   **print:** prints a route or routes.|  
|\<Destination>|Specifies the network destination of the route. The destination can be an IP network address (where the host bits of the network address are set to 0), an IP address for a host route, or 0.0.0.0 for the default route.|  
|mask \<Netmask>|Specifies the network destination of the route. The destination can be an IP network address (where the host bits of the network address are set to 0), an IP address for a host route, or 0.0.0.0 for the default route.|  
|\<Gateway>|Specifies the forwarding or next hop IP address over which the set of addresses defined by the network destination and subnet mask are reachable. For locally attached subnet routes, the gateway address is the IP address assigned to the interface that is attached to the subnet. For remote routes, available across one or more routers, the gateway address is a directly reachable IP address that is assigned to a neighboring router.|  
|metric \<Metric>|Specifies an integer cost metric (ranging from 1 to 9999) for the route, which is used when choosing among multiple routes in the routing table that most closely match the destination address of a packet being forwarded. The route with the lowest metric is chosen. The metric can reflect the number of hops, the speed of the path, path reliability, path throughput, or administrative properties.|  
|if \<Interface>|Specifies the interface index for the interface over which the destination is reachable. For a list of interfaces and their corresponding interface indexes, use the display of the route print command. You can use either decimal or hexadecimal values for the interface index. For hexadecimal values, precede the hexadecimal number with 0x. When the if parameter is omitted, the interface is determined from the gateway address.|  
|/?|Displays help at the command prompt.|  

## Remarks  
- Large values in the **metric** column of the routing table are the result of allowing TCP/IP to automatically determine the metric for routes in the routing table based on the configuration of IP address, subnet mask, and default gateway for each LAN interface. Automatic determination of the interface metric, enabled by default, determines the speed of each interface and adjusts the metrics of routes for each interface so that the fastest interface creates the routes with the lowest metric. To remove the large metrics, disable the automatic determination of the interface metric from the advanced properties of the TCP/IP protocol for each LAN connection.  
- Names can be used for *Destination* if an appropriate entry exists in the local Networks file stored in the <strong>systemroot\System32\Drivers\\</strong>Etc folder. Names can be used for the *gateway* as long as they can be resolved to an IP address through standard host name resolution techniques such as Domain Name System (DNS) queries, use of the local Hosts file stored in the <strong>systemroot\system32\drivers\\</strong>etc folder, and NetBIOS name resolution.  
- if the command is **print** or **delete**, the *Gateway* parameter can be omitted and wildcards can be used for the destination and gateway. The *Destination* value can be a wildcard value specified by an asterisk (*). If the destination specified contains an asterisk (\*) or a question mark (?), it is treated as a wildcard and only matching destination routes are printed or deleted. The asterisk matches any string, and the question mark matches any single character. For example, 10.\*.1, 192.168.\*, 127.\*, and \*224\* are all valid uses of the asterisk wildcard.  
- Using an invalid combination of a destination and subnet mask (netmask) value displays a "Route: bad gateway address netmask" error message. This error message appears when the destination contains one or more bits set to 1 in bit locations where the corresponding subnet mask bit is set to 0. To test this condition, express the destination and subnet mask using binary notation. The subnet mask in binary notation consists of a series of 1 bits, representing the network address portion of the destination, and a series of 0 bits, representing the host address portion of the destination. Check to determine whether there are bits in the destination that are set to 1 for the portion of the destination that is the host address (as defined by the subnet mask).  
- The **/p** parameter is only supported on the route command for Windows NT 4.0, Windows 2000, Windows Millennium edition, Windows XP, and Windows Server 2003. This parameter is not supported by the **route** command for Windows 95 or Windows 98.  
- This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.  

## <a name="BKMK_Examples"></a>Examples  
To display the entire contents of the IP routing table, type:  
```  
route print  
```  
To display the routes in the IP routing table that begin with 10, type:  
```  
route print 10.*  
```  
To add a default route with the default gateway address of 192.168.12.1, type:  
```  
route add 0.0.0.0 mask 0.0.0.0 192.168.12.1  
```  
To add a route to the destination 10.41.0.0 with the subnet mask of 255.255.0.0 and the next hop address of 10.27.0.1, type:  
```  
route add 10.41.0.0 mask 255.255.0.0 10.27.0.1  
```  
To add a persistent route to the destination 10.41.0.0 with the subnet mask of 255.255.0.0 and the next hop address of 10.27.0.1, type:  
```  
route /p add 10.41.0.0 mask 255.255.0.0 10.27.0.1  
```  
To add a route to the destination 10.41.0.0 with the subnet mask of 255.255.0.0, the next hop address of 10.27.0.1, and the cost metric of 7, type:  
```  
route add 10.41.0.0 mask 255.255.0.0 10.27.0.1 metric 7  
```  
To add a route to the destination 10.41.0.0 with the subnet mask of 255.255.0.0, the next hop address of 10.27.0.1, and using the interface index 0x3, type:  
```  
route add 10.41.0.0 mask 255.255.0.0 10.27.0.1 if 0x3  
```  
To delete the route to the destination 10.41.0.0 with the subnet mask of 255.255.0.0, type:  
```  
route delete 10.41.0.0 mask 255.255.0.0  
```  
To delete all routes in the IP routing table that begin with 10, type:  
```  
route delete 10.*  
```  
To change the next hop address of the route with the destination of 10.41.0.0 and the subnet mask of 255.255.0.0 from 10.27.0.1 to 10.27.0.25, type:  
```  
route change 10.41.0.0 mask 255.255.0.0 10.27.0.25  
```  

## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
