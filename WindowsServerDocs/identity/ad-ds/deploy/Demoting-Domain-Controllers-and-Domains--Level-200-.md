---
description: Demote domain controllers and domains
ms.assetid: 65ed5956-6140-4e06-8d99-8771553637d1
title: Learn how to demote domain controllers and domains using Server Manager or PowerShell in Windows Server.
author: meaghanlewis
ms.author: mosagie
ms.date: 06/13/2025
ms.topic: how-to
---

# Demote domain controllers and domains

This article explains how to remove Active Directory Domain Services (AD DS) using Server Manager or Windows PowerShell.

## AD DS removal workflow

The following workflow diagram shows the steps to remove AD DS.

![AD DS removal workflow chart](media/Demoting-Domain-Controllers-and-Domains--Level-200-/adds_demotedomainforest.png)

> [!CAUTION]
> Removing the AD DS roles with Dism.exe or the Windows PowerShell DISM module after promotion to a Domain Controller (DC) isn't supported and prevents the server from booting normally.
>
> Unlike Server Manager or the ADDSDeployment module for Windows PowerShell, DISM is a native servicing system that has no inherent knowledge of AD DS or its configuration. We don't recommend using Dism.exe or the Windows PowerShell DISM module to uninstall the AD DS role unless the server is no longer a domain controller.

## Demotion and role removal with PowerShell

| ADDSDeployment and ServerManager Cmdlets | Arguments (**Bold** arguments are required. *Italicized* arguments can be specified by using Windows PowerShell or the AD DS Configuration Wizard.) |
|--|--|
| Uninstall-ADDSDomainController | -SkipPreChecks<p>*-LocalAdministratorPassword*<p>-Confirm<p>***-Credential***<p>-DemoteOperationMasterRole<p>*-DNSDelegationRemovalCredential*<p>-Force<p>*-ForceRemoval*<p>*-IgnoreLastDCInDomainMismatch*<p>*-IgnoreLastDNSServerForZone*<p>*-LastDomainControllerInDomain*<p>-Norebootoncompletion<p>*-RemoveApplicationPartitions*<p>*-RemoveDNSDelegation*<p>-RetainDCMetadata |
| Uninstall-WindowsFeature/Remove-WindowsFeature | ***-Name***<p>***-IncludeManagementTools***<p>*-Restart*<p>-Remove<p>-Force<p>-ComputerName<p>-Credential<p>-LogPath<p>-Vhd |

To learn more about how to demote your DC using PowerShell, see the [Uninstall-ADDSDomainController](/powershell/module/addsdeployment/uninstall-addsdomaincontroller) and [Uninstall-WindowsFeature](/powershell/module/servermanager/uninstall-windowsfeature) PowerShell references.

When using `Uninstall-ADDSDomainController` and `Uninstall-WindowsFeature`, these commands only require the minimum arguments as they each perform a single action. Pressing the **Enter** key during the confirmation phase initiates the irrevocable demotion process and restarts your device.

The **Credential** argument is only required if you aren't already signed in as a member of the Enterprise Admins group or the Domain Admins group. The **IncludeManagementTools** argument is only required if you want to remove all of the AD DS management utilities.

## Demote

### Remove roles and features

There are two methods you can use to remove the AD DS role:

- The **Manage** menu on the main dashboard, using **Remove Roles and Features**

   ![Server Manager - Remove Roles and Features](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Manage.png)

- Select **AD DS** or **All Servers** on the navigation pane. Scroll down to the **Roles and Features** section. Right-click **Active Directory Domain Services** in the **Roles and Features** list and select **Remove Role or Feature**. This interface skips the **Server Selection** page.

   ![Server Manager - All Servers- Remove Roles and Features](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerSelection.png)

The ServerManager cmdlets **Uninstall-WindowsFeature** and **Remove-WindowsFeature** prevent you from removing the AD DS role until you demote the domain controller.

### Server selection

![Remove Roles and Features Wizard select destination server](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerSelection2.png)

The **Server Selection** dialog enables you to choose from one of the servers previously added to the pool, as long as it's accessible. The local server running Server Manager is always automatically available.

### Server Roles and Features

![Remove Roles and Features Wizard - Select roles to remove](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerRoles.png)

Clear the **Active Directory Domain Services** check box to demote a domain controller; if the server is currently a domain controller, this doesn't remove the AD DS role, and instead switches to a **Validation Results** dialog with the offer to demote. Otherwise, it removes the binaries like any other role feature.

