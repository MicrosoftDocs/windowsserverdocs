---
title: Configure NUMA to Optimize Hyper-V Memory
description: Learn how to configure NUMA in Hyper-V to optimize memory access and performance of virtual machines running on NUMA-enabled hardware.
ms.topic: how-to
ai-usage: ai-assisted
author: dknappettmsft
ms.author: daknappe
ms.date: 07/03/2026

#customer intent: As a Hyper-V administrator, I want to configure NUMA settings so that virtual machines optimize memory access and improve performance on NUMA-enabled hardware.
---

# Configure NUMA in Hyper-V

Non-Uniform Memory Access (NUMA) lets virtual machines (VMs) access memory that's physically closer to the CPU cores they use. This feature improves performance for workloads that are sensitive to memory access latency, such as databases and high-performance computing applications. By configuring the NUMA topology and NUMA spanning for your Hyper-V host and VMs, you control how VMs map to the host's physical NUMA nodes.

This article shows you how to configure NUMA settings on multiprocessor systems. NUMA settings don't apply to single-processor systems, as they don't have multiple NUMA nodes.

To learn more about NUMA in Hyper-V, including changes to the behavior with Windows Server 2025 and Windows 11 24H2, see [NUMA in Hyper-V](non-uniform-memory-access.md).

## Prerequisites

Before you configure NUMA in Hyper-V, ensure that you meet the following prerequisites:

- Administrative access to a Hyper-V host.

- NUMA-enabled hardware.

## Determine the NUMA topology of a Hyper-V host

You can determine the NUMA topology of a Hyper-V host by using the [Get-VMHostNumaNode](/powershell/module/hyper-v/get-vmhostnumanode) PowerShell cmdlet from the [Hyper-V module](/powershell/module/hyper-v/). This cmdlet returns information about the NUMA nodes on the host, including the number of logical cores and memory available on each node.

To view the NUMA topology of a Hyper-V host:

1. On a Hyper-V host, open PowerShell as an administrator.

1. Run the following command:

   ```powershell
   Get-VMHostNumaNode
   ```

   Here's an example of the output from the command. If you have multiple NUMA nodes, the output shows multiple entries for `NodeId`, each representing a different NUMA node on the host.

   ```output
   NodeId                 : 0
   ProcessorsAvailability : {94, 99, 100, 100}
   MemoryAvailable        : 3196
   MemoryTotal            : 4093
   ComputerName           : host-01
     
   NodeId                 : 1
   ProcessorsAvailability : {66, 73, 98, 99}
   MemoryAvailable        : 2533
   MemoryTotal            : 4096
   ComputerName           : host-01
   ```

If you have multiple NUMA nodes, consider how you want to configure NUMA spanning and virtual NUMA topology for your VMs based on the available resources on each node.

## Configure NUMA spanning on a Hyper-V host

You can enable or disable NUMA spanning on a Hyper-V host by using Hyper-V Manager or PowerShell. The setting for NUMA spanning on a Hyper-V host only applies to hosts with multiple NUMA nodes.

Select the relevant tab.

# [Hyper-V Manager](#tab/hyper-v-manager)

To configure NUMA spanning on a Hyper-V host by using Hyper-V Manager:

1. Open Hyper-V Manager and select a Hyper-V host in the left pane.

1. Shut down all VMs on that host. If you had VMs running, restart the host, and then open Hyper-V Manager again.

1. Right-click the Hyper-V host, and then select **Hyper-V Settings**.

1. In the section for **Server**, select **NUMA Spanning**.

1. Check the box **Allow virtual machines to span physical NUMA nodes** to enable NUMA spanning, or uncheck it to disable NUMA spanning.

1. Select **OK** to save the changes, and then restart the Hyper-V Virtual Machine Management Service (`vmms`) from the Services console. Alternatively, you can restart the Hyper-V host.

# [PowerShell](#tab/powershell)

To configure NUMA spanning on a Hyper-V host by using PowerShell:

1. Open PowerShell as an administrator on the Hyper-V host.

1. Run the following command to check the current NUMA spanning setting:

   ```powershell
   Get-VMHost | FL NumaSpanningEnabled
   ```

   Here's an example of the output from the command. If NUMA spanning is enabled, the value is `True`. If it's disabled, the value is `False`.

   ```output
   NumaSpanningEnabled : True
   ```

1. To change the value, shut down all VMs on that host. If you had VMs running, restart the host, and then open Hyper-V Manager again.

1. Run one of the following commands to enable or disable NUMA spanning:

   - To enable NUMA spanning:

     ```powershell
     Set-VMHost -NumaSpanningEnabled $true
     ```

   - To disable NUMA spanning:

     ```powershell
     Set-VMHost -NumaSpanningEnabled $false
     ```

1. Run the command in step 2 again to verify that the setting changed.

1. Restart the Hyper-V Virtual Machine Management Service (`vmms`) by running the following command. Alternatively, you can restart the Hyper-V host.

   ```powershell
   Restart-Service vmms -Verbose
   ```

---

## Configure virtual NUMA topology on a VM

