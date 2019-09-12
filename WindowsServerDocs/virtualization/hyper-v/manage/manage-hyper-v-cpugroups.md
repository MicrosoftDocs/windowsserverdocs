---
title: Virtual Machine Resource Controls
description: Using VM CPU Groups
keywords: windows 10, hyper-v
author: allenma
ms.date: 06/18/2018
ms.topic: article
ms.prod: windows-10-hyperv
ms.service: windows-10-hyperv
ms.assetid: cc7bb88e-ae75-4a54-9fb4-fc7c14964d67
---

>Applies To: Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

# Virtual Machine Resource Controls

This article describes Hyper-V resource and isolation controls for virtual machines.  These capabilities, which we'll refer to as Virtual Machine CPU Groups, or just “CPU groups”, were introduced in Windows Server 2016.  CPU groups allow Hyper-V administrators to better manage and allocate the host's CPU resources across guest virtual machines.  Using CPU groups, Hyper-V administrators can:

* Create groups of virtual machines, with each group having different allocations of the virtualization host's total CPU resources, shared across the entire group. This allows the host administrator to implement classes of service for different types of VMs.

* Set CPU resource limits to specific groups. This “group cap” sets the upper bound for host CPU resources that the entire group may consume, effectively enforcing the desired class of service for that group.

* Constrain a CPU group to run only on a specific set of the host system's processors. This can be used to isolate VMs belonging to different CPU groups from each other.

## Managing CPU Groups

CPU groups are managed through the Hyper-V Host Compute Service, or HCS. A great description of the HCS, its genesis, links to the HCS APIs, and more is available on the Microsoft Virtualization team's blog in the posting [Introducing the Host Compute Service (HCS)](https://blogs.technet.microsoft.com/virtualization/2017/01/27/introducing-the-host-compute-service-hcs/).

>[!NOTE] 
>Only the HCS may be used to create and manage CPU groups; the Hyper-V Manager applet, WMI and PowerShell management interfaces don't support CPU groups.

