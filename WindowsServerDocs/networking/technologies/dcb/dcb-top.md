---
title: Data Center Bridging (DCB)
description: You can use this topic for introductory information about Data Center Bridging in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: da58f312-bd3b-4bb6-98ca-6177869dd6ad
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Data Center Bridging \(DCB\)

>Applies To: Windows Server 2016

You can use this topic for introductory information about Data Center Bridging \(DCB\).

DCB is a suite of Institute of Electrical and Electronics Engineers \(IEEE\) standards that enable Converged Fabrics in the data center, where storage, data networking, cluster Inter\-Process Communication \(IPC\), and management traffic all share the same Ethernet network infrastructure.

DCB provides hardware\-based bandwidth allocation to a specific type of network traffic, and enhances Ethernet transport reliability with the use of priority\-based flow control.

Hardware\-based bandwidth allocation is essential if traffic bypasses the operating system and is offloaded to a converged network adapter, which might support Internet Small Computer System Interface \(iSCSI\), Remote Direct Memory Access \(RDMA\) over Ethernet, or Fiber Channel over Ethernet \(FCoE\).

Priority\-based flow control is essential if the upper layer protocol, such as Fiber Channel, assumes a lossless underlying transport.

##  Important DCB functionality

Following is a list that summarizes the functionality that is provided by DCB.

1. Provides interoperability between DCB\-capable network adapters and DCB\-capable switches.

2. Provides a lossless Ethernet transport between a computer running Windows Server 2016 and its neighbor switch by turning on priority\-based flow control on the network adapter.

3. Provides the ability to allocate bandwidth to a Traffic Control \(TC\) by percentage, where the TC might consist of one or more classes of traffic that are differentiated by 802.1p traffic class \(priority\) indicators.

4. Enables server administrators or network administrators to assign an application to a particular traffic class or priority based on well-known protocols, well-known TCP/UDP port, or NetworkDirect port used by that application.