The virtual NUMA topology lets you specify the number of virtual NUMA nodes, the number of virtual processors per node, and the amount of memory to allocate to each node. By default, a VM uses the topology of the physical host. You can configure the virtual NUMA topology for a VM by using Hyper-V Manager or PowerShell.

Select the relevant tab.

# [Hyper-V Manager](#tab/hyper-v-manager)

To configure the virtual NUMA topology for a VM by using Hyper-V Manager:

1. Open Hyper-V Manager and select the VM you want to configure. If the VM is running, shut it down.

1. Right-click the VM, and then select **Settings**.

1. In the **Hardware** section, expand **Processor**, and then select **NUMA**.

1. Set values for the maximum number of processors and memory allowed on a single virtual NUMA node. Change the values based on your requirements. Set the following options:

   - **Maximum number of processors**
   - **Maximum amount of memory (MB)**
   - **Maximum NUMA nodes allowed on a socket**
   - **Hardware threads per core**

   To reset the values to the default settings, select **Use Hardware Topology**.

1. Select **OK** to save the changes.

# [PowerShell](#tab/powershell)

To configure the virtual NUMA topology for a VM by using PowerShell, replace the placeholder `<values>` with your own values.

1. Open PowerShell as an administrator on the Hyper-V host.

1. If the VM is running, shut it down by running the following command:

   ```powershell
   Stop-VM -Name '<VMName>'
   ```

1. Run the following commands to view the current virtual NUMA topology of the VM:

   ```powershell
   $vmName = '<VMName>'

   $vmNuma = @{
       "Maximum number of processors" = (Get-VMProcessor -VMName $vmName).MaximumCountPerNumaNode
       "Maximum amount of memory (MB)" = (Get-VMMemory -VMName $vmName).MaximumPerNumaNode
       "Maximum NUMA nodes allowed on a socket" = (Get-VMProcessor -VMName $vmName).MaximumCountPerNumaSocket
       "Hardware threads per core" = (Get-VMProcessor -VMName $vmName).HwThreadCountPerCore
   }

   $vmNuma | FT -AutoSize
   ```

   Here's an example of the output from the commands:

   ```output
   Name                                   Value
   ----                                   -----
   Maximum NUMA nodes allowed on a socket 2    
   Hardware threads per core              0    
   Maximum number of processors           16   
   Maximum amount of memory (MB)           262144
   ```

1. Use the following commands to set the virtual NUMA topology for the VM.

   - To set the maximum number of processors per NUMA node:

     ```powershell
     Set-VMProcessor -VMName '<VMName>' -MaximumCountPerNumaNode '<value>'
     ```

   - To set the maximum amount of memory per NUMA node (in MB):

     ```powershell
     Set-VMMemory -VMName '<VMName>' -MaximumPerNumaNode '<value>'
     ```

   - To set the maximum number of processors per NUMA socket:

     ```powershell
     Set-VMProcessor -VMName '<VMName>' -MaximumCountPerNumaSocket '<value>'
     ```

   - To set the number of hardware threads per core:

     ```powershell
     Set-VMProcessor -VMName '<VMName>' -HwThreadCountPerCore '<value>'
     ```

1. Run the commands in step 3 again to verify the updated virtual NUMA topology.

---

## Check VM to NUMA node mapping

Use the following PowerShell script to determine the mapping of virtual machines to physical NUMA nodes, including the amount of memory allocated to each VM and the remaining memory on each physical NUMA node.

Running the script as-is returns the mapping for all VMs on the host. You can also specify a VM name to get the mapping for a specific VM by replacing the `*` in the `$vmName` variable with the name of the VM you want to check.

