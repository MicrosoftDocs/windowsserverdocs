---
title: Upgrade domain controllers to a newer version of Windows Server
description: This article describes how to upgrade from an earlier version of Windows Server to a later version.
ms.author: daveba
author: PatAltimore
manager: daveba
ms.date: 12/16/2021
ms.topic: article
---
# Upgrade domain controllers to a newer version of Windows Server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article provides background information about Active Directory Domain Services in Windows Server and explains the process for upgrading domain controllers (DCs) from an earlier version of Windows Server.

## Prerequisites

The recommended way to upgrade a domain is to promote new servers to DCs that run a newer version of Windows Server and demote the older DCs as needed. This method is preferable to upgrading the operating system of an existing DC, which is also known as an in-place upgrade.

Follow these general steps before you promote a server to a DC that runs a newer version of Windows Server:

1. Verify the target server meets the [system requirements](../../../get-started/hardware-requirements.md).
1. Verify application compatibility.
1. Review recommendations for moving to a newer version of Windows Server.
1. Verify security settings.
1. Check connectivity to the target server from the computer where you plan to run the installation.
1. Check for availability of the necessary Flexible Single Master Operation (FSMO) roles in Active Directory. This step is required for the following scenarios:
   - To install the first DC that runs the latest Windows Server version in an existing domain and forest, the machine where you run the installation needs connectivity to:
     - The **schema master** to run `adprep /forestprep`.
     - The **infrastructure master** to run `adprep /domainprep`.
   - To install the first DC in a domain where the forest schema is already extended, you only need connectivity to the **infrastructure master**.
   - To install or remove a domain in an existing forest, you need connectivity to the **domain naming master**.
   - Any DC installation also requires connectivity to the **RID master.**
   - If you're installing the first read-only DC in an existing forest, you need connectivity to the **infrastructure master** for each application directory partition, which is also known as a non-domain naming context.
   
   To find out which server or servers hold which FSMO role, run the following commands in an elevated PowerShell session by using an account that's a member of the Domain Admins group:
   
   ```PowerShell
   Get-ADDomain | FL InfrastructureMaster, RIDMaster, PDCEmulator
   Get-ADForest | FL DomainNamingMaster, SchemaMaster
   ```

### Installation actions and required administrative levels

The following table provides a summary of the installation actions and the permissions requirements to accomplish these steps.

|Installation action|Credential requirements|
| ----- | ----- |
|Install a new forest.|Local admin on the target server|
|Install a new domain in an existing forest.|Enterprise admins|
|Install another DC in an existing domain.|Domain admins|
|Run `adprep /forestprep`.|Schema admins, enterprise admins, and domain admins|
|Run `adprep /domainprep`.|Domain admins|
|Run `adprep /domainprep /gpprep.`|Domain admins|
|Run `adprep /rodcprep`.|Enterprise admins|

## Supported in-place upgrade paths

Only 64-bit version upgrades are supported. For more information about supported upgrade paths, see [Supported upgrade paths](../../../get-started/supported-upgrade-paths.md).

## Adprep - forestprep and domainprep

For an in-place upgrade of an existing DC, you must run `adprep /forestprep` and `adprep /domainprep` manually. You need to run `Adprep /forestprep` only once in the forest for each newer version of Windows Server. Run `Adprep /domainprep` once in each domain in which you have DCs that you're upgrading for each newer version of Windows Server.

If you're promoting a new server to a DC, you don't need to run these command-line tools manually. They're integrated into the PowerShell and Server Manager experiences.

For more information on running adprep, see [Running Adprep](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)).

## Functional-level features and requirements

Windows Server 2019 or later requires a Windows Server 2008 forest functional level as a minimum. Windows Server 2016 requires a Windows Server 2003 forest functional level as a minimum. If the forest contains DCs running an older forest functional level than the operating system supports, the installation is blocked. Those DCs must be removed and the forest functional level raised to a version that's supported before you add newer Windows Server DCs to your forest. For more information about supported functional levels, see [Forest and domain functional levels](../active-directory-functional-levels.md).

> [!NOTE]
> No new forest or domain functional levels have been added since Windows Server 2016. Later operating system versions can and should be used for domain controllers. They use Windows Server 2016 as the most recent functional levels.

### Roll back functional levels

After you set the forest functional level to a certain value, you can't roll back or lower the forest functional level, with the following exceptions:

- If you're upgrading from Windows Server 2012 R2 forest functional level, you can roll back to Windows Server 2012 R2.
- If you're upgrading from Windows Server 2008 R2 forest functional level, you can roll back to Windows Server 2008 R2.

After you set the domain functional level to a certain value, you can't roll back or lower the domain functional level, with the following exceptions:

