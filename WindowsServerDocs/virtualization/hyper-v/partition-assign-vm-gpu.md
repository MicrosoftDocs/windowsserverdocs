---
title: Partition and assign GPUs to a virtual machine in Hyper-V
description: Learn how to partition and share a GPU with multiple virtual machines on Windows Server and Azure Stack HCI.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 02/08/2024
zone_pivot_groups: windows-os

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

# Partition and assign GPUs to a virtual machine

:::zone pivot="window-server"
>Applies to: Windows Server 2025

> [!IMPORTANT]
> GPU partitioning is in PREVIEW on Windows Server. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
::: zone-end

:::zone pivot="azure-stack-hci"
>Applies to: Azure Stack HCI, versions 23H2 and 22H2

inlcudes here
::: zone-end

This article describes how to configure graphics processing unit (GPU) partitions and assign a partition to a virtual machine (VM). It provides instructions on how to configure GPU partition count, assign GPU partitions, and unassign GPU partitions via Windows Admin Center and PowerShell.