5. Provides DCB management through Windows Server 2016 Windows Management Instrumentation \(WMI\) and Windows PowerShell. For more information, see the section [Windows PowerShell Commands for DCB](#bkmk_wps) later in this topic, in addition to the following topics.
	- [System-Provided DCB Components](https://msdn.microsoft.com/windows/hardware/drivers/network/system-provided-dcb-components)
	- [NDIS QoS Requirements for Data Center Bridging](https://msdn.microsoft.com/windows/hardware/drivers/network/ndis-qos-requirements-for-data-center-bridging)

6. Provides DCB management through Windows Server 2016 Group Policy.

7. Supports the coexistence of Windows Server 2016 Quality of Service \(QoS\) solutions.

>[!NOTE]
>Before using any RDMA over Converged Ethernet \(RoCE\) version of RDMA, you must enable DCB. While not required for Internet Wide Area RDMA Protocol \(iWARP\) networks, testing has determined that all Ethernet\-based RDMA technologies work better with DCB. Because of this, you should consider using DCB for iWARP RDMA deployments. For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](../../../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).

##  Practical applications of DCB

Many organizations have large Fiber Channel \(FC\) storage area network \(SAN\) installations for storage service. FC SAN requires special network adapters on servers and FC switches in the network. These organizations typically also use Ethernet network adapters and switches.

In most cases, FC hardware is significantly more expensive to deploy than Ethernet hardware, which results in large capital expenditures. In addition, the requirement for separate Ethernet and FC SAN network adapter and switch hardware requires additional space, power, and cooling capacity in a datacenter, which results in additional, ongoing operational expenditures.

From a cost perspective, it is advantageous for many organizations to merge their FC technology with their Ethernet\-based hardware solution to provide both storage and data networking services.

### Using DCB for an Ethernet\-based converged fabric for storage and data networking

For organizations that already have a large FC SAN but want to migrate away from additional investment in the FC technology, DCB allows you to build an Ethernet based converged fabric for both storage and data networking. A DCB converged fabric can reduce the future total cost of ownership \(TCO\) and simplify management.

For hosters who have already adopted, or who plan to adopt, iSCSI as their storage solution, DCB can provide hardware\-assisted bandwidth reservation for iSCSI traffic to ensure performance isolation. And unlike other proprietary solutions, DCB is standards\-based - and therefore relatively easy to deploy and manage in a heterogeneous network environment.

A Windows Server 2016\-based implementation of DCB alleviates many of the issues that can occur when converged fabric solutions are provided by multiple original equipment manufacturers \(OEMs\).

Implementations of proprietary solutions provided by multiple OEMs might not interoperate with one another, might be difficult to manage, and will typically have different software maintenance schedules. 

By contrast, Windows Server 2016 DCB is standards\-based, and you can deploy and manage DCB in a heterogeneous network.

##  Hardware requirements

Following is a list of hardware requirements for DCB.

1. DCB\-capable Ethernet network adapter\(s\) must be installed in computers that are providing Windows Server 2016 DCB.

2. DCB\-capable hardware switches must be deployed on your network.

## Install DCB in Windows Server 2016

You can use the following sections to install DCB on a computer running Windows Server 2016.

**Administrative Credentials**

To perform these procedures, you must be a member of Administrators.

### Install DCB Using Windows PowerShell

You can use the following procedure to install DCB by using Windows PowerShell.

1. On a computer running Windows Server 2016, click **Start**, then right-click the Windows PowerShell icon. A menu appears. In the menu, click **More**, and then click **Run as administrator**. If prompted, type the credentials for an account that has Administrator privileges on the computer. Windows PowerShell opens with Administrator privileges.
2. Type the following command, and then press ENTER.

````
	Install-WindowsFeature -Name Data-Center-Bridging -IncludeManagementTools
````

### Install DCB Using Server Manager

You can use the following procedure to install DCB by using Server Manager.

>[!NOTE]
>After you perform the first step in this procedure, the **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously selected **Skip this page by default** when the Add Roles and Features Wizard was run. If the **Before You Begin** page is not displayed, skip from step 1 to step 3.

1. On DC1, in Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.
2. In **Before You Begin**, click **Next**.
3. In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.
4. In **Select destination server**, ensure that **Select a server from the server pool** is selected. In **Server Pool**, ensure that the local computer is selected. Click **Next**.
5. In **Select server roles**, click **Next**.
6. In **Select features**, in **Features**, click **Data Center Bridging**. A dialog box opens to ask if you want to add DCB required features. Click **Add Features**.
7. In **Select features**, click **Next**. 
8. 7.In **Confirm installation selections**, click **Install**. The **Installation progress** page displays status during the installation process. After the message appears stating that installation succeeded, click **Close**.

### Configure the kernel debugger to allow QoS \(Optional\)

 By default, kernel debuggers block NetQos. Regardless of the method that you used to install DCB, if you have a kernel debugger installed in the computer, you must configure the debugger to allow QoS to be enabled and configured by running the following command.

````
Set-ItemProperty HKLM:"\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" AllowFlowControlUnderDebugger -type DWORD -Value 1 -Force
````

## <a name="bkmk_wps"></a>Windows PowerShell Commands for DCB

There are DCB Windows PowerShell commands for both Windows Server 2016 and Windows Server 2012 R2. You can use all of the commands for Windows Server 2012 R2 in Windows Server 2016.

### Windows Server 2016 Windows PowerShell Commands for DCB

The following topic for Windows Server 2016 provides Windows PowerShell cmdlet descriptions and syntax for all Data Center Bridging \(DCB\) Quality of Service \(QoS\)\-specific cmdlets. It lists the cmdlets in alphabetical order based on the verb at the beginning of the cmdlet.

- [DcbQoS Module](https://technet.microsoft.com/itpro/powershell/windows/dcbqos/dcbqos)

### Windows Server 2012 R2 Windows PowerShell Commands for DCB

The following topic for Windows Server 2012 R2 provides Windows PowerShell cmdlet descriptions and syntax for all Data Center Bridging \(DCB\) Quality of Service \(QoS\)\-specific cmdlets. It lists the cmdlets in alphabetical order based on the verb at the beginning of the cmdlet.

- [Data Center Bridging (DCB) Quality of Service (QoS) Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/hh967440.aspx)
