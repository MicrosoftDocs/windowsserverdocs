---
title: Extended Security Updates for Windows Server 2008, 2008 R2, 2012, and 2012 R2
description: Learn about Extended Security Updates (ESU) for Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2, and how to upgrade on-premises servers or rehost to Azure.
ms.topic: article
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 08/17/2021
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
ms.localizationpriority: high
---

# Extended Security Updates for Windows Server

Extended support for [Windows Server 2008](/lifecycle/products/windows-server-2008) and [Windows Server 2008 R2](/lifecycle/products/windows-server-2008-r2) ended on January 14, 2020, and extended support for [Windows Server 2012](/lifecycle/products/windows-server-2012) and [Windows Server 2012 R2](/lifecycle/products/windows-server-2012-r2) will be ending on October 10, 2023. There are two modernization paths available: on-premises upgrade, or migration by rehosting in Azure. **If you rehost in Azure, you can migrate your existing Server images free of charge**.

Once you've understood these options, see wow to use Windows Server Extended Security Updates

![Flow chart describing upgrade paths from Windows Server](media/WS08_upgrade_paths.png)

## On-premises upgrade

If you need to keep your servers on-premises, and you are running Windows Server 2008 or Windows Server 2008 R2, you will need to upgrade to Windows Server 2012/2012 R2 before you can upgrade to Windows Server 2016. There is no direct upgrade path from Windows Server 2008 R2 to Windows Server 2016 or later. Instead, upgrade first to Windows Server 2012 R2, and then upgrade to Windows Server 2016. As you upgrade, you still have the option to migrate to Azure by rehosting. See [supported upgrade paths for Windows Server](supported-upgrade-paths.md), for more information about your on-premises upgrade options.

If you are running Windows Server 2003, you will need to [upgrade to Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff972408(v%3dws.10)). See [upgrade paths for Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd979563(v=ws.10)) for more information about your on-premises upgrade options.

## Migrate to Azure

You can migrate your on-premises Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2 servers to Azure, where you can continue to run them on virtual machines. In Azure you'll stay compliant, become more secure, and add cloud innovation to your work. The benefits of migrating to Azure include:

- Security updates in Azure.
- Get three more years of Windows Server critical and important security updates, included at no additional charge.
- No-charge upgrades in Azure.
- Adopt more cloud services as you are ready.
- By migrating SQL Server to Azure Managed Instances or VMs, you get three more years of Windows Server critical security updates, included at no additional charge.
- Benefit from [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/), which means you can leverage existing SQL Server and Windows Server licenses for cloud savings unique to Azure.

To get started migrating, learn how to [upload a generalized VHD and use it to create new VMs in Azure](/azure/virtual-machines/windows/upload-generalized-managed), or use [Shared Image Galleries in Azure](/azure/virtual-machines/shared-image-galleries).

To help you understand how to analyze existing IT resources, assess what you have, and identify the benefits of moving specific services and applications to the cloud or keeping workloads on-premises and upgrading to the latest version of Windows Server, see [Migration Guide for Windows Server](https://go.microsoft.com/fwlink/?linkid=872689).

## Upgrade SQL Server 2008/2008 R2 in parallel with your Windows Servers

If you are running SQL Server 2008 or SQL Server 2008 R2, you can also upgrade to [SQL Server 2016](/sql/database-engine/install-windows/supported-version-and-edition-upgrades?view=sql-server-2016&preserve-view=true) or [SQL Server 2017](/sql/database-engine/install-windows/supported-version-and-edition-upgrades-2017?view=sql-server-2017&preserve-view=true).
