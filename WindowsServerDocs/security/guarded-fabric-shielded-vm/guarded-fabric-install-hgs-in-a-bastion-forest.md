---
title: Install HGS in an existing bastion forest 
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Install HGS in an existing bastion forest 

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016


## Join the HGS server to the existing domain

In an existing bastion forest, HGS must be added to the root domain. Use Server Manager or [Add-Computer](https://go.microsoft.com/fwlink/?LinkId=821564) to join your HGS server to the root domain.

## Add the HGS server role

Run all commands in this topic in an elevated PowerShell session.

[!INCLUDE [Install the HGS server role](../../../includes/guarded-fabric-install-hgs-server-role.md)] 

If your datacenter has a secure bastion forest where you want to join HGS nodes, follow these steps.
You can also use these steps to configure 2 or more independent HGS clusters that are joined to the same domain.

## Join the HGS server to the existing domain

Use Server Manager or [Add-Computer](https://go.microsoft.com/fwlink/?LinkId=821564) to join the HGS servers to the desired domain.

## Prepare Active Directory objects

Create a group managed service account and 2 security groups.
You can also pre-stage the cluster objects if the account you are initializing HGS with does not have permission to create computer objects in the domain.

## Group managed service account

The group managed service account (gMSA) is the identity used by HGS to retrieve and use its certificates. Use [New-ADServiceAccount](https://technet.microsoft.com/itpro/powershell/windows/addsadministration/new-adserviceaccount) to create a gMSA.
If this is the first gMSA in the domain, you will need to add a Key Distribution Service root key.

Each HGS node will need to be permitted to access the gMSA password.
The easiest way to configure this is to create a security group that contains all of your HGS nodes and grant that security group access to retrieve the gMSA password.

You must reboot your HGS server after adding it to a security group to ensure it obtains its new group membership.

```powershell
# Check if the KDS root key has been set up
if (-not (Get-KdsRootKey)) {
    # Adds a KDS root key effective immediately (ignores normal 10 hour waiting period)
    Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))
}

# Create a security group for HGS nodes
$hgsNodes = New-ADGroup -Name 'HgsServers' -GroupScope DomainLocal -PassThru

# Add your HGS nodes to this group
# If your HGS server object is under an organizational unit, provide the full distinguished name instead of "HGS01"
Add-ADGroupMember -Identity $hgsNodes -Members "HGS01"

# Create the gMSA
New-ADServiceAccount -Name 'HGSgMSA' -DnsHostName 'HGSgMSA.yourdomain.com' -PrincipalsAllowedToRetrieveManagedPassword $hgsNodes
```

The gMSA will require the right to generate events in the security log on each HGS server.
If you use Group Policy to configure User Rights Assignment, ensure that the gMSA account is granted the [generate audit events privilege](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn221956%28v=ws.11%29) on your HGS servers.

> [!NOTE]
> Group managed service accounts are available beginning with the Windows Server 2012 Active Directory schema.
> For more information, see [group managed service account requirements](https://technet.microsoft.com/library/jj128431.aspx).

## JEA security groups

When you set up HGS, a [Just Enough Administration (JEA)](https://aka.ms/JEAdocs) PowerShell endpoint is configured to allow admins to manage HGS without needing full local administrator privileges.
You are not required to use JEA to manage HGS, but it still must be configured when running Initialize-HgsServer.
The configuration of the JEA endpoint consists of designating 2 security groups that contain your HGS admins and HGS reviewers.
Users who belong to the admin group can add, change, or remove policies on HGS; reviewers can only view the current configuration.

Create 2 security groups for these JEA groups using Active Directory admin tools or [New-ADGroup](https://technet.microsoft.com/itpro/powershell/windows/addsadministration/new-adgroup).

```powershell
New-ADGroup -Name 'HgsJeaReviewers' -GroupScope DomainLocal
New-ADGroup -Name 'HgsJeaAdmins' -GroupScope DomainLocal
```

## Cluster objects

If the account you are using to set up HGS does not have permission to create new computer objects in the domain, you will need to pre-stage the cluster objects.
These steps are explained in [Prestage Cluster Computer Objects in Active Directory Domain Services](https://technet.microsoft.com/library/dn466519(v=ws.11).aspx).

To set up your first HGS node, you will need to create one Cluster Name Object (CNO) and one Virtual Computer Object (VCO).
The CNO represents the name of the cluster, and is primarily used internally by Failover Clustering.
The VCO represents the HGS service that resides on top of the cluster and will be the name registered with the DNS server.

> [!IMPORTANT]
> The user who will run `Initialize-HgsServer` requires **Full Control** over the CNO and VCO objects in Active Directory.

To quickly prestage your CNO and VCO, have an Active Directory admin run the following PowerShell commands:

```powershell
# Create the CNO
$cno = New-ADComputer -Name 'HgsCluster' -Description 'HGS CNO' -Enabled $false -Passthru

# Create the VCO
$vco = New-ADComputer -Name 'HgsService' -Description 'HGS VCO' -Passthru

# Give the CNO full control over the VCO
$vcoPath = Join-Path "AD:\" $vco.DistinguishedName
$acl = Get-Acl $vcoPath
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $cno.SID, "GenericAll", "Allow"
$acl.AddAccessRule($ace)
Set-Acl -Path $vcoPath -AclObject $acl

# Allow time for your new CNO and VCO to replicate to your other Domain Controllers before continuing
```

## Security baseline exceptions

If you are deploying HGS into a highly locked down environment, certain Group Policy settings may prevent HGS from operating normally.
Check your Group Policy objects for the following settings and follow the guidance if you are affected:

### Network Logon

**Policy Path:** Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignments

**Policy Name:** Deny access to this computer from the network

**Required value:** Ensure the value does not block network logons for all local accounts. You can safely block local administrator accounts, however.

**Reason:** Failover Clustering relies on a non-administrator local account called CLIUSR to manage cluster nodes. Blocking network logon for this user will prevent the cluster from operating correctly.

### Kerberos Encryption

**Policy Path:** Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options

**Policy Name:** Network Security: Configure encryption types allowed for Kerberos

**Action**: If this policy is configured, you must update the gMSA account with [Set-ADServiceAccount](https://docs.microsoft.com/powershell/module/addsadministration/set-adserviceaccount?view=win10-ps) to use only the supported encryption types in this policy. For instance, if your policy only allows AES128\_HMAC\_SHA1 and AES256\_HMAC\_SHA1, you should run `Set-ADServiceAccount -Identity HGSgMSA -KerberosEncryptionType AES128,AES256`.



## Next steps

- For the next steps to set up TPM-based attestation, see [Initialize the HGS cluster using TPM mode in an existing bastion forest](guarded-fabric-initialize-hgs-tpm-mode-bastion.md).
- For the next steps to set up host key attestation, see [Initialize the HGS cluster using key mode in an existing bastion forest](guarded-fabric-initialize-hgs-key-mode-bastion.md).
- For the next steps to set up Admin-based attestation (deprecated in Windows Server 2019), see [Initialize the HGS cluster using AD mode in an existing bastion forest](guarded-fabric-initialize-hgs-ad-mode-bastion.md).

