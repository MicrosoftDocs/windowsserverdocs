---
title: Delegate AD FS Powershell Commandlet Access to Non-Admin Users 
description: This document descirbes how to delegate permissions to non-admins for AD FS PowerShell cmdlts.
author: billmath
ms.author: billmath
manager: daveba
ms.reviewer: zhvolosh
ms.date: 01/31/2019
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---


# Delegate AD FS Powershell Commandlet Access to Non-Admin Users 
By default, AD FS administration via PowerShell can only be accomplished by AD FS administrators. For many large organizations, this may not be a viable operational model when dealing with other personas such as a help desk personnel.  

With Just Enough Administration (JEA), customers can now delegate specific commandlets to different personnel groups.  
A good example of this use case is allowing help desk personnel to query AD FS account lockout status and reset account lockout state in AD FS once a user has been vetted. In this case, the commandlets that would need to be delegated are: 
- `Get-ADFSAccountActivity`
- `Set-ADFSAccountActivity` 
- `Reset-ADFSAccountLockout` 

We use this example in the rest of this document. However, one can customize this to also allow delegation to set properties of relying parties and hand this off to application owners within the organization.  


##  Create the required groups necessary to grant users permissions 
1. Create a [Group Managed Service Account](https://docs.microsoft.com/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview). The gMSA account is used to allow the JEA user to access network resources as other machines or web services. It provides a domain identity which can be used to authenticate against resources on any machine within the domain. The gMSA account is granted the necessary administrative rights later in the setup. For this example, we call the account **gMSAContoso**. 
2. Create an Active Directory group can be populated with users that need to be granted the rights to the delegated commands. In this example, help desk personnel are granted permissions to read, update, and reset the ADFS lockout state. We refer to this group throughout the example as **JEAContoso**. 

### Install the gMSA account on the ADFS Server: 
Create a service account which has administrative rights to the ADFS servers. This can be performed on the domain controller or remotely as long as the AD RSAT package is installed.  The service account must be created in the same forest as the ADFS server. 
Modify the example values to the configuration of your farm. 

```powershell
 # This command should only be run if this is the first time gMSA accounts are enabled in the forest 
Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10))  
 
# Run this on every node that you want to have JEA configured on  
$adfsServer = Get-ADComputer server01.contoso.com  
 
# Run targeted at domain controller  
$serviceaccount = New-ADServiceAccount gMSAcontoso -DNSHostName <FQDN of the domain containing the KDS key> - PrincipalsAllowedToRetrieveManagedPassword $adfsServer –passthru 
 
# Run this on every node 
Add-ADComputerServiceAccount -Identity server01.contoso.com -ServiceAccount $ServiceAccount 
```

Install the gMSA account on the ADFS server.  This needs to be run on every ADFS node in the farm. 
 
```powershell
Install-ADServiceAccount gMSAcontoso 
```

### Grant the gMSA Account Admin Rights 
If the farm is using delegated administration, grant the gMSA Account admin rights by adding it to the existing group which has delegated admin access.  
 
If the farm is not using delegated administration, grant the gMSA account admin rights by making it the local administration group on all of the ADFS servers. 
 
 
### Create the JEA Role File 
 
On the AD FS server, create the JEA role in a notepad file. Instructions to create the role is provided on [JEA role capabilities](https://docs.microsoft.com/powershell/jea/role-capabilities). 
 
The commandlets delegated in this example are `Reset-AdfsAccountLockout, Get-ADFSAccountActivity, and Set-ADFSAccountActivity`. 

Sample JEA role delegating access of ‘Reset-ADFSAccountLockout', ‘Get-ADFSAccountActivity', and ‘Set-ADFSAccountActivity' commandlets:

```powershell
@{
GUID = 'b35d3985-9063-4de5-81f8-241be1f56b52'
ModulesToImport = 'adfs'
VisibleCmdlets = 'Reset-AdfsAccountLockout', 'Get-ADFSAccountActivity', 'Set-ADFSAccountActivity'
}
```


### Create the JEA Session Configuration File 
Follow the instructions to create the [JEA session configuration](https://docs.microsoft.com/powershell/jea/session-configurations) file. The configuration file determines who can use the JEA endpoint, and what capabilities they have access to. 

Role capabilities are referenced by the flat name (filename without the extension) of the role capability file. If multiple role capabilities are available on the system with the same flat name, PowerShell uses its implicit search order to select the effective role capability file. It does not give access to all role capability files with the same name. 

To specify a Role Capability File with a path, use the `RoleCapabilityFiles` argument. For a subfolder, JEA looks for valid Powershell modules that contain a `RoleCapabilities` subfolder, where the `RoleCapabilityFiles` argument should be modified to be `RoleCapabilities`. 

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
 
It is strongly recommended to [test your session configuration file](https://docs.microsoft.com/powershell/module/Microsoft.PowerShell.Core/Test-PSSessionConfigurationFile?view=powershell-5.1) if you have edited the pssc file manually using a text editor to ensure the syntax is correct. If a session configuration file does not pass this test, it is not successfully registered on the system.  
 
### Install the JEA session configuration on the AD FS Server 

Install the JEA session configuration on the AD FS server 
 
```powershell
Register-PSSessionConfiguration -Path .\JEASessionConfig.pssc -name "AccountActivityAdministration" -force
``` 
## Operational Instructions 
Once set up, JEA logging and auditing can be used to determine the if the correct users have access to the JEA endpoint. 

To use the delegated commands: 

```powershell
Enter-pssession -ComputerName server01.contoso.com -ConfigurationName "AccountActivityAdministration" -Credential <User Using JEA> 
Get-AdfsAccountActivity <User> 


```
