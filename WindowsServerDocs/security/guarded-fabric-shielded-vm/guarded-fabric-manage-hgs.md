---
title: Managing the Host Guardian Service
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: eecb002e-6ae5-4075-9a83-2bbcee2a891c
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Managing the Host Guardian Service

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

The Host Guardian Service (HGS) is the centerpiece of the guarded fabric solution.
It is responsible for ensuring that Hyper-V hosts in the fabric are known to the hoster or enterprise and running trusted software and for managing the keys used to start up shielded VMs.
When a tenant decides to trust you to host their shielded VMs, they are placing their trust in your configuration and management of the Host Guardian Service.
Therefore, it is very important to follow best practices when managing the Host Guardian Service to ensure the security, availability and reliability of your guarded fabric.
The guidance in the following sections addresses the most common operational issues facing administrators of HGS.

## Limiting admin access to HGS
Due to the security sensitive nature of HGS, it is important to ensure that its administrators are highly trusted members of your organization and, ideally, separate from the administrators of your fabric resources.
Additionally, it is recommended that you only manage HGS from secure workstations using secure communication protocols, such as WinRM over HTTPS.

### Separation of Duties
When setting up HGS, you are given the option of creating an isolated Active Directory forest just for HGS or to join HGS to an existing, trusted domain.
This decision, as well as the roles you assign the admins in your organization, determine the trust boundary for HGS.
Whoever has access to HGS, whether directly as an admin or indirectly as an admin of something else (e.g. Active Directory) that can influence HGS, has control over your guarded fabric.
HGS admins choose which Hyper-V hosts are authorized to run shielded VMs and manage the certificates necessary to start up shielded VMs.
An attacker or malicious admin who has access to HGS can use this power to authorize compromised hosts to run shielded VMs, initiate a denial-of-service attack by removing key material, and more.

To avoid this risk, it is *strongly* recommended that you limit the overlap between the admins of your HGS (including the domain to which HGS is joined) and Hyper-V environments.
By ensuring no one admin has access to both systems, an attacker would need to compromise 2 different accounts from 2 individuals to complete his mission to change the HGS policies.
This also means that the domain and enterprise admins for the two Active Directory environments should not be the same person, nor should HGS use the same Active Directory forest as your Hyper-V hosts.
Anyone who can grant themselves access to more resources poses a security risk.

