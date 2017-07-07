---
title: Configure the fabric DNS for guarded hosts
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 074b6d09-f16e-49bf-b88a-377139d35067
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

>[!div class="step-by-step"]
[« Install trusted TPM root certificates](guarded-fabric-install-trusted-tpm-root-certificates.md)
[Configure Https  »](guarded-fabric-configure-hgs-https.md)

# Configure the fabric DNS for guarded hosts

>Applies To: Windows Server 2016

A fabric administrator needs to configure the fabric DNS takes to allow guarded hosts to resolve the HGS cluster. The HGS cluster must already be [set up by the HGS administrator](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

There are many ways to configure name resolution for the fabric domain. One simple way is to set up a conditional forwarder zone in DNS for the fabric. To set up this zone, run the following commands in an elevated Windows PowerShell console on a fabric DNS server. Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. Add master servers for the additional HGS nodes.

    Add-DnsServerConditionalForwarderZone -Name <HGS domain name> -ReplicationScope "Forest" -MasterServers <IP addresses of HGS server>

##  Next step

The next step is to capture information from the hosts and add it to HGS. How you do this depends on which attestation mode you are using:

| Actions | Section |
|-----|-----|
| **Admin-trusted attestation**: Create an Active Directory security group in the fabric domain, add guarded hosts as members, and provide that group identifier to the HGS admin. | See [Create a security group for guarded hosts](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md) |
| **TPM-trusted attestation**: Capture TPM identifiers (also called platform identifiers), create a TPM baseline, and create a Code Integrity policy. Provide those artifacts to the HGS admin. | See [Capturing TPM-mode information required by HGS](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md) |

## See also

- [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)
- [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms)
