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

This topic describes an initial step (configuring fabric DNS) that a fabric administrator takes to in a configuration for Hyper-V hosts that will become guarded hosts. Before this step can begin, the HGS cluster must already have been set up by the HGS administrator, as described in [Setting up the Host Guardian Service - HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

For background about how HGS works with guarded hosts, see [Guarded fabric and shielded VMs overview](Guarded-Fabric-and-Shielded-VMs.md).

## Configure the fabric DNS

Regardless of the attestation mode that you use, guarded hosts must be able to resolve the HGS cluster. Therefore, you (the fabric administrator) must set up a DNS forwarder from the fabric domain to the HGS domain. There are many ways to configure name resolution on the fabric domain. One way is to set up a conditional forwarder zone in DNS for the fabric. To set up this zone, run the following commands in an elevated Windows PowerShell console on a fabric DNS server.

Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. Add master servers for the additional HGS nodes.

>**Note**&nbsp;&nbsp;Run the command on a fabric DNS server, not on an HGS server.

    Add-DnsServerConditionalForwarderZone -Name <HGS domain name> -ReplicationScope "Forest" -MasterServers <IP addresses of HGS server>

##  Next step

With HGS set up and name resolution in place, it's time to capture information from the hosts that you will later provide to the HGS administrator, so that HGS will recognize those hosts. How you do this depends on which attestation mode you are using:

| Actions | Section |
|-----|-----|
| **Admin-trusted attestation**: Set up an Active Directory security group in the fabric domain, add guarded hosts as members of that group, and provide that group identifier to HGS. | See [Admin-trusted attestation for a guarded fabric - creating a security group](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md) |
| **TPM-trusted attestation**: Capture TPM identifiers (also called platform identifiers), create a TPM baseline, and create a Code Integrity policy. Provide information to HGS. | See [TPM-trusted attestation for a guarded fabric - capturing information required by HGS](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md) |

## See also

- [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)
- [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms)
