---
title: What's new in Windows Server, version 1903 and version 1909
description: This article describes some of the new features in Windows Server, version 1903 and version 1909, which are Semi-Annual Channel releases.
ms.topic: article
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 8/13/2021
ms.prod: windows-server
---

# What's new in Windows Server, version 1903 and version 1909

> [!IMPORTANT]
> Windows Server, version 1903 has reached end of servicing as of December 8, 2020. Windows Server, version 1909 has reached end of servicing as of May 11, 2021.

This article describes some of the new features covering both Windows Server, version 1903, and Windows Server, version 1909, which are Semi-Annual Channel releases. These features include enhancements for running and managing containers, tools for working in Server Core installations, and the ability to migrate storage from Linux devices.

Windows Server, version 1909 is focused on reliability, performance, and other general improvements, but has no new features. Like other Semi-Annual Channel releases, it’s supported for 18 months from its first availability. For more information on the support dates of Semi-Annual Channel releases, see [Windows Server release information](../get-started/windows-server-release-info.md).

The system requirements for this release are the same as for Windows Server 2019, for more information see [System requirements](../get-started-19/sys-reqs-19.md) . To see what's been removed recently, see [Features Removed or Planned for Replacement starting with Windows Server, version 1903 and version 1909](../get-started-19/removed-features-1903.md)

> [!NOTE]
> Windows containers must use the same version of Windows as the host server, or an **earlier** version. For example, a host server running the released version of Windows Server, version 1903 (build 18342) can run Windows Server containers with the same or earlier version and build number (even if the container uses an Insider Preview version of Windows). For more information, see [Windows container version compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility).

## Enhanced support for non-Microsoft container services

We enhanced platform capabilities to support Azure container services and non-Microsoft container services.