Microsoft provides a command line utility, cpugroups.exe, on the [Microsoft Download Center](https://go.microsoft.com/fwlink/?linkid=865968) which uses the HCS interface to manage CPU groups.  This utility can also display the CPU topology of a host.

## How CPU Groups Work

Allocation of host compute resources across CPU groups is enforced by the Hyper-V hypervisor, using a computed CPU group cap. The CPU group cap is a fraction of the total CPU capacity for a CPU group. The value of the group cap depends on the group class, or priority level assigned. The computed group cap can be thought of as “a number of LP's worth of CPU time”. This group budget is shared, so if only a single VM were active, it could use the entire group's CPU allocation for itself.

The CPU group cap is calculated as G = *n* x *C*, where:

    *G* is the amount of host LP we'd like to assign to the group
    *n* is the total number of logical processors (LPs) in the group
    *C* is the maximum CPU allocation — that is, the class of service desired for the group, expressed as a percentage of the system's total compute capacity

For example, consider a CPU group configured with 4 logical processors (LPs), and a cap of 50%.

    G = n * C
    G = 4 * 50%
    G = 2 LP's worth of CPU time for the entire group

In this example, the CPU group G is allocated 2 LP's worth of CPU time.  

Note that the group cap applies regardless of the number of virtual machines or virtual processors bound to the group, and regardless of the state  (e.g., shutdown or started) of the virtual machines assigned to the CPU group. Therefore, each VM bound to the same CPU group will receive a fraction of the group's total CPU allocation, and this will change with the number of VMs bound to the CPU group. Therefore, as VMs are bound or unbound VMs from a CPU group, the overall CPU group cap must be readjusted and set to maintain the resulting per-VM cap desired. The VM host administrator or virtualization management software layer is responsible for managing group caps as necessary to achieve the desired per-VM CPU resource allocation.

## Example Classes of Service

Let's look at some simple examples. To start with, assume the Hyper-V host administrator would like to support two tiers of service for guest VMs:

1. A low-end “C” tier. We'll give this tier 10% of the entire host's compute resources.

1. A mid-range “B” tier. This tier is allocated 50% of the entire host's compute resources.

At this point in our example we'll assert that no other CPU resource controls are in use, such as individual VM caps, weights, and reserves.
However, individual VM caps are important, as we'll see a bit later.

For simplicity's sake, let's assume each VM has 1 VP, and that our host has 8 LPs. We'll start with an empty host.

To create the "B" tier, the host adminstartor sets the group cap to 50%:

    G = n * C
    G = 8 * 50%
    G = 4 LP's worth of CPU time for the entire group

The host administrator adds a single “B” tier VM.
At this point, our “B” tier VM can use at most 50% worth of the host's CPU, or the equivalent of 4 LPs in our example system.

Now, the admin adds a second “Tier B” VM. The CPU group's allocation—is divided evenly among all the VMs. We've got a total of 2 VMs in Group B, so each VM now gets half of Group B's total of 50%, 25% each, or the equivalent of 2 LPs worth of compute time.

## Setting CPU Caps on Individual VMs

In addition to the group cap, each VM can also have an individual “VM cap”. Per-VM CPU resource controls, including a CPU cap, weight, and reserve, have been a part of Hyper-V since its introduction.
When combined with a group cap, a VM cap specifies the maximum amount of CPU that each VP can get, even if the group has CPU resources available.

For example, the host administrator might want to place a 10% VM cap on “C” VMs.
That way, even if most “C” VPs are idle, each VP could never get more than 10%.
Without a VM cap, “C” VMs could opportunistically achieve performance beyond levels allowed by their tier.

## Isolating VM Groups to Specific Host Processors

Hyper-V host administrators may also want the ability to dedicate compute resources to a VM.
For example, imagine the administrator wanted to offer a premium “A” VM that has a class cap of 100%.
These premium VMs also require the lowest scheduling latency and jitter possible; that is, they may not be de-scheduled by any other VM.
To achieve this separation, a CPU group can also be configured with a specific LP affinity mapping.

For example, to fit an “A” VM on the host in our example, the administrator would create a new CPU group, and set the group's processor affinity to a subset of the host's LPs.
Groups B and C would be affinitized to the remaining LPs.
The administrator could create a single VM in Group A, which would then have exclusive access to all LPs in Group A, while the presumably lower tier groups B and C would share the remaining LPs.

## Segregating Root VPs from Guest VPs

By default, Hyper-V will create a root VP on each underlying physical LP.
These root VPs are strictly mapped 1:1 with the system LPs, and do not migrate — that is, each root VP will always execute on the same physical LP.
Guest VPs may be run on any available LP, and will share execution with root VPs.

However, it may be desirable to completely separate root VP activity from guest VPs.
Consider our example above where we implement a premium “A” tier VM.
To ensure our “A” VM's VPs have the lowest possible latency and “jitter”, or scheduling variation, we'd like to run them on a dedicated set of LPs and ensure the root does not run on these LPs.

This can be accomplished using a combination of the “minroot” configuration, which limits the host OS partition to running on a subset of the total system logical processors, along with one or more affinitized CPU groups.

The virtualization host can be configured to restrict the host partition to specific LPs, with one or more CPU groups affinitized to the remaining LPs.
In this manner, the root and guest partitions can run on dedicated CPU resources, and completely isolated, with no CPU sharing.

For more information about the "minroot" configuration, see [Hyper-V Host CPU Resource Management](https://docs.microsoft.com/windows-server/virtualization/hyper-v/manage/manage-hyper-v-minroot-2016).

## Using the CpuGroups Tool

Let's look at some examples of how to use the CpuGroups tool.

>[!NOTE] 
>Command line parameters for the CpuGroups tool are passed using only spaces as delimiters. No ‘/' or ‘-‘ characters should proceed the desired command line switch.

### Discovering the CPU Topology

Executing CpuGroups with the GetCpuTopology returns information about the current system, as shown below, including the LP Index, the NUMA node to which the LP belongs, the Package and Core IDs, and the ROOT VP index.

The following example shows a system with 2 CPU sockets and NUMA nodes, a total of 32 LPs, and multi threading enabled, and configured to enable Minroot with 8 root VPs, 4 from each NUMA node.
The LPs that have root VPs have a RootVpIndex >= 0; LPs with a RootVpIndex of -1 are not available to the root partition, but are still managed by the hypervisor and will run guest VPs as allowed by other configuration settings.

```console
C:\vm\tools>CpuGroups.exe GetCpuTopology

LpIndex NodeNumber PackageId CoreId RootVpIndex
------- ---------- --------- ------ -----------
      0          0         0      0           0
      1          0         0      0           1
      2          0         0      1           2
      3          0         0      1           3
      4          0         0      2          -1
      5          0         0      2          -1
      6          0         0      3          -1
      7          0         0      3          -1
      8          0         0      4          -1
      9          0         0      4          -1
     10          0         0      5          -1
     11          0         0      5          -1
     12          0         0      6          -1
     13          0         0      6          -1
     14          0         0      7          -1
     15          0         0      7          -1
     16          1         1     16           4
     17          1         1     16           5
     18          1         1     17           6
     19          1         1     17           7
     20          1         1     18          -1
     21          1         1     18          -1
     22          1         1     19          -1
     23          1         1     19          -1
     24          1         1     20          -1
     25          1         1     20          -1
     26          1         1     21          -1
     27          1         1     21          -1
     28          1         1     22          -1
     29          1         1     22          -1
     30          1         1     23          -1
     31          1         1     23          -1
```

### Example 2 – Print all CPU groups on the host

Here, we'll list all CPU groups on the current host, their GroupId, the group's CPU cap, and the indicies of LPs assigned to that group.

Note that valid CPU cap values are in the range [0, 65536], and these values express the group cap in percent (e.g., 32768 = 50%).

```console
C:\vm\tools>CpuGroups.exe GetGroups

CpuGroupId                          CpuCap  LpIndexes
------------------------------------ ------ --------
36AB08CB-3A76-4B38-992E-000000000002 32768  4,5,6,7,8,9,10,11,20,21,22,23
36AB08CB-3A76-4B38-992E-000000000003 65536  12,13,14,15
36AB08CB-3A76-4B38-992E-000000000004 65536  24,25,26,27,28,29,30,31
```

### Example 3 – Print a single CPU group

In this example, we'll query a single CPU Group using the GroupId as a filter.

```console
C:\vm\tools>CpuGroups.exe GetGroups /GroupId:36AB08CB-3A76-4B38-992E-000000000003
CpuGroupId                          CpuCap   LpIndexes
------------------------------------ ------ ----------
36AB08CB-3A76-4B38-992E-000000000003 65536  12,13,14,15
```

### Example 4 – Create a new CPU group

Here, we'll create a new CPU group, specifying the Group ID and the set of LPs to assign to the group.

```console
C:\vm\tools>CpuGroups.exe CreateGroup /GroupId:36AB08CB-3A76-4B38-992E-000000000001 /GroupAffinity:0,1,16,17
```

Now display our newly added group.

```console
C:\vm\tools>CpuGroups.exe GetGroups
CpuGroupId                          CpuCap LpIndexes
------------------------------------ ------ ---------
36AB08CB-3A76-4B38-992E-000000000001 65536 0,1,16,17
36AB08CB-3A76-4B38-992E-000000000002 32768 4,5,6,7,8,9,10,11,20,21,22,23
36AB08CB-3A76-4B38-992E-000000000003 65536 12,13,14,15
36AB08CB-3A76-4B38-992E-000000000004 65536 24,25,26,27,28,29,30,31
```

### Example 5 – Set the CPU group cap to 50%

Here, we'll set the CPU group cap to 50%.

```console
C:\vm\tools>CpuGroups.exe SetGroupProperty /GroupId:36AB08CB-3A76-4B38-992E-000000000001 /CpuCap:32768
```

Now let's confirm our setting by displaying the group we just updated.

```console
C:\vm\tools>CpuGroups.exe GetGroups /GroupId:36AB08CB-3A76-4B38-992E-000000000001

CpuGroupId                          CpuCap LpIndexes
------------------------------------ ------ ---------
36AB08CB-3A76-4B38-992E-000000000001 32768 0,1,16,17
```

### Example 6 – Print CPU group ids for all VMs on the host

```console
C:\vm\tools>CpuGroups.exe GetVmGroup

VmName                                 VmId                           CpuGroupId
------ ------------------------------------ ------------------------------------
    G2 4ABCFC2F-6C22-498C-BB38-7151CE678758 36ab08cb-3a76-4b38-992e-000000000002
    P1 973B9426-0711-4742-AD3B-D8C39D6A0DEC 36ab08cb-3a76-4b38-992e-000000000003
    P2 A593D93A-3A5F-48AB-8862-A4350E3459E8 36ab08cb-3a76-4b38-992e-000000000004
    G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200 36ab08cb-3a76-4b38-992e-000000000002
    G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC 36ab08cb-3a76-4b38-992e-000000000002
```

### Example 7 – Unbind a VM from the CPU group

To remove a VM from a CPU group, set to VM's CpuGroupId to the NULL GUID. This unbinds the VM from the CPU group.

```console
C:\vm\tools>CpuGroups.exe SetVmGroup /VmName:g1 /GroupId:00000000-0000-0000-0000-000000000000

C:\vm\tools>CpuGroups.exe GetVmGroup
VmName                                 VmId                           CpuGroupId
------ ------------------------------------ ------------------------------------
    G2 4ABCFC2F-6C22-498C-BB38-7151CE678758 36ab08cb-3a76-4b38-992e-000000000002
    P1 973B9426-0711-4742-AD3B-D8C39D6A0DEC 36ab08cb-3a76-4b38-992e-000000000003
    P2 A593D93A-3A5F-48AB-8862-A4350E3459E8 36ab08cb-3a76-4b38-992e-000000000004
    G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200 36ab08cb-3a76-4b38-992e-000000000002
    G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC 00000000-0000-0000-0000-000000000000
```

### Example 8 – Bind a VM to an existing CPU group

Here, we'll add a VM to an existing CPU group.
Note that the VM must not be bound to any existing CPU group, or setting CPU group id will fail.

```console
C:\vm\tools>CpuGroups.exe SetVmGroup /VmName:g1 /GroupId:36AB08CB-3A76-4B38-992E-000000000001
```

Now, confirm the VM G1 is in the desired CPU group.

```console
C:\vm\tools>CpuGroups.exe GetVmGroup
VmName                                 VmId                           CpuGroupId
------ ------------------------------------ ------------------------------------
    G2 4ABCFC2F-6C22-498C-BB38-7151CE678758 36ab08cb-3a76-4b38-992e-000000000002
    P1 973B9426-0711-4742-AD3B-D8C39D6A0DEC 36ab08cb-3a76-4b38-992e-000000000003
    P2 A593D93A-3A5F-48AB-8862-A4350E3459E8 36ab08cb-3a76-4b38-992e-000000000004
    G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200 36ab08cb-3a76-4b38-992e-000000000002
    G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC 36AB08CB-3A76-4B38-992E-000000000001
```

### Example 9 – Print all VMs grouped by CPU group id

```console
C:\vm\tools>CpuGroups.exe GetGroupVms
CpuGroupId                           VmName                                 VmId
------------------------------------ ------ ------------------------------------
36AB08CB-3A76-4B38-992E-000000000001     G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC
36ab08cb-3a76-4b38-992e-000000000002     G2 4ABCFC2F-6C22-498C-BB38-7151CE678758
36ab08cb-3a76-4b38-992e-000000000002     G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200
36ab08cb-3a76-4b38-992e-000000000003     P1 973B9426-0711-4742-AD3B-D8C39D6A0DEC
36ab08cb-3a76-4b38-992e-000000000004     P2 A593D93A-3A5F-48AB-8862-A4350E3459E8
```

### Example 10 – Print all VMs for a single CPU group

```console
C:\vm\tools>CpuGroups.exe GetGroupVms /GroupId:36ab08cb-3a76-4b38-992e-000000000002

CpuGroupId                           VmName                                VmId
------------------------------------ ------ ------------------------------------
36ab08cb-3a76-4b38-992e-000000000002     G2 4ABCFC2F-6C22-498C-BB38-7151CE678758
36ab08cb-3a76-4b38-992e-000000000002     G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200
```

### Example 11 – Attempting to delete a non-empty CPU Group

Only empty CPU groups—that is, CPU groups with no bound VMs—can be deleted.
Attempting to delete a non-empty CPU group will fail.

```console
C:\vm\tools>CpuGroups.exe DeleteGroup /GroupId:36ab08cb-3a76-4b38-992e-000000000001
(null)
Failed with error 0xc0350070
```

### Example 12 – Unbind the only VM from a CPU group and delete the group

In this example, we'll use several commands to examine a CPU group, remove the single VM belonging to that group, then delete the group.

First, let's enumerate the VMs in our group.

```console
C:\vm\tools>CpuGroups.exe GetGroupVms /GroupId:36AB08CB-3A76-4B38-992E-000000000001
CpuGroupId                           VmName                                VmId
------------------------------------ ------ ------------------------------------
36AB08CB-3A76-4B38-992E-000000000001     G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC
```

We see that only a single VM, named G1, belongs to this group.
Let's remove the G1 VM from our group by setting the VM's group ID to NULL.

```console
C:\vm\tools>CpuGroups.exe SetVmGroup /VmName:g1 /GroupId:00000000-0000-0000-0000-000000000000
```

And verify our change...

```console
C:\vm\tools>CpuGroups.exe GetVmGroup /VmName:g1
VmName                                 VmId                           CpuGroupId
------ ------------------------------------ ------------------------------------
    G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC 00000000-0000-0000-0000-000000000000
```

Now that the group is empty, we can safely delete it.

```console
C:\vm\tools>CpuGroups.exe DeleteGroup /GroupId:36ab08cb-3a76-4b38-992e-000000000001
```

And confirm our group is gone.

```console
C:\vm\tools>CpuGroups.exe GetGroups
CpuGroupId                          CpuCap                     LpIndexes
------------------------------------ ------ -----------------------------
36AB08CB-3A76-4B38-992E-000000000002 32768  4,5,6,7,8,9,10,11,20,21,22,23
36AB08CB-3A76-4B38-992E-000000000003 65536  12,13,14,15
36AB08CB-3A76-4B38-992E-000000000004 65536 24,25,26,27,28,29,30,31
```

### Example 13 – Bind a VM back to its original CPU group

```console
C:\vm\tools>CpuGroups.exe SetVmGroup /VmName:g1 /GroupId:36AB08CB-3A76-4B38-992E-000000000002

C:\vm\tools>CpuGroups.exe GetGroupVms
CpuGroupId VmName VmId
------------------------------------ -------------------------------- ------------------------------------
36ab08cb-3a76-4b38-992e-000000000002 G2 4ABCFC2F-6C22-498C-BB38-7151CE678758
36ab08cb-3a76-4b38-992e-000000000002 G3 B0F3FCD5-FECF-4A21-A4A2-DE4102787200
36AB08CB-3A76-4B38-992E-000000000002 G1 F699B50F-86F2-4E48-8BA5-EB06883C1FDC
36ab08cb-3a76-4b38-992e-000000000003 P1 973B9426-0711-4742-AD3B-D8C39D6A0DEC
36ab08cb-3a76-4b38-992e-000000000004 P2 A593D93A-3A5F-48AB-8862-A4350E3459E8
```
