---
title: Azure Hybrid Benefit for Windows Server
description: Azure Hybrid Benefit for Windows Server lets you reduce costs by using your on-premises Windows Server licenses with Software Assurance enabled for VMs in Azure. Use Azure Stack HCI and Azure Kubernetes Service (AKS) on Azure Stack HCI and Windows Server at no extra cost.
ms.date: 10/07/2022
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
---

# Azure Hybrid Benefit for Windows Server

Azure Hybrid Benefit (AHB) is a cost saving benefit that enables you to use your on-premises licenses with Software Assurance (SA) in the cloud. This article focuses on benefits for Windows Server licenses with SA: cost savings for Windows Server virtual machines (VMs) in Azure, Azure Stack HCI, and Azure Kubernetes Service (AKS) hybrid deployment options.

For other benefits of AHB (for example, SQL Server), see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/#why-azure-hybrid-benefit).

## What qualifies you for AHB?

To qualify for Azure Hybrid Benefit for Windows Server, you need on-premises core licenses for Windows Server with active Software Assurance. Software Assurance is only available as part of a commercial licensing agreement. To learn more about volume licensing and which agreements it's available with, see [Microsoft Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default). To learn more about Windows Server core licenses, see [Windows Server product licensing](https://www.microsoft.com/licensing/product-licensing/windows-server?rtc=1).

> [!IMPORTANT]
> Workloads using Azure Hybrid Benefit can run only during the Software Assurance term. When the Software Assurance term approaches expiration, you must either renew your agreement with Software Assurance, disable the hybrid benefit functionality, or de-provision those workloads that are using Azure Hybrid Benefit.

## What's included in AHB?

Customers with Windows Server Software Assurance can use Azure Hybrid Benefit to further reduce costs in the cloud and in datacenter and edge locations.

AHB includes the following cost savings:

- **Windows Server VMs on Azure:** The license for Windows Server is covered by AHB, so you only need to pay for the base compute rate of the virtual machine. The base compute rate is equal to the Linux rate for virtual machines.

- **Azure Stack HCI:** The Azure Stack HCI host fee and Windows Server subscription fee are waived with AHB. That is, unlimited virtualization rights are provided at no extra cost. You still pay other costs associated with Azure Stack HCI (for example, customer-managed hardware, Azure services, and workloads).

- **AKS:** Run AKS on Windows Server and Azure Stack HCI at no extra cost. You'll still pay for the underlying host infrastructure and any licenses for Windows containers unless you're also eligible for AHB for Azure Stack HCI. With AHB for Azure Stack HCI, you can waive fees for the Azure Stack HCI host and Windows Server subscription.

![Illustration showing Azure Hybrid Benefit savings for Windows Server VMs on Azure, AKS on Azure Stack HCI and Windows Server.](media/azure-hybrid-benefit/azure-hybrid-benefit-savings.png)

## Pricing for AHB

To evaluate your potential cost savings, you can use these resources:

