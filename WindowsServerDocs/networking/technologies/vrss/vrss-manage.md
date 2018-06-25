---
title: Manage vRSS
description: You can use this topic to change or remove vRSS settings in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 0fe5bfc3-591f-4a19-b98a-0668d4c9f93a
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Manage vRSS

You can use the following Windows PowerShell commands to manage vRSS in virtual machines \(VMs\) and on Hyper\-V hosts.

>[!NOTE]
>For more information about the commands mentioned in this topic, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

## VMQ on Hyper-V Hosts

On the Hyper-V host, you must use the keywords that control the VMQ processors.
You can view the current settings inside the host by using the following Windows PowerShell command.

    Get-NetAdapterVmq

To configure the VMQ settings, you can use the following Windows PowerShell command.

    Set-NetAdapterVmq

## vRSS on Hyper-V switch ports

On the Hyper-V host, you must also enable vRSS on the Hyper\-V Virtual Switch port.

You can view the current settings by using one of the following Windows PowerShell commands.

    Get-VMNetworkAdapter <vm-name> | fl

    Get-VMNetworkAdapter -ManagementOS | fl


After you run one of these commands, you can observe two fields:

    
    VrssEnabledRequested   : True
    VrssEnabled: True
    

Generally, if **VrssEnabledRequested** is **True**, then **VrssEnabled** will also be **True**.  

Under some resource limitation conditions, a Hyper\-V Virtual Switch port might be unable to have this feature enabled. This is a temporary condition, and the feature may become available at a subsequent time.

If **VrssEnabled** is **True**, then the feature is enabled for this Hyper\-V Virtual Switch port \(i.e., for this VM or vNIC\).

To configure the switch port vRSS settings, you can use one of the following Windows PowerShell command to set the **VrssEnabledRequested** field to **True**:

    
    Set-VMNetworkAdapter <vm-name> -VrssEnabled $TRUE
    
    Set-VMNetworkAdapter -ManagementOS -VrssEnabled $TRUE
    

## vRSS in VMs and host vNICs

You can configure vRSS settings in virtual machines \(VMs\) and host vNICs by using the following Windows PowerShell command, which is the same command used for native RSS. This is also the way RSS can be enabled on host vNICs.

    Set-NetAdapterRss

You can view the vRSS settings by using the following Windows PowerShell command.

    Get-NetAdapterRSS

> [!NOTE]
>  Setting the profile inside the VM does not impact the scheduling of the work. Hyper\-V makes all the scheduling decisions and ignores the profile inside the VM.

## Disable vRSS

You can disable vRSS by using Windows PowerShell commands to disable any of the previously mentioned settings.

1. You can disable VMQ for the physical NIC or the VM.

>[!CAUTION]
>Disabling VMQ on the physical NIC severely impacts the ability of your Hyper\-V host to handle incoming packets.

2. You can disable vRSS for a VM on the Hyper\-V Virtual Switch port by using the following Windows PowerShell command on the Hyper\-V host.

    Set-VMNetworkAdapter <vm-name> -VrssEnabled $FALSE

3. You can disable vRSS for a host vNIC on the Hyper\-V Virtual Switch port by using the following PowerShell command on the Hyper\-V host.

    Set-VMNetworkAdapter -ManagementOS -VrssEnabled $FALSE

4. You can disable RSS in the VM \(or host vNIC\) by using the following Windows PowerShell command inside the VM \(or on the host\)

    Disable-NetAdapterRSS *