- Don't remove any other AD DS-related roles or features - such as DNS, GPMC, or the RSAT tools - if you intend to promote the domain controller again immediately. Removing other roles and feature increases the time to repromote, as Server Manager reinstalls these features when you reinstall the role.
- Remove unneeded AD DS roles and features at your own discretion if you intend to demote the domain controller permanently. This requires clearing the check boxes for those roles and features.

The full list of AD DS-related roles and features include:

- Active Directory Module for Windows PowerShell feature
- AD DS and AD LDS Tools feature
- Active Directory Administrative Center feature
- AD DS Snap-ins and Command-line Tools feature
- DNS Server
- Group Policy Management Console

The equivalent ADDSDeployment and ServerManager Windows PowerShell cmdlets are:

```powershell
Uninstall-ADDSDomainController
Uninstall-WindowsFeature
```

![Remove Roles and Features Wizard - Confirmation dialog](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_RemoveFeatures.png)

![Remove Roles and Features Wizard - Validation](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Demote.png)

### Credentials

![Active Directory Domain Services Configuration Wizard - Credentials selection](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Credentials.png)

You configure demotion options on the **Credentials** page. Provide the credentials necessary to perform the demotion from the following list:

- Demoting an extra domain controller requires Domain Admin credentials. Selecting **Force the removal of this domain controller** demotes the domain controller without removing the domain controller object's metadata from Active Directory.

   > [!WARNING]
   > Don't select this option unless the domain controller can't contact other domain controllers and there is *no reasonable way* to resolve that network issue. Forced demotion leaves orphaned metadata in Active Directory on the remaining domain controllers in the forest. In addition, all unreplicated changes on that domain controller, such as passwords or new user accounts, are lost forever. Orphaned metadata is the root cause in a significant percentage of Microsoft Customer Support cases for AD DS, Exchange, SQL, and other software.
   >
   > If you forcibly demote a domain controller, you *must* manually perform metadata cleanup immediately. For steps, review [Clean Up Server Metadata](ad-ds-metadata-cleanup.md).

   ![Active Directory Domain Services Configuration Wizard - Credentials Force removal](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ForceDemote.png)

- Demoting the last domain controller in a domain requires Enterprise Admins group membership, as this removes the domain itself (if the last domain in the forest, this removes the forest). Server Manager informs you if the current domain controller is the last domain controller in the domain. Select the **Last domain controller in the domain** check box to confirm the domain controller is the last domain controller in the domain.

The equivalent ADDSDeployment Windows PowerShell arguments are:

```powershell
-Credential <PSCredential>
-ForceRemoval <{ $true | $false }>
-LastDomainControllerInDomain <{ $true | $false }>
```

### Warnings

![Active Directory Domain Services Configuration Wizard - Credentials FSMO Roles Impact](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Warnings.png)

The **Warnings** page alerts you to the possible consequences of removing this domain controller. To continue, you must select **Proceed with removal**.

If you previously selected **Force the removal of this domain controller** on the **Credentials** page, then the **Warnings** page shows all Flexible Single Master Operations roles hosted by this domain controller. You *must* seize the roles from another domain controller *immediately* after demoting this server. For more information on seizing FSMO roles, see [Seize the Operations Master Role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816779(v=ws.10)).

This page doesn't have an equivalent ADDSDeployment Windows PowerShell argument.

### Removal Options

![Active Directory Domain Services Configuration Wizard - Credentials Remove DNS and Application partitions](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ReviewOptions.png)

The **Removal Options** page appears, depending on previously selecting **Last domain controller in the domain** on the **Credentials** page. This page enables you to configure extra removal options. Select **Ignore last DNS server for zone**, **Remove application partitions**, and **Remove DNS Delegation** to enable the **Next** button.

The options only appear if applicable to this domain controller. For instance, if there's no DNS delegation for this server then that checkbox doesn't display.

Select **Change** to specify alternate DNS administrative credentials. Select **View Partitions** to view extra partitions the wizard removes during the demotion. By default, the only other partitions are Domain DNS and Forest DNS Zones. All other partitions are non-Windows partitions.

The equivalent ADDSDeployment cmdlet arguments are:

```PowerShell
-IgnoreLastDnsServerForZone <{ $true | false }>
-RemoveApplicationPartitions <{ $true | false }>
-RemoveDNSDelegation <{ $true | false }>
-DNSDelegationRemovalCredential <PsCredential>
```

