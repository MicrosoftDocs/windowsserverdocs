---
title: DirectAccess Known Issues
description: This topic provides a link to Microsoft Technical Support documents for DirectAccess in Windows Server 2016.
manager: brianlic
ms.topic: article
ms.assetid: 3511a91f-1d5d-45a0-97f2-3fc0d6f079b4
ms.author: jgerend
author: JasonGerend
ms.date: 06/19/2023
---
# DirectAccess Known Issues

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806260" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common DirectAccess issues.

>Applies to: Windows Server 2022, Windows Server 2016, Windows Server 2019

## DNS registration of DirectAccess client IPv6 addresses

Starting with the Windows 10 May 2020 Update, a client no longer registers its IP addresses on DNS servers configured in a Name Resolution Policy Table (NRPT).
If DNS registration is needed, for example **Manage Out**, it can be explicitly enabled with this registry key on the client:

Path: `HKLM\System\CurrentControlSet\Services\Dnscache\Parameters`<br/>
Type: `DWORD`<br/>
Value name: `DisableNRPTForAdapterRegistration`<br/>
Values:<br/>
`1` - DNS Registration disabled (default since the Windows 10 May 2020 Update)<br/>
`0` - DNS Registration enabled
