If your datacenter has a secure bastion forest where you want to join HGS nodes, follow these steps.
You can also use these steps to configure 2 or more independent HGS clusters that are joined to the same domain.

## Join the HGS server to the existing domain

Use Server Manager or [Add-Computer](http://go.microsoft.com/fwlink/?LinkId=821564) to join the HGS servers to the desired domain.

## Prepare Active Directory objects

Create a group managed service account and 2 security groups.
You can also pre-stage the cluster objects if the account you are initializing HGS with does not have permission to create computer objects in the domain.

## Group managed service account

The group managed service account (gMSA) is the identity used by HGS to retrieve and use its certificates. Use [New-ADServiceAccount](https://technet.microsoft.com/itpro/powershell/windows/addsadministration/new-adserviceaccount) to create a gMSA.
If this is the first gMSA in the domain, you will need to add a Key Distribution Service root key.

Each HGS node will need to be permitted to access the gMSA password.
The easiest way to configure this is to create a security group that contains all of your HGS nodes and grant that security group access to retrieve the gMSA password.

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
```

<!-- Appears in guarded-fabric-initialize-hgs-tpm-mode-bastion.md and guarded-fabric-initialize-hgs-ad-mode-bastion.md>