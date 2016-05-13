---
title: Disaggregated solution using Storage Spaces Direct in Windows Server 2016
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 6fa1d570-cda8-4bb0-96b7-bd946f65fcac
---
# Disaggregated solution using Storage Spaces Direct in Windows Server 2016
Windows Server 2016 Technical Preview introduces Storage Spaces Direct, which enables building highly available (HA) storage systems with local storage. This is a significant step forward in Microsoft Windows Server software-defined storage (SDS) as it simplifies the deployment and management of SDS systems and also unlocks use of new classes of disk devices, such as SATA and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.

Windows Server 2016 provides a hyper-converged solution by allowing the same set of servers to provide SDS, through Storage Spaces Direct (S2D), and serve as the hosts for virtual machines using Hyper-V. The same

## How to Use this Guide ##


This document provides both an introductory overview and specific standalone examples of how to deploy a Disaggregated Solution with Storage Spaces Direct.

Before taking any action, it is recommended that you do a quick read through of this document to familiarize yourself with the overall approach, to get a sense for the important **Notes** associated with some steps, and to acquaint yourself with the additional supporting resources and documentation.

## Disaggregated Solution with Software Defined Storage Overview  ##

The **disaggregated** deployment scenario has the Hyper\-V servers \(compute component\) in a separate cluster from the Storage Spaces Direct servers \(storage component\).  Virtual machines are configured to store their files on the Scale\-Out File Server which is accessed through the network using the SMB3 protocol. This allows for scaling Hyper\-V clusters \(compute\) and Scale Out File Server cluster \(storage\) independently. For example, the compute nodes are nearing capacity for the number of VMs that they can host but the storage has excess capacity \(both disk and IOPS\), more compute nodes can be added without adding additional storage nodes.

![](media/StorageSpacesDirectDisaggregated.png)

**FIGURE : Disaggregated deployment of Storage Spaces Direct**

## Hardware requirements ##


We are working with our hardware partners to define and validate specific hardware configurations, including SAS HBA, SATA SSD and HDD, RDMA enabled network adapters etc. to ensure a good user experience. You should contact your hardware vendors for the solutions that they have verified are compatible for use with Storage Spaces Direct.

If you would like to evaluate Storage Spaces Direct in Windows Server 2016 Technical Preview without investing in hardware, you can use Hyper-V virtual machines, see [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx).

For more information about hardware options, see Hardware options for evaluating Storage Spaces Direct in Technical Preview 4

[!NOTE] 

Storage Spaces Direct does not support disks connected via multiple paths, and the Microsoft Multipath MPIO software stack.

## Information Gathering ##


The following information will be needed as inputs to configure provision and manage the hyper-converged system, and therefore it will speed up the process and make it easier for you if you have it on hand when you start:

-   **Server Names** – you should be familiar with your organization’s naming policies for computers, files, paths, and other resources as you will be provisioning several servers with Nano installations and each will need to have a unique server name.

-   **Domain name –** you will be joining computers to your domain, and you will need to specify the domain name. It would be good to familiarize with your internal domain naming and domain joining policies.

-   **Administrator Password for the new servers:** When the Nano images are created, the command to create the images will prompt you to input the password for the local administrator account.

-   For RDMA configurations

    -   Top of Rack switch make/model

    -   Network Adapter make/model

        -   There are 2 types of RDMA protocols, note which type your RDMA adapter is (RoCEv2 or iWarp)

    -   Vlan id to be used for the 2 network interfaces used by the management OS on the hyper-converged hosts. You should be able to obtain this from your network administrator.

## Installing and configuring Hyper-Converged solution using Storage Spaces Direct with Windows Server 2016 Nano Server ##
------------------------------------------------

This section includes instructions to install and configure the components of a Hyper-Converged system using the Windows Server 2016 Technical Preview with a Nano Server configuration of the operating system. The act of deploying a Hyper-Converged system can be divided into three high level phases:

