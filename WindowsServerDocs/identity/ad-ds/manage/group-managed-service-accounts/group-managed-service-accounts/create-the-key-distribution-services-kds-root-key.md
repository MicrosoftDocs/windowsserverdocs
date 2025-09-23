---
title: Create a Key Distribution Service (KDS) Root Key
description: Learn how to create a Key Distribution Service root key on a domain controller by using Windows PowerShell to generate group Managed Service Account passwords in Windows Server 2012 or later.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 07/09/2025
---
# Create a Key Distribution Service (KDS) root key

This article for IT professionals describes how to create a Key Distribution Service (kdssvc.dll) root key on the domain controller by using Windows PowerShell to generate group Managed Service Account passwords in Windows Server 2012 or later.

Domain controllers (DC) require a root key to begin generating gMSA passwords. The domain controllers will wait up to 10 hours from time of creation to allow all domain controllers to converge their Active Directory replication before allowing the creation of a gMSA. Waiting up to 10 hours is a safety measure to prevent password generation from occurring before all DCs in the environment are capable of answering gMSA requests. Trying to use a gMSA too soon might fail when the gMSA host attempts to retrieve the password, because the key might not have been replicated to all domain controllers. gMSA password retrieval failures can also occur when you use DCs with limited replication schedules or if there's a replication issue.

> [!NOTE]
> Deleting and re-creating the root key can lead to issues where the old key continues to be used after deletion due to caching of the key. The KDC should be restarted on all domain controllers if the root key is re-created.

Membership in the **Domain Admins** or **Enterprise Admins** groups, or the equivalent, is the minimum requirement for completing this procedure. For detailed information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

> [!NOTE]
> A 64-bit architecture is required to run the Windows PowerShell commands that are used to administer group Managed Service Accounts.

#### To create the KDS root key by using the Add-KdsRootKey cmdlet

1.  On the Windows Server 2012 or later domain controller, run Windows PowerShell from the Taskbar.

1.  At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then select **Enter**:

    **Add-KdsRootKey -EffectiveImmediately**

    > [!TIP]
    > You can use the Effective time parameter to provide time for keys to be propagated to all DCs before use. Using Add-KdsRootKey -EffectiveImmediately will add a root key to the target DC that will be used by the KDS service immediately. However, other domain controllers won't be able to use the root key until replication is successful.

KDS root keys are stored in Active Directory in container `CN=Master Root Keys,CN=Group Key Distribution Service,CN=Services,CN=Configuration,DC=<forest name>;`. They have an attribute msKds-DomainID that links to the computer account of the domain controller that created the object. When this domain controller is demoted and removed from the domain, the value will refer to the tombstone of the computer account. You can ignore the broken value because it's only used to help the administrator track the object when it's freshly created. You can also change the attribute value to point it to the computer object of another domain controller in your forest.

For test environments that have only one DC, you can create a KDS root key and set the start time in the past to avoid the interval wait for key generation by using the following procedure. Validate that a 4004 event has been logged in the KDS event log.

#### To create the KDS root key in a test environment for immediate effectiveness

1.  On the Windows Server 2012 or later domain controller, run the Windows PowerShell from the Taskbar.

1.  At the command prompt for the Windows PowerShell Active Directory module, type the following commands, and then select **Enter**:

    **$a=Get-Date**

    **$b=$a.AddHours(-10)**

    **Add-KdsRootKey -EffectiveTime $b**

    Or use a single command:

    **Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10))**

## Related content

- [Manage Group Managed Service Accounts](manage-group-managed-service-accounts.md)