- When you raise the domain functional level to Windows Server 2016 and if the forest functional level is Windows Server 2012 or lower, you have the option of rolling the domain functional level back to Windows Server 2012 or Windows Server 2012 R2.

For more information about features available at each of the functional levels, see [Forest and domain functional levels](../active-directory-functional-levels.md).

## Active Directory Domain Services interoperability

Active Directory Domain Services isn't supported on the following Windows operating systems:

- Windows MultiPoint Server
- Windows Server Essentials

Active Directory Domain Services can't be installed on a server that also runs the following server roles or role services:

- Microsoft Hyper-V Server
- Remote Desktop Connection Broker

## Administration of Windows Server

Use the Remote Server Administration Tools for Windows 10 or later to manage domain controllers and other servers that run Windows Server. You can run the Windows Server Remote Server Administration Tools on a computer that runs Windows 10 or later.

## Add a new domain controller with a newer version of Windows Server

The following example shows how to upgrade the Contoso forest from a previous version of Windows Server to a later version.

1. Join the new Windows Server to your forest. Restart when you're prompted.

   ![Screenshot of the Server Manager showing the Systems Properties and Computer Name/Domain Changes dialog boxes.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade2.png)

1. Sign in to the new Windows Server with a domain admin account.
1. In **Server Manager**, under **Add Roles and Features**, install **Active Directory Domain Services** on the new Windows Server. This action automatically runs adprep on the earlier version forest and domain.

   ![Screenshot of the Select server roles page of the Add Roles and Features Wizard showing the Active Directory Domain Services option highlighted.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade3.png)

1. In **Server Manager**, select the yellow triangle. From the drop-down, select **Promote the server to a domain controller**.

   ![Screenshot of the Post-deployment Configuration progress dialog box with the Promote the server to a domain controller option called out.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade4.png)

1. On the **Deployment Configuration** screen, select **Add a new domain to an existing forest** and select **Next**.

   ![Screenshot of the Deployment Configuration page of the Active Directory Domain Services Configuration Wizard showing the Add a new domain to an existing forest option selected.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade5.png)

1. On the **Domain Controller options** screen, enter the **Directory Services Restore Mode (DSRM)** password and select **Next**.
1. For the rest of the screens, select **Next**.
1. On the **Prerequisite Check** screen, select **Install**. After the restart has completed, sign in again.
1. On the earlier version of Windows Server, in **Server Manager**, under **Tools**, select **Active Directory Module for Windows PowerShell**.

   ![Screenshot of the Tools drop-down list in the Server Manager with the Active Directory Module for Windows PowerShell option called out.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade6.png)

1. In the PowerShell window, use the `Move-ADDirectoryServerOperationMasterRole` cmdlet to move the FSMO roles. You can enter the name of each Operation Master Role or use numbers to specify the roles. For more information, see [Move-ADDirectoryServerOperationMasterRole](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)).

    ``` powershell
    Move-ADDirectoryServerOperationMasterRole -Identity "DC-W2K16" -OperationMasterRole 0,1,2,3,4
    ```

    ![Screenshot of the Active Directory Module for Windows PowerShell window showing the results of the Move-ADDirectoryServerOperationMasterRole cmdlet.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade7.png)

1. To verify the roles were moved, go to the new Windows Server. In **Server Manager**, under **Tools**, select **Active Directory Module for Windows PowerShell**. Use the `Get-ADDomain` and `Get-ADForest` cmdlets to view the FSMO role holders.

    ![Screenshot of the Active Directory Module for Windows PowerShell window showing the results of the Get-ADDomain cmdlet with the Infrastructure Master, P D C Emulator, and R I D Master values called out.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade8.png)

    ![Screenshot of the Active Directory Module for Windows PowerShell window showing the results of the Get-ADForest cmdlet with the Domain Naming Master and Schema Master values called out.](media/Upgrade-Domain-Controllers-to-Windows-Server-2016/upgrade9.png)

1. Demote and remove the earlier Windows Server DC. For information on how to demote a DC, see [Demoting domain controllers and domains](../../ad-ds/deploy/Demoting-Domain-Controllers-and-Domains--Level-200-.md).
1. After the server is demoted and removed, you can [raise the forest functional and domain functional levels](/troubleshoot/windows-server/identity/raise-active-directory-domain-forest-functional-levels) to the latest version of Windows Server.

## Next steps

- [What's new in Active Directory Domain Services installation and removal](../../ad-ds/deploy/What-s-New-in-Active-Directory-Domain-Services-Installation-and-Removal.md)
- [Install Active Directory Domain Services &#40;Level 100&#41;](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md)
- [Windows Server functional levels](../active-directory-functional-levels.md)
