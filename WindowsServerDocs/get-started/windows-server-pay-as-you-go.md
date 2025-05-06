---
title: Configure Windows Server Pay-as-you-go with Azure Arc
description: Configure Windows Server Pay-as-you-go to license your devices with usage-based charges available through Azure Arc service and billed via Azure subscription.
ms.topic: how-to
author: xelu86
ms.author: alalve
ms.date: 10/31/2024
---

# Configure Windows Server Pay-as-you-go with Azure Arc

Azure Arc's Pay-as-you-go subscription licensing option is an alternative to the conventional perpetual licensing for Windows Server 2025. With Pay-as-you-go, you can deploy a Windows Server device, license it, and only pay for as much as you use. This feature is facilitated through Azure Arc and billed via your Azure subscription. You have the flexibility to disable Pay-as-you-go whenever necessary. Additionally, you can use Pay-as-you-go for free for the first seven days after enabling it as a trial.

> [!NOTE]
>
> - If you shut down or deprovision your device, without disabling Pay-as-you-go, billing will continue. To avoid unexpected charges, it's recommended to disable Pay-as-you-go using the Azure portal, PowerShell, API, or remove the device from Azure Arc.
>
> - Windows Server Pay-as-you-go is an Azure service and the detailed usage rights are provided in the [Microsoft Product Terms](https://www.microsoft.com/licensing/terms/welcome/welcomepage).

Windows Server Pay-as-you-go shares the same pricing and model as Windows Server licensing on Microsoft Azure, but is designed for devices that are deployed outside of Microsoft Azure. Windows Server Pay-as-you-go with Azure Arc isn't supported on Microsoft Azure, as there are other ways to license Windows Server with Pay-as-you-go with that service.

Pay-as-you-go regulations differ from traditional perpetual licensing. For instance, in Pay-as-you-go, the cost is the same for both Standard and Datacenter editions, and there are no client access licenses (CALs) required for standard functionality. However, Remote Desktop Services (RDS) CALs are still required.

The Pay-as-you-go license only applies to the exact device where the feature is enabled on Microsoft Azure. Unlike traditional perpetual licenses, it doesn't provide additional rights for virtual machines (VM) running on the same server. Thus, the Automatic Virtual Machine Activation (AVMA) feature isn't available. Each VM requires its own separate license, regardless of the host server. The host and VMs can run different versions of the operating system (OS) and mix different license types.

## Prerequisites

- Your device must be running Windows Server 2025 Standard or Datacenter edition.
- Your device must be Azure Arc-enabled and be running Microsoft Azure connected machine agent version 1.47 or later.
- Your device isn't currently licensed (activated) with another license type, such as OEM, Retail, or Volume License (VL).
- An active internet connection is required.

## Set up Windows Server Pay-as-you-go

During the installation of the Windows Server 2025 OS, you can choose to set up Pay-as-you-go. This option is available on the **Choose a licensing method** screen where you would normally enter a product key. Once Pay-as-you-go is selected, providing a product key isn't required.

> [!NOTE]
> Pay-as-you-go integration is only available during the operating system installation if you're running Windows Setup from a retail copy of Windows Server 2025 media. If you're using Evaluation or Volume license (VL) media of Windows Server 2025, then the Product key page is bypassed, and hence you cannot opt in to Pay-as-you-go during the operating system installation. Nevertheless, you can enable Pay-as-you-go after installation as described below.

There are two methods for setting up Pay-as-you-go, via the graphical wizard and through the command line. Follow these steps based on which edition of Windows you're installing:

# [GUI](#tab/gui)

If you're new to Windows Server, see [Feature update, clean install, or migrate to Windows Server](/windows-server/get-started/install-upgrade-migrate) for more details.

Once you're at the **Choose a licensing method** screen, follow these steps:

1. Select **Pay-as-you-go** and then select **Next**.
1. Select your edition of Windows with **Desktop Experience** and then select **Next**.
1. Accept the license terms by selecting **Accept** to proceed.
1. Under **Select location to install Windows Server**, choose your disk and partition per your needs. Then select **Next**.
1. On the **Ready to install** screen, select **Install**

The install process automatically reboots your device as needed. You're prompted to create a password in order to proceed with the installation. Once complete and you're signed in, the **Azure Arc Setup** wizard is displayed. Follow these steps to continue setting up Pay-as-you-go:

1. On the Get **Started with Azure Arc** screen, select **Next**.
1. On the **Installing Azure Arc** screen, your device goes through several checks to install the Azure Connected Machine (AzCM) agent. Then select **Configure**.
1. On the **Configure Azure Arc** screen, select **Next**.
1. On the **Sign in to Azure** screen, select your Azure cloud, sign in, then select **Next**.
1. On the **Resource details** screen, continue filling in the required information, then select **Next**.
1. On the **Choose a licensing method for Windows Server** screen, select **Pay-as-you-go with Azure**, then select **Next**.
1. Once you reach the last screen during the configuration process, select **Finish**.

> [!NOTE]
> If you select **Use a product key** on the **Choose a licensing method for Windows Server** screen, and continue with the installation wizard, Pay-as-you-go won't be activated even if you had previously opted in during the OS installation.
>
> If you decide to opt out of using Pay-as-you-go, you will need to manually enter a product key using any supported method. However, if you still wish to use Pay-as-you-go, even though it has not been enabled through the Azure Arc configuration wizard, you can activate it through the Azure portal.

# [CLI](#tab/cli)

This option is for the Windows Server Core installation. Once you're at the **Choose a licensing method** screen, follow these steps:

1. Select **Pay-as-you-go** and then select **Next**.
1. Select your edition of Windows without Desktop Experience and then select **Next**.

As the Azure Arc installation wizard isn't supported with this set up, an alternative method to Arc-enable Windows Server Core must be used. See, [Connect hybrid machines to Azure by using PowerShell](/azure/azure-arc/servers/onboard-powershell#prerequisites) to proceed with the command line installation method.

---

## Manage Windows Server Pay-as-you-go

Managing Pay-as-you-go for Windows Server is possible using the Azure portal, PowerShell, or API. Even if you didn't choose to enable Pay-as-you-go during the initial installation of the OS is also an option, as long as the necessary prerequisites are met.

To enable Windows Server Pay-as-you-go, follow these steps:

# [Azure portal](#tab/azureportal)

1. Navigate to your [Azure portal](https://portal.azure.com), then search for and select **Machines - Azure Arc**.
1. Select the machine you want to enable Windows Server Pay-as-you-go.
1. Select the **Pay-as-you-go** tile.
1. Check the box next to **Pay-as-you-go with Azure**, and then select **Confirm**.

*Alternatively*, in the left pane menu by expanding **Licenses**, selecting **Windows Server**, and follow step 4.

# [Azure PowerShell](#tab/azurepowershell)

1. Launch PowerShell and authenticate your Azure subscription by running the following command:

   ```powershell
   Connect-AzAccount
   ```

1. Run the following script to prepare and activate the Windows Server Pay-as-you-go license for your resource:

   ```powershell
   $machine           = Get-AzResource -Name <MachineName> -ResourceType 'Microsoft.HybridCompute/machines'
   $licenseProfileId  = $machine.ResourceId + '/licenseProfiles/default'
   $apiVersion        = '2023-10-03-preview'
   $productType       = 'WindowsServer'
   $property          = @{
       productProfile = @{
           productType        = $productType
           subscriptionStatus = 'Enabled'
       }
   }

   $licenseProfile   = New-AzResource -ResourceId $licenseProfileId -Properties $property -Location $location -ApiVersion $apiVersion
   ```

---

To disable Windows Server Pay-as-you-go, follow these steps:

# [Azure portal](#tab/azureportal)

1. Navigate to your [Azure portal](https://portal.azure.com), then search for and select **Machines - Azure Arc**.
1. Select the machine you want to disable Windows Server Pay-as-you-go.
1. Select the **Pay-as-you-go** tile.
1. Uncheck the box next to **Pay-as-you-go with Azure**, and then select **Confirm**.
1. The **Deactivate Pay-as-you-go** notification appears asking if you'd like to deactivate. Select **Deactivate**.

*Alternatively*, in the left pane menu by expanding **Licenses**, selecting **Windows Server**, and follow step 4.

# [Azure PowerShell](#tab/azurepowershell)

1. Launch PowerShell and authenticate your Azure subscription by running the following command:

   ```powershell
   Connect-AzAccount
   ```

1. Run the following script to deactivate the Windows Server Pay-as-you-go license for your resource:

   ```powershell
   $machine           = Get-AzResource -Name <MachineName> -ResourceType 'Microsoft.HybridCompute/machines'
   $licenseProfileId  = $machine.ResourceId + '/licenseProfiles/default'
   $apiVersion        = '2023-10-03-preview'
   $productType       = 'WindowsServer'
   $property          = @{
       productProfile = @{
           productType        = $productType
           subscriptionStatus = 'Disabled'
       }
   }

   $licenseProfile   = Set-AzResource -ResourceId $licenseProfileId -Properties $property -ApiVersion $apiVersion
   ```

> [!NOTE]
> You have the ability to disable Windows Server Pay-as-you-go whenever you desire. It's important to remember to disable it when you're no longer using Pay-as-you-go, as failing to do so could result in continued charges for the Windows Server license even if the device is shut down, disconnected, or unavailable.
>
> After disabling Windows Server Pay-as-you-go, you'll need a different type of license if you want to continue using your device. You can install a traditional perpetual license by entering a product key.

---

## See also

- [Azure Arc-enabled servers](/azure/azure-arc/servers/)

- [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server)
