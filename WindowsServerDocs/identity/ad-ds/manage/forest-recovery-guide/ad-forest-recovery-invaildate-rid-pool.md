---
description: "Learn more about: AD Forest Recovery - Invalidating the current RID pool"
title: AD Forest Recovery - Invalidating the RID Pool
ms.author: roharwoo
author: robinharwood
ms.date: 05/12/2025
ms.topic: how-to
---

# Active Directory Forest Recovery - Invalidate the current RID pool

Use the following procedure to use Windows PowerShell to invalidate the current RID pool on a domain controller. Windows PowerShell is enabled by default on Windows Server 2012 and Windows Server 2008 R2, but not Windows Server 2008 where it must be installed by using **Add Features**. It can be [downloaded](/troubleshoot/windows-server/system-management-components/windows-server-2003-service-pack-1-support-tools) to run on Windows Server 2003.

To verify the command completed successfully, check for event ID 16654 (source is Directory-Services-SAM) in the System log in Event Viewer in Windows Server 2012. Earlier versions of Windows don't log this event.

> [!NOTE]
> After you invalidate the RID pool, you will receive an error when you first attempt to create security principal (user, computer, or group). The attempt to create an object triggers a request for a new RID pool. Retry of the operation succeeds because the new RID pool will be allocated.

## Invalidate the current RID pool

- Open an elevated Windows PowerShell session, run the following command and press ENTER:

   ```powershell
   $Domain = New-Object System.DirectoryServices.DirectoryEntry
   $DomainSid = $Domain.objectSid
   $RootDSE = New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
   $RootDSE.UsePropertyCache = $false
   $RootDSE.Put("invalidateRidPool", $DomainSid.Value)
   $RootDSE.SetInfo()
   ```

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
