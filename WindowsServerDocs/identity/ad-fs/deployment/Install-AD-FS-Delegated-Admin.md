---
ms.assetid: 46725afe-8652-4cd7-928c-93b98f7fbae3
title: Creating an AD FS farm without Domain Administrator privileges
description: Using the Install-AdfsFarm cmdlet and script to create an AD FS farm using delegated admin credentials
author: jenfieldmsft
ms.author: billmath
manager: samueld
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Creating an AD FS Farm without domain admin privileges

>Applies To: Windows Server 2016

## Overview
Starting with AD FS in Windows Server 2016, you can run the cmdlet Install-AdfsFarm as a local administrator on your federation server, provided your Domain Administrator has prepared Active Directory.  The script below in this article can be used to prepare AD.  The steps are as follows:

1) As Domain Administrator, run the script (or create the Active Directory objects and permissions manually).
2) The script will return an AdminConfiguration object containing the DN of the newly created AD object
3) On the federation server, execute the Install-AdfsFarm cmdlet while logged on as a local administrator, passing the object from #2 above as the AdminConfiguration parameter

## Assumptions
- Contoso\localadmin is a non-Domain Admin builtin admin on the federation server
- Contoso\FsSvcAcct is a domain account that will be the AD FS service account
- Contoso\FsGmsaAcct$ is a gMSA account that will be the AD FS service account
- $svcCred is the credentials of the AD FS service account
- $localAdminCred is the credentials of the local (non DA) admin account on the federation server

## Using a domain account as AD FS Service Account
### Prepare AD 
Run the following as domain administrator
```
PS:\>$adminConfig=(C:\scriptlocation\CreateNonDADkmContainer.ps1 "contoso\fssvcacct")
```
### Sample Output
```
OU Name9530440c-bc84-4fe6-a3f9-8d60162a7bcf
Creating organizational unit with DN: CN=9530440c-bc84-4fe6-a3f9-8d60162a7bcf,CN=ADFS,CN=Microsoft,CN=Program Data,DC=contoso,DC=com
```
### Create the AD FS Farm
On the federation server as a local admin, execute the following in an elevated PowerShell command window.

First, if the federation server admin is not using the same PowerShell session as the above domain admin, re-create the adminConfig object using the output from the above.
```
PS:\>$adminConfig = @{"DKMContainerDn"="CN=9530440c-bc84-4fe6-a3f9-8d60162a7bcf,CN=ADFS,CN=Microsoft,CN=Program Data,DC=contoso,DC=com"}
```

Next, create the farm:
```
PS:\>$svcCred = (get-credential)
PS:\>$localAdminCred = (get-credential) 
PS:\>Install-AdfsFarm -CertificateThumbprint 270D041785C579D75C1C981DA0F9C36ECFDB65E0 -FederationServiceName "fs.contoso.com" -ServiceAccountCredential $svcCred -Credential $localAdminCred -OverwriteConfiguration -AdminConfiguration $adminConfig -Verbose
```
## Using a gMSA as the AD FS Service Account
### Prepare AD
```
PS:\>$adminConfig=(C:\scriptlocation\CreateNonDADkmContainer.ps1 "contoso\FsGmsaAcct$")
```

### Sample Output
```
OU Name8065f653-af9d-42ff-aec8-56e02be4d5f3
Creating organizational unit with DN: CN=8065f653-af9d-42ff-aec8-56e02be4d5f3,CN=ADFS,CN=Microsoft,CN=Program Data,DC=contoso,DC=com
```

### Create the AD FS Farm
On the federation server as a local admin, execute the following in an elevated PowerShell command window.

First, if the federation server admin is not using the same PowerShell session as the above domain admin, re-create the adminConfig object using the output from the above.
```
PS:\>$adminConfig = @{"DKMContainerDn"="CN=8065f653-af9d-42ff-aec8-56e02be4d5f3,CN=ADFS,CN=Microsoft,CN=Program Data,DC=contoso,DC=com"}
```

Next, create the farm:
```
PS:\>Set-ADServiceAccount -Identity fsgmsaacct -PrincipalsAllowedToDelegateToAccount "localadmin"
PS:\>$localAdminCred = (get-credential) 
PS:\>Install-AdfsFarm -CertificateThumbprint 270D041785C579D75C1C981DA0F9C36ECFDB65E0 -FederationServiceName "fs.contoso.com" -Credential $localAdminCred -GroupServiceAccountIdentifier "contoso\fsgmsaacct$" -OverwriteConfiguration -AdminConfiguration $adminConfig
```

# Script for preparing AD
The following PowerShell script can be used to accomplish the examples above

```
#[CmdletBinding()] 
param (
   [Parameter(Mandatory=$True)]
   [string]$AcctToAclDkmContainer
)

$userNameSplit = $AcctToAclDkmContainer.Split("\");
if ($userNameSplit.Length -ne 2)
{
	Write-error "Specify non-DA local admin user in 'domain\username' format"
	exit 1
}

push-location ad:

# The OU Name is a randomly generated Guid
[string]$guid = (New-Guid).Guid
write-host ("OU Name" + $guid)

$ouName = $guid
$initialPath = "CN=Microsoft,CN=Program Data," + (Get-ADDomain).DistinguishedName
$ouPath = "CN=ADFS," + $initialPath
$ou = "CN=" + $ouName + "," + $ouPath

Write-Host ("Creating organizational unit with DN: " + $ou)

if ((Get-ADObject -Filter {distinguishedName -eq $ouPath}) -eq $null)
{
	Write-Host ("First creating initial path " + $ouPath)
	New-ADObject -Name "ADFS" -Type Container -Path $initialPath
}

New-ADObject -Name $ouName -Type Container -Path $ouPath

if ($AcctToAclDkmContainer.EndsWith("$"))
{
	$strSID = (Get-ADServiceAccount -Identity $userNameSplit[1]).SID
}
else
{
	$objUser = New-Object System.Security.Principal.NTAccount($AcctToAclDkmContainer)
	$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
}

[System.DirectoryServices.ActiveDirectorySecurityInheritance]$adSecInEnum = [System.DirectoryServices.ActiveDirectorySecurityInheritance]::All
$ace1 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $strSID,"GenericRead","Allow",$adSecInEnum
$ace2 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $strSID,"CreateChild","Allow",$adSecInEnum
$ace3 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $strSID,"WriteOwner","Allow",$adSecInEnum
$ace4 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $strSID,"DeleteTree","Allow",$adSecInEnum

$acl = get-acl -Path $ou

$acl.AddAccessRule($ace1)
$acl.AddAccessRule($ace2)
$acl.AddAccessRule($ace3)
$acl.AddAccessRule($ace4)

set-acl -Path $ou -AclObject $acl

pop-location

$adminConfig = @{"DKMContainerDn"=$ou}

return $adminConfig
```

