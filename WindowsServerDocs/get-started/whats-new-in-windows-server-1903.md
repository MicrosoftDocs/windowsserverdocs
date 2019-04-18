---
title: What's New in Windows Server, version 1903
description: This topic describes some of the new features in Windows Server, version 1903, which is a Semi-Annual Channel release. 
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 05/21/2019
---
# What's new in Windows Server, version 1903

>Applies to: Windows Server (Semi-Annual Channel)

This topic describes some of the new features in Windows Server, version 1903, which is a Semi-Annual Channel release. These features include enhancements for running and managing containers, tools for working in Server Core installations, and migrating storage from Linux.

To instead find out what's new in the latest Long-Term Servicing Channel (LTSC) release of Windows Server, see see [What's New in Windows Server 2019](../get-started-19/whats-new-19.md).

> [!NOTE]
> Windows containers must use the same or *earlier* version of Windows as the host server. For example, a host server running the released version of Windows Server, version 1903 (build 18342) can run Windows Server containers with the same or earlier version and build number. For more info, see [Windows container version compability](https://docs.microsoft.com/virtualization/windowscontainers/deploy-containers/version-compatibility).

## Enhanced support for non-Microsoft container services

We enhanced platform capabilities to support Azure container services and non-Microsoft container services.

- We integrated CRI-containerd with Host Compute Service (HCS) to support pods of Windows containers and Linux containers on Windows (LCOW) on Azure.
- We worked with the Kubernetes community to enable Windows container support. With the release of Kubernetes v1.14, Windows Server node support officially graduated from beta to stable. For more info, see [Windows containers now supported in Kubernetes](https://cloudblogs.microsoft.com/opensource/2019/03/25/windows-server-containers-now-supported-kubernetes/). 
- Tigera Calico for Windows is now generally available as part of Tigera Essentials subscription and offers both non-overlay networking and network policy interoperable across mixed Linux/Windows environments.
- We delivered scalability improvements enhancing overlay networking support for Windows containers, including integration with Kubernetes through the latest release of Flannel and Kubernetes v1.14. For more info, see [Intro to Windows support in Kubernetes](https://kubernetes.io/docs/setup/windows/).

## DirectX hardware acceleration in containers

Based on customer interest in GPU acceleration, we’re taking the first step by enabling support for hardware acceleration of DirectX APIs in Windows containers. This enables scenarios such as edge-local Machine Learning (ML) inferencing. For more info, see [Bringing GPU acceleration to Windows containers](https://techcommunity.microsoft.com/t5/Containers/Bringing-GPU-acceleration-to-Windows-containers/ba-p/393939).

## Updated container identity and group managed service account documentation

We added more examples and compatibility info to the [Group Managed Service Accounts](https://docs.microsoft.com/virtualization/windowscontainers/manage-containers/manage-serviceaccounts) documentation, and made the [Credential Spec PowerShell module](https://www.powershellgallery.com/packages/CredentialSpec) available in the PowerShell Gallery. For more info, see the [What's new for container identity](https://techcommunity.microsoft.com/t5/Containers/What-s-new-for-container-identity/ba-p/389151) blog post.

## Add Task Scheduler and Hyper-V Manager to Server Core installations

As you may know, we recommend using the Server Core installation option when using Windows Server, Semi-Annual Channel in production. However, Server Core by default omits a number of useful management tools. You can add many of the most commonly used tools by installing the App Compatibility feature.

Based on customer feedback, we added two more tools to the App Compatibility feature in this version: Task Scheduler (taskschd.msc) and Hyper-V Manager (virtmgmt.msc).

For more info, see 
[Server Core app compatibility feature](../get-started-19/install-fod-19.md).

## Storage Migration Service now migrates local accounts and Linux servers

Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers—all without apps or users having to change anything.

In this version of Windows Server, we've added the following abilities:

- Migrate local users and groups to the new server
- Migrate storage from a Linux server that uses Samba
- More easily sync migrated shares into Azure by using Azure File Sync

For more info, see [Storage Migration Service overview](../storage/storage-migration-service/overview.md).

## System Insights disk anomaly detection

System Insights is a predictive analytics feature in Windows Server that locally analyzes Windows Server system data and provides insight into the functioning of your servers. It comes with a number of built-in capabilities, but we've added the ability to install additional capabilities via Windows Admin Center, starting with disk anomaly detection.

Disk anomaly detection is a new capability that highlights when disks are behaving *differently* than usual. While different isn't necessarily a bad thing, seeing these anomalous moments can be helpful when troubleshooting issues on your systems.

This capability is also available for servers running Windows Server 2019.

## Windows Admin Center enhancements

A new release of Windows Admin Center is out, adding new functionality to Windows Server. For info on the latest features, see [Windows Admin Center](../manage/windows-admin-center/understand/windows-admin-center.md).