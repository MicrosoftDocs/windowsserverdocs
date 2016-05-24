---
title: Ping
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49272671-2eec-4fa5-881f-65c24cfbef52
author: jaimeo
---
# Ping
Verifies IP\-level connectivity to another TCP\/IP computer by sending Internet Control Message Protocol \(ICMP\) Echo Request messages. The receipt of corresponding Echo Reply messages are displayed, along with round\-trip times. Ping is the primary TCP\/IP command used to troubleshoot connectivity, reachability, and name resolution. Used without parameters,  **ping** displays help. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
Ping [/t] [/a] [/n <Count>] [/l <Size>] [/f] [/I <TTL>] [/v <TOS>] [/r <Count>] [/s <Count>] [{/j <HostList> | /k <HostList>}] [/w <Timeout>] [/R] [/S <SrcAddr>] [/4] [/6] <TargetName>  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/t|Specifies that ping continue sending Echo Request messages to the destination until interrupted. To interrupt and display statistics, press CTRL\+BREAK. To interrupt and quit **ping**, press CTRL\+C.|  
|\/a|Specifies that reverse name resolution is performed on the destination IP address. If this is successful, ping displays the corresponding host name.|  
|\/n <Count>|Specifies the number of Echo Request messages sent. The default is 4.|  
|\/l <Size>|Specifies the length, in bytes, of the Data field in the Echo Request messages sent. The default is 32. The maximum Size is 65,527.|  
|\/f|Specifies that Echo Request messages are sent with the Do not Fragment flag in the IP header set to 1 \(available on IPv4 only\). The Echo Request message cannot be fragmented by routers in the path to the destination. This parameter is useful for troubleshooting path Maximum Transmission Unit \(PMTU\) problems.|  
|\/I <TTL>|Specifies the value of the TTL field in the IP header for Echo Request messages sent. The default is the default TTL value for the host. The maximum *TTL* is 255.|  
|\/v <TOS>|Specifies the value of the Type of Service \(TOS\) field in the IP header for Echo Request messages sent \(available on IPv4 only\). The default is 0. *TOS* is specified as a decimal value from 0 through 255.|  
|\/r <Count>|Specifies that the Record Route option in the IP header is used to record the path taken by the Echo Request message and corresponding Echo Reply message \(available on IPv4 only\). Each hop in the path uses an entry in the Record Route option. If possible, specify a *Count* that is equal to or greater than the number of hops between the source and destination. The *Count* must be a minimum of 1 and a maximum of 9.|  
|\/s <Count>|Specifies that the Internet Timestamp option in the IP header is used to record the time of arrival for the Echo Request message and corresponding Echo Reply message for each hop. The *Count* must be a minimum of 1 and a maximum of 4. This is required for link\-local destination addresses.|  
|\/j <HostList>|Specifies that the Echo Request messages use the Loose Source Route option in the IP header with the set of intermediate destinations specified in *HostList* \(available on IPv4 only\). With loose source routing, successive intermediate destinations can be separated by one or multiple routers. The maximum number of addresses or names in the host list is 9. The host list is a series of IP addresses \(in dotted decimal notation\) separated by spaces.|  
|\/k <HostList>|Specifies that the Echo Request messages use the Strict Source Route option in the IP header with the set of intermediate destinations specified in *HostList* \(available on IPv4 only\). With strict source routing, the next intermediate destination must be directly reachable \(it must be a neighbor on an interface of the router\). The maximum number of addresses or names in the host list is 9. The host list is a series of IP addresses \(in dotted decimal notation\) separated by spaces.|  
|\/w <Timeout>|Specifies the amount of time, in milliseconds, to wait for the Echo Reply message that corresponds to a given Echo Request message to be received. If the Echo Reply message is not received within the time\-out, the "Request timed out" error message is displayed. The default time\-out is 4000 \(4 seconds\).|  
|\/R|Specifies that the round\-trip path is traced \(available on IPv6 only\).|  
|\/S <SrcAddr>|Specifies the source address to use \(available on IPv6 only\).|  
|\/4|Specifies that IPv4 is used to ping. This parameter is not required to identify the target host with an IPv4 address. It is only required to identify the target host by name.|  
|\/6|Specifies that IPv6 is used to ping. This parameter is not required to identify the target host with an IPv6 address. It is only required to identify the target host by name.|  
|<TargetName>|Specifies the host name or IP address of the destination.|  
|\/?|Displays Help at the command prompt.|  
  
## Remarks  
  
-   You can use **ping** to test both the computer name and the IP address of the computer. If pinging the IP address is successful, but pinging the computer name is not, you might have a name resolution problem. In this case, ensure that the computer name you are specifying can be resolved through the local Hosts file, by using Domain Name System \(DNS\) queries, or through NetBIOS name resolution techniques.  
  
-   This command is available only if the Internet Protocol \(TCP\/IP\) protocol is installed as a component in the properties of a network adapter in Network Connections.  
  
## <a name="BKMK_Examples"></a>Examples  
The following example shows **ping** command output:  
  
```  
C:\>ping example.microsoft.com         
         Pinging example.microsoft.com [192.168.239.132] with 32 bytes of data:         
         Reply from 192.168.239.132: bytes=32 time=101ms TTL=124         
         Reply from 192.168.239.132: bytes=32 time=100ms TTL=124         
         Reply from 192.168.239.132: bytes=32 time=120ms TTL=124         
         Reply from 192.168.239.132: bytes=32 time=120ms TTL=124  
```  
  
To ping the destination 10.0.99.221 and resolve 10.0.99.221 to its host name, type:  
  
```  
ping /a 10.0.99.221  
```  
  
To ping the destination 10.0.99.221 with 10 Echo Request messages, each of which has a Data field of 1000 bytes, type:  
  
```  
ping /n 10 /l 1000 10.0.99.221  
```  
  
To ping the destination 10.0.99.221 and record the route for 4 hops, type:  
  
```  
ping /r 4 10.0.99.221  
```  
  
To ping the destination 10.0.99.221 and specify the loose source route of 10.12.0.1\-10.29.3.1\-10.1.44.1, type:  
  
```  
ping /j 10.12.0.1 10.29.3.1 10.1.44.1 10.0.99.221  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
