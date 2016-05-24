---
title: 9 Scenario #3 – Deploy a shielded VM using Windows Azure Pack (new in Windows Server 2016 Technical Preview 3)
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a92f3b6b-23b3-4297-a25e-ec80686f7a3d
robots: noindex,nofollow
---
# 9 Scenario #3 – Deploy a shielded VM using Windows Azure Pack (new in Windows Server 2016 Technical Preview 3)
>**Important:** You must complete steps 8.1 – 8.3.2 in Scenario \#2 before beginning this scenario.  
  
In this scenario, the host service providers prepare a signed disk template for use by their tenants, and then make it available to the tenants using Plans in Windows Azure Pack. Tenants then connect to the Windows Azure Pack portal and create a shielded VM from a shielded VM template in the Windows Azure Pack Gallery. The required steps for the administrator are the same (with one or two additional steps) for allowing the VM creation from VMM, while the tenant flow is completely different because the tenant creates their VM from Windows Azure Pack instead of VMM.  
  
1.  The hosting service providers configure VMM 2016 Technical Preview 3 and the Hyper-V Technical Preview 3 fabric to support shielded VMs.    
2.  The hosting service providers use the following procedures to create a shielded VM template:    
    1.  Download or prepare VHD to use as a template.    
    2.  Create a Signed Disk Template.    
    3.  Copy and publish the disk template to the VMM library.    
    4.  Create the shielded VM template in VMM using the signed disk.    
3.  The hosting service providers install and configure Service Provider Foundation 2016 Technical Preview 3 and Windows Azure Pack, and then create plans in Windows Azure Pack to expose the shielded VMs to the tenants.    
Tenant administrators use the Windows Azure Pack tenant portal to execute the following procedures to create shielding data for shielded VM. To do this:    
	1.  Get the Volume Signature Catalog File Host Guardian Service Metadata from the Windows Azure Pack portal.    
    2.  Create a shielding data file.    
4.  Tenants use the following procedures to create and start the virtual machine.    
5.  Tenants create a shielded VM using Windows Azure Pack.  
  
**Important**: Before you start this section, make sure you have completed Scenario \#2, and have successfully completed the following configurations in VMM, with artefacts that are defined for use in the Windows Azure Pack portal. You should have:  
  
