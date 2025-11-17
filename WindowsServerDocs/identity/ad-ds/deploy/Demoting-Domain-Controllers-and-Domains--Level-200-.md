---
description: Learn how to demote domain controllers and domains using Server Manager or PowerShell in Windows Server.
title: Demote Domain Controllers and Domains
author: dknappettmsft
ms.author: daknappe
ms.date: 07/09/2025
ms.topic: how-to
ms.custom: sfi-image-nochange
---

# Demote domain controllers and domains

This article explains how to remove Active Directory Domain Services (AD DS) by using Server Manager or Windows PowerShell.

## AD DS removal workflow

The following workflow diagram shows the steps to remove AD DS.

![Diagram that shows the AD DS removal workflow.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/adds_demotedomainforest.png)

> [!CAUTION]
> Removing the AD DS roles with Dism.exe or the Windows PowerShell DISM module after promotion to a domain controller (DC) isn't supported and prevents the server from booting normally.
>
> Unlike Server Manager and the ADDSDeployment module for Windows PowerShell, DISM is a native servicing system that has no inherent knowledge of AD DS or its configuration. We don't recommend using Dism.exe or the Windows PowerShell DISM module to uninstall the AD DS role unless the server is no longer a domain controller.

## Demotion and role removal by using PowerShell

| ADDSDeployment and ServerManager cmdlets | Arguments (Bold arguments are required. *Italicized* arguments can be specified via Windows PowerShell or the AD DS Configuration Wizard.) |
|--|--|
| Uninstall-ADDSDomainController | -SkipPreChecks<p>*-LocalAdministratorPassword*<p>-Confirm<p>***-Credential***<p>-DemoteOperationMasterRole<p>*-DNSDelegationRemovalCredential*<p>-Force<p>*-ForceRemoval*<p>*-IgnoreLastDCInDomainMismatch*<p>*-IgnoreLastDNSServerForZone*<p>*-LastDomainControllerInDomain*<p>-Norebootoncompletion<p>*-RemoveApplicationPartitions*<p>*-RemoveDNSDelegation*<p>-RetainDCMetadata |
| Uninstall-WindowsFeature/Remove-WindowsFeature | ***-Name***<p>***-IncludeManagementTools***<p>*-Restart*<p>-Remove<p>-Force<p>-ComputerName<p>-Credential<p>-LogPath<p>-Vhd |

To learn more about how to demote your DC by using PowerShell, see [Uninstall-ADDSDomainController](/powershell/module/addsdeployment/uninstall-addsdomaincontroller) and [Uninstall-WindowsFeature](/powershell/module/servermanager/uninstall-windowsfeature).

`Uninstall-ADDSDomainController` and `Uninstall-WindowsFeature` only require the minimum arguments because they each perform a single action. Selecting the **Enter** key during the confirmation phase initiates the irrevocable demotion process and restarts your device.

The **Credential** argument is only required if you aren't already signed in as a member of the Enterprise Admins group or the Domain Admins group. The **IncludeManagementTools** argument is only required if you want to remove all of the AD DS management utilities.

## Demote

### Remove roles and features

There are two methods you can use to remove the AD DS role:

- On the **Manage** menu on the main dashboard, select **Remove Roles and Features**:

   ![Screenshot that shows the Manage menu in Server Manager.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Manage.png)

- Select **AD DS** or **All Servers** on the navigation pane. Scroll down to the **Roles and Features** section. Right-click **Active Directory Domain Services** in the **Roles and Features** list and select **Remove Roles or Features**. This interface skips the **Server Selection** page.

   ![Screenshot that shows the Remove Roles and Features option in Server Manager.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerSelection.png)

The ServerManager cmdlets **Uninstall-WindowsFeature** and **Remove-WindowsFeature** prevent you from removing the AD DS role until you demote the domain controller.

### Server Selection

![Screenshot that shows the Server Selection section of the Remove Roles and Features Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerSelection2.png)

The **Server Selection** section enables you to choose from one of the servers previously added to the pool, as long as it's accessible. The local server running Server Manager is always automatically available.

### Server roles and features

![Screenshot that shows the Active Directory Domain Services checkbox.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ServerRoles.png)