- We integrated CRI-containerd with Host Compute Service (HCS) to support pods of Windows containers and Linux containers on Windows (LCOW) on Azure.
- We worked with the Kubernetes community to enable Windows container support. With the release of Kubernetes v1.14, Windows Server node support officially graduated from beta to stable. For more information, see [Windows containers now supported in Kubernetes](https://cloudblogs.microsoft.com/opensource/2019/03/25/windows-server-containers-now-supported-kubernetes/).
- Tigera Calico for Windows is now generally available as part of Tigera Essentials subscription and offers both non-overlay networking and network policy interoperable across mixed Linux/Windows environments.
- We delivered scalability improvements enhancing overlay networking support for Windows containers, including integration with Kubernetes through the latest release of Flannel and Kubernetes v1.14. For more information, see [Intro to Windows support in Kubernetes](https://kubernetes.io/docs/setup/windows/).

## DirectX hardware acceleration in containers

We're enabling support for hardware acceleration of DirectX APIs in Windows containers to support scenarios such as Machine Learning (ML) inference using local graphical processing unit (GPU) hardware. For more information, see the [Bringing GPU acceleration to Windows containers](https://techcommunity.microsoft.com/t5/Containers/Bringing-GPU-acceleration-to-Windows-containers/ba-p/393939) blog post.

## Updated container identity and group managed service account documentation

We added more examples and compatibility information to the [Group Managed Service Accounts](/virtualization/windowscontainers/manage-containers/manage-serviceaccounts) documentation, and made the [Credential Spec PowerShell module](https://www.powershellgallery.com/packages/CredentialSpec) available in the PowerShell Gallery. For more information, see the [What's new for container identity](https://techcommunity.microsoft.com/t5/Containers/What-s-new-for-container-identity/ba-p/389151) blog post.

## Add Task Scheduler and Hyper-V Manager to Server Core installations

As you might know, we recommend using the Server Core installation option when using Windows Server, Semi-Annual Channel in production. However, Server Core by default omits several useful management tools. You can add many of the most commonly used tools by installing the App Compatibility Feature on Demand feature package, but previously there were some key tools missing.

Based on customer feedback, we added two more tools to the App Compatibility Feature on Demand feature package in this version: Task Scheduler (taskschd.msc) and Hyper-V Manager (virtmgmt.msc). For more information, see [Server Core App Compatibility Feature on Demand](../get-started-19/install-fod-19.md).

## Storage Migration Service now migrates local accounts, clusters, and Linux servers

Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers, all without changes to applications or users having to change anything.

When using this version of Windows Server to orchestrate migrations, we've added the following abilities:

- Migrate local users and groups to the new server
- Migrate storage from failover clusters
- Migrate storage from a Linux server that uses Samba
- More easily sync migrated shares into Azure by using Azure File Sync
- Migrate to new networks, such as Azure

For more information about Storage Migration Service, see [Storage Migration Service overview](../storage/storage-migration-service/overview.md).

## System Insights disk anomaly detection

[System Insights](../manage/system-insights/overview.md) is a predictive analytics feature that locally analyzes Windows Server system data and provides insight into the functioning of the server. It comes with many built-in capabilities, but we've added the ability to install additional capabilities via Windows Admin Center, starting with disk anomaly detection.

Disk anomaly detection is a new capability that highlights when disks are behaving *differently* than usual. While different isn't necessarily a bad thing, seeing these anomalous moments can be helpful when troubleshooting issues on your systems.

This capability is also available for servers running Windows Server 2019.

## Windows Admin Center enhancements

A new release of Windows Admin Center is available, adding new functionality for Windows Server. For information on the latest features, see [Windows Admin Center](../manage/windows-admin-center/overview.md).

## Security baseline for Windows 10 and Windows Server

The draft release of the [security configuration baseline settings](/archive/blogs/secguide/security-baseline-draft-for-windows-10-v1903-and-windows-server-v1903) for Windows 10 version 1903, and for Windows Server version 1903 is available.

## SetupDiag

[SetupDiag](/windows/deployment/upgrade/setupdiag) version 1.4.1 is available.

SetupDiag is a command-line tool that can help diagnose why a Windows Update failed to install. SetupDiag works by searching Windows Setup log files. When searching log files, SetupDiag uses a set of rules to match known issues. In the current version of SetupDiag there are 53 rules contained in the rules.xml file, which is extracted when SetupDiag is run. The rules.xml file will be updated as new versions of SetupDiag are made available.

## Windows Update rollback improvements

Servers can now automatically recover from startup failures by removing updates if the startup failure was introduced after the installation of recent driver or quality Windows Updates. When a device is unable to start up properly after the recent installation of quality of driver updates, Windows will now automatically uninstall the updates to get the device back up and running normally.

This functionality requires the server to be using the [Server Core installation option](../get-started/getting-started-with-server-core.md) option with a [Windows Recovery Environment](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference) partition.

## Microsoft Defender Antivirus improvements

Windows Server includes [Microsoft Defender Antivirus](/microsoft-365/security/defender-endpoint/microsoft-defender-antivirus-on-windows-server). This release includes the following improvements:

- [Attack surface area reduction](/windows/security/threat-protection/windows-defender-atp/overview-attack-surface-reduction) – IT admins can configure devices with advanced web protection that enables them to define allow and deny lists for specific URL's and IP addresses.
- [Next generation protection](/windows/security/threat-protection/windows-defender-antivirus/windows-defender-antivirus-in-windows-10) – Controls have been extended to protection from ransomware, credential misuse, and attacks that are transmitted through removable storage.
  - Integrity enforcement capabilities – Enable remote runtime attestation.
  - Tamper-proofing capabilities – Uses virtualization-based security to isolate critical ATP security capabilities away from the OS and attackers.
- Microsoft Defender ATP next-gen protection technologies include:
  - **Advanced machine learning**: Improved with advanced machine learning and AI models that enable it to protect against apex attackers using innovative vulnerability exploit techniques, tools, and malware.
  - **Emergency outbreak protection**: Provides emergency outbreak protection, which will automatically update devices with new intelligence when a new outbreak has been detected.
  - **Certified ISO 27001 compliance**: Ensures that the cloud service has analyzed for threats, vulnerabilities and impacts, and that risk management and security controls are in place.
  - **Geolocation support**: Support geolocation and sovereignty of sample data as well as configurable retention policies.
