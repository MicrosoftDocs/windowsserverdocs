---
title: Nano Server Quick Start
description: "Steps to quickly deploy a basic Nano Server on physical or virtual machines"
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/05/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Nano Server Quick Start

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

Follow the steps in this section to get started quickly with a basic deployment of Nano Server using DHCP to obtain an IP address. You can run a Nano Server VHD either in a virtual machine or boot to it on a physical computer; the steps are slightly different.

Once you've tried out the basics with these quick-start steps, you can find details of creating your own custom images, package management by several methods, domain operations, and much more in [Deploy Nano Server](Deploy-Nano-Server.md).
  
**Nano Server in a virtual machine**  
  
Follow these steps to create a Nano Server VHD that will run in a virtual machine.  
  
## To quickly deploy Nano Server in a virtual machine  
  
1. Copy *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server 2016 ISO to a folder on your hard drive.  
  
2. Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`  
   >[!NOTE]  
   >You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
3. Create a VHD for the Standard edition that sets a computer name and includes the Hyper-V **guest drivers** by running the following command which will prompt you for an administrator password for the new VHD:  
  
   `New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerVM\NanoServerVM.vhd -ComputerName <computer name>` where  
  
   -   **-MediaPath <path to root of media\>** specifies a path to the root of the contents of the Windows Server 2016 ISO. For example if you have copied the contents of the ISO to d:\TP5ISO you would use that path.  
  
   -   **-BasePath** (optional) specifies a folder that will be created to copy the Nano Server WIM and packages to.  
  
   -   **-TargetPath** specifies a path, including the filename and extension, where the resulting VHD or VHDX will be created.  
  
   -   **Computer_name** specifies the computer name that the Nano Server virtual machine you are creating will have.  
  
   **Example:** `New-NanoServerImage -Edition Standard -DeploymentType Guest -MediaPath f:\ -BasePath .\Base -TargetPath .\Nano1\Nano.vhd -ComputerName Nano1`  
  
   This example creates a VHD from an ISO mounted as f:\\. When creating the VHD it will use a folder called Base in the same directory where you ran New-NanoServerImage; it will place the VHD (called Nano.vhd) in a folder called Nano1 in the folder from where the command is run. The computer name will be Nano1. The resulting VHD will contain the Standard edition of Windows Server 2016 and will be suitable for Hyper-V virtual machine deployment. If you want a Generation 1 virtual machine, create a VHD image by specifying a  **.vhd** extension for -TargetPath. For a Generation 2 virtual machine, create a VHDX image by specifying a  **.vhdx** extension for -TargetPath. You can also directly generate a WIM file by specifying a **.wim** extension for -TargetPath.  
  
   > [!NOTE]  
   > New-NanoServerImage is supported on Windows 8.1, Windows 10, Windows Server 2012 R2, and Windows Server 2016.  
  
4. In Hyper-V Manager, create a new virtual machine and use the VHD created in Step 3.  
  
5. Boot the virtual machine and in Hyper-V Manager connect to the virtual machine.  
  
6. Log on to the Recovery Console (see the "Nano Server Recovery Console" section in this guide), using the administrator and password you supplied while running the script in Step 3.  
   > [!NOTE]  
   > The Recovery Console only supports basic keyboard functions. Keyboard lights, 10-key sections, and keyboard layout switching such as caps lock and number lock are not supported.
  
7. Obtain the IP address of the Nano Server virtual machine and use Windows PowerShell remoting or other remote management tool to connect to and remotely manage the virtual machine.  
  
**Nano Server on a physical computer**  
  
You can also create a VHD that will run Nano Server on a physical computer, using the pre-installed device drivers. If your hardware requires a driver that is not already provided in order to boot or connect to a network, follow the steps in the "Adding Additional Drivers" section of this guide.  
  
## To quickly deploy Nano Server on a physical computer  
  
1.  Copy *NanoServerImageGenerator* folder from the \NanoServer folder in the Windows Server 2016 ISO to a folder on your hard drive.  
  
2.  Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder and then import the module with `Import-Module .\NanoServerImageGenerator -Verbose`  
  
>[!NOTE]  
>You might have to adjust the Windows PowerShell execution policy. `Set-ExecutionPolicy RemoteSigned` should work well.  
  
3. Create a VHD that sets a computer name and includes the OEM drivers and Hyper-V by running the following command which will prompt you for an administrator password for the new VHD:  
  
   `New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath <path to root of media> -BasePath .\Base -TargetPath .\NanoServerPhysical\NanoServer.vhd -ComputerName <computer name> -OEMDrivers -Compute -Clustering` where  
  
   -   **-MediaPath <path to root of media\>** specifies a path to the root of the contents of the Windows Server 2016 ISO. For example if you have copied the contents of the ISO to d:\TP5ISO you would use that path.  
  
   -   **BasePath** specifies a folder that will be created to copy the Nano Server WIM and packages to. (This parameter is optional.)  
  
   -   **TargetPath** specifies a path, including the filename and extension, where the resulting VHD or VHDX will be created.  
  
   -   **Computer_name** is the computer name for the Nano Server you are creating.  
  
   **Example:**`New-NanoServerImage -Edition Standard -DeploymentType Host -MediaPath F:\ -BasePath .\Base -TargetPath .\Nano1\NanoServer.vhd -ComputerName Nano-srv1 -OEMDrivers -Compute -Clustering`  
  
   This example creates a VHD from an ISO mounted as F:\\. When creating the VHD it will use a folder called Base in the same directory where you ran New-NanoServerImage; it will place the VHD in a folder called Nano1 in the folder from where the command is run. The computer name will be Nano-srv1 and will have OEM drivers installed for most common hardware and has the Hyper-V role and clustering feature enabled. The Standard Nano edition is used.  
  
4. Log in as an administrator on the physical server where you want to run the Nano Server VHD.  
  
5. Copy the VHD that this script creates to the physical computer and configure it to boot from this new VHD. To do that, follow these steps:  
  
   1.  Mount the generated VHD. In this example, it's mounted under D:\\.  
  
   2.  Run **bcdboot d:\windows**.  
  
   3.  Unmount the VHD.  
  
6. Boot the physical computer into the Nano Server VHD.  
  
7. Log on to the Recovery Console (see the "Nano Server Recovery Console" section in this guide), using the administrator and password you supplied while running the script in Step 3.
   > [!NOTE]  
   > The Recovery Console only supports basic keyboard functions. Keyboard lights, 10-key sections, and keyboard layout switching such as caps lock and number lock are not supported. 
  
8. Obtain the IP address of the Nano Server computer and use Windows PowerShell remoting or other remote management tool to connect to and remotely manage the virtual machine.  
