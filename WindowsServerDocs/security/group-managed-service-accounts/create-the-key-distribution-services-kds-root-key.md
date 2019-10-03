---
title: Create the Key Distribution Services KDS Root Key
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 42e5db8f-1516-4d42-be0a-fa932f5588e9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Create the Key Distribution Services KDS Root Key

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional describes how to create a Microsoft Key Distribution Service (kdssvc.dll) root key on the domain controller using Windows PowerShell to generate group Managed Service Account passwords in Windows Server 2012 or later.

Domain Controllers (DC) require a root key to begin generating gMSA passwords. The domain controllers will wait up to 10 hours from time of creation to allow all domain controllers to converge their AD replication before allowing the creation of a gMSA. The 10 hours is a safety measure to prevent password generation from occurring before all DCs in the environment are capable of answering gMSA requests.  If you try to use a gMSA too soon the key might not have been replicated to all domain controllers and therefore password retrieval might fail when the gMSA host attempts to retrieve the password. gMSA password retrieval failures can also occur when using DCs with limited replication schedules or if there is a replication issue.

> [!NOTE]
> Deleting and recreating the root key may lead to issues where the old key continues to be used after deletion due to caching of the key. The Key Distribution Service (KDC) should be restarted on all domain controllers if the root key is recreated.

Membership in the **Domain Admins** or **Enterprise Admins** groups, or equivalent, is the minimum required to complete this procedure. For detailed information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](https://technet.microsoft.com/library/dd728026(WS.10).aspx).

> [!NOTE]
> A 64-bit architecture is required to run the Windows PowerShell commands which are used to administer group Managed Service Accounts.

#### To create the KDS root key using the Add-KdsRootKey cmdlet

1.  On the Windows Server 2012 or later domain controller, run the Windows PowerShell from the Taskbar.

2.  At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

    **Add-KdsRootKey -EffectiveImmediately**

    > [!TIP]
    > The Effective time parameter can be used to give time for keys to be propagated to all DCs before use. Using Add-KdsRootKey -EffectiveImmediately will add a root key to the target DC which will be used by the KDS service immediately. However, other domain controllers will not be able to use the root key until replication is successful.

For test environments with only one DC, you can create a KDS root key and set the start time in the past to avoid the interval wait for key generation by using the following procedure. Validate that a 4004 event has been logged in the kds event log.

#### To create the KDS root key in a test environment for immediate effectiveness

1.  On the Windows Server 2012 or later domain controller, run the Windows PowerShell from the Taskbar.

2.  At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then press ENTER:

    **$a=Get-Date**

    **$b=$a.AddHours(-10)**

    **Add-KdsRootKey -EffectiveTime $b**

    Or use a single command

    **Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10))**

## See Also
[Getting Started with Group Managed Service Accounts](getting-started-with-group-managed-service-accounts.md)


