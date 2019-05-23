---
title: Configure AD FS Banned IP Addesses
description:
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 06/28/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# AD FS and banned IP addresses


In June 2018, AD FS on Windows Server 2016 introduced **Banned IPs** with the AD FS June 2018 update.  This update enables you to configure a set of IP addresses globally in AD FS, so that requests coming from those IP addresses, or that have those IP addresses in the **x-forwarded-for** or **x-ms-forwarded-client-ip** headers, will be blocked by AD FS.

## Adding banned IPs
To add banned IPs to the global list, use the below Powershell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -AddBannedIps "1.2.3.4", "::3", "1.2.3.4/16"
```

Allowed formats

1.	IPv4
2.	IPv6
3.	CIDR format with IPv4 or v6

There is a limit of 300 entries for banned IP addresses. You can use CIDR or range format to deny a large block of entries with a single entry.

## Removing banned IPs
To remove banned IPs from the global list, use the below Powershell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -RemoveBannedIps "1.2.3.4"
```

#### Read banned IPs
To read the current set of banned IP addresses, use the below Powershell cmdlet:

``` powershell
PS C:\ >Get-AdfsProperties 
```

Example output:

```
BannedIpList                   : {1.2.3.4, ::3,1.2.3.4/16}
```



## Additional references  
[Best practices for securing Active Directory Federation Services](../../ad-fs/deployment/best-practices-securing-ad-fs.md)

[Set-AdfsProperties](https://technet.microsoft.com/itpro/powershell/windows/adfs/set-adfsproperties)

[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)