```powershell
$vmName = "*"

if ($vmName -eq "*") {
    $vms = Get-WmiObject -Namespace 'root\virtualization\v2' -Class Msvm_ComputerSystem | Where-Object { $_.ElementName -ne $_.__SERVER }
} else {
    $vms = Get-WmiObject -Namespace 'root\virtualization\v2' -Class Msvm_ComputerSystem | Where-Object { $_.ElementName -eq $VmName }
}

if (!$vms) {
    throw "$vmName does not exist on $($ENV:COMPUTERNAME)"
}

$results = @()
foreach ($vm in $vms) {
    $vmMem = Get-WmiObject -Namespace 'root\virtualization\v2' -Class Msvm_Memory | Where-Object { $_.Name.Contains($vm.Name) }
    $vmMemStg = Get-WmiObject -Namespace 'root\virtualization\v2' -Class Msvm_MemorySettingData | Where-Object { $_.__PATH.Contains($vm.Name) }
    
    if ($vm.EnabledState -ne 2) {
        $results += [PSCustomObject]@{
            "VM Name" = $vm.ElementName
            "VM Memory" = if ($vmMemStg -is [Array]) { "$($vmMemStg[0].VirtualQuantity) MB" } else { "$($vmMemStg.VirtualQuantity) MB" }
            "Virtual NUMA Node" = "Not applicable - VM is powered off"
            "Physical NUMA Node" = "N/A"
            "Physical NUMA Node Memory Remaining" = "N/A"
        }
    } else {
        if ($vmMem -is [Array]) {
            foreach ($mem in $vmMem) {
                if (!$mem.DeviceID.EndsWith("Aggregate")) {
                    $numaNode = $mem.GetRelated("Msvm_NumaNode")
                    $results += [PSCustomObject]@{
                        "VM Name" = $vm.ElementName
                        "VM Memory" = "$($mem.NumberOfBlocks) MB"
                        "Virtual NUMA Node" = $mem.DeviceID.Split("\")[1]
                        "Physical NUMA Node" = if ($numaNode) { $numaNode.NodeId.Split("\")[1] } else { "Multi" }
                        "Physical NUMA Node Memory Remaining" = if ($numaNode) { "$($numaNode.CurrentlyConsumableMemoryBlocks) MB" } else { "N/A" }
                    }
                }
            }
        } else {
            $numaNode = $vmMem.GetRelated("Msvm_NumaNode")
            $results += [PSCustomObject]@{
                "VM Name" = $vm.ElementName
                "VM Memory" = if ($numaNode) { "$($vmMem.NumberOfBlocks) MB" } else { if ($vmMemStg.DynamicMemoryEnabled) { "Dynamic" } else { "Multi" } }
                "Virtual NUMA Node" = if ($numaNode) { $vmMem.DeviceID.Split("\")[1] } else { "N/A" }
                "Physical NUMA Node" = if ($numaNode) { $numaNode.NodeId.Split("\")[1] } else { "N/A" }
                "Physical NUMA Node Memory Remaining" = if ($numaNode) { "$($numaNode.CurrentlyConsumableMemoryBlocks) MB" } else { "N/A" }
            }
        }
    }
}

$results
```

Here's an example of the output from the script:

```output
VM Name                             : vm01  
VM Memory                           : 6828 MB,       6826 MB,        6826 MB 
Virtual NUMA Node                   : 0,             1,              2  
Physical NUMA Node                  : 3,             1,              2  
Physical NUMA Node Memory Remaining : 1836 MB,       1840 MB,        1840 MB 
```

Other virtual machines running on the host dictate which physical NUMA nodes best provide memory. When you enable NUMA spanning, Hyper-V might choose NUMA distributions that don't seem to match the physical host well, but this configuration makes sense in the context of the other running virtual machines.

## Determine performance of NUMA spanning on VMs

Hyper-V provides performance counters that you can use to judge how well a virtual machine's virtual NUMA nodes align with the host's physical NUMA nodes. You can retrieve performance counters information through Performance Monitor or the [Get-Counter](/powershell/module/microsoft.powershell.diagnostics/get-counter) PowerShell cmdlet.

You can view the following counters from the `Hyper-V VM Vid Partition` performance object:

- **Remote Physical Pages**: shows how many of a virtual machine's memory pages the host allocates on a nonaligned physical NUMA node.

- **Physical Pages Allocated**: shows how many memory pages a virtual machine has in total.

If the **Remote Physical Pages** counter is zero, the virtual machine is perfectly aligned. If it's not zero, compare it with the total number of memory pages. The **Physical Pages Allocated** counter enables you to determine the percentage of the virtual machine's memory that spans more than one physical NUMA node.

The following PowerShell command retrieves all the `Hyper-V VM Vid Partition` performance counters and shows the values for VMs and the Hyper-V host:

```powershell
Get-Counter "\Hyper-V VM VID Partition(*)\*" 
```

Here's an example of the output from the command:

```output
Timestamp                 CounterSamples
---------                 --------------
15/07/2025 00:00:00       \\host01\hyper-v vm vid partition(vm01)\remote physical pages :
                          0

                          \\host01\hyper-v vm vid partition(vm01)\preferred numa node index :
                          1

                          \\host01\hyper-v vm vid partition(vm01)\physical pages allocated :
                          526344

                          \\host01\hyper-v vm vid partition(_total)\remote physical pages :
                          0

                          \\host01\hyper-v vm vid partition(_total)\preferred numa node index :
                          1

                          \\host01\hyper-v vm vid partition(_total)\physical pages allocated :
                          526344
```

If a VM spans NUMA nodes and it's already performing well, the workload might not depend heavily on memory access latency, or your host might provide remote memory access latencies that are low enough that the misalignment doesn't cause performance problems.

If the workload isn't performing optimally, and performance counters indicate the host allocates a large proportion of the virtual machine's memory on misaligned physical NUMA nodes, consider the following actions:

- Ensure that the configured NUMA topology of the virtual machine aligns well with the Hyper-V host. Try [resetting the virtual machine's NUMA settings to their default values](#configure-virtual-numa-topology-on-a-vm).

- If you have multiple Hyper-V hosts, consider moving the virtual machine to another host. The distribution of available memory across NUMA nodes on the current host might not be ideal with the memory that the host allocates for the virtual machine.

- Consider [disabling NUMA spanning](#configure-numa-spanning-on-a-hyper-v-host) on the Hyper-V host.

## Related content

- [NUMA in Hyper-V](non-uniform-memory-access.md)
- [Hyper-V PowerShell module](/powershell/module/hyper-v/)