### Using Just Enough Administration
HGS comes with [Just Enough Administration](https://aka.ms/JEAdocs) (JEA) roles built in to help you manage it more securely.
JEA helps by allowing you to delegate admin tasks to non-admin users, meaning the people who manage HGS policies need not actually be admins of the entire machine or domain.
JEA works by limiting what commands a user can run in a PowerShell session and using a temporary local account behind the scenes (unique for each user session) to run the commands which normally require elevation.

HGS ships with 2 JEA roles preconfigured:
- **HGS Administrators** which allows users to manage all HGS policies, including authorizing new hosts to run shielded VMs.
- **HGS Reviewers** which only allows users the right to audit existing policies. They cannot make any changes to the HGS configuration.

To use JEA, you first need to create a new standard user and make them a member of either the HGS admins or HGS reviewers group.
If you used `Install-HgsServer` to set up a new forest for HGS, these groups will be named "*servicename*Administrators" and "*servicename*Reviewers", respectively, where *servicename* is the network name of the HGS cluster.
If you joined HGS to an existing domain, you should refer to the group names you specified in `Initialize-HgsServer`.

**Create standard users for the HGS administrator and reviewer roles**

```powershell
$hgsServiceName = (Get-ClusterResource HgsClusterResource | Get-ClusterParameter DnsName).Value
$adminGroup = $hgsServiceName + "Administrators"
$reviewerGroup = $hgsServiceName + "Reviewers"

New-ADUser -Name 'hgsadmin01' -AccountPassword (Read-Host -AsSecureString -Prompt 'HGS Admin Password') -ChangePasswordAtLogon $false -Enabled $true
Add-ADGroupMember -Identity $adminGroup -Members 'hgsadmin01'

New-ADUser -Name 'hgsreviewer01' -AccountPassword (Read-Host -AsSecureString -Prompt 'HGS Reviewer Password') -ChangePasswordAtLogon $false -Enabled $true
Add-ADGroupMember -Identity $reviewerGroup -Members 'hgsreviewer01'
```

**Audit policies with the reviewer role**

On a remote machine that has network connectivity to HGS, run the following commands in PowerShell to enter the JEA session with the reviewer credentials.
It is important to note that since the reviewer account is just a standard user, it cannot be used for regular Windows PowerShell remoting, Remote Desktop access to HGS, etc.

```powershell
Enter-PSSession -ComputerName <hgsnode> -Credential '<hgsdomain>\hgsreviewer01' -ConfigurationName 'microsoft.windows.hgs'
```

You can then check which commands are allowed in the session with `Get-Command` and run any allowed commands to audit the configuration.
In the below example, we are checking which policies are enabled on HGS.

```powershell
Get-Command

Get-HgsAttestationPolicy
```

Type the command `Exit-PSSession` or its alias, `exit`, when you are done working with the JEA session. 

**Add a new policy to HGS using the administrator role**

To actually change a policy, you need to connect to the JEA endpoint with an identity that belongs to the 'hgsAdministrators' group.
In the below example, we show how you can copy a new code integrity policy to HGS and register it using JEA.
The syntax may be different from what you are used to.
This is to accommodate some of the restrictions in JEA like not having access to the full file system.

```powershell
$cipolicy = Get-Item "C:\temp\cipolicy.p7b"
$session = New-PSSession -ComputerName <hgsnode> -Credential '<hgsdomain>\hgsadmin01' -ConfigurationName 'microsoft.windows.hgs'
Copy-Item -Path $cipolicy -Destination 'User:' -ToSession $session

# Now that the file is copied, we enter the interactive session to register it with HGS
Enter-PSSession -Session $session
Add-HgsAttestationCiPolicy -Name 'New CI Policy via JEA' -Path 'User:\cipolicy.p7b'

# Confirm it was added successfully
Get-HgsAttestationPolicy -PolicyType CiPolicy

# Finally, remove the PSSession since it is no longer needed
Exit-PSSession
Remove-PSSession -Session $session
```

## Monitoring HGS
### Event sources and forwarding
Events from HGS will show up in the Windows event log under 2 sources:
- **HostGuardianService-Attestation**
- **HostGuardianService-KeyProtection**

You can view these events by opening Event Viewer and navigating to Microsoft-Windows-HostGuardianService-Attestation and Microsoft-Windows-HostGuardianService-KeyProtection.

In a large environment, it is often preferable to forward events to a central Windows Event Collector to make analyzation of the events easier.
For more information, check out the [Windows Event Forwarding documentation](https://msdn.microsoft.com/library/windows/desktop/bb427443.aspx).

### Using System Center Operations Manager
You can also use System Center 2016 - Operations Manager to monitor HGS and your guarded hosts.
The guarded fabric management pack has event monitors to check for common misconfigurations that can lead to datacenter downtime, including hosts not passing attestation and HGS servers reporting errors.

To get started, [install and configure SCOM 2016](https://technet.microsoft.com/system-center-docs/om/welcome-to-operations-manager) and [download the guarded fabric management pack](https://www.microsoft.com/download/details.aspx?id=52764).
The included management pack guide explains how to configure the management pack and understand the scope of its monitors.

## Backing up and restoring HGS
### Disaster recovery planning
When drafting your disaster recovery plans, it is important to consider the unique requirements of the Host Guardian Service in your guarded fabric.
Should you lose some or all of your HGS nodes, you may face immediate availability problems that will prevent users from starting up their shielded VMs.
In a scenario where you lose your entire HGS cluster, you will need to have complete backups of the HGS configuration on hand to restore your HGS cluster and resume normal operations.
This section covers the steps necessary to prepare for such a scenario.

First, it's important to understand what about HGS is important to back up.
HGS retains several pieces of information that help it determine which hosts are authorized to run shielded VMs.
This includes:
1. Active Directory security identifiers for the groups containing trusted hosts (when using Active Directory attestation);
2. Unique TPM identifiers for each host in your environment;
3. TPM policies for each unique configuration of host; and
4. Code integrity policies that determine which software is allowed to run on your hosts.

These attestation artifacts require coordination with the admins of your hosting fabric to obtain, potentially making it difficult to get this information again after a disaster.

Additionally, HGS requires access to 2 or more certificates used to encrypt and sign the information required to start up a shielded VM (the key protector).
These certificates are well known (used by the owners of shielded VMs to authorize your fabric to run their VMs) and must be restored after a disaster for a seamless recovery experience.
Should you not restore HGS with the same certificates after a disaster, each VM would need to be updated to authorize your new keys to decrypt their information.
For security reasons, only the VM owner can update the VM configuration to authorize these new keys, meaning failure to restore your keys after a disaster will result in each VM owner needing to take action to get their VMs running again.

#### Preparing for the worst
To prepare for a complete loss of HGS, there are 2 steps you must take:
1. Back up the HGS attestation policies
2. Back up the HGS keys

Guidance on how to perform both of these steps is provided in the [Backing up HGS](#backing-up-hgs) section.

It is additionally recommended, but not required, that you back up the list of users authorized to manage HGS in its Active Directory domain or Active Directory itself.

Backups should be taken regularly to ensure the information is up to date and stored securely to avoid tampering or theft.

It is **not recommended** to back up or attempt to restore an entire system image of an HGS node.
In the event you have lost your entire cluster, the best practice is to set up a brand new HGS node and restore just the HGS state, not the entire server OS.

#### Recovering from the loss of one node
If you lose one or more nodes (but not every node) in your HGS cluster, you can simply [add nodes to your cluster](guarded-fabric-configure-additional-hgs-nodes.md) following the guidance in the deployment guide.
The attestation policies will sync automatically, as will any certificates which were provided to HGS as PFX files with accompanying passwords.
For certificates added to HGS using a thumbprint (non-exportable and hardware backed certificates, commonly), you will need to ensure each new node has access to the private key of each certificate.

#### Recovering from the loss of the entire cluster
If your entire HGS cluster goes down and you are unable to bring it back online, you will need to restore HGS from a backup.
Restoring HGS from a backup involves first setting up a new HGS cluster per the [guidance in the deployment guide](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).
It is highly recommended, but not required, to use the same cluster name when setting up the recovery HGS environment to assist with name resolution from hosts.
Using the same name avoids having to reconfigure hosts with new attestation and key protection URLs.
If you restored objects to the Active Directory domain backing HGS, it is recommended that you remove the objects representing the HGS cluster, computers, service account and JEA groups before initializing the HGS server.

Once you have set up your first HGS node (e.g. it has been installed and initialized), you will follow the procedures under [Restoring HGS from a backup](#restoring-hgs-from-a-backup) to restore the attestation policies and public halves of the key protection certificates.
You will need to restore the private keys for your certificates manually according to the guidance of your certificate provider (e.g. import the certificate in Windows, or configure access to HSM-backed certificates).
After the first node is set up, you can continue to [install additional nodes to the cluster](guarded-fabric-configure-additional-hgs-nodes.md) until you have reached the capacity and resiliency you desire.

### Backing up HGS
The HGS administrator should be responsible for backing up HGS on a regular basis.
A complete backup will contain sensitive key material that must be appropriately secured.
Should an untrusted entity gain access to these keys, they could use that material to set up a malicious HGS environment for the purpose of compromising shielded VMs.

**Backing up the attestation policies**
To back up the HGS attestation policies, run the following command on any working HGS server node.
You will be prompted to provide a password.
This password is used to encrypt any certificates added to HGS using a PFX file (instead of a certificate thumbprint).

```powershell
Export-HgsServerState -Path C:\temp\HGSBackup.xml
```

> [!NOTE]
> If you are using admin-trusted attestation, you must separately back up membership in the security groups used by HGS to authorize guarded hosts.
> HGS will only back up the SID of the security groups, not the membership within them.
> In the event these groups are lost during a disaster, you will need to recreate the group(s) and add each guarded host to them again.

**Backing up certificates**

The `Export-HgsServerState` command will back up any PFX-based certificates added to HGS at the time the command is run.
If you added certificates to HGS using a thumbprint (typical for non-exportable and hardware-backed certificates), you will need to manually back up the private keys for your certificates.
To identify which certificates are registered with HGS and need to be backed up manually, run the following PowerShell command on any working HGS server node.

```powershell
Get-HgsKeyProtectionCertificate | Where-Object { $_.CertificateData.GetType().Name -eq 'CertificateReference' } | Format-Table Thumbprint, @{ Label = 'Subject'; Expression = { $_.CertificateData.Certificate.Subject } }
```

For each of the certificates listed, you will need to manually back up the private key.
If you are using software-based certificate that is non-exportable, you should contact your certificate authority to ensure they have a backup of your certificate and/or can reissue it on demand.
For certificates created and stored in hardware security modules, you should consult the documentation for your device for guidance on disaster recovery planning.

You should store the certificate backups alongside your attestation policy backups in a secure location so that both pieces can be restored together.

**Additional configuration to back up**

The backed up HGS server state will not include the name of your HGS cluster, any information from Active Directory, or any SSL certificates used to secure communications with the HGS APIs.
These settings are important for consistency but not critical to get your HGS cluster back online after a disaster.

To capture the name of the HGS service, run `Get-HgsServer` and note the flat name in the Attestation and Key Protection URLs.
For example, if the Attestation URL is "<http://hgs.contoso.com/Attestation>", "hgs" is the HGS service name.

The Active Directory domain used by HGS should be managed like any other Active Directory domain.
When restoring HGS after a disaster, you will not necessarily need to recreate the exact objects that are present in the current domain.
However, it will make recovery easier if you back up Active Directory and keep a list of the JEA users authorized to manage the system as well as the membership of any security groups used by admin-trusted attestation to authorize guarded hosts.

To identify the thumbprint of the SSL certificates configured for HGS, run the following command in PowerShell.
You can then back up those SSL certificates according to your certificate provider's instructions.

```powershell
Get-WebBinding -Protocol https | Select-Object certificateHash
```

### Restoring HGS from a backup
The following steps describe how to restore HGS settings from a backup.
The steps are relevant to both situations where you are trying to undo changes made to your already-running HGS instances and when you are standing up a brand new HGS cluster after a complete loss of your previous one.

#### Set up a replacement HGS cluster
Before you can restore HGS, you need to have an initialized HGS cluster to which you can restore the configuration.
If you are simply importing settings that were accidentally deleted to an existing (running) cluster, you can skip this step.
If you are recovering from a complete loss of HGS, you will need to install and initialize at least one HGS node following the [guidance in the deployment guide](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

Specifically, you will need to:
1. [Set up the HGS domain](guarded-fabric-choose-where-to-install-hgs.md) or join HGS to an existing domain
2. [Initialize the HGS server](guarded-fabric-initialize-hgs.md) using your existing keys *or* a set of temporary keys. You can [remove the temporary keys](#renewing-or-replacing-keys) after importing your actual keys from the HGS backup files.
3. [Import HGS settings](#import-settings-from-a-backup) from your backup to restore the trusted host groups, code integrity policies, TPM baselines, and TPM identifiers

> [!TIP]
> The new HGS cluster does not need to use the same certificates, service name, or domain as the HGS instance from which your backup file was exported.

#### Import settings from a backup

To restore attestation policies, PFX-based certificates, and the public keys of non-PFX certificates to your HGS node from a backup file, run the following command on an initialized HGS server node.
You will be prompted to enter the password you specified when creating the backup.

```powershell
Import-HgsServerState -Path C:\Temp\HGSBackup.xml
```

If you only want to import admin-trusted attestation policies or TPM-trusted attestation policies, you can do so by specifying the `-ImportActiveDirectoryModeState` or `-ImportTpmModeState` flags to [Import-HgsServerState](https://technet.microsoft.com/library/mt652168.aspx).

Ensure the latest cumulative update for Windows Server 2016 is installed before running `Import-HgsServerState`.
Failure to do so may result in an import error.

> [!NOTE]
> If you restore policies on an existing HGS node that already has one or more of those policies installed, the import command will show an error for each duplicate policy.
> This is an expected behavior and can be safely ignored in most cases.

#### Reinstall private keys for certificates
If any of the certificates used on the HGS from which the backup was created were added using thumbprints, only the public key of those certificates will be included in the backup file.
This means that you will need to manually install and/or grant access to the private keys for each of those certificates before HGS can service requests from Hyper-V hosts.
The actions necessary to complete that step varies depending on how your certificate was originally issued.
For software-backed certificates issued by a certificate authority, you will need to contact your CA to get the private key and install it on **each** HGS node per their instructions.
Similarly, if your certificates are hardware-backed, you will need to consult your hardware security module vendor's documentation to install the necessary driver(s) on each HGS node to connect to the HSM and grant each machine access to the private key.

As a reminder, certificates added to HGS using thumbprints require manual replication of the private keys to each node.
You will need to repeat this step on each additional node you add to the restored HGS cluster.

#### Review imported attestation policies
After you've imported your settings from a backup, it is recommended to closely review all the imported policies using `Get-HgsAttestationPolicy` to make sure only the hosts you trust to run shielded VMs will be able to successfully attest.
If you find any policies which no longer match your security posture, you can [disable or remove them](#review-attestation-policies).

#### Run diagnostics to check system state
After you have finished setting up and restoring the state of your HGS node, you should run the HGS diagnostics tool to check the state of the system.
To do this, run the following command on the HGS node where you restored the configuration:

```powershell
Get-HgsTrace -RunDiagnostics
```

If the "Overall Result" is not "Pass", additional steps are required to finish configuring the system.
Check the messages reported in the subtest(s) that failed for more information.

## Patching HGS
It is important to keep your Host Guardian Service nodes up to date by installing the latest cumulative update when it comes out.
If you are setting up a brand new HGS node, it is highly recommended that you install any available updates before installing the HGS role or configuring it.
This will ensure any new or changed functionality will take effect immediately.

When patching your guarded fabric, it is strongly recommended that you first upgrade *all* Hyper-V hosts **before upgrading HGS**.
This is to ensure that any changes to the attestation policies on HGS are made *after* the Hyper-V hosts have been updated to provide the information needed for them.
If an update is going to change the behavior of policies, they will not automatically be enabled to avoid disrupting your fabric.
Such updates require that you follow the guidance in the following section to activate the new or changed attestation policies.
We encourage you to read the release notes for Windows Server and any cumulative updates you install to check if the policy updates are required.

### Updates requiring policy activation
If an update for HGS introduces or significantly changes the behavior of an attestation policy, an additional step is required to activate the changed policy.
Policy changes are only enacted after exporting and importing the HGS state.
You should only activate the new or changed policies after you have applied the cumulative update to all hosts and all HGS nodes in your environment.
Once every machine has been updated, run the following commands on any HGS node to trigger the upgrade process:

```powershell
$password = Read-Host -AsSecureString -Prompt "Enter a temporary password"
Export-HgsServerState -Path .\temporaryExport.xml -Password $password
Import-HgsServerState -Path .\temporaryExport.xml -Password $password
```

If a new policy was introduced, it will be disabled by default.
To enable the new policy, first find it in the list of Microsoft policies (prefixed with 'HGS_') and then enable it using the following commands:

```powershell
Get-HgsAttestationPolicy

Enable-HgsAttestationPolicy -Name <Hgs_NewPolicyName>
```

## Managing attestation policies
HGS maintains several attestation policies which define the minimum set of requirements a host must meet in order to be deemed "healthy" and allowed to run shielded VMs.
Some of these policies are defined by Microsoft, others are added by you to define the allowable code integrity policies, TPM baselines, and hosts in your environment.
Regular maintenance of these policies is necessary to ensure hosts can continue attesting properly as you update and replace them, and to ensure any untrusted hosts or configurations are blocked from successfully attesting.

For admin-trusted attestation, there is only one policy which determines if a host is healthy: membership in a known, trusted security group.
TPM attestation is more complicated, and involves various policies to measure the code and configuration of a system before determining if it is healthy.

A single HGS can be configured with both Active Directory and TPM policies at once, but the service will only check the policies for the current mode which it is configured for when a host tries attesting.
To check the mode of your HGS server, run `Get-HgsServer`.

### Default policies
For TPM-trusted attestation, there are several built-in policies configured on HGS.
Some of these policies are "locked" -- meaning that they cannot be disabled for security reasons.
The table below explains the purpose of each default policy.

Policy Name                    | Purpose
-------------------------------|-----------------------------------------------------
Hgs_SecureBootEnabled          | Requires hosts to have Secure Boot enabled. This is necessary to measure the startup binaries and other UEFI-locked settings.
Hgs_UefiDebugDisabled          | Ensures hosts do not have a kernel debugger enabled. User-mode debuggers are blocked with code integrity policies.
Hgs_SecureBootSettings         | Negative policy to ensure hosts match at least one (admin-defined) TPM baseline.
Hgs_CiPolicy                   | Negative policy to ensure hosts are using one of the admin-defined CI policies.
Hgs_HypervisorEnforcedCiPolicy | Requires the code integrity policy to be enforced by the hypervisor. Disabling this policy weakens your protections against kernel-mode code integrity policy attacks.
Hgs_FullBoot                   | Ensures the host did not resume from sleep or hibernation. Hosts must be properly restarted or shut down to pass this policy.
Hgs_VsmIdkPresent              | Requires virtualization based security to be running on the host. The IDK represents the key necessary to encrypt information sent back to the host's secure memory space.
Hgs_PageFileEncryptionEnabled  | Requires pagefiles to be encrypted on the host. Disabling this policy could result in information exposure if an unencrypted pagefile is inspected for tenant secrets.
Hgs_BitLockerEnabled           | Requires BitLocker to be enabled on the Hyper-V host. This policy is disabled by default for performance reasons and is not recommended to be enabled. This policy has no bearing on the encryption of the shielded VMs themselves.
Hgs_IommuEnabled               | Requires that the host have an IOMMU device in use to prevent direct memory access attacks. Disabling this policy and using hosts without an IOMMU enabled can expose tenant VM secrets to direct memory attacks.
Hgs_NoHibernation              | Requires hibernation to be disabled on the Hyper-V host. Disabling this policy could allow hosts to save shielded VM memory to an unencrypted hibernation file.
Hgs_NoDumps                    | Requires memory dumps to be disabled on the Hyper-V host. If you disable this policy, it is recommended that you configure dump encryption to prevent shielded VM memory from being saved to unencrypted crash dump files.
Hgs_DumpEncryption             | Requires memory dumps, if enabled on the Hyper-V host, to be encrypted with an encryption key trusted by HGS. This policy does not apply if dumps are not enabled on the host. If this policy and *Hgs\_NoDumps* are both disabled, shielded VM memory could be saved to an unencrypted dump file.
Hgs_DumpEncryptionKey          | Negative policy to ensure hosts configured to allow memory dumps are using an admin-defined dump file encryption key known to HGS. This policy does not apply when *Hgs\_DumpEncryption* is disabled.

### Authorizing new guarded hosts
To authorize a new host to become a guarded host (e.g. attest successfully), HGS must trust the host and (when configured to use TPM-trusted attestation) the software running on it.
The steps to authorize a new host differ based on the attestation mode for which HGS is currently configured.
To check the attestation mode for your guarded fabric, run `Get-HgsServer` on any HGS node.

#### Software configuration
On the new Hyper-V host, ensure that Windows Server 2016 Datacenter edition is installed.
Windows Server 2016 Standard cannot run shielded VMs in a guarded fabric.
The host may be installed Desktop Experience or Server Core.

On server with desktop experience and Server Core, you need to install the Hyper-V and Host Guardian Hyper-V Support server roles:

```powershell
Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart
```

#### Admin-trusted attestation
To register a new host in HGS when using admin-trusted attestation, you must first add the host to a security group in the domain to which it's joined.
Typically, each domain will have one security group for guarded hosts.
If you have already registered that group with HGS, the only action you need to take is to restart the host to refresh its group membership.

You can check which security groups are trusted by HGS by running the following command:

```powershell
Get-HgsAttestationHostGroup
```

To register a new security group with HGS, first capture the security identifier (SID) of the group in the host's domain and register the SID with HGS.

```powershell
Add-HgsAttestationHostGroup -Name "Contoso Guarded Hosts" -Identifier "S-1-5-21-3623811015-3361044348-30300820-1013"
```

Instructions on how to set up the trust between the host domain and HGS are available in the deployment guide.

#### TPM-trusted attestation
When HGS is configured in TPM mode, hosts must pass all locked policies and "enabled" policies prefixed with "Hgs_", as well as at least one TPM baseline, TPM identifier, and code integrity policy.
Each time you add a new host, you will need to register the new TPM identifier with HGS.
As long as the host is running the same software (and has the same code integrity policy applied) and TPM baseline as another host in your environment, you will not need to add new CI policies or baselines.

**Adding the TPM identifier for a new host**
On the new host, run the following command to capture the TPM identifier.
Be sure to specify a unique name for the host that will help you look it up on HGS.
You will need this information if you decommission the host or want to prevent it from running shielded VMs in HGS.

```powershell
(Get-PlatformIdentifier -Name "Host01").InnerXml | Out-File C:\temp\host01.xml -Encoding UTF8
```

Copy this file to your HGS server, then run the following command to register the host with HGS.

```powershell
Add-HgsAttestationTpmHost -Name 'Host01' -Path C:\temp\host01.xml
```

**Adding a new TPM baseline**
If the new host is running a new hardware or firmware configuration for your environment, you may need to take a new TPM baseline.
To do this, run the following command on the host.

```powershell
Get-HgsAttestationBaselinePolicy -Path 'C:\temp\hardwareConfig01.tcglog'
```

> [!NOTE]
> If you receive an error saying your host failed validation and will not successfully attest, do not worry.
> This is a prerequisite check to make sure your host can run shielded VMs, and likely means that you have not yet applied a code integrity policy or other required setting.
> Read the error message, make any changes suggested by it, then try again.
> Alternatively, you can skip the validation at this time by adding the `-SkipValidation` flag to the command.

Copy the TPM baseline to your HGS server, then register it with the following command.
We encourage you to use a naming convention that helps you understand the hardware and firmware configuration of this class of Hyper-V host.

```powershell
Add-HgsAttestationTpmPolicy -Name 'HardwareConfig01' -Path 'C:\temp\hardwareConfig01.tcglog'
```

**Adding a new code integrity policy**
If you have changed the code integrity policy running on your Hyper-V hosts, you will need to register the new policy with HGS before those hosts can successfully attest.
On a reference host, which serves as a master image for the trusted Hyper-V machines in your environment, capture a new CI policy using the `New-CIPolicy` command.
We encourage you to use the **FilePublisher** level and **Hash** fallback for Hyper-V host CI policies.
You should first create a CI policy in audit mode to ensure that everything is working as expected.
After validating a sample workload on the system, you can enforce the policy and copy the enforced version to HGS.
For a complete list of code integrity policy configuration options, consult the [Device Guard documentation](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-deploy-code-integrity-policies).

```powershell
# Capture a new CI policy with the FilePublisher primary level and Hash fallback and enable user mode code integrity protections
New-CIPolicy -FilePath 'C:\temp\ws2016-hardware01-ci.xml' -Level FilePublisher -Fallback Hash -UserPEs

# Apply the CI policy to the system
ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\ws2016-hardware01-ci.xml' -BinaryFilePath 'C:\temp\ws2016-hardware01-ci.p7b'
Copy-Item 'C:\temp\ws2016-hardware01-ci.p7b' 'C:\Windows\System32\CodeIntegrity\SIPolicy.p7b'
Restart-Computer

# Check the event log for any untrusted binaries and update the policy if necessary
# Consult the Device Guard documentation for more details

# Change the policy to be in enforced mode
Set-RuleOption -FilePath 'C:\temp\ws2016-hardare01-ci.xml' -Option 3 -Delete

# Apply the enforced CI policy on the system
ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\ws2016-hardware01-ci.xml' -BinaryFilePath 'C:\temp\ws2016-hardware01-ci.p7b'
Copy-Item 'C:\temp\ws2016-hardware01-ci.p7b' 'C:\Windows\System32\CodeIntegrity\SIPolicy.p7b'
Restart-Computer
```

Once you have your policy created, tested and enforced, copy the binary file (.p7b) to your HGS server and register the policy.

```powershell
Add-HgsAttestationCiPolicy -Name 'WS2016-Hardware01' -Path 'C:\temp\ws2016-hardware01-ci.p7b'
```

**Adding a memory dump encryption key**

When the *Hgs\_NoDumps* policy is disabled and *Hgs\_DumpEncryption* policy is enabled, guarded hosts are allowed to have memory dumps (including crash dumps) to be enabled as long as those dumps are encrypted. Guarded hosts will only pass attestation if they either have memory dumps disabled or are encrypting them with a key known to HGS. By default, no dump encryption keys are configured on HGS.

To add a dump encryption key to HGS, use the `Add-HgsAttestationDumpPolicy` cmdlet to provide HGS with the hash of your dump encryption key.
If you capture a TPM baseline on a Hyper-V host configured with dump encryption, the hash is included in the tcglog and can be provided to the `Add-HgsAttestationDumpPolicy` cmdlet.

```powershell
Add-HgsAttestationDumpPolicy -Name 'DumpEncryptionKey01' -Path 'C:\temp\TpmBaselineWithDumpEncryptionKey.tcglog'
```

Alternatively, you can directly provide the string representation of the hash to the cmdlet.

```powershell
Add-HgsAttestationDumpPolicy -Name 'DumpEncryptionKey02' -PublicKeyHash '<paste your hash here>'
```

Be sure to add each unique dump encryption key to HGS if you choose to use different keys across your guarded fabric.
Hosts that are encrypting memory dumps with a key not known to HGS will not pass attestation.

Consult the Hyper-V documentation for more information about [configuring dump encryption on hosts](https://technet.microsoft.com/windows-server-docs/virtualization/hyper-v/manage/about-dump-encryption).

#### Check if the system passed attestation
After registering the necessary information with HGS, you should check if the host passes attestation.
On the newly-added Hyper-V host, run `Set-HgsClientConfiguration` and supply the correct URLs for your HGS cluster.
These URLs can be obtained by running `Get-HgsServer` on any HGS node.

```powershell
Set-HgsClientConfiguration -KeyProtectionServerUrl 'http://hgs.bastion.local/KeyProtection' -AttestationServerUrl 'http://hgs.bastion.local/Attestation'
```

If the resulting status does not indicate "IsHostGuarded : True" you will need to troubleshoot the configuration.
On the host that failed attestation, run the following command to get a detailed report about issues that may help you resolve the failed attestation.

```powershell
Get-HgsTrace -RunDiagnostics -Detailed
```

> [!IMPORTANT]
> If you're using Windows Server 2019 or Windows 10, version 1809 and are using code integrity policies, `Get-HgsTrace` may return a failure for the **Code Integrity Policy Active** diagnostic.
> You can safely ignore this result when it is the only failing diagnostic.

### Review attestation policies
To review the current state of the policies configured on HGS, run the following commands on any HGS node:

```powershell
# List all trusted security groups for admin-trusted attestation
Get-HgsAttestationHostGroup

# List all policies configured for TPM-trusted attestation
Get-HgsAttestationPolicy
```

If you find a policy enabled that no longer meets your security requirement (e.g. an old code integrity policy which is now deemed unsafe), you can disable it by replacing the name of the policy in the following command:

```powershell
Disable-HgsAttestationPolicy -Name 'PolicyName'
```

Similarly, you can use `Enable-HgsAttestationPolicy` to re-enable a policy.

If you no longer need a policy and wish to remove it from all HGS nodes, run `Remove-HgsAttestationPolicy -Name 'PolicyName'` to permanently delete the policy.

## Changing attestation modes
If you started your guarded fabric using admin-trusted attestation, you will likely want to upgrade to the much-stronger TPM attestation mode as soon as you have enough TPM 2.0-compatible hosts in your environment.
When you're ready to switch, you can pre-load all of the attestation artifacts (CI policies, TPM baselines and TPM identifiers) in HGS while continuing to run HGS with admin-trusted attestation.
To do this, simply follow the instruction in the [authorizing a new guarded host](#authorizing-new-guarded-hosts) section.

Once you've added all of your policies to HGS, the next step is to run a synthetic attestation attempt on your hosts to see if they would pass attestation in TPM mode.
This does not affect the current operational state of HGS.
The commands below must be run on a machine that has access to all of the hosts in the environment and at least one HGS node.
If your firewall or other security policies prevent this, you can skip this step.
When possible, we recommend running the synthetic attestation to give you a good indication of whether "flipping" to TPM mode will cause downtime for your VMs. 

```powershell
# Get information for each host in your environment
$hostNames = 'host01.contoso.com', 'host02.contoso.com', 'host03.contoso.com'
$credential = Get-Credential -Message 'Enter a credential with admin privileges on each host'
$targets = @()
$hostNames | ForEach-Object { $targets += New-HgsTraceTarget -Credential $credential -Role GuardedHost -HostName $_ }

$hgsCredential = Get-Credential -Message 'Enter an admin credential for HGS'
$targets += New-HgsTraceTarget -Credential $hgsCredential -Role HostGuardianService -HostName 'HGS01.bastion.local'

# Initiate the synthetic attestation attempt
Get-HgsTrace -RunDiagnostics -Target $targets -Diagnostic GuardedFabricTpmMode 
```

After the diagnostics complete, review the outputted information to determine if any hosts would have failed attestation in TPM mode.
Re-run the diagnostics until you get a "pass" from each host, then proceed to change HGS to TPM mode.

**Changing to TPM mode** takes just a second to complete.
Run the following command on any HGS node to update the attestation mode.

```powershell
Set-HgsServer -TrustTpm
```

If you run into problems and need to switch back to Active Directory mode, you can do so by running `Set-HgsServer -TrustActiveDirectory`.

Once you have confirmed everything is working as expected, you should remove all trusted Active Directory host groups from HGS and remove the trust between the HGS and fabric domains.
If you leave the Active Directory trust in place, you risk someone re-enabling the trust and switching HGS to Active Directory mode, which could allow untrusted code to run unchecked on your guarded hosts.

## Key management
The guarded fabric solution uses several public/private key pairs to validate the integrity of various components in the solution and encrypt tenant secrets.
The Host Guardian Service is configured with at least two certificates (with public and private keys), which are used for signing and encrypting the keys used to start up shielded VMs.
Those keys must be carefully managed.
If the private key is acquired by an adversary, they will be able to unshield any VMs running on your fabric or set up an imposter HGS cluster that uses weaker attestation policies to bypass the protections you put in place.
Should you lose the private keys during a disaster and not find them in a backup, you will need to set up a new pair of keys and have each VM re-keyed to authorize your new certificates.

This section covers general key management topics to help you configure your keys so they are functional and secure.

### Adding new keys
While HGS must be initialized with one set of keys, you can add more than one encryption and signing key to HGS.
The two most common reasons why you would add new keys to HGS are:
1. To support "bring your own key" scenarios where tenants copy their private keys to your hardware security module and only authorize their keys to start up their shielded VMs.
2. To replace the existing keys for HGS by first adding the new keys and keeping both sets of keys until each VM configuration has been updated to use the new keys.

The process to add your new keys differs based on the type of certificate you are using.

**Option 1: Adding a certificate stored in an HSM**

Our recommended approach for securing HGS keys is to use certificates created in a hardware security module (HSM).
HSMs ensure use of your keys is tied to physical access to a security-sensitive device in your datacenter.
Each HSM is different and has a unique process to create certificates and register them with HGS.
The steps below are intended to provide rough guidance for using HSM backed certificates.
Consult your HSM vendor's documentation for exact steps and capabilities.

1. Install the HSM software on each HGS node in your cluster. Depending on whether you have a network or local HSM device, you may need to configure the HSM to grant your machine access to its key store.
2. Create 2 certificates in the HSM with **2048 bit RSA keys** for encryption and signing
    1. Create an encryption certificate with the **Data Encipherment** key usage property in your HSM
    2. Create a signing certificate with the **Digital Signature** key usage property in your HSM
3. Install the certificates in each HGS node's local certificate store per your HSM vendor's guidance.
4. If your HSM uses granular permissions to grant specific applications or users permission to use the private key, you will need to grant your HGS group managed service account access to the certificate. You can find the name of the HGS gMSA account by running `(Get-IISAppPool -Name KeyProtection).ProcessModel.UserName`
5. Add the signing and encryption certificates to HGS by replacing the thumbprints with those of your certificates' in the following commands:

    ```powershell
    Add-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint "AABBCCDDEEFF00112233445566778899"
    Add-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint "99887766554433221100FFEEDDCCBBAA"
    ```

**Option 2: Adding non-exportable software certificates**

If you have a software-backed certificate issued by your company's or a public certificate authority that has a non-exportable private key, you will need to add your certificate to HGS using its thumbprint.
1. Install the certificate on your machine according to your certificate authority's instructions.
2. Grant the HGS group managed service account read-access to the private key of the certificate. You can find the name of the HGS gMSA account by running `(Get-IISAppPool -Name KeyProtection).ProcessModel.UserName`
3. Register the certificate with HGS using the following command and substituting in your certificate's thumbprint (change *Encryption* to *Signing* for signing certificates):

    ```powershell
    Add-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint "AABBCCDDEEFF00112233445566778899"
    ```

> [!IMPORTANT]
> You will need to manually install the private key and grant read access to the gMSA account on each HGS node.
> HGS cannot automatically replicate private keys for *any* certificate registered by its thumbprint.

**Option 3: Adding certificates stored in PFX files**

If you have a software-backed certificate with an exportable private key that can be stored in the PFX file format and secured with a password, HGS can automatically manage your certificates for you.
Certificates added with PFX files are automatically replicated to every node of your HGS cluster and HGS secures access to the private keys.
To add a new certificate using a PFX file, run the following commands on any HGS node (change *Encryption* to *Signing* for signing certificates):

```powershell
$certPassword = Read-Host -AsSecureString -Prompt "Provide the PFX file password"
Add-HgsKeyProtectionCertificate -CertificateType Encryption -CertificatePath "C:\temp\encryptionCert.pfx" -CertificatePassword $certPassword
```

**Identifying and changing the primary certificates**
While HGS can support multiple signing and encryption certificates, it uses one pair as its "primary" certificates.
These are the certificates that will be used if someone downloads the guardian metadata for that HGS cluster.
To check which certificates are currently marked as your primary certificates, run the following command:

```powershell
Get-HgsKeyProtectionCertificate -IsPrimary $true
```

To set a new primary encryption or signing certificate, find the thumbprint of the desired certificate and mark it as primary using the following commands:

```powershell
Get-HgsKeyProtectionCertificate
Set-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint "AABBCCDDEEFF00112233445566778899" -IsPrimary
Set-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint "99887766554433221100FFEEDDCCBBAA" -IsPrimary
```

### Renewing or replacing keys
When you create the certificates used by HGS, the certificates will be assigned an expiration date according to your certificate authority's policy and your request information.
Normally, in scenarios where the validity of the certificate is important such as securing HTTP communications, certificates must be renewed before they expire to avoid a service disruption or worrisome error message.
HGS does not use certificates in that sense.
HGS is simply using certificates as a convenient way to create and store an asymmetric key pair.
An expired encryption or signing certificate on HGS does not indicate a weakness or loss of protection for shielded VMs.
Further, certificate revocation checks are not performed by HGS.
If an HGS certificate or issuing authority's certificate is revoked, it will not impact HGS' use of the certificate.

The only time you need to worry about an HGS certificate is if you have reason to believe that its private key has been stolen.
In that case, the integrity of your shielded VMs is at risk because possession of the private half of the HGS encryption and signing key pair is enough to remove the shielding protections on a VM or stand up a fake HGS server that has weaker attestation policies.

If you find yourself in that situation, or are required by compliance standards to refresh certificate keys regularly, the following steps outline the process to change the keys on an HGS server.
Please note that the following guidance represents a significant undertaking that will result in a disruption of service to each VM served by the HGS cluster.
Proper planning for changing HGS keys is required to minimize service disruption and ensure the security of tenant VMs.

On an HGS node, perform the following steps to register a new pair of encryption and signing certificates.
See the section on [adding new keys](#adding-new-keys) for detailed information the various ways to add new keys to HGS.
1. Create a new pair of encryption and signing certificates for your HGS server. Ideally, these will be created in a hardware security module.
2. Register the new encryption and signing certificates with **Add-HgsKeyProtectionCertificate**

    ```powershell
    Add-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint <Thumbprint>
    Add-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint <Thumbprint>
    ```
3. If you used thumbprints, you'll need to go to each node in the cluster to install the private key and grant the HGS gMSA access to the key.
4. Make the new certificates the default certificates in HGS

    ```powershell
    Set-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint <Thumbprint> -IsPrimary
    Set-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint <Thumbprint> -IsPrimary
    ```

At this point, shielding data created with metadata obtained from the HGS node will use the new certificates, but existing VMs will continue to work because the older certificates are still there.
In order to ensure all existing VMs will work with the new keys, you will need to update the key protector on each VM.
This is an action that requires the VM owner (person or entity in possession of the "owner" guardian) to be involved.
For each shielded VM, perform the following steps:
5. Shut down the VM. The VM cannot be turned back on until the remaining steps are complete or else you will need to start the process over again.
6. Save the current key protector to a file: `Get-VMKeyProtector -VMName 'VM001' | Out-File '.\VM001.kp'`
7. Transfer the KP to the VM owner
8. Have the owner download the updated guardian info from HGS and import it on their local system
9. Read the current KP into memory, grant the new guardian access to the KP, and save it to a new file by running the following commands:

    ```powershell
    $kpraw = Get-Content -Path .\VM001.kp
    $kp = ConvertTo-HgsKeyProtector -Bytes $kpraw
    $newGuardian = Get-HgsGuardian -Name 'UpdatedHgsGuardian'
    $updatedKP = Grant-HgsKeyProtectorAccess -KeyProtector $kp -Guardian $newGuardian
    $updatedKP.RawData | Out-File .\updatedVM001.kp
    ```
10. Copy the updated KP back to the hosting fabric
11. Apply the KP to the original VM:

   ```powershell
   $updatedKP = Get-Content -Path .\updatedVM001.kp
   Set-VMKeyProtector -VMName VM001 -KeyProtector $updatedKP
   ```
12.	Finally, start the VM and ensure it runs successfully.

> [!NOTE]
> If the VM owner sets an incorrect key protector on the VM and does not authorize your fabric to run the VM, you will be unable to start up the shielded VM.
> To return to the last known good key protector, run `Set-VMKeyProtector -RestoreLastKnownGoodKeyProtector`

Once all VMs have been updated to authorize the new guardian keys, you can disable and remove the old keys.

13. Get the thumbprints of the old certificates from `Get-HgsKeyProtectionCertificate -IsPrimary $false`

14. Disable each certificate by running the following commands:  

   ```powershell
   Set-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint <Thumbprint> -IsEnabled $false
   Set-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint <Thumbprint> -IsEnabled $false
   ```

15. After ensuring VMs are still able to start with the certificates disabled, remove the certificates from HGS by running the following commands:

   ```powershell
   Remove-HgsKeyProtectionCertificate -CertificateType Signing -Thumbprint <Thumbprint>`
   Remove-HgsKeyProtectionCertificate -CertificateType Encryption -Thumbprint <Thumbprint>`
   ```

> [!IMPORTANT]
> VM backups will contain old key protector information that allow the old certificates to be used to start up the VM.
> If you are aware that your private key has been compromised, you should assume that the VM backups can be compromised, too, and take appropriate action.
> Destroying the VM configuration from the backups (.vmcx) will remove the key protectors, at the cost of needing to use the BitLocker recovery password to boot the VM the next time.

### Key replication between nodes
Every node in the HGS cluster must be configured with the same encryption, signing, and (when configured) SSL certificates.
This is necessary to ensure Hyper-V hosts reaching out to any node in the cluster can have their requests serviced successfully.

**If you initialized HGS server with PFX-based certificates** then HGS will automatically replicate both the public and private key of those certificates across every node in the cluster.
You only need to add the keys on one node.

**If you initialized HGS server with certificate references** or thumbprints, then HGS will only replicate the *public* key in the certificate to each node.
Additionally, HGS cannot grant itself access to the private key on any node in this scenario.
Therefore, it is your responsibility to:
1. Install the private key on each HGS node
2. Grant the HGS group managed service account (gMSA) access to the private key on each node
These tasks add extra operational burden, however they are required for HSM-backed keys and certificates with non-exportable private keys.

**SSL Certificates** are never replicated in any form.
It is your responsibility to initialize each HGS server with the same SSL certificate and update each server whenever you choose to renew or replace the SSL certificate.
When replacing the SSL certificate, it is recommended that you do so using the [Set-HgsServer](https://technet.microsoft.com/library/mt652180.aspx) cmdlet.

## Unconfiguring HGS

If you need to decommission or significantly reconfigure an HGS server, you can do so using the [Clear-HgsServer](https://technet.microsoft.com/library/mt652176.aspx) or [Uninstall-HgsServer](https://technet.microsoft.com/library/mt652182.aspx) cmdlets.

### Clearing the HGS configuration

To remove a node from the HGS cluster, use the [Clear-HgsServer](https://technet.microsoft.com/library/mt652176.aspx) cmdlet.
This cmdlet will make the following changes on the server where it is run:

- Unregisters the attestation and key protection services
- Removes the "microsoft.windows.hgs" JEA management endpoint
- Removes the local computer from the HGS failover cluster

If the server is the last HGS node in the cluster, the cluster and its corresponding Distributed Network Name resource will also be destroyed.

```powershell
# Removes the local computer from the HGS cluster
Clear-HgsServer
```

After the clear operation completes, the HGS server can be re-initialized with [Initialize-HgsServer](https://technet.microsoft.com/library/mt652185.aspx).
If you used [Install-HgsServer](https://technet.microsoft.com/library/mt652169.aspx) to set up an Active Directory Domain Services domain, that domain will remain configured and operational after the clear operation.

### Uninstalling HGS

If you wish to remove a node from the HGS cluster **and** demote the Active Directory Domain Controller running on it, use the [Uninstall-HgsServer](https://technet.microsoft.com/library/mt652182.aspx) cmdlet.
This cmdlet will make the following changes on the server where it is run:

- Unregisters the attestation and key protection services
- Removes the "microsoft.windows.hgs" JEA management endpoint
- Removes the local computer from the HGS failover cluster
- Demotes the Active Directory Domain Controller, if configured

If the server is the last HGS node in the cluster, the domain, failover cluster, and the cluster's Distributed Network Name resource will also be destroyed.

```powershell
# Removes the local computer from the HGS cluster and demotes the ADDC (restart required)
$newLocalAdminPassword = Read-Host -AsSecureString -Prompt "Enter a new password for the local administrator account"
Uninstall-HgsServer -LocalAdministratorPassword $newLocalAdminPassword -Restart
```

After the uninstall operation is complete and the computer has been restarted, you can reinstall ADDC and HGS using [Install-HgsServer](https://technet.microsoft.com/library/mt652169.aspx) or join the computer to a domain and initialize the HGS server in that domain with [Initialize-HgsServer](https://technet.microsoft.com/library/mt652185.aspx).

If you no longer intend to use the computer as a HGS node, you can remove the role from Windows.

```powershell
Uninstall-WindowsFeature HostGuardianServiceRole
```
