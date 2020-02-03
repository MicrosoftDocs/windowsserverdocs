---
title: Windows Server 2008 and 2008 R2 extended security updates
description: Learn how to use Extended Security Updates (ESU) for Windows Server 2008 and 2008 R2 after the end of their support lifecycle.
ms.prod: windows-server
ms.technology: server-general
ms.mktglfcycl: manage
author: iainfoulds
ms.author: iainfou
ms.topic: get-started-article
ms.localizationpriority: high
ms.date: 01/23/2020
---

# How to use Windows Server 2008 and 2008 R2 extended security updates (ESU)

>Applies To: Windows Server 2008 / 2008 R2

Windows Server 2008 and Windows Server 2008 R2 reach the end of their support lifecycle on January 14, 2020. Windows Server Long Term Servicing Channel (LTSC) has a minimum of ten years of support - five years for mainstream support and five years for extended support. This support includes regular security updates.

End of support also means the end of security updates. This scenario can cause security or compliance issues and put business applications at risk. Microsoft recommends that you [upgrade to the current version of Windows Server](modernize-windows-server-2008.md) for the most advanced security, performance, and innovation.

If you can't upgrade all your servers by the end of support lifecycle deadline, the following options help protect applications and data during the upgrade transition:

* Migrate existing Windows Server 2008 and 2008 R2 workloads as-is to Azure Virtual Machines (VMs).
    * This migration to Azure automatically provides an additional three years of extended security updates (ESU). There's no additional charge for extended security updates on top of Azure VM's cost, and there's no additional configuration required.
* Purchase an extended security update subscription for your servers and remain protected until you're ready to upgrade to a newer Windows Server version.
    * These updates are provided for up to three years after the end of support lifecycle date.

After the three year period of extended updates, there's no option for computers to receive additional updates.

## What are extended security updates for Windows Server?

Extended security updates (ESUs) for Windows Server include security updates and bulletins rated *critical* and *important*, for a maximum of three years after January 14, 2020. Extended security updates don't include the following:

* New features
* Customer-requested non-security hotfixes
* Design change requests

For more information, see the [Extended Security Updates frequently asked questions](https://www.microsoft.com/cloud-platform/extended-security-updates).

## How to use extended security updates

If you run Windows Server 2008 / 2008 R2 VMs in Azure, they're automatically enabled for extended security updates. You don't need to configure anything, and there's no additional charge for using extended security updates with Azure VMs. Extended security updates are automatically delivered to Azure VMs if they're configured to receive updates.

For other environments, such as on-premises VMs or physical servers, you need to manually request and configure extended security updates. If you've already purchased extended security updates, which are available through Volume Licensing Programs such as Enterprise Agreement (EA), Enterprise Agreement Subscription (EAS), Enrollment for Education Solutions (EES), or Server and Cloud Enrollment (SCE), you can use one of the following steps to get an activation key:

* Sign in to the [Microsoft Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) to view and get activation keys.
* Register for extended security updates in the Azure portal to get the Windows Server 2008/R2 activation keys.
    * See the following steps in this article for steps on how to complete this process.

## Register for extended security updates

To use extended security updates, you create a multiple activation key (MAK) and apply it to Windows Server 2008 and 2008 R2 computers. This key lets the Windows Update servers know that you can continue to receive security updates. You register for extended security updates and manage these keys using the Azure portal, even if you only use on-premises computers.

> [!NOTE]
>
> You don't need to register for extended security updates if you're running Windows Server 2008 and 2008 R2 on Azure VMs. For other environments, such as on-premises VMs or physical servers, [purchase extended security updates](https://www.microsoft.com/licensing/how-to-buy/how-to-buy) before you try to register and use them.

> [!IMPORTANT]
>
> Make sure that you've followed the previous steps to purchase extended security updates through your Volume Licensing Program. Before following the steps below, send an e-mail to [winsvresuchamps@microsoft.com](mailto:winsvresuchamps@microsoft.com) with the following information for approval to use the feature:
>
> * Customer Name:
> * Azure Subscription:
> * EA Agreement Number (for ESU):
> * Number of ESU servers:
>
> The team will review provided information and add the user / subscription to the approved list.
>
> If the requestor is not approved, the following error can occur:
>
> [The resource type could not be found in the namespace 'Microsoft.WindowsESU'](https://social.msdn.microsoft.com/Forums/office/94b16a89-3149-43da-865d-abf7dba7b977/the-resource-type-could-not-be-found-in-the-namespace-microsoftwindowsesu-for-api-version)

To register non-Azure VMs for extended security updates and create a key, complete the following steps in the Azure Portal:

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search box at the top of the Azure portal, search for and select **Extended Security Updates**.

    ![Search for extended security updates in the Azure portal](media/extended-security-updates/esu-portal-search.png)

    If you haven't use extended security updates before, chose to **+ Create** an extended security updates resource first. Otherwise, select your resource from the list.

1. Under **Register for Extended Service Updates**, select **Get started**.

    ![Get started with Extended Security Updates in the Azure portal](media/extended-security-updates/get-started-with-esu.png)

1. To create your first key, select **Get key**.

    ![Choose to create a key in the Azure portal](media/extended-security-updates/get-key.png)

    > [!NOTE]
    > You need an Azure subscription associated with your account to create the extended security update resource and key. If you don't have an Azure subscription associated with your account, sign in with a different user account or create an Azure subscription using the guided steps shown in the portal.

1. Under **Azure details**, select your Azure subscription, a resource group, and location for your key.

    Under **Registration details**, enter the following information:

    | Setting             | Value |
    |---------------------|-------|
    | Key name            | A display name for your key, such *Agreement01*. |
    | Agreement number    | Your agreement number generated by the volume licensing contract management system, or MSLicense for Enterprise Agreement programs. |
    | Number of computers | Choose the number of computers on which you want to install Extended Security Updates with this key.​ |
    | Operating system    | Choose the operating system to use this key with, such as Windows Server 2008 or Windows Server 2008 R2. |

    When ready, select **Review + register**.

1. After successful validation, a summary of your choices for the new registry resource is shown. If needed, correct any validation errors or update your configuration choice. The Azure [Terms of Use](https://azure.microsoft.com/support/legal/) and [Privacy Policy](https://privacy.microsoft.com/privacystatement) are available.

    Check the box to confirm that you have eligible computers and the key is only to be used within your organization:

    ![Confirm that the key will only be used by your organization](media/extended-security-updates/confirm-key-usage.png)

    When ready, select **Create** to generate the MAK.

Extended security updates registration is now available for use with your computers. The key created should be applied to Windows Server 2008 and 2008 R2 computers that you wish to remain eligible for security updates.

## Download and apply extended security updates

Delivery, download and application of extended security updates for Windows Server is no different than existing deployment processes. The updates provided through extended security updates are only for *Security*, and are released every Patch Tuesday.

You can install the updates using whatever tools and processes already in place. The only difference is that the system must be registered using the key generated in the previous section for the updates to download and install.

For Azure VMs, the process of enabling the computer for extended security updates is automatically completed for you. Updates should download and install without additional configuration.
