---
title: Appendix A – Import a VMM 2016 VHD in your fabric
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ab3f83a5-d33a-497a-81a3-331b741d5aa8
robots: noindex,nofollow
---
# Appendix A – Import a VMM 2016 VHD in your fabric
### Building a VM to run Virtual Machine Manager    
1.  Copy the VMM Image you have downloaded to the Hyper-V server that will run Virtual Machine Manager    
2.  Start the Hyper-V Manager on the physical host.    
3.  Click **New** &gt; **Virtual Machine** &gt; **Next**.    
4.  Specify a name and a path for the virtual machine.    
5.  Select Generation 1 VM.    
6.  Assign 6 GB or more of memory to the VM, and then click **Next**.    
7.  Connect the VM to a network that has access to the AD for the test environment, and then click **Next**.    
8.  Select **Attach disk later**, and then click **Next**.    
9.  Select **Install an Operation System later** &gt; **Next**.    
10. Click **Finish**.    
11. Copy the VHD file to the folder of the new VM.    
12. In Hyper-V Manager, right-click the new VM &gt; **Settings**.    
13. Click **IDE Controller** &gt; **Hard Drive** &gt; **Add**.      
14. Select the path to the location where the VHD was copied under the VM folder in step 12 &gt; **OK**.    
15. Select the VM &gt; **Start**.  
  
### Configure the Virtual Machine Manager image    
1.  Provide an administrator password for the VMM server.    
2.  Join the VMM server to the test domain.    
3.  Restart the VMM server.    
4.  Log in as a domain administrator.    
5.  Add the VMM service account to local administrators.    
  
### Configure SQL Server for Virtual Machine Manager    
1.  From the shortcut on the desktop, start **SQL Configuration**.    
2.  Click **Eval** &gt; **Next**.    
3.  Read and accept the license if you agree with it.    
4.  Click **Check for updates** &gt; **Next**.    
5.  Click **Next** for image rules.    
6.  Select **Default Instance** &gt; **Next**.    
7.  Click **Next** for Features &gt; **Next** for Instance configuration &gt; **Configure Instance**.    
8.  Close the SQL Server configuration.  
  
### Configure Virtual Machine Manager    
1.  Click the **Configure VMM** shortcut on the desktop.    
2.  Specify the name and organization.    
3.  Read the terms of the license. If you agree to them, click **Next**.    
4.  Choose the customer experience option &gt; **Next**.    
5.  Select an update option &gt; **Next**.    
6.  From the dropdown **Instance** menu, click **MSSQLSERVER** &gt; **Next**.    
7.  Specify a domain account for the VMM service.    
> **NOTE:** This account has to be member of local administrators    
1.  Select default path for VMM library, or enter another path if desired &gt; **Next** &gt; **Install**.    
2.  Click close after the installation finishes  
  
### Add a Hyper-V host to Virtual Machine Manager    
1.  Start the **Virtual Machine Manager** console from the **Start** menu.    
2.  In the left pane, click **Fabric**, and then in the left menu, click **Servers**.    
3.  Click **Add Resources**, and then select **Hyper-V Host or Cluster.**    
4.  Depending on where your Hyper-V host is located, select **Windows Server in a domain or non-domain**.    
5.  Select **Manually enter credentials**, enter the username and password for a user who has administrator access to the Hyper-V host &gt; **Next**.    
6.  Select **Specify Windows Server Computer Names**.    
7.  Enter the name of the Hyper-V host that was installed with Windows Server vNext build 9926 &gt; **Next**.    
8.  Under **Discovered computers**, select the server &gt; **Next**.    
9.  Read the warning &gt; **OK**.    
10. On the Host group page, click **Next** &gt; **Finish**.    
11. Close the job window, and then in the Servers view, verify that the host is running as healthy.