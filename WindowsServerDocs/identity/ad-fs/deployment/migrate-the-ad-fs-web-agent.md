---
title: Migrate the AD FS web agent
description: Provides information on the AD FS web agent to Windows Server 2012.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---

# Migrate the AD FS web agent

To migrate the AD FS 1.1 Windows token-based agent or the AD FS 1.1 claims-aware agent that is installed with Windows Server 2008 R2 or Windows Server 2008 to Windows Server 2012, perform an in-place upgrade of the operating system of the computer that hosts either agent to Windows Server 2012. For more information, see [Installing Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)). No further configuration is required.

> [!IMPORTANT]
>  The migrated AD FS 1.1 Windows token-based agent functions only with an AD FS 1.1 federation service that is installed with Windows Server 2008 R2 or Windows Server 2008. For more information, see [Interoperating with AD FS 1.x](Interoperating-with-AD-FS-1.x.md).
>
>  The migrated AD FS 1.1 claims-aware web agent functions with the following:
>
> - AD FS 1.1 federation service installed with Windows Server 2008 R2 or Windows Server 2008
>   -   AD FS 2.0 federation service installed on Windows Server 2008 R2 or Windows Server 2008
>   -   AD FS federation service installed with Windows Server 2012
>
>   For more information, see [Interoperating with AD FS 1.x](Interoperating-with-AD-FS-1.x.md).


## Next Steps
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)
