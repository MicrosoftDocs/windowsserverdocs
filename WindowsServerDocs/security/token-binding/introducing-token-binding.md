---
title: Introducing Token Binding
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: 4623a48c-cefd-4a27-9173-2af58ac212f2
manager: alanth
author: justinha
ms.technology: security-authentication
ms.date: 11/09/2016
---

# Introducing Token Binding

>Applies To: Windows Server 2016 and Windows 10

The Token Binding protocol allows applications and services to cryptographically bind their security tokens to the TLS layer to mitigate token theft and replay attacks. 
The long-lived, uniquely identifiable TLS [RFC5246] bindings can span multiple TLS sessions and connections.

Version support:

- Windows 10, version 1507 – Off by default
    - Token Binding Protocol added [[draft-ietf-tokbind-protocol-01]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-protocol/01/)
    - WinInet & HTTP.SYS support of token binding over HTTP [[draft-ietf-tokbind-https-01]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-https/01/)
- Windows 10, versions 1511 and 1607, and Windows Server 2016 – On by default
    - Token Binding Protocol updated [[draft-ietf-tokbind-protocol-01]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-protocol/01/)
    - TLS extension for token binding negotiation added [[draft-popov-tokbind-negotiation-00]](https://tools.ietf.org/html/draft-popov-tokbind-negotiation-00)
    - WinInet & HTTP.SYS support of token binding over HTTP updated [[draft-ietf-tokbind-https-02]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-https/02/)
- Windows 10, version 1507 with servicing update [KB4034668](https://support.microsoft.com/kb/KB4034668), Windows 10, version 1511 with servicing update [KB4034660](https://support.microsoft.com/kb/KB4034660), Windows 10, version 1607 and Windows Server 2016 with servicing update [KB4034658](https://support.microsoft.com/kb/KB4034658) support Token Binding Protocol version 0.10 – On by default
    - Token Binding Protocol updated [[draft-ietf-tokbind-protocol-10]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-protocol/10/)
    - TLS extension for token binding negotiation added [[draft-ietf-tokbind-negotiation-05]](https://tools.ietf.org/html/draft-ietf-tokbind-negotiation-05)
    - WinInet & HTTP.SYS support of token binding over HTTP updated [[draft-ietf-tokbind-https-06]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-https/06/)
- Windows 10, version 1703 supports Token Binding Protocol version 0.10 – On by default
    - Token Binding Protocol updated [[draft-ietf-tokbind-protocol-10]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-protocol/10/)
    - TLS extension for token binding negotiation added [[draft-ietf-tokbind-negotiation-05]](https://tools.ietf.org/html/draft-ietf-tokbind-negotiation-05)
    - WinInet & HTTP.SYS support of token binding over HTTP updated [[draft-ietf-tokbind-https-06]](https://datatracker.ietf.org/doc/draft-ietf-tokbind-https/06/)
    - Windows devices with Virtualization-based security enabled will keep the token binding keys in a protected environment that is isolated from the running operating system

Information about ASP .NET support can be found at the [.NET Framework Reference Source](https://referencesource.microsoft.com/#System.Web/ITlsTokenBindingInfo.cs,4a5e5668f5c31170). 

For information about .NET Framework, see the following topics:

- [Networking enhancements](https://blogs.msdn.microsoft.com/dotnet/2015/11/30/net-framework-4-6-1-is-now-available/#networking)

- [.NET TokenBinding class](https://msdn.microsoft.com/library/system.security.authentication.extendedprotection.tokenbinding.aspx)
