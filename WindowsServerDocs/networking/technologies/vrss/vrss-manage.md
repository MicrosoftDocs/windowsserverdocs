---
title: Manage vRSS
description: You can use this topic to change or remove vRSS settings in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 0fe5bfc3-591f-4a19-b98a-0668d4c9f93a
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Manage vRSS

You can use the following Windows PowerShell commands to manage vRSS in virtual machines \(VMs\) and on Hyper\-V hosts.

>[!NOTE]
>For more information about the commands mentioned in this topic, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

## vRSS in VMs

You can configure vRSS settings in virtual machines \(VMs\) by using the following Windows PowerShell command, which is the same command used for native RSS.

    Set-NetAdapterRss

You can view the vRSS settings of the VM by using the following Windows PowerShell command in the VM.

    Get-NetAdapterRSS

> [!NOTE]
>  Setting the profile inside the virtual machine does not impact the scheduling of the work. Hyper\-V makes all the scheduling decisions and ignores the profile inside the virtual machine.

## vRSS on Hyper\-V Hosts

On the Hyper\-V host, you must use the keywords that control the VMQ processors. 

You can view the current settings inside the VM by using the following Windows PowerShell command.

    Get-NetAdapterVmq

To configure the vRSS settings, you can use the following Windows PowerShell command.

    Set-NetAdapterVmq

The output for this command is slightly different than that when used with native RSS.
  
## Disable vRSS

You can disable vRSS by using either Windows PowerShell or Device Manager.
  
### To disable vRSS using Device Manager  
  
You can use this procedure to disable vRSS by using Device Manager.

>[!NOTE]
>The first step in this procedure is specific to VMs that are running Windows 10 or Windows Server 2016. If your VM is running a different operating system, you can open Device Manager by first opening Control Panel, then locating and opening Device Manager.
  
1. On the Hyper\-V host task bar, in **Type here to search**, type **device**. In search results, click **Device Manager**.  
  
2. Expand **Network adapters**, right-click the network adapter that you want to configure, and then click **Properties**.
  
3. In network adapter **Properties**, click the **Advanced** tab. In **Property**, scroll down to and click **Receive-side scaling**. Ensure that the selection in **Value** is **Disabled**.

4. Click **OK**.
  
#### To disable vRSS by using Windows PowerShell

You can use the following procedure to disable vRSS by using Windows PowerShell.

1. On the Hyper\-V host, open **Windows PowerShell**.  
  
2. Type the following command, ensuring that you replace the *AdapterName* value for the **-Name** parameter with the name of the network adapter that you want to configure, and then press ENTER.

    
    `Disable-NetAdapterRSS -Name "AdapterName"`
    

Alternately, you can use the following command to disable vRSS.


    Set-NetAdapterRSS -Name "AdapterName" -Enabled $False  
