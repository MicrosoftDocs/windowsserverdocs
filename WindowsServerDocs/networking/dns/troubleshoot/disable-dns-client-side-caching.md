---
title: Disable DNS client-side caching on DNS clients
description: This article introduces how to disable DNS client-side caching on DNS clients.
manager: willchen
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

- ```cmd
  net stop dnscache
  ```

- ```cmd
  sc servername stop dnscache
  ```

To disable the DNS cache permanently in Windows, use the Service Controller tool or the Services tool to set the DNS Client service startup type to **Disabled**. Note that the name of the Windows DNS Client service may also appear as "Dnscache." 

>![Note]
>If the DNS resolver cache is deactivated, the overall performance of the client computer decreases and the network traffic for DNS queries increases. 

The DNS Client service optimizes the performance of DNS name resolution by storing previously resolved names in memory. If the DNS Client service is turned off, the computer can still resolve DNS names by using the network's DNS servers. 

When the Windows resolver receives a response, either positive or negative, to a query, it adds that response to its cache and thereby creates a DNS resource record. The resolver always checks the cache before it queries any DNS server. If a DNS resource record is in the cache, the resolver uses the record from the cache instead of querying a server. This behavior expedites queries and decreases network traffic for DNS queries. 

You can use the ipconfig tool to view and flush the DNS resolver cache. To view the DNS resolver cache, run the following command at a command prompt:

```cmd
ipconfig /displaydns 
```

This command displays the contents of the DNS resolver cache, including the DNS resource records that are preloaded from the Hosts file and any recently queried names that were resolved by the system. After some time, the resolver discards the record from the cache. The time period is specified by the **Time to Live (TTL)** value that is associated with the DNS resource record. You can also flush the cache manually. After you flush the cache, the computer must query DNS servers again for any DNS resource records that were previously resolved by the computer. To delete the entries in the DNS resolver cache, run `ipconfig /flushdns` at a command prompt.

## Next step

See [How to Disable Client-Side DNS Caching in Windows](https://support.microsoft.com/en-us/kb/318803) for more information.