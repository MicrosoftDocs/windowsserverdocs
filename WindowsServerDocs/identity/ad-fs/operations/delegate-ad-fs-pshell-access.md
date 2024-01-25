---
title: Delegate AD FS PowerShell commandlet access to nonadmin users
description: This article describes how to delegate permissions for AD FS PowerShell commandlets to nonadmins.
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# Delegate AD FS PowerShell commandlet access to nonadmin users

By default, only AD FS administrators can perform AD FS administration via PowerShell. For many large organizations, this may not be a viable operational model when dealing with other personas such as a help desk personnel.

With Just Enough Administration (JEA), customers now can delegate permissions for specific commandlets to different personnel groups.

A good example of this use case is allowing help desk personnel to query AD FS account lockout status and reset account lockout state in AD FS after a user has been vetted. In this case, the commandlets that would need to be delegated are:

- `Get-ADFSAccountActivity`
- `Set-ADFSAccountActivity`
- `Reset-ADFSAccountLockout`

We use this example in the rest of this document. However, you can customize this to also allow delegation to set properties of relying parties and hand this off to application owners within the organization.

## Create the required groups necessary to grant users permissions

1. Create a [Group Managed Service Account](../../../security/group-managed-service-accounts/group-managed-service-accounts-overview.md). The gMSA account is used to allow the JEA user to access network resources as other machines or web services. It provides a domain identity that can be used to authenticate against resources on any machine within the domain. The gMSA account is granted the necessary administrative rights later in the setup. For this example, we call the account **gMSAContoso**.
1. Create an Active Directory group can be populated with users that need to be granted the rights to the delegated commands. In this example, help desk personnel are granted permissions to read, update, and reset the AD FS lockout state. We refer to this group throughout the example as **JEAContoso**.

### Install the gMSA account on the AD FS server

Create a service account that has administrative rights to the AD FS servers. This can be performed on the domain controller or remotely as long as the AD RSAT package is installed. The service account must be created in the same forest as the AD FS server.

Modify the example values to the configuration of your farm.

```powershell
 # This command should only be run if this is the first time gMSA accounts are enabled in the forest
Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10)) 

# Run this on every node that you want to have JEA configured on
$adfsServer = Get-ADComputer server01.contoso.com

# Run targeted at domain controller
$serviceaccount = New-ADServiceAccount gMSAcontoso -DNSHostName <FQDN of the domain containing the KDS key> -PrincipalsAllowedToRetrieveManagedPassword $adfsServer –passthru

# Run this on every node
Add-ADComputerServiceAccount -Identity server01.contoso.com -ServiceAccount $ServiceAccount
```

Install the gMSA account on the AD FS server. This needs to be run on every AD FS node in the farm.

```powershell
Install-ADServiceAccount gMSAcontoso
```

### Grant the gMSA Account admin rights

If the farm is using delegated administration, grant the gMSA Account admin rights by adding it to the existing group, which has delegated admin access.

If the farm isn't using delegated administration, grant the gMSA account admin rights by making it the local administration group on all of the AD FS servers.

### Create the JEA role file

On the AD FS server, create the JEA role in a notepad file. Instructions to create the role are provided on [JEA role capabilities](/powershell/scripting/learn/remoting/jea/role-capabilities).

The commandlets delegated in this example are `Reset-AdfsAccountLockout, Get-ADFSAccountActivity, and Set-ADFSAccountActivity`.

Sample JEA role delegating access of ‘Reset-ADFSAccountLockout', ‘Get-ADFSAccountActivity', and ‘Set-ADFSAccountActivity' commandlets:

```powershell
@{
GUID = 'b35d3985-9063-4de5-81f8-241be1f56b52'
ModulesToImport = 'adfs'
VisibleCmdlets = 'Reset-AdfsAccountLockout', 'Get-ADFSAccountActivity', 'Set-ADFSAccountActivity'
}
```

### Create the JEA session configuration file

Follow the instructions to create the [JEA session configuration](/powershell/scripting/learn/remoting/jea/session-configurations) file. The configuration file determines who can use the JEA endpoint and what capabilities they can access.

Role capabilities are referenced by the flat name (filename without the extension) of the role capability file. If multiple role capabilities are available on the system with the same flat name, PowerShell uses its implicit search order to select the effective role capability file. It doesn't give access to all role capability files with the same name.

To specify a Role Capability File with a path, use the `RoleCapabilityFiles` argument. For a subfolder, JEA looks for valid PowerShell modules that contain a `RoleCapabilities` subfolder, where the `RoleCapabilityFiles` argument should be modified to be `RoleCapabilities`.

Sample session configuration file:

```powershell
@{
SchemaVersion = '2.0.0.0'
GUID = '54c8d41b-6425-46ac-a2eb-8c0184d9c6e6'
SessionType = 'RestrictedRemoteServer'
GroupManagedServiceAccount =  'CONTOSO\gMSAcontoso'
RoleDefinitions = @{ JEAcontoso = @{ RoleCapabilityFiles = 'C:\Program Files\WindowsPowershell\Modules\AccountActivityJEA\RoleCapabilities\JEAAccountActivityResetRole.psrc' } }
}
```

Save the session configuration file.

It's recommended to [test your session configuration file](/powershell/module/microsoft.powershell.core/test-pssessionconfigurationfile) if you have edited the pssc file manually using a text editor to ensure the syntax is correct. If a session configuration file doesn't pass this test, it isn't successfully registered on the system.

### Install the JEA session configuration on the AD FS server

Install the JEA session configuration on the AD FS server

```powershell
Register-PSSessionConfiguration -Path .\JEASessionConfig.pssc -name "AccountActivityAdministration" -force
```

## Operational instructions

After it's set up, JEA logging and auditing can be used to determine if the correct users have access to the JEA endpoint.

To use the delegated commands:

```powershell
Enter-pssession -ComputerName server01.contoso.com -ConfigurationName "AccountActivityAdministration" -Credential <User Using JEA>
Get-AdfsAccountActivity <User>
```
