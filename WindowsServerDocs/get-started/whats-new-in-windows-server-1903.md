---
title: What's New in Windows Server, version 1903
description: This topic describes some of the new features in Windows Server, version 1903, which is a Semi-Annual Channel release. 
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.localizationpriority: high
---
# What's new in Windows Server, version 1903

>Applies to: Windows Server (Semi-Annual Channel)

This topic describes some of the new features in Windows Server, version 1903, which is a Semi-Annual Channel release. To find out what's new in the latest Long-Term Servicing Channel (LTSC) release of Windows Server, see see [What's New in Windows Server 2019](../get-started-19/whats-new-19.md).

> [!NOTE]
> Windows containers must use the same or *earlier* version of Windows as the host server. For example, a host server running the released version of Windows Server, version 1903 (build 18342) can run Windows Server containers with the same or earlier version and build number. For more info, see [Windows container version compability](https://docs.microsoft.com/virtualization/windowscontainers/deploy-containers/version-compatibility).

## Enhanced support for non-Microsoft container services

We enhanced platform capabilities to support Azure container services and non-Microsoft container services.

- We integrated CRI-containerd with Host Compute Service (HCS) to support pods of Windows containers and Linux containers on Windows (LCOW) on Azure.
- We worked with the Kubernetes community to enable Windows container support. With the release of Kubernetes v1.14, Windows Server node support officially graduated from beta to stable. For more info, see [Windows containers now supported in Kubernetes](https://cloudblogs.microsoft.com/opensource/2019/03/25/windows-server-containers-now-supported-kubernetes/). 
- Tigera Calico for Windows is now generally available as part of Tigera Essentials subscription and offers both non-overlay networking and network policy interoperable across mixed Linux/Windows environments.
- We delivered scalability improvements enhancing overlay networking support for Windows containers, including integration with Kubernetes through the latest release of Flannel and Kubernetes v1.14. Try it out here.

## DirectX hardware acceleration in containers

Based on customer interest in GPU acceleration, we’re taking the first step by enabling support for hardware acceleration of DirectX APIs in Windows containers. We believe this will enable new and interesting scenarios such as edge-local Machine Learning (ML) inferencing. For more info, see [Bringing GPU acceleration to Windows containers](https://techcommunity.microsoft.com/t5/Containers/Bringing-GPU-acceleration-to-Windows-containers/ba-p/393939).

## Updated container identity and group managed service account documentation

We added more examples and compatibility info to the [Group Managed Service Accounts](https://docs.microsoft.com/virtualization/windowscontainers/manage-containers/manage-serviceaccounts) documentation, and made the [Credential Spec PowerShell module](https://www.powershellgallery.com/packages/CredentialSpec) available in the PowerShell Gallery. For more info, see the [What's new for container identity](https://techcommunity.microsoft.com/t5/Containers/What-s-new-for-container-identity/ba-p/389151) blog post.


## Task Scheduler and Hyper-V Manager on-demand feature packages

[Server Core app compatibility](../get-started-19/install-fod-19.md)


## System Insights disk anomaly detection

Also available for Windows Server 2019

## Windows Admin Center

Also available for Windows Server 2019