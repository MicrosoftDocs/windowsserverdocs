---
ms.topic: include
author: robinharwood
ms.author: roharwoo
ms.date: 08/29/2018
---

There are many ways to configure name resolution for the fabric domain. 
One simple way is to set up a conditional forwarder zone in DNS for the fabric. 
To set up this zone, run the following commands in an elevated Windows PowerShell console on a fabric DNS server. 
Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. 
Add the parameter `-MasterServers` for the additional HGS nodes.

```
Add-DnsServerConditionalForwarderZone -Name 'bastion.local' -ReplicationScope "Forest" -MasterServers <IP addresses of HGS server>
```

<!-- Appears in guarded-fabric-configuring-fabric-dns-ad.md and guarded-fabric-configuring-fabric-dns.md and set-up-hgs-for-always-encrypted-in-sql-server.md
-->    