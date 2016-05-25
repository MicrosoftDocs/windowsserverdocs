---
title: Supported Linux and FreeBSD virtual machines for Hyper-V on Windows
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 990ff94a-30fb-434b-b4a2-3804a5245ba6
author: cwatsonmsft
---
# Supported Linux and FreeBSD virtual machines for Hyper-V on Windows
Hyper\-V supports both emulated and Hyper\-V\-specific devices for Linux and FreeBSD virtual machines. When running with emulated devices, no additional software is required to be installed. However emulated devices do not provide high performance and cannot leverage the rich virtual machine management infrastructure that the Hyper\-V technology offers. In order to make full use of all benefits that Hyper\-V provides, it is best to use Hyper\-V\-specific devices for Linux and FreeBSD. The collection of drivers that are required to run Hyper\-V\-specific devices are known as Linux Integration Services \(LIS\) or FreeBSD Integration Services \(BIS\).  
  
LIS has been added to the Linux kernel and is updated for new releases. But Linux distributions based on older kernels may not have the latest enhancements or fixes. Microsoft provides a download containing installable LIS drivers for some Linux installations based on these older kernels. Because distribution vendors include versions of Linux Integration Services, it is best to install the latest downloadable version of LIS, if applicable, for your installation.  
  
For other Linux distributions LIS changes are regularly integrated into the operating system kernel and applications so no separate download or installation is required.  
  
For older FreeBSD releases \(before 10.0\), Microsoft provides ports that contain the installable BIS drivers and corresponding daemons for FreeBSD virtual machines. For newer FreeBSD releases, BIS is built in to the FreeBSD operating system, and no separate download or installation is required except for a KVP ports download that is needed for FreeBSD 10.0.  
  
> [!TIP]  
> -   Download [Windows Server 2016 Technical Prevew](https://www.microsoft.com/evalcenter/evaluate-windows-server-technical-preview) from the Evaluation Center.  
> -   Download  [Microsoft Hyper-V  Server 2016 Technical Prevew](https://www.microsoft.com/evalcenter/evaluate-hyper-v-server-technical-preview) from the Evaluation Center.  
  
The goal of this content is to provide information that helps facilitate your Linux or FreeBSD deployment on Hyper\-V. Specific details include:  
  
-   Linux distributions or FreeBSD releases that require the download and installation of LIS or BIS drivers.  
  
-   Linux distributions or FreeBSD releases that contain built\-in LIS or BIS drivers.  
  
-   Feature distribution maps that indicate the features in major Linux distributions or FreeBSD releases.  
  
-   Known issues and workarounds for each distribution or release.  
  
-   Feature description for each LIS or BIS feature.  
  
**Want to make a suggestion about features and functionality?** Is there something we could do better?  You can use the [Windows Server User Voice](https://windowsserver.uservoice.com/forums/295062-linux-support) site to suggest new features and capabilities for Linux and FreeBSD Virtual Machines on Hyper\-V, and to see what other people  are saying.  
  
## In this section:  
  
-   [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](../Topic/Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Debian virtual machines on Hyper-V](../Topic/Supported-Debian-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Oracle Linux virtual machines on Hyper-V](../Topic/Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported SUSE virtual machines on Hyper-V](../Topic/Supported-SUSE-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Ubuntu virtual machines on Hyper-V](../Topic/Supported-Ubuntu-virtual-machines-on-Hyper-V.md)  
  
-   [Supported FreeBSD virtual machines on Hyper-V](../Topic/Supported-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](../Topic/Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Best Practices for running Linux on Hyper-V](../Topic/Best-Practices-for-running-Linux-on-Hyper-V.md)  
  
-   [Best practices for running FreeBSD on Hyper-V](../Topic/Best-practices-for-running-FreeBSD-on-Hyper-V.md)  
  
