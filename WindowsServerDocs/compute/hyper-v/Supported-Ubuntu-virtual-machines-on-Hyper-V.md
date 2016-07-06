---
title: Supported Ubuntu virtual machines on Hyper-V
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95ea5f7c-25c6-494b-8ffd-2a77f631ee94
author: cwatsonmsft
---
# Supported Ubuntu virtual machines on Hyper-V

>Applies To: Windows Server Technical Preview, Microsoft Hyper-V Server Technical Preview, Windows 10, Windows Server 2012, Windows Server 2012 R2, Windows Server 2008 R2, Hyper-V Server 2012, Hyper-V Server 2012 R2, Windows 8, Windows 8.1

Beginning with Ubuntu 12.04, loading the "linux-virtual" package installs a kernel suitable for use as a guest virtual machine. This package always depends on the latest minimal generic kernel image and headers used for virtual machines. While its use is optional, the linux-virtual kernel will load fewer drivers than a more generic image.  
  
To get full use of Hyper-V, load the appropriate linux-tools and linux-cloud-tools packages, which installs tools and daemons for use with virtual machines. When using the linux-virtual kernel, load linux-tools-virtual and linux-cloud-tools-virtual.  
  
The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.  
  
**Table legend**  
  
-   **Built in** - LIS are included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution, so don't install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.  
  
-   **√** - Feature available  
  
-   (*blank*) - Feature not available  
  
|**Feature**|**Windows Server operating system version**|**16.04**|**15.10**|**14.04**|**12.04**|  
|-|-|-|-|-|-|  
|**Availability**||Built-in|Built-in|Built-in|Built-in|  
|**[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_core)**|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**|**√**|  
|**[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Networking)**||  
|Jumbo frames|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**|**√**|  
|VLAN tagging and trunking|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**|**√**|  
|Live migration|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**|**√**|  
|Static IP Injection|2016, 2012 R2, 2012|**√** Note 1|**√** Note 1|**√** Note 1|**√** Note 1|  
|vRSS|2016, 2012 R2|**√**|**√**|**√**||  
|TCP Segmentation and Checksum Offloads|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**||  
|**[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Storage)**||  
|VHDX resize|2016, 2012 R2|**√**|**√**|**√**||  
|Virtual Fibre Channel|2016, 2012 R2|**√** Note 2|**√** Note 2|**√** Note 2||  
|Live virtual machine backup|2016, 2012 R2|**√** Note 3, 4, 5|**√** Note 3, 4, 6|**√** Note 3, 4, 5||  
|TRIM support|2016, 2012 R2|**√**|**√**|**√**||  
|SCSI WWN|2016, 2012 R2|**√**||||  
|**[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Memory)**|||  
|Configuration of MMIO gap|2016, 2012 R2|**√**|**√**|**√**|**√**|  
|Dynamic Memory - Hot Add|2016, 2012 R2, 2012|**√** Note 7, 8, 9|**√** Note 7, 8, 9|**√** Note 7, 8, 9||  
|Dynamic Memory - Ballooning|2016, 2012 R2, 2012|**√** Note 7, 8, 9|**√** Note 7, 8, 9|**√** Note 7, 8, 9||  
|Manual Memory Hot Add|2016|||||  
|**[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Video)**||  
|Hyper-V specific video device|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**||  
|**[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Misc)**||  
|Key/value pair|2016, 2012 R2, 2012, 2008 R2|**√** Note 5, 10|**√** Note 6, 10|**√** Note 5, 10|**√** Note 5, 10|  
|Non-Maskable Interrupt|2016, 2012 R2|**√**|**√**|**√**|**√**|  
|PAE Kernel Support|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|**√**|**√**|  
|File copy from host to guest|2016, 2012 R2|**√**|**√**|**√**||  
|lsvmbus command|2016, 2012 R2, 2012, 2008 R2|||||  
|Hyper-V Sockets|2016|||||  
|**[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_gen2)**||  
|Boot using UEFI|2016, 2012 R2|**√** Note 11, 12|**√** Note 11, 12|**√** Note 11, 12||  
|Secure boot|2016|**√**|**√**|**√**||  
  
## <a name="BKMK_notes"></a>Notes  
  
1.  Static IP injection may not work if **Network Manager** has been configured for a given Hyper-V-specific network adapter on the virtual machine. To ensure smooth functioning of static IP injection please ensure that Network Manager is turned off completely or has been turned off for a specific network adapter through its **ifcfg-ethX** file.  
  
2.  While using virtual fiber channel devices, ensure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fiber channel devices natively.  
  
3.  If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (`fsck`) on restore.  
  
