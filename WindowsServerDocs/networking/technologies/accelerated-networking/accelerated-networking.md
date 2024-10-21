---
title: Accelerated Networking
description: How to set up and validate Accelerated Networking on your VMs.
ms.topic: article
ms.author: helohr
author: Heidilohr
ms.date: 10/21/2024
---
# Accelerated Networking

On regular networking, all traffic entering and leaving a virtual machine (VM) goes between the host and the virtual switch. The virtual switch provides all policy enforcement for network traffic, including network security groups, access control lists, isolation, and other network virtualized services.

Accelerated Networking offloads all network policies applied by the virtual switch, instead applying them using the hardware. When the hardware applies policies, the VM network interface (NIC) can forward network traffic directly to the VM. The NIC also bypasses the host and the virtual switch while maintaining all policies applied in the host.

The following diagram illustrates how two VMs communicate with and without Accelerated Networking.

:::image type="content" source="./media/accelerated-networking.png" alt-text="A diagram showing the difference between two deployments with and without Accelerated Networking. The deployment without accelerated networking has to send its network traffic through two virtual switches on physical servers, while the network with Accelerated Networking doesn't.":::

Accelerated Networking's high-performance data path enables single root I/O virtualization (SR-IOV) on supported VM types, greatly improving networking performance in the following ways:

- Lower latency and higher packets per second (pps). Removing the virtual switch from the data path eliminates the wait time that packets need to spend in the host for policy processing. Higher pps increases the number of packets that the VM can process.

- Reduced jitter. Processing time for virtual switches depends on how many policies the host needs to apply and the workload of the CPU that does the processing. Offloading policy enforcement to the hardware removes that variability by delivering packets directly to the VM. Offloading also removes the host-to-VM communication, all software interrupts, and all context switches.

- Decreased CPU utilization. Bypassing the virtual switch in the host leads to less CPU utilization for processing network traffic.

## Prerequisites

Your deployment needs to meet the following prerequisites in order to be able to set up and use Accelerated Networking:

- A [Windows Server Azure Arc Managements services](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm). <!--Follow up w/ PMs about exact link for subscription.-->

- Your device must be running Windows Server 2025 Datacenter edition with a functioning cluster.

  >[!NOTE]
  >Non-clustered single servers and WS Standard don't support Accelerated Networking.

- Your hardware must support SR-IOV and be enabled in the BIOS. You may need to contact your hardware vendor to see if your machine supports SR-IOV.

- An SR-IOV supported network interface card (NIC).

- The Virtualization feature must be enabled in your BIOS.

- If you're running Azure Stack HCI, after you enable SR-IOV, you must install and configure a valid Compute intent for the [Network Advanced Transfer Cache (ATC)](/azure-stack/hci/deploy/network-atc?tabs=22H2). You can only enable Accelerated Networking on virtual switches managed by a Network ATC Compute intent. You must also install a [Network HUD](/azure-stack/hci/concepts/network-hud-overview) that is running Storage Spaces Direct.

## Enable Accelerated Networking on a cluster

To enable Accelerated Networking on a cluster:

#### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window as an administrator.

1. Run the following cmdlet to make sure your system meets all prerequisite requirements:

  ```powershell
  Get-AccelNetManagementPreReq
  ```

1. Run the following cmdlet to enable SR-IOV on your NIC if you haven't already:

  ```powershell
  Enable-NetAdapterSriov
  ```

1. Go to any node that's on the cluster where you want to enable Accelerated Networking.

1. Run the following command to enable Accelerated Networking:

  ```powershell
  Enable-AccelNetManagement -IntentName "MyIntent" -NodeReservePercentage
  ```

  >[!NOTE]
  > The `-IntentName` parameter is required.
  >
  >If you leave the `NodeReservePercentage` value blank, the system defaults to 50%. This value must be an integer greater than or equal to 0 and less than or equal to 99.

#### [Windows Admin Center](#tab/wac)

1. Open Windows Admin Center and go to your cluster.

1. In the cluster view menu, open the **Accelerated Networking** tab on the left side of the window.

1. Select the blue button labeled **Set up Accelerated networking**.

1. Select the name of the valid Network ATC compute intent and enter the percentage of nodes you want to reserve in case of a failover.

   >[!NOTE]
   >We recommend you reserve 50% of your nodes.

1. Select **Enable**.

---

## Change Accelerated Networking settings on a cluster

