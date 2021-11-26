---
title: Azure Hybrid Benefit for Windows Server
description: Azure Hybrid Benefit for Windows Server allows you to save up to 40% on Windows Server virtual machines (VMs) in Azure by using your on-premises Windows Server licenses with Software Assurance or subscription license
ms.date: 11/26/2021
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
ms.localizationpriority: medium
---

# Azure Hybrid Benefit for Windows Server

Azure Hybrid Benefit for Windows Server allows you to save up to 40% on Windows Server virtual machines (VMs) in Azure by using your on-premises Windows Server licenses with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-by-benefits) or subscription license. With this benefit, you only need to pay for the infrastructure costs of the virtual machine because the license for Windows Server is covered by the Software Assurance benefit.  The benefit is applicable to both Standard and Datacenter editions of Windows Server for Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, and Windows Server 2022. This benefit is available across all regions and sovereign clouds.

:::image type="content" source="media/ahb01.png" alt-text="Windows VM cost structure":::

## Rules, and use cases

All you need to qualify for the benefit is an active Software Assurance (SA) or a subscription license such as EAS, SCE subscription or Open Value Subscription on your Windows Server licenses.

Each Windows Server two-processor license with active SA or subscription, and each set of 16 core licenses for Windows Server with active SA or subscription, entitles you to use Windows Server on Microsoft Azure with up to 16 virtual cores allocated across two or fewer Azure Base Instances (VMs). Each extra set of eight core licenses with active SA or subscription entitles use on up to eight virtual cores and one Azure Base Instance (VM). Differences how they can be used depends on which edition the licenses are for, Datacenter or Standard. The table below summarizes this:

| License with SA/Subscription               | VMs and cores granted                   | How they can be used                                |
|--------------------------------------------|-----------------------------------------|-----------------------------------------------------|
| WS Datacenter (16 cores or two-processors) | Up to two VMs with up to 16 cores total | Run virtual machines both on-premises and in Azure  |
| WS Standard (16 cores or two-processors)   | Up to two VMs with up to 16 cores total | Run virtual machines either on-premises or in Azure |

Windows Server VMs using Azure Hybrid Benefit can run in Azure only during the SA or subscription term. When the SA or subscription is nearing expiry, you need to either renew your SA or subscription, disable the hybrid benefit functionality, or de-provision those VMs using Azure Hybrid Benefit.

## Example savings

The image below illustrates examples of Azure Hybrid Benefit for Windows Server being used full time and part time:

:::image type="content" source="media/ahb02.png" alt-text="Azure Hybrid Benefit for Windows Server full time and part time examples":::

Below is a reference table to assist you with understanding the benefit rules with more granularity. The green column shows the quantity of same-type VMs, and the blue row shows the core density of each VM. The yellow cells show the number of two-processor licenses (or sets of 16 cores) you must have to deploy a certain number of VMs of a certain core density:

:::image type="content" source="media/ahb03.png" alt-text="Windows Server with SA or subscription requirements reference table":::

## Example configurations

Azure Hybrid Benefit for Windows Server also allows flexibility to run different VM configurations and combining VMs of different types. The examples below show configurations for some licensing scenarios:

:::image type="content" source="media/ahb04.png" alt-text="An example configuration for 16 cores or one 2-processor license, or for 24 cores":::

:::image type="content" source="media/ahb05.png" alt-text="An example configuration for 32 cores or two 2-processor licenses (stacking the licenses)":::

## How to use Azure Hybrid Benefit for Windows Server

We have enabled pre-built gallery images that are available for all our customers who have eligible licenses, irrespective of where they bought them, and enabled partners to be able to perform the deployments on customers' behalf. You can learn how to deploy Windows Server VMs with Azure Hybrid Benefit in Azure documentation for [Azure Hybrid Benefit for Windows Server](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

## How to maintain compliance

If you apply Azure Hybrid Benefit to your Windows Server VMs, you need to verify the number of eligible licenses and respective coverage period of your SA or subscription before any activation of this benefit, and apply the guidelines above to ensure you deploy the correct number of Windows Server VMs with Azure Hybrid Benefit.

If you already have Windows Server VMs running with Azure Hybrid Benefit, you need to perform an inventory of how many units you are running, and check this against the SA or subscription licenses you have. Please contact your Microsoft Enterprise Agreement licensing specialist to validate your SA or subscription licensing position.

To see and count all virtual machines deployed with Azure Hybrid Benefit for Windows Server in a subscription, please follow the steps in this article in Azure documentation for Azure Hybrid Benefit for Windows Server to [list all VMs and Virtual Machine Scale Sets with Azure Hybrid Benefit for Windows Server in a subscription](/azure/virtual-machines/windows/hybrid-use-benefit-licensing#list-all-vms-and-vmss-with-azure-hybrid-benefit-for-windows-server-in-a-subscription). You can also look at your Microsoft Azure bill to determine how many virtual machines with Azure Hybrid Benefit for Windows Server you are running. The information about the number of instances with the benefit shows under **Additional Info**:

```json
"{"ImageType":"WindowsServerBYOL","ServiceType":"Standard_A1","VMName":"","UsageType":"ComputeHR"}"
```

Please note that billing does not apply in real time. There will be a delay of several hours from the time you've activated a Windows Server VM with Azure Hybrid Benefit before it shows on your bill.
You can then populate the results in the [Azure Hybrid Benefit for Windows Server SA Count Tool](https://download.microsoft.com/download/7/1/2/712FEFF0-155C-4ABF-96C0-CE4EC4DB0516/Azure_Hybrid_Benefit_Windows_Server_SA_Count_Tool.xlsx) below to get to the number of Windows Server licenses covered by SA or subscriptions that are required.

Be sure to perform an inventory in each Azure subscription that you own to generate a comprehensive view of your licensing position. Once you have confirmed you are fully licensed for the number of Windows Server VMs you are running with Azure Hybrid Benefit, there is no need for any further action. You should perform an inventory regularly to ensure you are using any license benefits you are entitled to in order to reduce your costs, but also to ensure that you always have enough licenses to cover the number of Windows Server VMs you have deployed with Azure Hybrid Benefit.

If you do not have enough eligible Windows Server licenses for the number of VMs already deployed, you either need to purchase extra Windows Server on-premises licenses covered with SA or subscription through one of the channels listed in the table below, purchase Windows Server VMs at regular Azure hourly rates by disabling Azure Hybrid Benefit for some VMs, or deallocate some VMs. Please note that you may buy core licenses in  increments of eight cores, to qualify for each additional Windows Server VM with Azure Hybrid Benefit.

Windows Server Software Assurance and/or subscriptions are available for purchase through one of a combination of the following Microsoft licensing channels:

| Channel                     | Open     | OVS      | Select/ Select Plus | MPSA     | EA/EAS   |
|-----------------------------|----------|----------|---------------------|----------|----------|
| Typical size (# of devices) | 5-250    | 5-250    | >250                | >250     | >500     |
| SA / Subscription           | Optional | Included | Optional            | Optional | Included |

> [!NOTE]
> Microsoft reserves the right to audit customers at any time to verify eligibility for Azure Hybrid Benefit utilization.

If you want to learn more, including pricing, please see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).
