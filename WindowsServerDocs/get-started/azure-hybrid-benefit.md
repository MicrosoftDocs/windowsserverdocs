---
title: Azure Hybrid Benefit for Windows Server
description: Azure Hybrid Benefit for Windows Server allows you to save up to 40% on Windows Server virtual machines (VMs) in Azure by using your on-premises Windows Server licenses with Software Assurance
ms.date: 01/17/2022
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
---

# Azure Hybrid Benefit for Windows Server

Azure Hybrid Benefit for Windows Server allows you to make significant savings on Windows Server virtual machines (VMs) running in Azure by using your on-premises Windows Server licenses with Software Assurance (SA). With Azure Hybrid Benefit, you only need to pay for the infrastructure costs of the virtual machine because the license for Windows Server is covered by Software Assurance. Software Assurance is only available as part of a commercial licensing agreement. To learn more about Software Assurance and with which agreements it is available, see [Benefits of Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-by-benefits).

:::image type="content" source="media/ahb01.png" alt-text="Windows V M cost structure":::

Azure Hybrid Benefit is applicable to both Standard and Datacenter editions of Windows Server and is available across all Azure regions and sovereign clouds. It also includes VMs with additional software such as SQL Server or third-party marketplace software. You can save further on the infrastructure costs with [Azure Reserved Virtual Machine Instances](https://azure.microsoft.com/pricing/reserved-vm-instances/) by reserving VMs in advance.

## Rules and use cases

All you need to qualify for the benefit is Software Assurance for your Windows Server licenses that is currently active.

To begin, a minimum set of 16-core licenses for Windows Server with active Software Assurance entitles you to use Windows Server on Microsoft Azure with up to 16 virtual cores allocated across two or fewer Azure VMs. After that, a minimum of eight additional Windows Server core licenses with active Software Assurance entitles use on up to eight virtual cores and one Azure VM, where core licenses are sold in two-core packs and 16-core packs. For more information, see [Windows Server product licensing](https://www.microsoft.com/licensing/product-licensing/windows-server).

You can also run a virtual machine with more than 16 cores by stacking licenses. For example, with two 16-core license packs you may run a virtual machine with up to 32 cores. An Azure VM must be licensed with a minimum of eight cores, regardless of the size, then you can stack additional core licenses on top to the number you need.

There are differences in how Windows Server licenses can be used depending whether they are for Datacenter edition or Standard edition. The table below summarizes this:

| Right | Standard edition | Datacenter edition |
|--|--|--|
| Usage | You may either use your Windows Server licenses on Azure or licensed servers in your data centers, **but not at the same time**. The only exception to this is on a one-time basis, for up to 180 days, to allow you to migrate the same workloads to Azure. | *Dual Use Rights* allows you to use your Windows Server licenses on Azure and on licensed servers in your data centers **at the same time**. *Dual Use Rights* do not apply in the case of licenses allocated for *Unlimited Virtualization Rights*. |
| Unlimited Virtualization Rights | N/A | You may use your Windows Server licenses for any number of VMs on an Azure Dedicated Host, provided you allocate Windows Server Datacenter Licenses with SA for all of the physical cores available to you on that Azure server. |

> [!TIP]
> If your licenses qualify for use in Azure, you can run either Datacenter edition or Standard edition of Windows Server in Azure VMs, regardless of which edition the license is for.

> [!IMPORTANT]
> Windows Server VMs using Azure Hybrid Benefit can run in Azure only during the Software Assurance term. When the Software Assurance term is nearing expiry, you need to either renew your agreement with Software Assurance, disable the hybrid benefit functionality, or de-provision those VMs that are using Azure Hybrid Benefit.

For more information on the commercial licensing terms, see [Product terms for Microsoft Azure](https://www.microsoft.com/licensing/terms/productoffering/MicrosoftAzure/all), select a program from the dropdown menu, and see the heading **Azure Hybrid Benefit**.

## Azure Hybrid Benefit savings

You can use our [Azure Hybrid Benefit savings calculator](https://azure.microsoft.com/pricing/hybrid-benefit/#calculator) to estimate savings when using the Azure Hybrid Benefit for Windows Server licenses that include Software Assurance.

## How to use Azure Hybrid Benefit for Windows Server

We have enabled pre-built gallery images that are available for all our customers who have eligible licenses, irrespective of where they bought them, and enabled partners to be able to perform the deployments on customers' behalf. You can learn how to deploy Windows Server VMs with Azure Hybrid Benefit in Azure documentation for [Azure Hybrid Benefit for Windows Server](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

## How to maintain compliance

If you apply Azure Hybrid Benefit to your Windows Server VMs, you need to verify the number of eligible licenses and respective coverage period of your Software Assurance term before any activation of this benefit, and apply the guidelines above to ensure you deploy the correct number of Windows Server VMs with Azure Hybrid Benefit.

If you already have Windows Server VMs running with Azure Hybrid Benefit, you need to perform an inventory of how many units you are running, and check this against the Software Assurance licenses you have. Please contact your Microsoft licensing specialist to validate your Software Assurance licensing position.

To see and count all virtual machines deployed with Azure Hybrid Benefit for Windows Server in an Azure subscription, follow the steps in this Azure article to [list all VMs and Virtual Machine Scale Sets with Azure Hybrid Benefit for Windows Server in a subscription](/azure/virtual-machines/windows/hybrid-use-benefit-licensing#list-all-vms-and-vmss-with-azure-hybrid-benefit-for-windows-server-in-a-subscription). You can also look at your Microsoft Azure bill to determine how many virtual machines with Azure Hybrid Benefit for Windows Server you are running. The information about the number of instances with the benefit shows under **Additional Info**:

```json
"{"ImageType":"WindowsServerBYOL","ServiceType":"Standard_A1","VMName":"","UsageType":"ComputeHR"}"
```

Please note that billing does not apply in real time. There will be a delay of several hours from the time you've activated a Windows Server VM with Azure Hybrid Benefit before it shows on your bill.

Be sure to perform an inventory in each Azure subscription that you own to generate a comprehensive view of your licensing position. Once you have confirmed you are fully licensed for the number of Windows Server VMs you are running with Azure Hybrid Benefit, there is no need for any further action. You should perform an inventory regularly to ensure you are using any license benefits you are entitled to in order to reduce your costs, but also to make sure that you always have enough licenses to cover the number of Windows Server VMs you have deployed with Azure Hybrid Benefit.

If you do not have enough eligible Windows Server licenses for the number of VMs already deployed, you either need to purchase extra Windows Server licenses covered with Software Assurance through one of the commercial licensing agreements, purchase Windows Server VMs at regular Azure hourly rates by disabling Azure Hybrid Benefit for some VMs, or deallocate some VMs.

> [!NOTE]
> Microsoft reserves the right to audit customers at any time to verify eligibility for Azure Hybrid Benefit utilization.

If you want to learn more, including pricing, see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).
