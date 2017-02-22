---
title: Configuring the fabric DNS for hosts that will become guarded hosts
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 074b6d09-f16e-49bf-b88a-377139d35067
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Configuring the fabric DNS for hosts that will become guarded hosts

>Applies To: Windows Server 2016

A fabric administrator needs to configure the fabric DNS takes to allow guarded hosts must be able to resolve the HGS cluster. The HGS cluster must already be [set up by the HGS administrator](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

## Configure the fabric DNS

There are many ways to configure name resolution on the fabric domain. One simple way is to set up a conditional forwarder zone in DNS for the fabric. To set up this zone, run the following commands in an elevated Windows PowerShell console on a fabric DNS server. Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. Add master servers for the additional HGS nodes.

    Add-DnsServerConditionalForwarderZone -Name <HGS domain name> -ReplicationScope "Forest" -MasterServers <IP addresses of HGS server>

##  Next step

With HGS set up and name resolution in place, it's time to capture information from the hosts and add it to the HGS. How you do this depends on which attestation mode you are using:

| Actions | Section |
|-----|-----|
| **Admin-trusted attestation**: Create an Active Directory security group in the fabric domain, add guarded hosts as members, and provide that group identifier to the HGS admin. | See [Admin-trusted attestation for a guarded fabric - creating a security group](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md) |
| **TPM-trusted attestation**: Capture TPM identifiers (also called platform identifiers), create a TPM baseline, and create a Code Integrity policy. Provide those artifacts to the HGS admin. | See [TPM-trusted attestation for a guarded fabric - capturing information required by HGS](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md) |

## See also

- [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)
- [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms)
