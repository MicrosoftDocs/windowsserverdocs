---
title: Enable vRSS on a Virtual Network Adapter
description: In this topic, you learn how to enable vRSS in Windows Server by using either Device Manager or Windows PowerShell.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: cb48315c-0204-4927-aa24-64f6789c2e20
manager: dougkim
ms.localizationpriority: medium
ms.date: 09/05/2018
ms.author: lizross
author: eross-msft
---

# Enable vRSS on a Virtual Network Adapter

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Virtual RSS \(vRSS\) requires Virtual Machine Queue \(VMQ\) support from the physical adapter. If VMQ is disabled or is not supported then Virtual Receive-side scaling is disabled. 

For more information, see [Plan the Use of vRSS](vrss-plan.md).

## Enable vRSS on a VM
 
Use the following procedures to enable vRSS by using either Windows PowerShell or Device Manager.

-	Device Manager
-	Windows PowerShell
  
### Device Manager

You can use this procedure to enable vRSS by using Device Manager.

>[!NOTE]
>The first step in this procedure is specific to VMs that are running Windows 10 or Windows Server 2016. If your VM is running a different operating system, you can open Device Manager by first opening Control Panel, then locating and opening Device Manager.
  
1.	On the VM taskbar, in **Type here to search**, type **device**. 

2.	In the search results, click **Device Manager**.

3.	In Device Manager, click to expand **Network adapters**. 

4.	Right-click the network adapter you want to configure, and then click **Properties**.<p>The network adapter **Properties** dialog box opens.

5.	In network adapter **Properties**, click the **Advanced** tab. 

6.	In **Property**, scroll down to and click **Receive-side scaling**. 

7.	Ensure that the selection in **Value** is **Enabled**. 

8.	Click **OK**.
  
> [!NOTE]
> On the **Advanced** tab, some network adapters also display the number of RSS queues that are supported by the adapter.

---

### Windows PowerShell

Use the following procedure to enable vRSS by using Windows PowerShell.

1. On the virtual machine, open **Windows PowerShell**.

2. Type the following command, ensuring that you replace the *AdapterName* value for the **-Name** parameter with the name of the network adapter that you want to configure, and then press ENTER. 
  
   ```PowerShell
   Enable-NetAdapterRSS -Name "AdapterName"
   ```

   >[!TIP]
   >Alternately, you can use the following command to enable vRSS.
   >```PowerShell
   >Set-NetAdapterRSS -Name "AdapterName" -Enabled $True  
   >```

For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

---