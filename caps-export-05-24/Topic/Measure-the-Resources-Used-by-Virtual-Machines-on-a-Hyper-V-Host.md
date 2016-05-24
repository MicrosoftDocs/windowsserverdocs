---
title: Measure the Resources Used by Virtual Machines on a Hyper-V Host
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 53d7a9a7-1704-40f9-babe-219fae66cf50
author: cwatsonmsft
---
# Measure the Resources Used by Virtual Machines on a Hyper-V Host
*Provide 1\-2 paragraphs that describe this document and its contents. The first 255 characters should contain the most important words to help the reader decide if your document is the one they need. This assists in SEO, but is especially important for readers who are scanning the results list without clicking through \(for reference, “255 characters” falls in the word “readers” here\). Be sure to include keywords commonly used in searches for the topic.*  
  
**In this document**  
  
*Provide a list of links to the various steps. If this doc is more than about 15 pages, consider breaking up the document task into multiple smaller tasks for usability. If you have a small amount of conceptual content that needs to be included \(e.g. some minimal planning\/design content\), include this in its own topic before the procedures \(and make sure to provide links back to this topic in a See Also section at the bottom\).*  
  
-   [Prerequisites](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Prereqs)  
  
-   [Step 1: &lt;Step name&gt;](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step1)  
  
-   [Step 2: &lt;Step name&gt;](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step2)  
  
-   Step 3: *<Step name>*  
  
-   Step 4: *<Step name>*  
  
-   Step 5: *<Step name>*  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## Prerequisites  
*Provide the prerequisites for beginning the procedures in this guide, as necessary \(optional\). Alternatively, delete this section and include this information in Step 1, if it makes more sense. Note that the prerequisite tag is part of the Walkthrough topic type that this template is based on.*  
  
Research Notes:  
  
To configure the server running Hyper\-V to save the resource consumption data once an hour \(which is the minimum\), run the following command:  
  
```  
Set-VMHost -ResourceMeteringSaveInterval 01:00:00  
```  
  
From Krishna to Lalithra via email about the examples being wrong: HI Lalithra, The example of mesure\-vm resetting metrics is correct. In that example we describe, how somebody can query and reset. If you observe there are two cmdlets that are executed in that example. To make it clear, you can update sample step 1: Query    command:  PS C:\\> $UtilizationReport \= Get\-VM TestVM | Measure\-VMStep2: reset Command:PS C:\\> Get\-VM TestVM | Reset\-VMResourceMetering Example 2Reports collected resource utilization data for a virtual machine named TestVM and resets resource utilization so that Hyper\-V restarts collecting data from zero.  Copy PS C:\\> $UtilizationReport \= Get\-VM TestVM | Measure\-VMCopy PS C:\\> Get\-VM TestVM | Reset\-VMResourceMetering  
  
To differentiate between Internet and intranet traffic, providers can measure incoming and outgoing network traffic for any IP address range, use network metering port ACLs \(from the Resource Metering tech preview topic…no specifics given, check my internal draft to see what was there\).  
  
Basic steps seem to be:  
  
### The procedure title  
  
1.  Configure each virtual machine to track the amount of resources it consumes. \(How to specify how often? Do all trackable resources get measured unless you specify only specific ones? Or do you need to specify one specifically? Use Measure\-VM for this step  
  
2.  Configure the server for how often you want to save this data. This is a global server setting.  
  
3.  After you save the data, you have to reset the measurement on each virtual machine, using Reset\-VMResourceMetering:  
  
    PS C:\\> Get\-VM TestVM | Reset\-VMResourceMetering  
  
## <a name="BKMK_Step1"></a>Step 1:  Configure the data to be tracked for each virtual machine  
*Provide a brief explanation of this step for context \(1\-2 sentences\). Note that there are a few cases where the step will not require a numbered procedure \(see the examples referred to at the top of this template\). Also, provide Windows PowerShell commands that perform the same function after each GUI procedure.*  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep1)  
  
#### To *<procedure title>*  
  
1.  
  
*The next part of Step 1 is where you include the Windows PowerShell equivalent to the GUI procedure. Delete this part if there is no PowerShell equivalent.*  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
*Provide the Windows PowerShell code for the procedure. For example:*  
  
```  
New-ADGroup -Name "[group name]" -SamAccountName [group name] -GroupCategory Security -GroupScope Global  
-DisplayName "[group name]" -Path "[path]" -Description "Members of this group are DirectAccess client computers"  
```  
  
## <a name="BKMK_Step2"></a>Step 2:  Configure the server running Hyper\-V to save the resource data  
*Provide a brief explanation of this step for context \(1\-2 sentences\). Note that there are a few cases where the step will not require a numbered procedure \(see the examples referred to at the top of this template\). Also, provide Windows PowerShell commands that perform the same function after each GUI procedure.*  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep2)  
  
#### To *<procedure title>*  
  
1.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
*Provide the Windows PowerShell code for the procedure. For example:*  
  
```  
New-ADGroup -Name "[group name]" -SamAccountName [group name] -GroupCategory Security -GroupScope Global  
-DisplayName "[group name]" -Path "[path]" -Description "Members of this group are DirectAccess client computers"  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   *Include a link to the Feature\/Role overview topic.*  
  
-   *Include links to other related topics.*  
  
