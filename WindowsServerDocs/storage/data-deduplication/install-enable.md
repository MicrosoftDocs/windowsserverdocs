# Installing and Enabling Data Deduplication
> Applies to Windows Server 2016

This document explains how to install the [Data Deduplication](overview.md) (commonly referred to as Dedup) feature, evaluate workloads for deduplication, and enable Dedup on targeted volumes.

## <a id="install-dedup"></a>Install the Data Deduplication feature
### <a id="install-dedup-via-server-manager"></a>To install the Data Deduplication feature on the server using Server Manager
1. From the Add Roles and Feature Wizard, under Server Roles, select the **Data Deduplication** check box.
![Install Dedup via Server Manager: Select Dedup from Server Roles](media/install-dedup-via-server-manager-1.png)
2. Click **Next** until the **Install** button is active, and then click **Install**.
![Install Dedup via Server Manager: Click Install](media/install-dedup-via-server-manager-2.png) 

### <a id="install-dedup-via-powershell"></a>To install the Data Deduplication feature on the server using PowerShell
#### On Full and Core versions of Windows Server
1. Run the following PowerShell command as an administrator:  
`Install-WindowsFeature -Name FS-Data-Deduplication`

#### <a id="install-dedup-on-nano-server"></a>On Nano Server
1. Create a Nano Server installation with the 'Storage' installed per the [Getting Started with Nano Server](../../compute/nano-server/getting-started-with-nano-server.md#BKMK_CreateImage) guide.
2. From a Windows PC with the [Remote Server Administration Tools](https://www.microsoft.com/en-us/download/details.aspx?id=45520) (RSAT) installed (or from a Full or Core Windows Server), install the Data Deduplication with an explicit reference to the Nano Server instance (replace 'MyNanoServer' with the real name of the Nano Server instance):  
`Install-WindowsFeature -ComputerName MyNanoServer -Name FS-Data-Deduplication`  
&nbsp;  
**-- OR --**  
&nbsp;  
Remote into the Nano Server instance with PowerShell remoting and using dism to install Dedup:  
`Enter-PSSession -ComputerName MyNanoServer`  
`dism /online /enable-feature /featurename:dedup-core /all`

## <a id="enable-dedup"></a>Enable Data Deduplication
### <a id="enable-dedup-candidate-workloads"></a>Determine which workloads are candidates for Dedup
Dedup can be very effective to optimize storage and reduce the amount of disk space consumed. Before enabling Dedup, it is important that you first understand if your workload is an '**Always**' workload or a '**Sometimes**' workload. Understanding the characteristics of your workloads will help you get the maximum optimization and performance out of your storage. 

* '**Always**' workloads are workloads that have been proven to both have datasets which benefit highly from Dedup and resource consumption patterns which are compatible with Dedup's post-processing model. Always enable Dedup on the following workloads:
	* General purpose file servers (GPFS) serving shares like team shares, user home folders, Work Folders, and software development shares.
	* Virtualized Desktop Infrastructure (VDI) servers
	* Virtualized Backup Applications, such as [Microsoft Data Protection Manager (DPM)](https://technet.microsoft.com/en-us/library/hh758173.aspx)
* '**Sometimes**' workloads are workloads which may sometimes benefit from enabling Dedup. Not every workload in every circumstance is a good candidate for Dedup. 'Sometimes' workloads fitness for Dedup should be evaluated before enabling Dedup. 'Sometimes' workloads includes workloads like:
	* General Purpose Hyper-V hosts
	* SQL Servers
	* Line-of-business (LOB) servers

### <a id="enable-dedup-evaluating-sometimes-workloads"></a>Evaluating 'Sometimes' workloads
In order to determine a 'Sometimes' workload's fitness for Dedup, there are several questions that should be answered.

1. **Does my workload's dataset has enough duplication within it to benefit from enabling Dedup?**  
	Before enabling Dedup for a 'Sometimes' workload, investigate how much duplication your workload's dataset has by using the Data Deduplication Savings Evaluation tool. This tool can be found under `C:\Windows\System32\DDPEval.exe` when Dedup has been installed. The Data Deduplication Savings Evaluation tool can evaluate the potential for optimization against directly connected volumes (including local disks or Cluster Shared Volumes) and mapped or unmapped network shares.  
	&nbsp;   
	Running DDPEval.exe will return the following output:  
	&nbsp;  
	`Data Deduplication Savings Evaluation Tool`  
	`Copyright 2011-2012 Microsoft Corporation.  All Rights Reserved.`    
	&nbsp;   
	`Evaluated folder: E:\Test`     
	`Processed files: 34`  
	`Processed files size: 12.03MB`  
	`Optimized files size: 4.02MB`  
	`Space savings: 8.01MB`  
	`Space savings percent: 66`  
	`Optimized files size (no compression): 11.47MB`  
	`Space savings (no compression): 571.53KB`  
	`Space savings percent (no compression): 4`  
	`Files with duplication: 2`  
	`Files excluded by policy: 20`  
	`Files excluded by error: 0`  

2. **What do my workload's IO patterns to its dataset look like? What performance do I have for my workload?**  
	Writes to a deduplicated volume always occur un-deduplicated as Dedup uses a post-processing model. Therefore, the primary thing to examine is a workload's expected read patterns to the deduplicated volume. The ideal IO patterns for workloads are sequential

	> [!Note]  
	> These concerns primarily apply to storage workloads on volumes made up of traditional rotational storage media (also known as Hard Disks drives, or HDDs). All flash storage infrastructure (also known as Solid State Disk drives, or SSDs), are less affected by random IO patterns because one of the properties of flash media is equal access time to all locations on the disk. Therefore, SSDs do not suffer from the seek issues that HDDs do.

3. **What are the resource requirements of my workload on the server?**  
Hello world

### <a id="enable-dedup-lights-on"></a>Enabling Dedup
Before enabling Dedup, first pick the [Usage Type](usage-types.md) that matches your workload:  

* Use 'General purpose file server' ('Default' in PowerShell) if deploying GPFS workloads.  
* Use 'Virtual Desktop Infrastructure (VDI) server' ('HyperV' in PowerShell) if deploying a VDI workload.
* Use 'Virtualized Backup Server' ('Backup' in PowerShell) if deploying a virtualized backup application like DPM.

#### <a id="enable-dedup-via-server-manager"></a>Using Server Manager to enable Dedup
1. Select **File and Storage Services** from the left-hand panel in Server Manager.  
![Click on File and Storage Services](media/enable-dedup-via-server-manager-1.PNG)
2. Select **Volumes** from the **File and Storage Services** pop-out menu.  
![Click on Volumes](media/enable-dedup-via-server-manager-2.png)
3. Right-click on the desired volume and select **Configure Data Deduplication...**.  
![Click on Configure Data Deduplication](media/enable-dedup-via-server-manager-3.png)
4. Select the desired **Usage Type** from the drop-down box and select **OK**.
![Select the desired Usage Type from the drop down](media/enable-dedup-via-server-manager-4.png)

> [!Note]  
> More information on excluding file extensions or folders and selecting the deduplication schedule, including why you would want to do this, can be found here: [Configuring Data Deduplication](dedup-settings).

#### <a id="enable-dedup-via-powershell"></a>Using PowerShell to enable Dedup
1. With an administrator context, run the following PowerShell command:  
`Enable-DedupVolume -Volume <Volume-Path> -UsageType <Selected-Usage-Type>`

> [!Note]  
> The Dedup PowerShell cmdlets, including `Enable-DedupVolume`, are remotable by appending `-CimSession` with a CIM Session input. This is particularly useful for running the Dedup PowerShell cmdlets remotely against a Nano Server instance. To create a new CIM Session run `New-CimSession`. More information about creating CIM Sessions can be found here: [New-CimSession](https://technet.microsoft.com/en-us/library/jj590760.aspx). 

#### <a id="enable-dedup-sometimes-considerations"></a>Special considerations for 'Sometimes' workloads

## <a id="faq"></a>Frequently Asked Questions (FAQ)