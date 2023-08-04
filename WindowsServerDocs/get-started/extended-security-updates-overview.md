---
title: Overview of Extended Security Updates for Windows Server 2008, 2008 R2, 2012, and 2012 R2
description: Learn about Extended Security Updates (ESU) for Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2, and how to upgrade on-premises servers or rehost to Azure.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 08/04/2023
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
ms.custom: contperf-fy22q3
---

# Extended Security Updates for Windows Server overview

The Extended Security Update (ESU) program is a last resort option for customers who need to run certain legacy Microsoft products past the end of support. Windows Server [Long Term Servicing Channel](servicing-channels-comparison.md) (LTSC) has a minimum of 10 years of support: five years for mainstream support and five years for extended support, which includes regular security updates.

However, once products reach the end of support, it also means the end of security updates and bulletins. This scenario can cause security or compliance issues and put business applications at risk. Microsoft recommends that you [upgrade to the current version of Windows Server](install-upgrade-migrate.md) for the most advanced security, performance, and innovation.

> [!TIP]
> You can find information on support dates on [Microsoft Lifecycle](/lifecycle/products/).

The following versions of Windows Server have reached or are in the process of reaching the end of extended support:

- Extended support for [Windows Server 2008](/lifecycle/products/windows-server-2008) and [Windows Server 2008 R2](/lifecycle/products/windows-server-2008-r2) ended on January 14, 2020.
- Extended support for [Windows Server 2012](/lifecycle/products/windows-server-2012) and [Windows Server 2012 R2](/lifecycle/products/windows-server-2012-r2) will be ending on October 10, 2023.

## What are Extended Security Updates?

Extended Security Updates for Windows Server include security updates and bulletins rated *critical* and *important* for a maximum period of time from the end of extended support, depending on the version. They're available free of charge for servers hosted in Azure, and available to purchase for servers not hosted in Azure. Extended Security Updates don't include new features, customer-requested non-security hotfixes, or design change requests. For more information, see [Lifecycle FAQ - Extended Security Updates](/lifecycle/faq/extended-security-updates).

With Extended Security Updates, the different phases for these versions of Windows Server are as follows:

:::image type="content" source="media/esu-phases.png" alt-text="Diagram showing the phases with Extended Security Updates":::

If you haven't already upgraded your servers, you can do the following things to protect your applications and data during the transition:

- Migrate the affected existing Windows Server workloads as-is to Azure Virtual Machines (VM). Migrating to Azure automatically provides Extended Security Updates for the defined period. There's no extra charge for Extended Security Updates on top of an Azure VM's cost, and you don't need to do any other configuration.

- Purchase an Extended Security Update subscription for your servers and remain protected until you're ready to upgrade to a newer Windows Server version. When you have an Extended Security Update subscription, Microsoft provides updates for the defined period. Once you purchase a subscription, you must get a product key and install it on each applicable server. For more information, see [How to get Extended Security Updates](extended-security-updates-deploy.md).

When you get the Extended Security Updates depends on which version of Windows Server you're using and where it's hosted. The following table lists the Extended Security Update duration for each version of Windows Server.

| Product version | Hosted | ESU duration | ESU end date |
|--|--|--|--|
| Windows Server 2008<br />Windows Server 2008 R2 | Azure* | Four years | January 9, 2024 |
| Windows Server 2008<br />Windows Server 2008 R2 | Not in Azure | Three years | January 10, 2023 |
| Windows Server 2012<br />Windows Server 2012 R2 | Azure* | Three years | October 13, 2026 |
| Windows Server 2012<br />Windows Server 2012 R2 | Not in Azure | Three years | October 13, 2026 |

\* Includes the [Azure Stack portfolio of products](https://azure.microsoft.com/overview/azure-stack/) that extend Azure services and capabilities to your environment of choice.

> [!WARNING]
> After the period of Extended Security Updates ends, we'll stop providing updates. We recommend you update your version of Windows Server to a more recent version as soon as possible.

## Migrate to Azure

You can migrate your on-premises servers that run a version of Windows Server that has reached or is almost reaching the end of extended support to Azure, where you can continue to run them as virtual machines. When you migrate to Azure, you not only stay compliant with security updates, but also add cloud innovation to your work. The benefits of migrating to Azure include:

- Security updates in Azure.
- Get Windows Server critical and important security updates for a certain period of time, included at no extra charge.
- Upgrades in Azure free of charge.
- Adopt more cloud services whenever you're ready.
- By migrating SQL Server to Azure VMs, you get three more years of Windows Server critical security updates, included at no extra charge. You can also modernize your SQL Server to [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview).
- Benefit from [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/), which lets you use existing Windows Server licenses and SQL Server licenses for cloud savings unique to Azure.

To get started migrating, learn how to [upload a generalized VHD and use it to create new VMs in Azure](/azure/virtual-machines/windows/upload-generalized-managed), or use [Shared Image Galleries in Azure](/azure/virtual-machines/shared-image-galleries).

You can also read the [Migration Guide for Windows Server](https://go.microsoft.com/fwlink/?linkid=872689) for help with the following things:

- Analyze your existing IT resources.
- Assess the current state of your deployment.
- Understand whether moving certain services and applications to the cloud or keeping them on-premises and upgrading to the latest version of Windows Server instead is best for you.

## Upgrade on-premises

If you need to keep your servers on-premises instead of migrating to Azure and the cloud, you have two choices for how to proceed:

- Build new servers with a supported version of Windows Server and migrate your applications and data.
- [Upgrade in-place](install-upgrade-migrate.md) to a supported version of Windows Server.

In-place upgrades can typically upgrade Windows Server through at least one version, sometimes even two versions. For example, Windows Server 2012 R2 can upgrade in-place to Windows Server 2019. However, if you're running Windows Server 2008 or Windows Server 2008 R2, there's no direct upgrade path to Windows Server 2016 or later. Instead, you must first upgrade to Windows Server 2012 R2, then upgrade to Windows Server 2016 or Windows Server 2019.

As you upgrade, you can also migrate to Azure at any time. For more information about your on-premises upgrade options, see [supported upgrade paths for Windows Server](supported-upgrade-paths.md).

## Upgrade SQL Server in parallel with your Windows Servers

If you're running a version of SQL Server that reached or is reaching the end of extended support, you can also benefit from Extended Security Updates for SQL Server. For more information, see [Extended Security Updates for SQL Server and Windows Server](https://www.microsoft.com/windows-server/extended-security-updates).

## Next steps

- Learn [how to get Extended Security Updates (ESU) for Windows Server](extended-security-updates-deploy.md).
