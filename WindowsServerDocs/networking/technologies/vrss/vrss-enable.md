---
title: Enable vRSS on a Virtual Network Adapter
description: You can use this topic to enable vRSS in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: cb48315c-0204-4927-aa24-64f6789c2e20
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Enable vRSS on a Virtual Network Adapter

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

vRSS requires Virtual Machine Queue \(VMQ\) support from the physical adapter. If VMQ is disabled, or is not supported then Virtual Receive-side scaling is disabled. 

For more information, see [Plan the Use of vRSS](vrss-plan.md).

## Enable vRSS on a VM
 
You can use the following procedures to enable vRSS by using either Windows PowerShell or Device Manager.
  
### To enable vRSS on a VM by using Device Manager

You can use this procedure to enable vRSS by using Device Manager.

>[!NOTE]
>The first step in this procedure is specific to VMs that are running Windows 10 or Windows Server 2016. If your VM is running a different operating system, you can open Device Manager by first opening Control Panel, then locating and opening Device Manager.
  
1. On the VM task bar, in **Type here to search**, type **device**. In search results, click **Device Manager**.
  
2. In Device Manager, click to expand **Network adapters**. Right-click the network adapter you want to configure, and then click **Properties**. The network adapter **Properties** dialog box opens.
  
3. In network adapter **Properties**, click the **Advanced** tab. In **Property**, scroll down to and click **Receive-side scaling**. Ensure that the selection in **Value** is **Enabled**. 

4. Click **OK**.
  
> [!NOTE]
> On the **Advanced** tab, some network adapters also display the number of RSS queues that are supported by the adapter.
  
### To enable vRSS on a VM by using Windows PowerShell

You can use the following procedure to enable vRSS by using Windows PowerShell.

1. On the virtual machine, open **Windows PowerShell**.  
  
2. Type the following command, ensuring that you replace the *AdapterName* value for the **-Name** parameter with the name of the network adapter that you want to configure, and then press ENTER. 
  
````
Enable-NetAdapterRSS -Name "AdapterName"
````
  
Alternately, you can use the following command to enable vRSS.

````
Set-NetAdapterRSS -Name "AdapterName" -Enabled $True  
````

For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).
  