To change Accelerated Networking settings on a cluster:

#### [PowerShell](#tab/powershell)

On a node with Accelerated Networking enabled, run the following command with the values for the new intent and node reserve:

```powershell
Set-AccelNetManagement -IntentName "MyIntent" -NodeReservePercentage
```

#### [Windows Admin Center](#tab/wac)

1. Open Windows Admin Center and go to your cluster.

1. In the cluster view menu, open the **Accelerated Networking** tab on the left side of the window.

1. On the **Cluster overview** tab, select **Settings**.

1. On this page, you can select new intents and change the node reserve. When finished reconfiguring the settings, select **Save** to save your changes.

---

## Disable Accelerated Networking on a cluster

To disable Accelerated Networking on a cluster:

#### [PowerShell](#tab/powershell)

1. In a PowerShell window, go to any node in the cluster you want to disable Accelerated Networking for.

1. Run the following cmdlet to disable Accelerated Networking on the cluster:

  ```powershell
  Disable-AccelNetManagement 
  ```

After you disable the cluster, the Network HUD no longer monitors the health of the feature.

>[!NOTE]
>Disabling Accelerated Networking at the cluster doesn't change setting configurations on the VMs. VMs are no longer managed by Accelerated Networking or tracked by the Network HUD.

#### [Windows Admin Center](#tab/wac)

1. Open the **Accelerated Networking** tab and select the **Status** tab.

1. Under **Disable accelerated networking?**, select the blue **Disable Accelerated Networking** button.

---

## Enable Accelerated Networking on a VM

To enable Accelerated Networking on a VM:

#### [PowerShell](#tab/powershell)

1. Create a VM on a host in a cluster that has Accelerated Networking enabled.

1. In a PowerShell window, go to the node containing the VM you want to enable Accelerated Networking.

1. Run the following command to enable Accelerated Networking with high performance:

  ```powershell
  Enable-AccelNetVM -VMName "MyVM" -Performance High
  ```

  **VMName** and **Performance** are required parameters. You can set the performance value to Low, Medium, or High. Performance options have minimum vCPU requirements based on hyperthreading status, as shown in the following table:

  | Hyperthreading configuration | Performance setting | Minimum vCPUs required |
  |---|---|---|
  | Disabled | Low | 2 |
  | Disabled | Medium | 2 |
  | Disabled | High | 4 |
  | Enabled | Low | 4 |
  | Enabled | Medium | 4 |
  | Enabled | High | 4 |

1. To enable Accelerated Networking for multiple VMs to run in low performance, run the following command:

  ```powershell
  Get-VM -VMName "MyVM01, MyVM02" | Enable-AccelNetVM -Performance Low
  ```

#### [Windows Admin Center](#tab/wac)

With Windows Admin Center, you can enable Accelerated Networking on either a single VM or several VMs at the same time.

##### Enable a single VM

1. Go to the **Settings page** for the VM you want to enable Accelerated Networking for.

1. Select **Accelerated Networking**.

1. Select the **Enable** radio button and the radio button for your desired performance level.

1. Select **Save Accelerated networking settings** to save your changes.

##### Enable multiple VMs

1. Go to the **Cluster Level Accelerated Networking** tab and select **Disabled VMs**.

1. Select the check boxes for all the VMs you want to enable Accelerated Networking for.

1. Select your desired performance level for all enabled VMs.

1. Select **Enable**. The VMs should disappear from the Disabled VMs tab and reappear in the Enabled VMs tab.

---

## Change Accelerated Networking settings on a VM

To change the Accelerated Networking settings on a VM:

#### [PowerShell](#tab/powershell)

1. Go to the node that contains the VMs you want to reconfigure.

1. Run the following command to set your VM to run in medium performance:

   ```powershell
   Set-AccelNetManagement -VMName "MyVM" -Performance Medium
   ```

#### [Windows Admin Center](#tab/wac)

You can configure settings on either a single VM or multiple VMs at the same time.

##### Change settings on a single VM

1. Go to the VM you want to edit and select **Settings**.

1. Go to **Networking** > **Accelerated Networking**.

1. Edit the settings as desired.

##### Change settings on multiple VMs

1. Go to the **Cluster Level Accelerated Networking** tab and select **Enabled VMs**.

1. Select the check boxes for all the VMs you want to edit settings for.

1. You can edit performance settings for multiple VMs at once. Other settings aren't available at this time.

