---
title: Disable DNS client-side caching on DNS clients
description: This article introduces how to disable DNS client-side caching on DNS clients.
manager: dcscontentpm
ms.prod: 
ms.technology: networking-dns
ms.topic: article
ms.author: delhan
ms.date: 8/8/2019
author: Deland-Han
---

# Disable DNS client-side caching on DNS clients

Windows contains a client-side DNS cache. The client-side DNS caching feature may generate a false impression that DNS "round robin" load balancing is not occurring from the DNS server to the Windows client computer. When you use the ping command to search for the same A-record domain name, the client may use the same IP address.  

## How to disable client-side caching

To stop DNS caching, run either of the following commands:

```cmd
net stop dnscache
```

```cmd
sc servername stop dnscache
```


To disable the DNS cache permanently in Windows, use the Service Controller tool or the Services tool to set the DNS Client service startup type to **Disabled**. Note that the name of the Windows DNS Client service may also appear as "Dnscache." 

> [!NOTE]
> If the DNS resolver cache is deactivated, the overall performance of the client computer decreases and the network traffic for DNS queries increases. 

The DNS Client service optimizes the performance of DNS name resolution by storing previously resolved names in memory. If the DNS Client service is turned off, the computer can still resolve DNS names by using the network's DNS servers. 

When the Windows resolver receives a response, either positive or negative, to a query, it adds that response to its cache and thereby creates a DNS resource record. The resolver always checks the cache before it queries any DNS server. If a DNS resource record is in the cache, the resolver uses the record from the cache instead of querying a server. This behavior expedites queries and decreases network traffic for DNS queries. 

You can use the ipconfig tool to view and flush the DNS resolver cache. To view the DNS resolver cache, run the following command at a command prompt:

```cmd
ipconfig /displaydns 
```

This command displays the contents of the DNS resolver cache, including the DNS resource records that are preloaded from the Hosts file and any recently queried names that were resolved by the system. After some time, the resolver discards the record from the cache. The time period is specified by the **Time to Live (TTL)** value that is associated with the DNS resource record. You can also flush the cache manually. After you flush the cache, the computer must query DNS servers again for any DNS resource records that were previously resolved by the computer. To delete the entries in the DNS resolver cache, run `ipconfig /flushdns` at a command prompt.

## Using the registry to control the caching time

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

The length of time for which a positive or negative response is cached depends on the values of entries in the following registry key:

**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters**

The TTL for positive responses is the lesser of the following values: 

- The number of seconds specified in the query response the resolver received

- The value of the **MaxCacheTtl** registry setting.

>[!Note]
>- The default TTL for positive responses is 86,400 seconds (1 day).
>- The TTL for negative responses is the number of seconds specified in the MaxNegativeCacheTtl registry setting.
>- The default TTL for negative responses is 900 seconds (15 minutes).
If you do not want negative responses to be cached, set the MaxNegativeCacheTtl registry setting to 0.

To set the caching time on a client computer:

1. Start Registry Editor (Regedit.exe).

2. Locate and then click the following key in the registry:

   **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters**

3. On the Edit menu, point to New, click DWORD Value, and then add the following registry values:

   - Value name: MaxCacheTtl

     Data type: REG_DWORD

     Value data: Default value 86400 seconds. 
     
     If you lower the Maximum TTL value in the client's DNS cache to 1 second, this gives the appearance that the client-side DNS cache has been disabled.    

   - Value name: MaxNegativeCacheTtl

     Data type: REG_DWORD

     Value data: Default value 900 seconds. 
     
     Set the value to 0 if you do not want negative responses to be cached.

4. Type the value that you want to use, and then click OK.

5. Quit Registry Editor.