Clear the **Active Directory Domain Services** checkbox to demote a domain controller. If the server is currently a domain controller, this action doesn't remove the AD DS role. Instead, it presents a **Validation Results** dialog that lets you demote the server. If the server is a domain controller, this action removes the binaries like any other role feature.

- Don't remove any other AD DS-related roles or features - such as DNS, GPMC, or the RSAT tools - if you intend to promote the domain controller again immediately. Removing other roles and features increases the time to repromote because Server Manager reinstalls these features when you reinstall the role.
- Remove unneeded AD DS roles and features at your own discretion if you intend to demote the domain controller permanently. To remove roles and features, clear the appropriate checkboxes.

Here's the full list of AD DS-related roles and features:

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

![Screenshot that shows the confirmation page of the Remove Roles and Features Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_RemoveFeatures.png)

![Screenshot that shows validation results in the Remove Roles and Features Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Demote.png)

### Credentials

![Screenshot that shows the Credentials page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Credentials.png)

You configure demotion options on the **Credentials** page. Provide the credentials necessary to perform the demotion from the following list:

- Demoting an extra domain controller requires Domain Admin credentials. Selecting **Force the removal of this domain controller** demotes the domain controller without removing the domain controller object's metadata from Active Directory.

   > [!WARNING]
   > Don't select this option unless the domain controller can't contact other domain controllers and there's no reasonable way to resolve that network issue. Forced demotion leaves orphaned metadata in Active Directory on the remaining domain controllers in the forest. In addition, all unreplicated changes on that domain controller, such as passwords or new user accounts, are lost forever. Orphaned metadata is the root cause in a significant percentage of Microsoft customer support cases for AD DS, Exchange, SQL Server, and other software.
   >
   > If you forcibly demote a domain controller, you must manually perform metadata cleanup immediately. For more information, see [Clean Up Server Metadata](ad-ds-metadata-cleanup.md).

   ![Screenshot that shows the force removal option in the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ForceDemote.png)

- Demoting the last domain controller in a domain requires Enterprise Admins group membership because doing so removes the domain itself. (If the domain is the last one in the forest, this action removes the forest.) Server Manager informs you if the current domain controller is the last domain controller in the domain. Select the **Last domain controller in the domain** checkbox to confirm that the domain controller is the last domain controller in the domain.

The equivalent ADDSDeployment Windows PowerShell arguments are:

```powershell
-Credential <PSCredential>
-ForceRemoval <{ $true | $false }>
-LastDomainControllerInDomain <{ $true | $false }>
```

### Warnings

![Screenshot that shows the Warnings page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Warnings.png)

The **Warnings** page alerts you to the possible consequences of removing the domain controller. To continue, you must select **Proceed with removal**.

If you previously selected **Force the removal of this domain controller** on the **Credentials** page, the **Warnings** page shows all Flexible Single Master Operations roles hosted by the domain controller. You must seize the roles from another domain controller immediately after demoting the server. For more information on seizing FSMO roles, see [Seize the Operations Master Role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816779(v=ws.10)).

This page doesn't have an equivalent ADDSDeployment Windows PowerShell argument.

### Removal Options

![Screenshot that shows the Removal Options page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_ReviewOptions.png)

The **Removal Options** page appears if you select **Last domain controller in the domain** on the **Credentials** page. This page enables you to configure extra removal options. Select **Ignore last DNS server for zone**, **Remove application partitions**, and **Remove DNS Delegation** to enable the **Next** button.

The options only appear if applicable to the domain controller. For instance, if there's no DNS delegation for the server, that checkbox doesn't appear.

Select **Change** to specify alternative DNS administrative credentials. Select **View Partitions** to view extra partitions that the wizard removes during the demotion. By default, the only other partitions are Domain DNS and Forest DNS Zones. All other partitions are non-Windows partitions.

The equivalent ADDSDeployment cmdlet arguments are:

```PowerShell
-IgnoreLastDnsServerForZone <{ $true | false }>
-RemoveApplicationPartitions <{ $true | false }>
-RemoveDNSDelegation <{ $true | false }>
-DNSDelegationRemovalCredential <PsCredential>
```

### New Administrator Password

![Screenshot that shows the New Administrator Password page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_NewAdminPwd.png)