1.  Host Guardian Service settings defined in VMM    
2.  Guarded hosts in your fabric    
3.  A VMM cloud that supports shielding    
4.  A Generation 2 VM template with unsigned disk    
5.  A Generation 2 VM template with signed disk (also referred to as Shielded Template in this document)    
6.  Non-shielded VM  
  
  
### 9.1  Configure Service Provider Foundation and Windows Azure Pack to expose shielded VM plans to tenants    
#### 9.1.1  Configure the Service Provider Foundation    
Install Service Provider Foundation 2016 Technical Preview 3 using the instructions at this link: [https://technet.microsoft.com/en-us/library/dn266007.aspx](https://technet.microsoft.com/en-us/library/dn266007.aspx). Note that these instructions are for Service Provider Foundation 2012 R2, but you must install Service Provider Foundation 2016 Technical Preview 3. Use the service account for Application Pool Credentials in step #8.  
  
If you have issues with integrating Windows Azure Pack and Service Provider Foundation, see the following link for help: [http://blogs.technet.com/b/privatecloud/archive/2013/11/08/troubleshooting-windows-azure-pack-spf-amp-vmm.aspx](http://blogs.technet.com/b/privatecloud/archive/2013/11/08/troubleshooting-windows-azure-pack-spf-amp-vmm.aspx)  
  
#### 9.1.2  Install Windows Azure Pack    
Before you install the Windows Azure Pack Express, verify that you have complied with the [Windows Azure Pack system requirements overview](https://technet.microsoft.com/en-us/dn296442), including installing the [Web Platform Installer](http://go.microsoft.com/fwlink/?LinkId=327966).  
  
1.  Start the Web Platform Installer. Type **Windows Azure Pack** in the search box.    
2.  Next to **Windows Azure Pack: Portal and API Express**, click **Add** &gt; **Install**.  
  
	If the server running VMM 2016 Technical Preview 3 does not have Internet access, see the following instructions for installing offline: [https://technet.microsoft.com/en-us/dn756546.aspx](https://technet.microsoft.com/en-us/dn756546.aspx).  
  
1.  On the **Prerequisites** page, accept the terms and conditions.    
2.  Indicate whether you want to use Microsoft Update to keep Windows Azure Pack up-to-date. We recommend that you use Microsoft Update because it helps ensure that any updates needed for this scenario are automatically installed.      
3.  The installation begins. Your computer might restart during the installation. When the installation has completed, make sure all Internet Explorer windows are closed, and then click **Continue** to start the Service Management Configuration site.    
    The configuration site ([https://localhost:30101/](https://localhost:30101/)) opens in Internet Explorer.  
  
If you need help setting up Windows Azure Pack, see the instructions at [https://technet.microsoft.com/en-us/dn296439.aspx](https://technet.microsoft.com/en-us/dn296439.aspx).  
  
#### 9.1.3  Configure Windows Azure Pack    
Before you use Windows Azure Pack, you should already have it installed and configured for your infrastructure.    
1.  Navigate to the Windows Azure Pack admin portal at and then log in using your administrator credentials.    
2.  In the left pane, click **VM Clouds**.    
3.  Connect Windows Azure Pack to the SAP to the Service Provider Foundation instance you already configured by clicking “Register System Center Service Provider Foundation.” You will need to specify the URL for Service Provider Foundation, as well as username and password.    
![Register System Center Service Provider Foundation](/Image/ShieldVM_Register_System_Center_SPF.png)  
  
1.  If successful, you should be able to navigate to the VM cloud you just connected to and see details about the clouds that exist in VMM.  
  
#### 9.1.4  Create a Shielded VM Plan in Windows Azure Pack    
When you are connected to your instance of VMM, you are ready to create a Plan in Windows Azure Pack to offer VMs to your tenants.    
1.  On the lower pane of the portal, click **+NEW** &gt; **PLAN** &gt; **CREATE PLAN**.    
2.  In the first step of the wizard, choose a name for your Plan. This is the name your tenants will see.    
3.  In the second step, select **VIRTUAL MACHINE CLOUDS** as one of the services to offer in the plan.    
4.  Skip the step about selecting any add-ons for the plan.    
5.  Click **OK** (check mark) to create the plan. Although this creates the plan, it is not yet in a configured state.  
  
   ![Create a Shielded VM Plan](/Image/ShieldVM_VMM_Plan.png)  
  
6.  To begin configuring the Plan, click its name.    
7.  On the next page, under **plan services**, click **Virtual Machine Clouds**. This opens the page where you can configure quotas for this plan.    
8.  Under **basic**, select the VMM Management Server and Virtual Machine Cloud to which you want to connect. Choose the cloud that shows as “shielding supported” from the dropdown menu.    
9.  Select the quotas you want to apply in this Plan. (For example, limits on Core, RAM usage, and so forth.) Make sure to leave the **Allow Virtual Machines To Be Shielded** checkbox selected.    
  
  ![Allow virtual machines to be shielded](/Image/ShieldVM_VMM_Allow_VM_Shielded.png)  
  
1.  Scroll down to the section on the page titled **templates**, and then select the templates to add.    
2.  In the wizard that displays, look for the shielded templates you already created and added to VMM. Make sure to include that template and any other templates you wish to make available in the Plan.  
  
  ![Select templates to add to this plan](/Image/ShieldVM_VMM_Select_Templates.png)  
  
  >*Note: You will also want to include non-shielded Generation 2 VM templates in the Plan to validate scenarios around converting Generation 2 VMs to shielded VMs.*  
  
1.  After setting any other settings or quotas for the Plan, click **Save**.    
2.  At the top left of the screen, click on the arrow to take you back to the **Plan** page.    
3.  At the bottom of the screen change the Plan from being **Private** to **Public** so that tenants can subscribe to the Plan.  
  
    ![Change the plan to public](/Image/ShieldVM_VMM_Plan_Public.png)  
  
  
  
### 9.2  Tenants create Shielding Data for the VM    
#### 9.2.1  Get a Windows Azure Pack subscription    
1.  If you do not have a subscription already, navigate to the Windows Azure Pack administrator portal at and sign up for one. Click **+NEW** &gt; **My Account** &gt; **Add Subscription**.    
2.  From the list of Plans, select the Plan that was created in the previous section, including shielded virtual machines, and then click **OK** (check mark). This will start the provisioning of your subscription.    
  
#### 9.2.2  Download the Volume Signature Catalog and guardian key from the tenant portal    
1.  On the left side of the portal, click **Virtual Machines**.    
2.  At the top, click **Shielding Data**.    
3.  On the lower part of the page, click **Download Guardian** to download the Guardian Key file locally to your machine. You may be prompted to choose a subscription if you have multiple tenant subscriptions.    
4.  Click **Download Catalog**, and then select the template for which you want to create Shielding Data to download the VSC to your local machine.    
    ![Click Download Catalog](/Image/ShieldVM_Download_Catalog.png)  
  
#### 9.2.3  Create the Shielding Data File    
Follow the instructions in section 8.3.5 to create a shielding data file using the VSC and guardian key downloaded from the WAP portal.  
  
If you are using the Windows 10 Client operating system to browse the Windows Azure Portal, you can download Remote Server Administration Tools for Windows Server 2016, which will install the Shielding Data File Wizard to create PDK file on the client computer.  
  
OR  
  
You can use Windows Server 2016 Technical Preview 3 and add Feature\\Remote Server Administration Tools\\Shielded VM Tools in Server Manager.  
  
#### 9.2.4  Upload Shielding Data in the Windows Azure Pack portal    
1.  From the left navigation, click **Virtual Machines**.    
2.  At the top, click **Shielding Data**.    
3.  On the lower pane of the page, click **Upload**.    
4.  Click **Browse**, and then point to PDK file that was created in the previous step.    
5.  Enter the **Friendly Name** and **Description**, and click the “right” icon in the lower-right corner to upload it.    
      
  
### 9.3  Create a shielded VM in Windows Azure Pack    
There are two ways to create a VM from a Shielded Template in Windows Azure Pack: either by using the Quick Create feature of the portal, or by using the Gallery.  
  
#### 9.3.1  Quick Create a shielded VM in Windows Azure Pack    
1.  In the Tenant Portal, click **+NEW** &gt; **STANDALONE VIRTUAL MACHINE** &gt; **QUICK CREATE**.    
2.  Select a name for the VM. From the dropdown list under **Templates**, choose the Shielded Template from the list.    
3.  Choose the Shielding Data you want to use to create the VM.  
  
    ![Quick create a shielded VM](/Image/ShieldVM_Create_Shielded_VM.png)  
  
4.  Click **CREATE VM INSTANCE** to begin creating your VM.    
5.  Once the VM is created, it can be managed just like any other Windows Azure Pack VM (the only difference is that you cannot use Console Connect). See the Windows Azure Pack Virtual Machine documentation for more details regarding capabilities.  
  
#### 9.3.2  Create a shielded VM in Windows Azure Pack from the Gallery using a shielded template    
1.  In the tenant portal, click on click **+NEW** &gt; **STANDALONE VIRTUAL MACHINE** &gt; **FROM GALLERY**. The gallery wizard displays.    
2.  From the list of available templates, select a shielded template (indicated by an icon of a shield) &gt; **Next**.  
  
    ![Create a shielded VM from the gallery using a template](/Image/ShieldVM_VM_Config.png)  
  
3.  On the next page of the wizard, specify a name for the VM.    
4.  Using the dropdown menu, select the shielding data file to use to shield the VM.    
5.  On the next page of the wizard, choose a network to connect the VM to (optional), and then click **OK** to begin creating the VM.    
6.  When the VM creation is completed, the VM can be managed just like any other Windows Azure Pack VM (the only difference is that you cannot use Console Connect). See the Windows Azure Pack Virtual Machine documentation for details about capabilities.  
  
#### 9.3.3  Create a shielded VM in Windows Azure Pack from the gallery using a regular template    
1.  In the tenant portal, click on **+NEW** &gt; **STANDALONE VIRTUAL MACHINE** &gt; **FROM GALLERY**. The gallery wizard displays.    
2.  From the list of available templates, select a template for a Generation 2 VM that is not a shielded template (there should not be an icon with a shield next to the template), and then click **Next**.    
3.  In the next page of the wizard, fill in the required fields for creating the VM.    
4.  On the lower part of the page, click the check box that asks if you want to shield the VM after creation. This prompts you to select which shielding data to use.    
5.  In the next page of the wizard, choose a network to connect the VM to (optional), and then click **OK** to begin creating the VM.    
6.  After the VM is created, it can be managed just like any other Windows Azure Pack Virtual Machine (the only difference is that you cannot use Console Connect). See the Windows Azure Pack Virtual Machine documentation for more details regarding capabilities.  
  
### 9.4  Convert an existing Generation 2 VM to a shielded VM in Windows Azure Pack    
1.  Use **Quick Create** or **Create from Gallery** to create a VM using a Generation 2 VM Template that is not shielded.    
After the VM is created, you can manage it in the same way you would a regular VM.    
2.  Click the **Configure** tab for the VM. Verify that the VM state is **Stopped/Powered Off**.    
3.  On the lower part of the configuration screen, click **Shield**. You are prompted to select a Shielding Data file.  
  
  >You have to generate a shielding data file as discussed in 8.3.5, but you have to select **Create a new Shielding data file**, select the radio button next to **Shielding data for existing VM and non-shielded templates**, and upload the Shielding Data file in your Windows Azure Pack subscription as discussed in 9.2.4.  
  
1.  Click **OK**. After this process, the VM will be converted into a shielded VM.  
  
  >At this point, the VM can support shielding, but the configuration is not yet complete. To finish the process, you must log on to the VM, install BitLocker Components (if not already installed), and enable BitLocker on all volumes, including the system volume.  
  
  >You should also change the password for administrators and all other accounts enabled with RDP access to ensure that previously stored credentials cannot be reused to log in and access server using RDP.  
  
  >Note that existing checkpoints and backups are not encrypted. You should either consider securing such data and/or delete them.