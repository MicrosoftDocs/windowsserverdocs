---
title: Windows hypervisor must be running
description: "Gives instructions to resolve the issue reported by this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 501a9beb-c464-46c0-88c5-e3e7e3e70101
author: KBDAzure
ms.date: 10/03/2016
---
# Windows hypervisor must be running

>Applies To: Windows Server 2016
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Prerequisites|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*Windows hypervisor is not running.*  
  
## Impact  
  
*Virtual machines cannot be started until Windows hypervisor is running.*  
  
## Resolution  
  
*Check the Windows Server catalog to see if this server is qualified to run Hyper-V. Next, make sure the BIOS is enabled for hardware-assisted virtualization and hardware-enforced data execution prevention. Then, check the Hyper-V-Hypervisor event log.*  
  
To check the catalog, see [Windows Server catalog](https://go.microsoft.com/fwlink/?LinkId=111228) (https://go.microsoft.com/fwlink/?LinkId=111228).  
  
> [!CAUTION]  
> Changing certain parameters in the system BIOS of a computer can cause that computer to stop loading the operating system, or it can make hardware devices, such as hard disk drives, unavailable. Always consult the user manual for the computer to determine the proper way to configure the system BIOS. Also, it is always a good idea to keep track of the parameters that you modify and their original value so that you can restore them later if needed. If you experience problems after changing parameters in the system BIOS, try to load the default settings (an option is usually available in the BIOS configuration utility), or contact the computer manufacturer for assistance.  
  
#### To verify virtualization support in the BIOS or UEFI  
  
1.  Restart the computer and access the BIOS or UEFI through the configuration tool. Access to this tool usually is available when the computer goes through a boot process. Immediately after you turn on most computers, a message appears for a few seconds that lists the key or combination of keys to press to open the configuration tool.  
  
2.  Find the settings for virtualization and hardware-enforced Data Execution Prevention (DEP) and verify that they are on. Following are common menu locations for these settings in the configuration tool, and examples of what they might be named:  
  
    -   Virtualization support:  
  
        -   Usually available under the settings for the main processor or performance. Sometimes it's under the security settings.  
  
        -   Look for parameter names that include "virtualization" or "virtualization technology".  
  
    -   Hardware-enforced DEP:  
  
        -   Usually available under the security or memory settings.  
  
        -   Look for parameter names that include "execution", "execute", or "prevention".  
  
3.  If necessary, turn on the settings by following the instructions in the configuration tool. Save the changes and exit.  
  
4.  If you made any changes, turn the power off and then back on to finish.  
  
    > [!IMPORTANT]  
    > We recommend that you turn the power off and then back on (sometimes called a power cycle) because the changes aren't applied on some computers until this happens.  
  
Next, check the Hyper-V-Hypervisor event log. If there are problems, you'll also check the System log.  
  
#### To check the event logs  
  
1.  Open Event Viewer. Click **Start**, click **Administrative Tools**, and then click **Event Viewer**.  
  
2.  Open the Hyper-V-Hypervisor event log. In the navigation pane, expand **Applications and Services Logs** >> **Microsoft** >> **Windows** >> **Hyper-V-Hypervisor**, and then click **Operational**.  
  
3.  If Windows hypervisor is running, no further action is needed. If Windows hypervisor isn't running, do this:  
  
4.  Open the System log. (In the navigation pane, expand **Windows Logs** and then select **System**.)  
  
5.  Use a filter to find Hyper-V-Hypervisor events:   
    1. In the **Actions** pane, click **Filter Current Log**. For **Event sources**, specify "Hyper-V-Hypervisor".   
    2. Look for events that report problems. For example, event ID 41 indicates a problem with the BIOS configuration: "Hyper-V launch failed; Either VMX not present or not enabled in BIOS."  
  
### See Also  
For details about using Hyper-V on Windows 10, including how to check that your computer can run Hyper-V, see [Windows 10 Hyper-V System Requirements](https://msdn.microsoft.com/virtualization/hyperv_on_windows/quick_start/walkthrough_compatibility). 