### New administrator password

![Active Directory Domain Services Configuration Wizard - Credentials New Administrator Password](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_NewAdminPwd.png)

The **New Administrator Password** page requires you to provide a password for the built-in local computer's Administrator account, once the demotion completes and the computer becomes a domain member server or workgroup computer.

The **Uninstall-ADDSDomainController** cmdlet and arguments follow the same defaults as Server Manager if not specified.

The **LocalAdministratorPassword** argument is special:

- If *not specified* as an argument, then the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when running the cmdlet interactively.
- If specified *with a value*, then the value must be a secure string. This isn't the preferred usage when running the cmdlet interactively.

For example, you can manually prompt for a password by using the **Read-Host** cmdlet to prompt the user for a secure string.

```powershell
Uninstall-ADDSDomainController -LocalAdministratorPassword (Read-Host -Prompt "Password:" -AsSecureString)
```

As the previous two options don't confirm the password, use extreme caution. The password isn't visible.

You can also provide a secure string as a converted clear-text variable, although this is highly discouraged. For example:

```powershell
Uninstall-ADDSDomainController -LocalAdministratorPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)
```

Providing or storing a clear text password isn't recommended. Anyone running this command in a script or looking over your shoulder knows the local administrator password of that computer. With that knowledge, they have access to all of its data and can impersonate the server itself.

### Confirmation

![Active Directory Domain Services Configuration Wizard - Review Options](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Confirmation.png)

The **Confirmation** page shows the planned demotion; the page doesn't list demotion configuration options. This is the last page the wizard shows before the demotion begins. The View Script button creates a Windows PowerShell demotion script.

Select **Demote** to run the following AD DS Deployment cmdlet:

```powershell
Uninstall-ADDSDomainController
```

Use the optional **Whatif** argument with the **Uninstall-ADDSDomainController** and cmdlet to review configuration information. This enables you to see the explicit and implicit values of a cmdlet's arguments.

For example:

![Screenshot of a terminal window that shows the explicit and implicit values of a cmdlet's arguments.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstall.png)

The prompt to restart is your last opportunity to cancel this operation when using ADDSDeployment Windows PowerShell. To override that prompt, use the **-force** or **confirm:$false** arguments.

### Demotion

![Active Directory Domain Services Configuration Wizard - Demotion in progress](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Demotion.png)

When the **Demotion** page displays, the domain controller configuration begins and can't be halted or canceled. Detailed operations display on this page and write to logs:

- %systemroot%\debug\dcpromo.log
- %systemroot%\debug\dcpromoui.log

![PowerShell Uninstall-ADDSDomainController Example](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallConfirm.png)

![PowerShell Uninstall-WindowsFeature Example](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallWindowsFeature.png)

To accept the reboot prompt automatically, use the **-force** or **-confirm:$false** arguments with any ADDSDeployment Windows PowerShell cmdlet. To prevent the server from automatically rebooting at the end of promotion, use the **-norebootoncompletion:$false** argument.

> [!WARNING]
> Overriding the reboot is discouraged. The member server must reboot to function correctly.

![PowerShell Uninstall-ADDSDomainController Force Example](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallFinished.png)

Here's an example of forcibly demoting with its minimal required arguments of **-forceremoval** and **-demoteoperationmasterrole**. The **-credential** argument isn't required because the user logged on as a member of the Enterprise Admins group:

![Screenshot of a terminal window that shows an example of forcibly demoting with its minimal required arguments of -forceremoval and -demoteoperationmasterrole.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallExampleForce.png)

Here's an example of removing the last domain controller in the domain with its minimal required arguments of **-lastdomaincontrollerindomain** and **-removeapplicationpartitions**:

![PowerShell Uninstall-ADDSDomainController -LastDomainControllerInDomain Example](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallExampleLastDC.png)

If you attempt to remove the AD DS role before demoting the server, Windows PowerShell blocks you with an error:

![An uninstallation prerequisite step failed during the removal of AD-Domain-Services, and uninstallation can't continue. 1. The domain controller needs to be demoted before the Active DirectoryDomain Services Role can be uninstalled.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallError.png)

> [!IMPORTANT]
> You must restart the computer after demoting the server before you can remove the AD-Domain-Services role binaries.

### Results

![You're About to be signed off warning after removal of AD DS](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_DemoteSignoff.png)

The **Results** page shows the success or failure of the promotion and any important administrative information. The domain controller automatically reboots after 10 seconds.
