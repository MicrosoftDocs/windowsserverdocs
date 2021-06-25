---
title: DirectAccess Known Issues
description: This topic provides a link to Microsoft Technical Support documents for DirectAccess in Windows Server 2016.
manager: brianlic
ms.topic: article
ms.assetid: 3511a91f-1d5d-45a0-97f2-3fc0d6f079b4
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# DirectAccess Known Issues

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2019

## DNS registration of DirectAccess client IPv6 addresses

Starting with the Windows 10 May 2020 Update, a client no longer registers its IP addresses on DNS servers configured in a Name Resolution Policy Table (NRPT).
If DNS registration is needed, for example **Manage Out**, it can be explicitly enabled with this registry key on the client:

Path: `HKLM\System\CurrentControlSet\Services\Dnscache\Parameters`<br/>
Type: `DWORD`<br/>
Value name: `DisableNRPTForAdapterRegistration`<br/>
Values:<br/>
`1` - DNS Registration disabled (default since the Windows 10 May 2020 Update)<br/>
`0` - DNS Registration enabled

## Recommended hotfixes and updates for Windows Server 2012 DirectAccess
The following link lists Microsoft Technical Support documents for DirectAccess that you should review and apply before you start your deployment to avoid an unusable configuration.

-   [Recommended hotfixes and updates for Windows Server 2012 DirectAccess](https://support.microsoft.com/kb/2883952)