4.  Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).  
  
5.    
   
    On long term support (LTS) releases, we recommend that you use the latest Hardware Enablement (HWE) kernel in the virtual flavor.   
      
    To install the virtual kernel on 16.04, run the following commands as root (or sudo):  
  
    ```  
    # apt-get update  
    # apt-get install --install-recommends linux-virtual-lts-xenial  
  
    ```  
      
    To install the virtual kernel on 14.04, run the following commands as root (or sudo):  
   
    ```  
    # apt-get update  
    # apt-get install --install-recommends linux-virtual-lts-wily  
  
    ```  
   
    To install the virtual kernel on 12.04, run the following commands as root (or sudo):  
   
    ```  
    # apt-get update  
    # apt-get install --install-recommends linux-generic-lts-trusty  
  
    ```  
      
    On  Ubuntu 12.04, 14.04, and 16.04 the Hyper-V daemons are in a separately installed package:  
   
    -   **VSS Snapshot daemon** - This daemon is required to create live Linux virtual machine backups.  
    -   **KVP daemon** - This daemon allows setting and querying intrinsic and extrinsic key value pairs.  
    -   **fcopy daemon** - This daemon implements a file copying service between the host and guest.  
      
    To install the Hyper-V daemons on 16.04, run the following commands as root (or sudo):  
  
    ```  
    # apt-get install --install-recommends linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial  
  
    ```  
   
    To install the Hyper-V daemons on 14.04, run the following commands as root (or sudo).  
   
    ```  
    # apt-get install --install-recommends hv-kvp-daemon-init linux-tools-virtual-lts-wily linux-cloud-tools-virtual-lts-wily  
  
    ```  
   
    To install the kvp daemon on 12.04, run the following commands as root (or sudo).  
   
    ```  
    # apt-get install --install-recommends hv-kvp-daemon-init linux-tools-lts-trusty linux-cloud-tools-generic-lts-trusty  
  
    ```  
      
    To use the new kernel and daemons, you must reboot the VM after installing.  
  
6.  On 15.10, we recommend that you use the latest kernel in the virtual flavor.   
      
    To install the virtual kernel on 15.10, run the following commands as root (or sudo):  
  
    ```  
    # apt-get update  
    # apt-get install --install-recommends linux-virtual  
      
    ```  
      
    On 15.10, the following daemons are installed from a separate package.  
   
    -   **VSS Snapshot daemon** - This daemon is required to create live Linux virtual machine backups.  
    -   **KVP daemon** - This daemon allows setting and querying intrinsic and extrinsic key value pairs.  
    -   **fcopy daemon** - This daemon implements a file copying service between the host and guest.  
   
    To install these daemons when using the run the following commands as root (or sudo):  
   
    ```  
    # apt-get update  
    # apt-get install linux-tools-virtual linux-cloud-tools-virtual  
  
    ```  
   
7.  Dynamic memory support is only available on 64-bit virtual machines.  
  
8.  Dynamic Memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:  
   
    -   Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.  
    -   Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.  
  
9. If you are using Dynamic Memory on Windows Server 2016 Technical Preview or  Windows Server 2012  operating systems, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to Hot-Add failures, and you might not see any memory increase on a guest operating system.  
  
10. In Windows Server 2016 Technical Preview or  Windows Server 2012 R2 , the key/value pair infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.  
  
11. On  Windows Server 2012 R2  Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using Powershell:  
   
    ```  
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off  
  
    ```  
  
12. Before attempting to copy the VHD of an existing Generation 2 VHD virtual machine to create new Generation 2 virtual machines, follow these steps:  
   
    1.  Log in to the existing Generation 2 virtual machine.  
    2.  Change directory to the boot EFI directory:  
  
        ```  
        # cd /boot/efi/EFI  
  
        ```  
      
    3.  Copy the ubuntu directory in to a new directory named boot:  
  
        ```  
        # sudo cp -r ubuntu/ boot  
  
        ```  
          
    4.  Change directory to the newly created boot directory:  
  
        ```  
        # cd boot  
  
        ```  
                
    5.  Rename the shimx64.efi file:  
  
        ```  
        # sudo mv shimx64.efi bootx64.efi  
  
        ```  
          
**See Also**  
  
-   [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)  
  
-   [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)  
  
-   [Set-VMFirmware](http://technet.microsoft.com/library/dn464287.aspx)  
  
-   [Ubuntu 14.04 in a Generation 2 VM - Ben Armstrong's Virtualization Blog](http://blogs.msdn.com/b/virtual_pc_guy/archive/2014/06/09/ubuntu-14-04-in-a-generation-2-vm.aspx)  
  


