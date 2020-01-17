---
title: Upgrade a guarded fabric to Windows Server 2019
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 11/21/2018
---

# Upgrade a guarded fabric to Windows Server 2019

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

This article describes the steps necessary to upgrade an existing guarded fabric from Windows Server 2016, Windows Server version 1709 or Windows Server version 1803 to Windows Server 2019.

## What's new in Windows Server 2019

When you run a guarded fabric on Windows Server 2019, you can take advantage of several new features:

**Host Key Attestation** is our newest attestation mode, designed to make it easier to run shielded VMs when your Hyper-V hosts do not have TPM 2.0 devices available for TPM attestation. Host Key Attestation uses key pairs to authenticate hosts with HGS, removing the requirement for hosts to be joined to an Active Directory domain, eliminating the AD trust between HGS and the corporate forest, and reducing the number of open firewall ports. Host Key Attestation replaces Active Directory attestation, which is deprecated in Windows Server 2019.

**V2 Attestation Version** - To support Host Key Attestation and new features in the future, we've introduced versioning to HGS. A fresh install of HGS on Windows Server 2019 will result in the server using v2 attestation, which means it can support Host Key attestation for Windows Server 2019 hosts and still support v1 hosts on Windows Server 2016. In-place upgrades to 2019 will remain at version v1 until you manually enable v2. Most cmdlets now have a -HgsVersion parameter that lets you specify if you want to work with legacy or modern attestation policies.

**Support for Linux shielded VMs** - Hyper-V hosts running Windows Server 2019 can run Linux shielded VMs. While Linux shielded VMs have been around since Windows Server version 1709, Windows Server 2019 is the first Long Term Servicing Channel release to support them.

**Branch office improvements** - We've made it easier to run shielded VMs in branch offices with support for offline shielded VMs and fallback configurations on Hyper-V hosts.

**TPM host binding** - For the most secure workloads, where you want a shielded VM to run only on the first host where it was created but no other, you can now bind the VM to that host using the host's TPM. This is best used for privileged access workstations and branch offices, rather than general datacenter workloads that need to migrate between hosts.

## Compatibility matrix

Before you upgrade your guarded fabric to Windows Server 2019, review the following compatibility matrix to see if your configuration is supported.

|  | WS2016 HGS | WS2019 HGS|
|---|---|---|
|**WS2016 Hyper-V Host** | Supported | Supported<sup>1</sup>|
|**WS2019 Hyper-V Host** | Unsupported<sup>2</sup> | Supported|

<sup>1</sup> Windows Server 2016 hosts can only attest against Windows Server 2019 HGS servers using the v1 attestation protocol. New features that are exclusively available in the v2 attestation protocol, including Host Key Attestation, are not supported for Windows Server 2016 hosts.

<sup>2</sup> Microsoft is aware of an issue preventing Windows Server 2019 hosts using TPM attestation from successfully attesting against a Windows Server 2016 HGS server. This limitation will be addressed in a future update for Windows Server 2016.

## Upgrade HGS to Windows Server 2019

We recommend upgrading your HGS cluster to Windows Server 2019 before you upgrade your Hyper-V hosts to ensure that all hosts, whether they are running Windows Server 2016 or 2019, can continue to attest successfully.

Upgrading your HGS cluster will require you to temporarily remove one node from the cluster at a time while it is upgraded. This will reduce the capacity of your cluster to respond to requests from your Hyper-V hosts and could result in slow response times or service outages for your tenants. Ensure you have sufficient capacity to handle your attestation and key release requests before upgrading an HGS server.

To upgrade your HGS cluster, perform the following steps on each node of your cluster, one node at a time:

1.  Remove the HGS server from your cluster by running `Clear-HgsServer` in an elevated PowerShell prompt. This cmdlet will remove the HGS replicated store, HGS websites, and node from the failover cluster.
2.  If your HGS server is a domain controller (default configuration), you will need to run `adprep /forestprep` and `adprep /domainprep` on the first node being upgraded to prepare the domain for an OS upgrade. See the [Active Directory Domain Services upgrade documentation](https://docs.microsoft.com/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers#supported-in-place-upgrade-paths) for more information.
3.  Perform an [in-place upgrade](../../get-started-19/install-upgrade-migrate-19.md) to Windows Server 2019.
4.  Run [Initialize-HgsServer](guarded-fabric-configure-additional-hgs-nodes.md) to join the node back to the cluster.

Once all nodes have been upgraded to Windows Server 2019, you can optionally upgrade the HGS version to v2 to support new features such as Host Key Attestation.

```powershell
Set-HgsServerVersion  v2
```

## Upgrade Hyper-V hosts to Windows Server 2019

Before you upgrade your Hyper-V hosts to Windows Server 2019, ensure that your HGS cluster is already upgraded to Windows Server 2019 and that you've moved all VMs off the Hyper-V server.

1.  If you are using Windows Defender Application Control code integrity policies on your server (always the case when using TPM attestation), ensure that the policy is either in audit mode or disabled before attempting to upgrade the server. [Learn how to disable a WDAC policy](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/disable-windows-defender-application-control-policies)
2.  Follow the guidance in the [Windows Server upgrade content](../../upgrade/upgrade-overview.md) to upgrade your host to Windows Server 2019. If your Hyper-V host is part of a Failover Cluster, consider using a [Cluster Operating System Rolling Upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).
3.  [Test and re-enable](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/audit-windows-defender-application-control-policies) your Windows Defender Application Control policy, if you had one enabled before the upgrade.
4.  Run `Get-HgsClientConfiguration` to check if **IsHostGuarded = True**, meaning the host is successfully passing attestation with your HGS server.
5.  If you're using TPM attestation, you may need to [re-capture the TPM baseline or code integrity policy](guarded-fabric-add-host-information-for-tpm-trusted-attestation.md) after the upgrade to pass attestation.
6.  Start running shielded VMs on the host again!

## Switch to Host Key Attestation

Follow the steps below if you are currently running Active Directory-based attestation and want to upgrade to Host Key Attestation. Note that Active Directory-based attestation is deprecated in Windows Server 2019 and may be removed in a future release.

1.  Ensure that your HGS server is operating in v2 attestation mode by running the following command. Existing v1 hosts will continue to attest even when the HGS server is upgraded to v2.

    ```powershell
    Set-HgsServerVersion v2
    ```

2.  [Generate host keys](guarded-fabric-create-host-key.md) from each of your Hyper-V hosts and register them with HGS. Because HGS is still operating in Active Directory mode, you will receive a warning that the new host keys are not immediately effective. This is intentional, as you do not want to change to host key mode until all of your hosts can attest with host keys successfully.

3.  Once host keys have been registered for every host, you can configure HGS to use host key attestation mode:

    ```powershell
    Set-HgsServer -TrustHostKey
    ```

    If you run into trouble with host key mode and need to revert back to Active Directory-based attestation, run the following command on HGS:

    ```powershell
    Set-HgsServer -TrustActiveDirectory
    ```