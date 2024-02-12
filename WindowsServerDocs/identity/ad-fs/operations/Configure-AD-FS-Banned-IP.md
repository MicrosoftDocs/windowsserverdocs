---
title: Configure AD FS banned IP addresses
description: Learn more about banned IP addresses in AD FS
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# AD FS and banned IP addresses

AD FS on Windows Server 2016 introduced **Banned IPs** as part of the AD FS June 2018 update. This update enables you to configure a set of IP addresses globally in AD FS so that requests coming from those IP addresses are blocked. Requests that have IP addresses in the **x-forwarded-for** or **x-ms-forwarded-client-ip** headers are also blocked by AD FS.

## Adding banned IPs

To add banned IPs to the global list, use the below PowerShell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -AddBannedIps "1.2.3.4", "::3", "1.2.3.4/16"
```

Allowed formats are as follows:

- IPv4
- IPv6
- CIDR format with IPv4 or v6

There's a limit of 300 entries for banned IP addresses. You can use CIDR or range format to deny a large block of entries with a single entry.

## Removing banned IPs

To remove banned IPs from the global list, use the following PowerShell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -RemoveBannedIps "1.2.3.4"
```

### Reading banned IPs

To read the current set of banned IP addresses, use the following PowerShell cmdlet:

``` powershell
PS C:\ >Get-AdfsProperties
```

Example output:

```
BannedIpList                   : {1.2.3.4, ::3,1.2.3.4/16}
```

## Related links

[Best practices for securing Active Directory Federation Services](../../ad-fs/deployment/best-practices-securing-ad-fs.md)

[Set-AdfsProperties](/powershell/module/adfs/set-adfsproperties)

[AD FS Operations](../ad-fs-operations.md)