The **New Administrator Password** page requires you to provide a password for the built-in local computer's Administrator account after the demotion completes and the computer becomes a domain member server or workgroup computer.

The **Uninstall-ADDSDomainController** cmdlet and arguments use the same defaults as Server Manager, if the values aren't specified.

The **LocalAdministratorPassword** argument is special:

- If this argument isn't specified, the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when running the cmdlet interactively.
- If the argument is specified with a value, the value must be a secure string. This isn't the preferred usage when running the cmdlet interactively.

For example, you can manually prompt for a password by using the **Read-Host** cmdlet to prompt the user for a secure string:

```powershell
Uninstall-ADDSDomainController -LocalAdministratorPassword (Read-Host -Prompt "Password:" -AsSecureString)
```

Because the previous two options don't confirm the password, use extreme caution. The password isn't visible.

You can also provide a secure string as a converted clear-text variable, although this is highly discouraged. For example:

```powershell
Uninstall-ADDSDomainController -LocalAdministratorPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)
```

Providing or storing a clear text password isn't recommended. Anyone running this command in a script or looking over your shoulder will know the local administrator password of the computer. With that knowledge, they have access to all of its data and can impersonate the server itself.

### Confirmation

![Screenshot that shows the Review Options page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Confirmation.png)

The **Confirmation** page shows the planned demotion. The page doesn't list demotion configuration options. This is the last page the wizard shows before the demotion begins. The **View script** button creates a Windows PowerShell demotion script.

Select **Demote** to run the following AD DS Deployment cmdlet:

```powershell
Uninstall-ADDSDomainController
```

Use the optional **Whatif** argument with the **Uninstall-ADDSDomainController** cmdlet to review configuration information. This enables you to see the explicit and implicit values of a cmdlet's arguments.

For example:

![Screenshot of a terminal window that shows the explicit and implicit values of a cmdlet's arguments.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstall.png)

The prompt to restart is your last opportunity to cancel the operation when using ADDSDeployment Windows PowerShell. To override that prompt, use the **-force** or **confirm:$false** arguments.

### Demotion

![Screenshot that shows the Demotion page of the Active Directory Domain Services Configuration Wizard.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_Demotion.png)

When the **Demotion** page appears, the domain controller configuration begins and can't be halted or canceled. Detailed operations appear on this page and write to logs:

- %systemroot%\debug\dcpromo.log
- %systemroot%\debug\dcpromoui.log

![Screenshot that shows an example of Uninstall-ADDSDomainController.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallConfirm.png)

![Screenshot that shows an example of Uninstall-WindowsFeature.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallWindowsFeature.png)

To accept the reboot prompt automatically, use the **-force** or **-confirm:$false** arguments with any ADDSDeployment Windows PowerShell cmdlet. To prevent the server from automatically rebooting at the end of promotion, use the **-norebootoncompletion:$false** argument.

> [!WARNING]
> We don't recommend overriding the reboot. The member server must reboot to function correctly.

![Screenshot that shows an example of Uninstall-ADDSDomainController -force.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallFinished.png)

Here's an example of forced demotion with the minimum required arguments of **-forceremoval** and **-demoteoperationmasterrole**. The **-credential** argument isn't required because the user signed on as a member of the Enterprise Admins group:

![Screenshot of a terminal window that shows an example of forced demotion.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallExampleForce.png)

Here's an example of removing the last domain controller in the domain, with the minimum required arguments of **-lastdomaincontrollerindomain** and **-removeapplicationpartitions**:

![Screenshot that shows an example of Uninstall-ADDSDomainController -LastDomainControllerInDomain.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallExampleLastDC.png)

If you attempt to remove the AD DS role before demoting the server, Windows PowerShell blocks you with an error:

![Screenshot that shows the error that occurs if you try to remove an AD DS role before demoting the server.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_PSUninstallError.png)

> [!IMPORTANT]
> You must restart the computer after demoting the server before you can remove the AD-Domain-Services role binaries.

### Results

![Screenshot that shows the You're About to be signed off messsage.](media/Demoting-Domain-Controllers-and-Domains--Level-200-/ADDS_RRW_TR_DemoteSignoff.png)

The **Results** page shows the success or failure of the promotion and any important administrative information. The domain controller automatically reboots after 10 seconds.

