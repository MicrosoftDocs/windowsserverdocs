---
title: Branch Office Considerations
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Branch office considerations

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), 

This article describes best practices for running shielded virtual machines in branch offices and other remote scenarios where Hyper-V hosts may have periods of time with limited connectivity to HGS.

## Fallback configuration

Starting with Windows Server version 1709, you can configure an additional set of Host Guardian Service URLs on Hyper-V hosts for use when your primary HGS is unresponsive.
This allows you to run a local HGS cluster that is used as a primary server for better performance with the ability to fall back to your corporate datacenter's HGS if the local servers are down.

To use the fallback option, you’ll need to set up two HGS servers. They can run Windows Server 2019 or Windows Server 2016 and either be part of the same or different clusters. If they are different clusters, you will want to establish operational practices to ensure the attestation policies are in sync between the two servers. They both need to be able to correctly authorize the Hyper-V host to run shielded VMs and have the key material needed to start up the shielded VMs. You can choose to either have a pair of shared encryption and signing certificates between the two clusters, or use separate certificates and configure the HGS shielded VM to authorize both guardians (encryption/signing certificate pairs) in the shielding data file.

Then upgrade your Hyper-V hosts to Windows Server version 1709 or Windows Server 2019 and run the following command:
```powershell
# Replace https://hgs.primary.com and https://hgs.backup.com with your own domain names and protocols
Set-HgsClientConfiguration -KeyProtectionServerUrl 'https://hgs.primary.com/KeyProtection' -AttestationServerUrl 'https://hgs.primary.com/Attestation' -FallbackKeyProtectionServerUrl 'https://hgs.backup.com/KeyProtection' -FallbackAttestationServerUrl 'https://hgs.backup.com/Attestation'
```

To unconfigure a fallback server, simply omit both fallback parameters:
```powershell
Set-HgsClientConfiguration -KeyProtectionServerUrl 'https://hgs.primary.com/KeyProtection' -AttestationServerUrl 'https://hgs.primary.com/Attestation'
```

In order for the Hyper-V host to pass attestation with both the primary and fallback servers, you will need to ensure that your attestation information is up to date with both HGS clusters.
Additionally, the certificates used to decrypt the virtual machine's TPM need to be available in both HGS clusters.
You can configure each HGS with different certificates and configure the VM to trust both, or add a shared set of certificates to both HGS clusters.

For additional information about configuring HGS in a branch office using fallback URLs, see the blog post [Improved branch office support for shielded VMs in Windows Server, version 1709](https://blogs.technet.microsoft.com/datacentersecurity/2017/11/15/improved-branch-office-support-for-shielded-vms-in-windows-server-version-1709/).


## Offline mode

Offline mode allows your shielded VM to turn on when HGS cannot be reached, so long as the security configuration of your Hyper-V host has not changed.
Offline mode works by caching a special version of the VM TPM key protector on the Hyper-V host.
The key protector is encrypted to the current security configuration of the host (using the Virtualization Based Security identity key).
If your host is unable to communicate with HGS and its security configuration has not changed, it will be able to use the cached key protector to start up the shielded VM.
When security settings change on the system, such as a new code integrity policy being applied or Secure Boot being disabled, the cached key protectors will be invalidated and the host will have to attest with an HGS before any shielded VMs can be started offline again.

Offline mode requires Windows Server Insider Preview build 17609 or newer for both the Host Guardian Service cluster and Hyper-V host.
It is controlled by a policy on HGS, which is disabled by default.
To enable support for offline mode, run the following command on an HGS node:

```powershell
Set-HgsKeyProtectionConfiguration -AllowKeyMaterialCaching:$true
```

Since the cacheable key protectors are unique to each shielded VM, you will need to fully shut down (not restart) and start up your shielded VMs to obtain a cacheable key protector after this setting is enabled on HGS.
If your shielded VM migrates to a Hyper-V host running an older version of Windows Server, or obtains a new key protector from an older version of HGS, it will not be able to start itself up in offline mode, but can continue running in online mode when access to HGS is available.