1.  [Deploy the operating system](#deploy-the-operating-system)

2.  [Configure the Network](#_Network_Configuration)

3.  [Configure Storage Spaces Direct](#_Configure_Storage_Spaces)

Figure 6 illustrates the process for building a hyper-converged solution using Windows Server 2016 Technical Preview.

ADD IMAGE

**Figure 6: Process for building a hyper-converged solution using Windows Server 2016 Technical Preview.**

You can tackle these steps a few at a time or all at once, but they do need to be completed in the order shown in Figure 6. After describing some prerequisites and terminology, we will describe each of the three phases in more detail and provides examples.

[!IMPORTANT]

This preview release should not be used in production environments.

### Prerequisites and Terminology ###

The provisioning and deployment process for a Windows Server Nano server involves specific steps that include:

-   Creating a bootable .VHDx file for each Nano server

-   Copying the bootable .VHDx files to a physical host and configuring the host to boot from the .VHDx files

-   Remotely managing the newly deployed host machines running Nano Servers





 **Image creation machine**. The instructions in this guide includes creating bootable Nano .VHDx files for each server. It’s a simple process, but you will need a system (Windows 10 or Windows Server 2012 R2 or later) where you can use PowerShell to create and temporarily store the .VHDX files that will be copied to the servers. The cmdlet modules used to create the image are imported from the Windows Server 2016 preview ISO, the instructions below will have details on this process.

**Management machine.** For the purposes of this document, the machine that has the management tools to remotely manage the Nano servers will be referred to as the Management system. The management system machine has the following requirements:



- Running Windows Server 2016 Technical Preview 5, domain joined to the same domain or fully trusted domain as the Nano systems.



- Remote Server Administration Tools (RSAT) and PowerShell modules for Hyper-V and Failover Clustering. RSAT tools and PowerShell modules are available on Windows Server 2016 and can be installed without installing other features.



- Management system can be run inside of a Virtual Machine or on a physical machine.



- Requires network connectivity to the Nano servers

**Host machines.** In the example below, the expectation is that you start with physical machines that are booted to a Windows Server operating system (full or core). We’ll be copying the VHDs files to the Host machines and then re-booting into Nano operation system that was created in the VHDx files. Booting from a VHDx file is the method of deployment being outlined in this guide. Other methods of deploying VHDx boot files can also be used.

[!NOTE]
 The Image creation machine and the Management machine (defined below) can be the same machine. The critical factor is that **the machine from which you are managing must be of the same version (or higher) as the Nano server that are being managed.** For Windows Server 2016 Technical Preview 5 evaluation **we recommend that your Management machine be running WS2016 TP5 so you will be able to efficiently manage the Nano Servers (which are also running TP5).**

### Deploy the operating system

Deploying the operating system includes the following tasks:

1.  [Acquire an ISO image of Windows Server 2016 TP5](#acquire-an-iso-image-of-windows-server-2016-tp5-datacenter)

2.  [Use the ISO and PowerShell to create the new Nano Server Images](#use-the-iso-and-powershell-to-create-the-new-nano-server-images)

3.  [Copy the new Nano Server images to the Host machines](#_Copy_the_new)

4.  [Reboot into the new Nano Server image](#reboot-into-the-new-nano-server-image)

5.  [Connecting to and managing the Nano Servers from the Management system machine](#connecting-to-and-managing-the-nano-servers-from-the-management-system-machine)

ADD IMAGE

Complete the steps below to create and deploy the Nano Server as the operating system on your Host machines in a Hyper-Converged system. 

[!NOTE]

The [“Getting Started with Nano Server”](https://technet.microsoft.com/library/mt126167.aspx) guide has many more examples and detailed explanations of how to deploy and manage a Nano server. The instructions below are solely intended to illustrate one of many possible deployments; you need to find an approach that fits your organization’s needs and situation.

#### Acquire an ISO image of Windows Server 2016 TP5 Datacenter

#### Download a copy Datacenter ISO from &lt;link to Technet&gt; to your Image creation machine and note the path.

#### Use the ISO and PowerShell to Create the new Nano Server Images

There are other methods do deploy Nano, but in the case of this example we’ll provide a set of steps below. If you want to learn more about creating and managing different kinds of Nano deployments or images, see the [“Getting Started with Nano Server”](https://technet.microsoft.com/library/mt126167.aspx) guide, starting in the section “To quickly deploy Nano Server on a physical server”.

[!NOTE]

If your deployment isn’t using a RoCEv2 RDMA adapter, then you can remove the “-Packages Microsoft-NanoServer-DCB-Package” parameter in the PowerShell commandlet string below. Our example hardware for this guide does use RoCEv2 RDMA adapters and Data Center Bridging, so the DCB package is included in the example.

[!NOTE]

If you are going to manage the servers with System Center, add the following items in the “-Packages” section of the “New-NanoServerImage” command:

	Microsoft-NanoServer-SCVMM-Package
	Microsoft-NanoServer-SCVMM-Compute-Package

[!NOTE]

If you have drivers that are recommended by your hardware vendor, it is simplest to inject the network drivers into the image during the “New-NanoServerImage” step below. If you don’t, you may be able to use the in-box drivers using the –OEMDrivers parameter in the “New-NanoServerImage” command, and then update the drivers using Windows Update after deployment. It is important to have the drivers that your hardware vender recommends, so that the networks provide the best reliability and performance possible.

1.  On the **Image creation machine**, mount the Windows Server Technical Preview .ISO. To mount the ISO, in File Explorer select and right click on the ISO, then choose **Mount**. Once the mounted drive is opened, navigate to the \\*NanoServer\\NanoServerImageGenerator* directory and **copy** the contents to a directory to **your desired working folder** on your **Image creation machine** where you want to create and store your new Nano Server Images.

    In this example, the NanoServerImageGenerator directory will be copied to:

    	C:\\NanoBuild\\NanoBuildScripts

2.  Start Windows PowerShell **as an administrator**, change directory **your desired working folder** where you copied the “NanoServerImageGenerator” contents to, and **run the following command** to import the Nano Server Image Generator PowerShell module. This module will enable you to create the new Nano Server images.

	 	Import-Module .\\NanoServerImageGenerator –Verbose

	You should see something like this:

ADD IMAGE

1.  **Copy network drivers** to a directory and note the path. The example in the next step will use

    c:\\WS2016TP5\_Drivers

2.  **Before using the following PowerShell commands to create the new Nano Server images please read the following section to get an overview of the entire task**

	 In this step, you will **create a unique image for each Host machine**. We need 4 images; one for each physical host in the HyperConverged setup.

 	**Creating each Nano Server image can take several minutes** depending on the size of the drivers and other packages being included. It is not unusual for a large image to take 30 minutes to complete the creation process.

-   **Create the images one at a time**. Because of possible file collision, we recommend creating the images one at a time.

-   **You will be prompted to input a password for the Administrator** accounts of your new Nano Servers. **Type carefully and note your password for later use.** You will use these passwords later to log into the new Nano Servers

<!-- -->

-   **You will need the following information (at a minimum)**

    -   **MediaPath:** Specifies the path to the mounted Windows Server Preview ISO. It will usually be something like D:\\

    -   **TargetPath:** Specifies the path where the resulting .VHDx file will be located. NOTE: this path needs to pre-exist before running the new-NanaServerImage cmdlet.

    -   **ComputerName:** Specifies the name that the Nano server will use and be accessed by.

    -   **Domain name**: Specifies the fully qualified name to the domain that your server will join.

    -   **DriversPath** – folder location where the expanded drivers that you want to inject to the image are maintained

    -   **Other options**: If you want a richer understanding of the all the input parameters associated with New-NanoServerImage you can learn more from the “Getting Started with Nano Server” guide.

        New-NanoServerImage -MediaPath &lt;MediaPath&gt; -TargetPath &lt;TargetPath&gt; -ComputerName &lt;ComputerName&gt; -Compute -Storage -Clustering -DomainName &lt;DomainName -OEMDrivers -DeploymentType Host -Edition Datacenter -EnableRemoteManagementPort -ReuseDomainNode -DriversPath &lt;DriversPath&gt; -Packages Microsoft-NanoServer-DCB-Package

The following is an example of how you can execute the same thing in a script:

    //Example definition of variable names and values
    
    $myNanoServerName = "myComputer-1"
    
    $myNanoImagePath = ".\\Nano\\NanoServerPhysical"
    
    $myNanoServerVHDXname = "myComputer=1.VHDX"
    
    $myDomainFQDN = "corp.contoso.com"
    
    $MediaPath = "d:\\"
    
    $myDriversPath = "C:\\WS2016TP5\_Drivers"
 
 	New-NanoServerImage -MediaPath d:\\ -TargetPath "$myNanoImagePath\\$myNanoServerVHDXname" -ComputerName $myNanoServerName -Compute -Storage -Clustering -DomainName $myDomainFQDN -OEMDrivers -DeploymentType Host -Edition Datacenter -EnableRemoteManagementPort -ReuseDomainNode -DriversPath $myDriversPath -Packages Microsoft-NanoServer-DCB-Package

When you complete this task, you should have 1 VHDx file for each of the four hyper-converged systems that you are provisioning

#### Copy the new Nano Server images to the Host machines

The tasks in this section assume that the servers that will be used for the hyper-converged system (Host Machines) are booted into a Windows Server operating system and accessible to the network.

1.  **Log in as an Administrator** on the **Host machines** that will be the nodes of the hyper-converged system.

2.  **Copy the VHDX files that you created earlier** to each respective Host machine and **configure each Host machine to boot from the new VHDX** using the following steps:

    -   **Mount the VHDx**. If you are using Windows Explorer, the mount is accomplished by right clicking on the VHDX file and “**mount**”. **Note:** In this example, it is mounted under D:\\

    -   **Open a PowerShell console with Administrator privilages.**

    -   **Change the prompt to the “Windows” directory of the mounted VHD:** In this example the command would be:

> cd d:\\windows

-   **Enable booting to the VHDx: **

> Bcdboot.exe d:\\windows

-   **Unmount the VHD**. If you are using Windows Explorer, the unmount is accomplished by right clicking on the drive letter in the left hand navigation pane, and selecting “**eject**”. *THIS STEP IS IMPORTANT, THE SYSTEM MAY HAVE ISSUES BOOTING IF YOU DON’T UNMOUNT THE VHDX.*

#### Reboot into the new Nano Server image

1.  **Reboot the Host machines**. They will automatically boot into the new Nano Server VHDx images.

2.  **Log into the Nano Recovery Console:** After the Host machines are booted, they will show a logon screen for the **Nano Server Recovery Console** (see the "Nano Server Recovery Console" section in this Nano guide). You will need to enter “Administrator” for the User Name and enter the password you specified earlier when creating the new Nano Server images. For the Domain field, you can leave this blank or enter the computer name of your Nano server.

3.  **Acquire the IP address of the Nano Server**: You will use these IP addresses to connect to the Nano Server in the next section, so it’s suggested to write it down or note it somewhere.

    1.  Steps to aquire the IP address in the Nano Recovery Console:

        1.  Select Networking then press **Enter**

        2.  Identify from the network adapter list the one that is being used to connect to the system to manage it. If you aren’t sure which one, look at each of them and identify the addresses.

        3.  Select your Ethernet adapter then press **Enter**

        4.  Note your IPv4 address for later use

            **Note:** While you are in the Nano Recovery Console, you may also specify static IP addresses at this time for networks if DHCP is not available.

#### Connecting to and managing the Nano Servers from the Management system machine

You will need a Management system machine that has the same build of Windows Server 2016 to manage and configure your Nano deployment.

1.  **On the Management system machine** **configure TrustedHosts**; this is a onetime configuration on the management system machine:

> Open a PowerShell console with Administrator privilages and execute the following. This will configure the trusted hosts to all hosts.
>
> Set-Item WSMan:\\localhost\\Client\\TrustedHosts "\*"

After the onetime configuration above, you will not need to repeat Set-Item. However, each time you close and reopen the PowerShell console you should establish a new remote PS Session to the Nano Server by running the commands below:

1.  Enter the PS session and use either the Nano Server name or the IP address that you acquired from the Recovery Console earlier in this doc. You will be prompted for a password after you execute this command, enter the administrator password you specified when creating the Nano VHDx.

> Enter-PSSession -ComputerName &lt;myComputerName&gt; -Credential LocalHost\\Administrator

Examples of doing the same thing in a way that is more useful in scripts, in case you need to do this more than once:

**Example 1:** using an IP address:

> $ip = "10.100.0.1"
>
> $user = "$ip\\Administrator"
>
> Enter-PSSession -ComputerName $ip -Credential $user
>
> **Example 2:** OR you can do something similar with computer name instead of IP address.

$myNanoServer1 = "myNanoServer-1"

> $user = "$myNanoServer1\\Administrator"
>
> Enter-PSSession -ComputerName $myNanoServer1 -Credential $user

#### Adding domain accounts. 

So far this guide has had you deploying and configuring individual nodes with the local administrator account &lt;ComputerName&gt;\\Administrator.

Managing a hyper-converged system, including the cluster and storage and virtualization components, often requires using a domain account that is in the Administrators group on each node.

The following steps are done from the Management System.

For each server of the hyper-converged system:

1.  Use a PowerShell console that was opened with Administrator privileges and in a PSSession issue the following command to add your domain account(s) in the Administrators local security group. See the section above for information about how to connect to the Nano systems using PSSession.

    Net localgroup Administrators &lt;Domain\\Account&gt; /add

## Network Configuration


The following assumes 2 RDMA NIC Ports (1 dual port, or 2 single port). In order to deploy Storage Spaces Direct, the Hyper-V switch must be deployed with RDMA-enabled host virtual NICs. Complete the following steps to configure the network on each server:

IMAGE

IMAGE
    [!NOTE] Skip this **Network Configuration** section, if you are testing Storage Spaces Direct inside of virtual machines. RDMA is ot available for networking inside a virtual machine.                                                                                                


#### Configure the Top of Rack (TOR) Switch

Our example configuration is using a network adapter that implements RDMA using RoCEv2. Network QoS for this type of RDMA requires that the TOR has specific capabilities set for the network ports that the NICs are connected to.

#### Enable Network Quallity of Service (Network QoS)

Network QoS is used to in this hyper-converged configuration to ensure that the Software Defined Storage system has enough bandwidth to communicate between the nodes to ensure resiliency and performance. Do the following steps from a management system using [Enter-PSSession](https://technet.microsoft.com/library/hh849707(v=wps.630).aspx) to connect and do the following to each of the servers.

1. Set a network QoS policy for SMB-Direct, which is the protocol that the software defined storage system uses.                                                                                   
                                                                                                                                                                                                      
    New-NetQosPolicy “SMB” –NetDirectPortMatchCondition 445 –PriorityValue8021Action 3                                                                                                                 
                                                                                                                                                                                                     
   The output should look something like this:                                                                                                                                                        
 
```
   Name           : SMB
   Owner          : Group Policy (Machine)
   NetworkProfile : All
   Precedence     : 127
   JobObject      :
   NetDirectPort  : 445
   PriorityValue  : 3
                                       
```
1. Turn on Flow Control for SMB                                                                                                                                                                     
                                                                                                                                                                                                      
       Enable-NetQosFlowControl –Priority 3                                                                                                                                                   
                                                                                                                                                                                                      
 1.  Disable flow control for other traffic                                                                                                                                                           
                                                                                                                                                                                                      
         Disable-NetQosFlowControl –Priority 0,1,2,4,5,6,7                                                                                                                                                  
                                                                                                                                                                                                      
 1.  Get a list of the network adapters to identify the target adapters (RDMA adapters)                                                                                                               
                                                                                                                                                                                                      
         Get-NetAdapter | FT Name,InterfaceDescription,Status,LinkSpeed                                                                                                                                     
                                                                                                                                                                                                      
     The output should look something like the following. The Mellanox ConnectX03 Pro adapters are the RDMA network adapters and are the only ones connected to a switch, in this example configuration.  
                                                                                                                                                                                                      
 \[MachineName\]: PS C:\\Users\\User\\Documents&gt; Get-NetAdapter | FT Name,InterfaceDescription,Status,LinkSpeed                                                                                    
                                                                                                                                                                                                      
 Name InterfaceDescription Status LinkSpeed                                                                                                                                                           
                                                                                                                                                                                                      
 ---- -------------------- ------ ---------                                                                                                                                                           
                                                                                                                                                                                                      
 NIC3 QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) \#46 Disconnected 0 bps                                                                                                                      
                                                                                                                                                                                                      
 Ethernet 2 Mellanox ConnectX-3 Pro Ethernet Adapter \#2 Up 10 Gbps                                                                                                                                   
                                                                                                                                                                                                      
 SLOT \# Mellanox ConnectX-3 Pro Ethernet Adapter Up 10 Gbps                                                                                                                                          
                                                                                                                                                                                                      
 NIC4 QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) \#47 Disconnected 0 bps                                                                                                                      
                                                                                                                                                                                                      
 NIC1 QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) \#44 Disconnected 0 bps                                                                                                                   
                                                                                                                                                                                                      
 NIC2 QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) \#45 Disconnected 0 bps                                                                                                                   
                                                                                                                                                                                                      
 1.  Apply network QoS policy to the target adapters. The target adapters are the RDMA adapters. Use the “Name” of the target adapters for the –InterfaceAlias in the following example               
                                                                                                                                                                                                      
 > Enable-NetAdapterQos –InterfaceAlias “&lt;adapter1&gt;”,”&lt;adapter2&gt;”                                                                                                                         
 >                                                                                                                                                                                                    
 > Using the example above, the command would look like this:                                                                                                                                         
 >                                                                                                                                                                                                    
 > Enable-NetAdapterQoS –InterfaceAlias “Ethernet 2”,”SLOT \#”                                                                                                                                        
                                                                                                                                                                                                      
 1.  Create a Traffic class and give SMB Direct 30% of the bandwidth minimum. The name of the class will be “SMB”                                                                                     
                                                                                                                                                                                                      
 > New-NetQosTrafficClass “SMB” –Priority 3 –BandwidthPercentage 30 –Algorithm ETS                                                                                                                    |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

#### Create a Hyper-V Virtual Switch with SET and RDMA vNIC

The Hyper-V virtual switch allows the physical NIC ports to be used for both the host and virtual machines and enables RDMA from the host which allows for more throughput, lower latency, and less system (CPU) impact. The physical network interfaces are teamed using the Switch Embedded Teaming (SET) feature that is new in Windows Server 2016.

Do the following steps from a management system using [Enter-PSSession](https://technet.microsoft.com/library/hh849707(v=wps.630).aspx) to connect to each of the servers.



  



1. Identify the network adapters (you will use this info in step \#2)                                                                                                                                                                          
                                                                                                                                                                                                                                                  
		Get-NetAdapter | FT Name,InterfaceDescription,Status,LinkSpeed
		[MachineName]: PS C:\Users\User\Documents> Get-NetAdapter | FT Name,InterfaceDescription,Status,LinkSpeed
	                                                                                                                                                                           
		Name  				InterfaceDescription  									Status     LinkSpeed
		----  		--------------------  ------   								  ---------
		NIC3  		QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) #46      Disconnected     0 bps
		Ethernet 	2Mellanox ConnectX-3 Pro Ethernet Adapter #2   			        Up          10 Gbps
		SLOT #		Mellanox ConnectX-3 Pro Ethernet Adapter  				        Up          10 Gbps
		NIC4  		QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) #47	   Disconnected      0 bps
		NIC1  		QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) #44  Disconnected      0 bps
		NIC2  		QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) #45  Disconnected      0 bps





1. Create the virtual switch connected to both of the physical network adapters, and enable the Switch Embedded Teaming (SET). You may notice a message that your PSSession lost connection. This is expected and your session will reconnect.  
                                                                                                                                                                                                                                                  
  		New-VMSwitch –Name SETswitch –NetAdapterName “<adapter1>”,”<adapter2>” –EnableEmbeddedTeaming $true                                                                                                                                
                                                                                                                                                                                                                                                 
    Using the Get-NetAdapter example above, the command would look like this:                                                                                                                                                                      
                                                                                                                                                                                                                                                 
  		New-VMSwitch –Name SETswitch –NetAdapterName “Ethernet 2”,”Slot \#” –EnableEmbeddedTeaming $true                                                                                                                                               
                                                                                                                                                                                                                                                  
 

1. Add host vNICs to the virtual switch. This configures a virtual NIC (vNIC) from the virtual switch that you just configured for the management OS to use.                                                                                    
                                                                                                                                                                                                                                                  
  
  		Add-VMNetworkAdapter –SwitchName SETswitch –Name SMB\_1 –managementOS                                                                                                                                                                          
                                                                                                                                                                                                                                                 
  		Add-VMNetworkAdapter –SwitchName SETswitch –Name SMB\_2 –managementOS                                                                                                                                                                          
                                                                                                                                                                                                                                                  
 

1. Configure the host vNIC to use a Vlan. They can be on the same or different VLans                                                                                                                                                            
                                                                                                                                                                                                                                                  
		Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB_1" -VlanId <vlan number> -Access -ManagementOS

		Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB_2" -VlanId <vlan number>  -Access -ManagementOS                                                                                                                                   
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                 
  

1. Verify that the VlanID is set                                                                                                                                                                                                                
                                                                                                                                                                                                                                                  
  		Get-VMNetworkAdapterVlan –ManagementOS                                                                                                                                                                                                         
                                                                                                                                                                                                                                                 
     The output should look like this:                                                                                                                                                                                                              
                                                                                                                                                                                                                                                    
  		VMName   VMNetworkAdapterName    Mode     VlanList                                                                                                                                                                                                      
                                                                                                                                                                                                                                                 
 		 ------   -------------------    ----      --------                                                                                                                                                                                                      
                                                                                                                                                                                                                                                 
  		             SMB_1             Access      13                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                 
  		             SETswitch         Untagged                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                
  		             SMB_2             Access      13                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                  
 

1. Disable and Enable each host vNIC adapter so that the Vlan is active.                                                                                                                                                                        
                                                                                                                                                                                                                                                  
  		Disable-NetAdapter “vEthernet (SMB\_1)”                                                                                                                                                                                                        
                                                                                                                                                                                                                                                 
  		Enable-NetAdapter “vEthernet (SMB\_1)”                                                                                                                                                                                                         
                                                                                                                                                                                                                                                 
  		Disable-NetAdapter “vEthernet (SMB\_2)”                                                                                                                                                                                                        
                                                                                                                                                                                                                                                 
  		Enable-NetAdapter “vEthernet (SMB\_2)”                                                                                                                                                                                                         
                                                                                                                                                                                                                                                  
 

1. Enable RDMA on the host vNIC adapters                                                                                                                                                                                                        
                                                                                                                                                                                                                                                  
  		Enable-NetAdapterRDMA “vEthernet (SMB\_1)”,”vEthernet (SMB\_2)”                                                                                                                                                                                
                                                                                                                                                                                                                                                  
   

 

1. Verify RDMA capabilities.                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                  
 		Get-SmbClientNetworkInterface                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                 
    Values should show “True” for RDMA Capable for the RDMA enabled interfaces. The following is an example where you show true for the adapters “vEthernet (SMB\_1)” and “vEthernet (SMB\_2)”.                                                    
                                                                                                                                                                                                                                                 
   ADD IMAGE                                                                                                                                                                                     

### Configure Storage Spaces Direct 

Configuring Storage Spaces Direct in Windows Server 2016 Technical Preview includes the following steps:

-   [Step 1. Run](#ptrID0EMFAC) cluster validation tool

-   [Step 2. Create a cluster](#ptrID0EWGAC)

-   [Step 3. Enable Storage Spaces Direct](#ptrID0EDJAC)

-   [Step 4. Create virtual disks](#ptrID0EQLAC)

-   [Step 5. Create or deploy Virtual Machines

The following steps are done on a management system that is the same version as the servers being configured. The following steps should NOT be done using a PSSession, but run in a Windows PowerShell session that was opened as administrator on the management system.

ADD IMAGE

#### Step 1. Run the cluster validation tool

In this step, you will run the cluster validation tool to ensure that the server nodes are configured correctly to create a cluster using Storage Spaces Direct. When cluster validation (Test-Cluster) is run before the cluster is created, it runs the tests that verify that the configuration appears suitable to successfully function as a failover cluster. The example directly below uses the “-Include” parameter, and then the specific categories of tests are specified. This ensures that the Storage Spaces Direct specific tests are included in the validation.

Use the following PowerShell command to validate a set of servers for use as a Storage Spaces Direct cluster.

	Test-Cluster –Node <MachineName1,MachineName2,MachineName3,MachineName4> –Include “Storage Spaces Direct”,Inventory,Network,”System Configuration”

#### Step 2. Create a cluster

In this step, you will create a cluster with the four nodes that you have validated for cluster creation in the preceding step using the following PowerShell cmdlet. The **–NoStorage parameter is important** to be added to the cmdlet, otherwise disks may be automatically added to the cluster and you will need to remove them before enabling Storage Spaces Direct otherwise they will not be included in the Storage Spaces Direct storage pool.

[!NOTE]
When creating the cluster, you will get a warning that states - “There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below.” You can safely ignore this warning. It’s due to no disks being available for the cluster quorum. Its recommended that a file share witness or cloud witness is configured after creating the cluster. |

[!NOTE]
 If the servers are using static IP addresses, modify the following command to reflect the static IP address by adding the following parameter and specifying the IP address:`–StaticAddress <X.X.X.X>`

	
	New-Cluster –Name <ClusterName> –Node <MachineName1,MachineName2,MachineName3,MachineName4> –NoStorage	

It is recommended that you configure a witness for the cluster, so that this four node system can withstand two nodes failing or being offline. With these systems you can use a file share as a witness, or use cloud witness. For more information about configuring a Cloud Witness, see  [Introducing Cloud Witness in Windows Server 2016](https://blogs.msdn.microsoft.com/clustering/2014/11/13/introducing-cloud-witness/).

For more information about configuring a file share witness, see [Configuring a File Share Witness on a Scale-Out File Server](https://blogs.msdn.microsoft.com/clustering/2014/03/31/configuring-a-file-share-witness-on-a-scale-out-file-server/).

#### Step 3. Clean disks used for Storage Spaces Direct

The disks intended to be used for Storage Spaces Direct need to be empty and without partitions or other data. If a disk has partitions or other data, it will not be included in the Storage Spaces Direct system. The following PowerShell can be put in a PowerShell script (.PS1) file and executed from the management system in a PowerShell (or PowerShell ISE) console open with Administrator privileges. Running this script will help identify the disks on each node that are detected to be able to be used for Storage Spaces Direct, and removes all data and partitions from those disks.

[!IMPORTANT]
``Ensure that there is no data on any of the disks of the cluster before running this set of commands.

[!NOTE]
You may skip this step if the disks have already been cleaned or verified to be without partitions.

[!NOTE]
There is one parameter that needs to be replaced in the first and last line of the script below, which is &lt;ClusterName&gt;.

    icm (Get-Cluster -Name HCNanoUSClu3 | Get-ClusterNode) {
    
        Update-StorageProviderCache
    
        Get-StoragePool |? IsPrimordial -eq $false | Set-StoragePool -IsReadOnly:$false -ErrorAction SilentlyContinue
    
        Get-StoragePool |? IsPrimordial -eq $false | Get-VirtualDisk | Remove-VirtualDisk -Confirm:$false -ErrorAction SilentlyContinue
    
        Get-StoragePool |? IsPrimordial -eq $false | Remove-StoragePool -Confirm:$false -ErrorAction SilentlyContinue
    
        Get-PhysicalDisk | Reset-PhysicalDisk -ErrorAction SilentlyContinue
    
        Get-Disk |? Number -ne $null |? IsBoot -ne $true |? IsSystem -ne $true |? PartitionStyle -ne RAW |% {
    
            $\_ | Set-Disk -isoffline:$false
    
            $\_ | Set-Disk -isreadonly:$false
    
            $\_ | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false
    
            $\_ | Set-Disk -isreadonly:$true
    
            $\_ | Set-Disk -isoffline:$true
    
        }
    
        Get-Disk |? Number -ne $null |? IsBoot -ne $true |? IsSystem -ne $true |? PartitionStyle -eq RAW | Group -NoElement -Property FriendlyName
    
    } | Sort -Property PsComputerName,Count 

The output from this script will look similar to the following. The **Count** is the number of disks with that name per cluster node (PSComputerName):

ADD IMAGE

#### Step 4. Enable Storage Spaces Direct

After creating the cluster, use the Enable-ClusterStorageSpacesDirect PowerShell cmdlet, which will put the storage system into the Storage Spaces Direct mode and do the following automatically:

-   **Create a Pool:** Creates a single large Pool that has a name like “S2D on Cluster1”.

-   **Configures S2D Cache:** If there is more than one media type available for S2D use, it will configure the most performant as cache devices (read and write in most cases)

-   **Tiers:** Creates 2 tiers as default tiers. One is called “Capacity” and the other called “Performance”. The cmdlet analyzes the devices and configures each tier with the mix of device types and resiliency.

##### Command to enable Storage Spaces Direct

From the Management system, in a PowerShell command windows opened with Administrator privileges, initiate the following command. The cluster name is the name of the cluster that you created in the previous steps.

	Enable-ClusterStorageSpacesDirect –CimSession <ClusterName>

When this command is finished executing, which may take several minutes, the system will be ready for virtual disks to be created.

#### Step 5. Create virtual disks

When Storage Spaces Direct was enabled, it created a single pool using all the disks and named the pool something similar to “S2D on Cluster1”, with the name of the cluster that is on specified in the name.

The following PowerShell command creates a virtual disk with both mirror and parity resiliency on storage pool:

 [!NOTE]                                                                                                                                                                                                                                                                                                                                                                                                                                                

Technical Preview 4 introduced “Multi-Resiliency Virtual Disks”, which allows one virtual disk to include two different resiliency types. For instance, the example below sets the virtual disk to have 3-way mirror *and* parity. This allows for optimizing writes to the mirror for performance and in the background converting to parity when needed to optimize physical disk usage. To identify the tiers on the system you can use the **Get-StorageTier** cmdlet in a PSSession to one of the cluster nodes. |

Complete the following steps from a management system without using a PSSession.

    #Get the storage tier definitions
    $pt = Get-StorageTier Performance –CimSession <clusternode>
    $ct = Get-StorageTier Capacity –CimSession <clusternode>
    #Create Volume using both tiers
    New-Volume -StoragePoolFriendlyName “S2D*” -FriendlyName <VirtualDiskName> -FileSystem CSVFS_ReFS -StorageTiers $pt,$ct -StorageTierSizes <Size of performance tier in size units, example: 100GB>, <Size of capacity tier in size units, example: 800GB> –CimSession <clusternode>


The following PowerShell command creates a virtual disk with mirror resiliency only:

   		#Get the storage tier definition
    	$pt = Get-StorageTier Performance
   		#Create Volume 
    	New-Volume -StoragePoolFriendlyName <StoragePoolName> -FriendlyName <VirtualDiskName> -FileSystem CSVFS_ReFS -StorageTiers $pt -StorageTierSizes <Size of performance tier in size units, example: 900GB>

    

The [New-Volume](https://technet.microsoft.com/library/dn454966.aspx) was introduced in Windows Server 2012 R2 and this command significantly simplifies deployments as it ties together a long list of operations that would otherwise have to be done in individual commands such as creating the virtual disk, partitioning and formatting the virtual disk, adding the virtual disk to the cluster, and converting it into CSVFS.

#### Step 6. Create or deploy virtual machines

At this point you can provision virtual machines on to the nodes of the hyper-converged S2D cluster.

The virtual machine’s files should be stored on the systems CSV namespace (example: c:\\ClusterStorage\\Volume1) just like clustered VMs on failover clusters.

You may use in-box tools or other tools to manage the storage and virtual machines, including System Center Virtual Machine Manager.

## Definitions##


**Networking hardware** Storage Spaces Direct relies on a network to communicate between hosts. For production deployments, it is required to have an RDMA-capable NIC (or a pair of NIC ports).

**Storage hardware**: The storage system consisting of a minimum of four storage nodes with local storage. Each storage node can have internal disks, or disks in an external SAS connected JBOD enclosure. The disk devices can be SATA disks, NVMe disks or SAS disks.

**Software Storage Bus**: The Software Storage Bus is the Storage Spaces Direct specific software component that spans all the storage nodes and brings together the local storage in each node, so all disks are visible to the Storage Spaces layer above. For more information about Software Storage Bus, see [Storage Spaces Direct - Under the hood with the Software Storage Bus](http://blogs.technet.com/b/clausjor/archive/2015/11/19/storage-spaces-direct-under-the-hood-with-the-software-storage-bus.aspx).

**Storage Pool**: The storage pool spans local storage across all the nodes.

**Storage Spaces**: Storage Spaces (aka virtual disks) provide resiliency to disk or node failures as data copies are stored on different storage nodes.

**Resilient File System (ReFS)** ReFS provides the file system in which the Hyper-V VM files are stored. ReFS is a premier file system for virtualized deployments and includes optimizations for Storage Spaces such as error detection and automatic correction. In addition, ReFS provides accelerations for VHD(X) operations such as fixed VHD(X) creation, dynamic VHD(X) growth, and VHD(X) merge.

**Clustered Shared Volumes**: CSVFS layers above ReFS to bring all the mounted volumes into a single namespace accessible through any node.

## Storage Spaces Optimize Pool ##


Windows Server 2016 Technical Preview Storage Spaces Direct can optimize a storage pool to balance data equally across the set of physical disks that comprise the pool.

Over time, as physical disks are added or removed or as data is written or deleted, the distribution of data among the set of physical disks that comprise the pool may become uneven. In some cases, this may result in certain physical disks becoming full while other disks in the same pool have much lower consumption.

Similarly, if new storage is added to the pool, optimizing the existing data to utilize the new storage will result in better storage efficiency across the pool and, potentially, improved performance from the newly available additional physical storage throughput. Optimizing the pool is a maintenance task which is performed by the administrator.

Limitations in Windows Server 2016 Technical Preview:

-   Optimize pool is supported only with Simple or Mirror Spaces; Parity Spaces are not supported in Windows Server 2016 Technical Preview.

-   There may be cases in Windows Server 2016 Technical Preview where the rebalance operation does not complete. If the rebalance job has stopped making progress, then it is likely that the job is stuck. You can check the status of the optimize job using the command described above. To resolve this condition, run the following command: Get-VirtualDisk | Repair-VirtualDisk.

You can optimize a storage pool with the following command:

    Optimize-StoragePool &lt;PoolName&gt;

The output of the Optimize-StoragePool command include a progress bar that measures the progress of the re-balance operation

You can monitor the progress of the optimize job with the following command:

    Get-StorageJob | ? Name –eq Optimize

## See Also ##


[Enabling Private Cloud Storage Using Servers with Local Disks](http://channel9.msdn.com/Events/Ignite/2015/BRK3474) (video)

[Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx) (blog)