- **Windows VMs on Azure:** [Windows Virtual Machine Pricing](https://azure.microsoft.com/pricing/details/virtual-machines/windows). Use the [Azure Hybrid Benefit Savings Calculator](https://azure.microsoft.com/pricing/hybrid-benefit/) to estimate cost savings, or compare Windows VM pricing with and without AHB.  

- **Azure Stack HCI:** [Azure Stack HCI pricing](https://azure.microsoft.com/pricing/details/azure-stack/hci).  

- **Azure Kubernetes Service (AKS):** [AKS on Azure Stack HCI pricing](https://azure.microsoft.com/pricing/details/azure-stack/aks-hci).

## Getting AHB for Windows VMs in Azure

### Licensing prerequisites

#### Types of license

- Windows Server Standard with active Software Assurance, or
- Windows Server Datacenter with active Software Assurance, or
- An eligible Cloud Solution Provider (CSP) subscription

#### Number of licenses

- The minimum set of 16-core licenses, either Windows Server Datacenter or Windows Server Standard edition, entitles use on up to 16 virtual cores allocated across 2 or fewer virtual machines.

- Each additional set of 8-core licenses entitles use on up to 8 virtual cores on 1 virtual machine.

- Stacking licenses: To run a virtual machine with more than 16 cores, you can stack licenses. For example, with two 16-core license packs, you can run a virtual machine with up to 32 cores. Each virtual machine, regardless of its size, must be licensed with a minimum of 8 cores. You can then stack more core licenses on top, up to the number that you need.

#### Use rights

- **Windows Server Standard edition:** Licenses must be used either on-premises or in Azure, but not at the same time. The only exception is on a onetime basis, for up to 180 days, to allow you to migrate the same workloads to Azure.  

- **Windows Server Datacenter edition:** Licenses allow simultaneous usage on-premises and in Azure. Dual Use Rights don't apply for licenses allocated for [Unlimited Virtualization Rights](#unlimited-virtualization), below.

#### Unlimited virtualization

Unlimited Virtualization Rights refers to the right to use any number of Windows Server VMs on a host.  

- **Windows Server Datacenter edition:** You can use any number of Windows Server VMs on an Azure dedicated host if you allocate Windows Server Datacenter licenses with active SA for all the available physical cores on that Azure server.

- **Windows Server Standard edition:** Unlimited Virtualization Rights aren't available.  

### How to apply AHB for Windows VMs in Azure

To learn how to deploy Windows Server VMs in Azure with AHB, follow the steps in [Explore Azure Hybrid Benefit for Windows VMs](/azure/virtual-machines/windows/hybrid-use-benefit-licensing). One way to activate AHB for a Windows Server VM is to check the box under **Licensing** during VM creation, as shown below.

![Screenshot of Licensing screen to apply Azure Hybrid Benefit to a Windows Server VM.](media/azure-hybrid-benefit/activate-azure-hybrid-benefit-for-windows-server-vm.png)

### How to maintain compliance

If you apply Azure Hybrid Benefit to your Windows Server VMs, verify the number of eligible licenses and the Software Assurance coverage period before you activate this benefit. Use the guidelines above to make sure you deploy the correct number of Windows Server VMs with this benefit.

If you already have Windows Server VMs running with Azure Hybrid Benefit, perform an inventory to see how many units you're running, and check this number against your Software Assurance licenses. You can contact your Microsoft licensing specialist to validate your Software Assurance licensing position.

To see and count all VMs that are deployed with Azure Hybrid Benefit in an Azure subscription, [list all VMs and virtual machine scale sets](/azure/virtual-machines/windows/hybrid-use-benefit-licensing#list-all-vms-and-virtual-machine-scale-sets-with-azure-hybrid-benefit-for-windows-server-in-a-subscription) using the steps in [Explore Azure Hybrid Benefit for Windows VMs](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

You can also look at your Microsoft Azure bill to determine how many VMs with Azure Hybrid Benefit for Windows Server you are running. You'll find information about the number of instances with the benefit under **Additional Info**:

```json
"{"ImageType":"WindowsServerBYOL","ServiceType":"Standard_A1","VMName":"","UsageType":"ComputeHR"}"
```

Billing isn't applied in real time. Expect a delay of several hours after you activate a Windows Server VM with Azure Hybrid Benefit before the VM shows on your bill.

To get a comprehensive view of your licensing position, perform an inventory in each of your Azure subscriptions. Confirm that you're fully licensed for the Windows Server VMs running with Azure Hybrid Benefit. You don't need to take any further action.

Perform an inventory regularly to make sure you're using any license benefits that you're entitled to. Regular inventories can help you reduce costs and make sure that you always have enough licenses to cover the Windows Server VMs you've deployed with Azure Hybrid Benefit.

If you don't have enough eligible Windows Server licenses for your deployed VMs, you have three choices:
- Purchase extra Windows Server licenses covered by Software Assurance through a commercial licensing agreement.
- Disable Azure Hybrid Benefit for some of your VMs, and purchase them at regular Azure hourly rates.
- Deallocate some VMs.

> [!NOTE]
> Microsoft reserves the right to audit customers at any time to verify eligibility for Azure Hybrid Benefit utilization.

## Getting AHB for Azure Stack HCI

### Licensing prerequisites

#### Types of license

- Windows Server Datacenter with active Software Assurance only

#### Number of licenses

- Each Windows Server core license entitles use on 1 physical core of Azure Stack HCI. You'll need to allocate enough core licenses for all physical cores on servers in the Azure Stack HCI cluster.

#### Unlimited virtualization

- You can use Windows Server in any number of VMs on the Azure Stack HCI cluster if you allocate enough core licenses for all physical cores on servers in the Azure Stack HCI cluster.

#### Use rights

- Licenses must be used either on-premises or on Azure Stack HCI, but not on both. You'll have 180 days of concurrent licensing to migrate your servers.

### How to apply AHB for Azure Stack HCI

You can learn how to deploy AHB for Azure Stack HCI by following the steps in [Azure Stack HCI billing and payment](/azure-stack/hci/concepts/billing). One method is to activate the benefit from the **Configuration** pane of the Azure Stack HCI resource, as shown below.

![Screenshot of the screen for activating Azure Hybrid Benefit for Azure Stack HCI.](media/azure-hybrid-benefit/activate-azure-hybrid-benefit-for-azure-stack-hci.png)

## Getting AHB for AKS

### Licensing prerequisites 

#### Eligible hosts

- Windows Server 2019 or later (Datacenter or Standard), or
- Azure Stack HCI

#### Types of license

- Windows Server Standard with active Software Assurance, or
- Windows Server Datacenter with active Software Assurance, or
- An eligible Cloud Solution Provider (CSP) subscription

#### Number of licenses

- Each Windows Server core license entitles use on 1 virtual core of AKS.  

#### Use rights

- AHB for AKS is additive. Core licenses used for AHB for AKS can be used at the same time with on-premises Windows Server licensing, as well as AHB for other workloads in this article.

### How to apply AHB for AKS

AHB for AKS will be available soon.

## FAQ: Azure Hybrid Benefit

#### Which regions are eligible for Azure Hybrid Benefit?

AHB is available across all Azure regions and sovereign clouds.

#### What happens to my benefits if my Software Assurance expires?

To use these benefits, your Software Assurance or subscriptions must be active. If you choose not to renew your Software Assurance when it expires, you'll need to remove your benefits from your resources in the Azure portal.

#### What is Software Assurance?

Software Assurance provides other benefits to maximize your IT investments. Software Assurance is only available through volume licensing and is purchased when you buy or renew a Volume Licensing agreement. It's included with some agreements and is an optional purchase with others. Software Assurance benefits include new product version rights, support, license mobility rights, and a unique set of technologies and services.

For information about volume licensing, see [Microsoft Licensing](https://www.microsoft.com/en-us/Licensing/default). To learn more about Software Assurance benefits, and how each benefit can help meet your business needs, see [Software Assurance benefits](https://www.microsoft.com/en-us/Licensing/licensing-programs/software-assurance-by-benefits).

#### How can customers get Software Assurance?

You can purchase Software Assurance through Volume Licensing. Your Software Assurance benefits are activated in the [Volume Licensing Service Center (VLSC)](https://www.microsoft.com/Licensing/servicecenter/default.aspx). If your organization has a Microsoft Products and Services Agreement (MPSA), the [Business Center](https://businessaccount.microsoft.com/Customer/) is your destination for easy management of your Software Assurance benefits.