---

## Disable Accelerated Networking on a VM

To disable Accelerated Networking on a VM:

#### [PowerShell](#tab/powershell)

1. Go to the node that contains the VMs you want to disable Accelerated Networking for.

1. Run the following command:
  
   ```powershell
   Disable-AccelNetVM -VMName "MyVM"
   ```

1. To disable Accelerated Networking for multiple VMs, run the following command:

  ```powershell
  Get-VM -VMName "MyVM01, MyVM02" | Disable-AccelNetVM
  ```

#### [Windows Admin Center](#tab/wac)

With Windows Admin Center, you can disable Accelerated Networking on either a single VM or several VMs at the same time.

##### Single VM

1. Go to the **Settings page** for the VM you want to enable Accelerated Networking for.

1. Select **Accelerated Networking**.

1. In the **Status** tab under **Disable Aaccelerated networking?**, select **Disable Accelerated networking**.

##### Multiple VMs

1. Go to the cluster you want to disable Accelerated Networking for and select **Accelerated Networking**.

1. Select the **Enabled virtual machines** tab.

1. Select the check boxes for all the VMs you want to disable Accelerated Networking for.

1. Select **Disable VM Accelerated networking**. The VMs should disappear from the Enabled VMs tab and reappear in the **Disabled virtual machines** tab.

---

## Known issues

The following error messages are possible issues you may encounter while using this feature.

### Accel_net_not_supported

Node {0} does not support Accelerated Networking. Windows Server 2025/Azure Stack HCI 24H2 or later is required.

To resolve this issue, update your OS to the latest version of Windows Server.

### Hyperthreading_check_failed

Hyperthreading validation: Failed. There is an inconsistency across the cluster. Either disable or enable hyperthreading on all nodes.

To resolve this issue, make sure the hyperthreading configuration is consistent for every node in your cluster.

### Intent_not_found

Intent validation: Failed. Intent {0} not found.  

To resolve this issue, make sure the intent name you entered is correct, then try again.

### Intent_type_check_failed

The selected intent {0} does not have Compute capabilities.

To resolve this issue, create or update an intent with the Compute state.

### Sriov_support_[KEY]

#### Unknown

Adapter {0} cannot be enabled for Accelerated Networking because it is not advertising SR-IOV Support.

To resolve this issue, make sure the computer hardware can support SR-IOV and that you enabled I/O virtualization in the BIOS.

#### MissingAcs

Adapter {0} cannot be enabled for Accelerated Networking because it is in a PCIe slot that does not support Access Control Services (ACS).

To resolve this issue, either try moving the device to another PCIe slot or contact your hardware vendor.

#### MissingPfDriver

Adapter {0} cannot be enabled for Accelerated Networking because the device driver does not support SR-IOV.

To resolve this issue, update the driver.

#### NoBusResources

Adapter {0} cannot be enabled for Accelerated Networking because there are not enough PCI Express bus numbers available.

There are no known solutions for this issue at this time.

### Get_network_adapter_failed

Failed to get network adapters for VM {0}.  

To resolve this issue, make sure the VM has at least one network adapter.

### ht_enabled_min_processor_counter

The minimum required processor count for requested performance with hyperthreading enabled/disabled is {0}.

To resolve this issue, add more vCPUs to the VM in order to meet the requirements.

### cannot_provision_performance

Cannot provision {0} on this system.

To resolve this issue, select a different Performance option or update your network adapters.

### enable_accel_net_failed

Failed to enable Accelerated Networking on the cluster {0}.  

To resolve this issue, make sure you're using a valid PayGo subscription license.

### vm_not_enough_vcpus

VM {0} does not have enough vCPUs to enable Accelerated Networking with the specified performance. 

There is no known way to resolve this issue at this time.

### cluster_not_enough_resources

The cluster does not have enough SRIOV resources to enable VM {0}.  

To resolve this issue, either lower the NodeReservePercentage value, select a different Performance option, or increase the number of SRIOV resources in your cluster.

## Next steps

- For more information about virtualized networking, see [Hyper-V overview](../../../virtualization/hyper-v/hyper-v-overview.md).

- For more information about Azure Arc-enabled servers, see [What are Azure Arc-enabled servers?](/azure/azure-arc/servers/overview)

- For more information about high-performance networking (HPN), see [High-performance networking (HPN)](../hpn/hpn-top.md).
