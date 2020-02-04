---
title: Shielded VMs - Hosting service provider sets up Windows Azure Pack
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: d528c689-58b0-425c-9740-25e2553ed689
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Shielded VMs - Hosting service provider sets up Windows Azure Pack

This topic describes how a hosting service provider can configure Windows Azure Pack so that tenants can use it to deploy shielded VMs. Windows Azure Pack is a web portal that extends the functionality of System Center Virtual Machine Manager to allow tenants to deploy and manage their own VMs through a simple web interface. Windows Azure Pack fully supports shielded VMs and makes it even easier for your tenants to create and manage their shielding data files.

To understand how this topic fits in the overall process of deploying shielded VMs, see [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

## Setting up Windows Azure Pack

You will complete the following tasks to set up Windows Azure Pack in your environment:

1. Complete configuration of System Center 2016 - Virtual Machine Manager (VMM) for your hosting fabric. This includes setting up VM templates and a VM cloud, which will be exposed through Windows Azure Pack:

    [Scenario - Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)

2. Install and configure System Center 2016 - Service Provider Foundation (SPF). This software enables Windows Azure Pack to communicate with your VMM servers:

    [Deploying Service Provider Foundation - SPF](https://technet.microsoft.com/system-center-docs/spf/deploy/deploy-spf)

3. Install Windows Azure Pack and configure it to communicate with SPF:

    - [Install Windows Azure Pack](#install-windows-azure-pack) (in this topic)
    - [Configure Windows Azure Pack](#configure-windows-azure-pack) (in this topic)

4. Create one or more hosting plans in Windows Azure Pack to allow tenants access to your VM clouds:

    [Create a plan in Windows Azure Pack](#create-a-plan-in-windows-azure-pack) (in this topic)

## Install Windows Azure Pack

Install and configure Windows Azure Pack (WAP) on the machine where you wish to host the web portal for your tenants. This machine will need to be able to reach the SPF server and be reachable by your tenants.

1.  Reviewing [WAP system requirements](https://technet.microsoft.com/library/dn296442.aspx) and install the [prerequisite software](https://technet.microsoft.com/library/dn469335.aspx).

2.  Download and install the [Web Platform Installer](https://www.microsoft.com/web/downloads/platform.aspx). If the machine is not connected to the Internet, follow the [offline installation instructions](https://www.iis.net/learn/install/web-platform-installer/web-platform-installer-v4-command-line-webpicmdexe-rtw-release).

3.  Open the Web Platform Installer and find **Windows Azure Pack: Portal and API Express** under the **Products** tab. Click **Add**, then **Install** at the bottom of the window.

4.  Proceed through the installation. After the installation completes, the configuration site (*https://&lt;wapserver&gt;:30101/*) opens in your web browser. On this website, provide information about your SQL server and finish configuring WAP.

For help setting up Windows Azure Pack, see [Install an express deployment of Windows Azure Pack](https://technet.microsoft.com/dn296439.aspx).

> [!NOTE]
> If you already run Windows Azure Pack in your environment, you may use your existing installation. In order to work with the latest shielded VM features, however, you will need to upgrade your installation to at least Update Rollup 10.

### Configure Windows Azure Pack

Before you use Windows Azure Pack, you should already have it installed and configured for your infrastructure.

1.  Navigate to the Windows Azure Pack admin portal at *https://&lt;wapserver&gt;:30091*, and then log in using your administrator credentials.

2.  In the left pane, click **VM Clouds**.

3.  Connect Windows Azure Pack to the Service Provider Foundation instance by clicking **Register System Center Service Provider Foundation**. You will need to specify the URL for Service Provider Foundation, as well as a username and password.

    ![Register System Center Service Provider Foundation](../media/Guarded-Fabric-Shielded-VM/guarded-host-azure-pack-01-register-spf.png)

4.  Once completed, you should be able to see the VM clouds set up in your VMM environment. Ensure you have at least one VM cloud that supports shielded VMs available to WAP before continuing.

### Create a plan in Windows Azure Pack

In order to allow tenants to create VMs in WAP, you must first create a hosting plan to which tenants can subscribe. Plans define the allowed VM clouds, templates, networks, and billing entities for your tenants.

1. On the lower pane of the portal, click **+NEW** &gt; **PLAN** &gt; **CREATE PLAN**.

2. In the first step of the wizard, choose a name for your Plan. This is the name your tenants will see when subscribing.

3. In the second step, select **VIRTUAL MACHINE CLOUDS** as one of the services to offer in the plan.

4. Skip the step about selecting any add-ons for the plan.

5. Click **OK** (check mark) to create the plan. Although this creates the plan, it is not yet in a configured state.

   ![Plans in Windows Azure Pack](../media/Guarded-Fabric-Shielded-VM/guarded-host-azure-pack-02-create-plan.png)

6. To begin configuring the Plan, click its name.

7. On the next page, under **plan services**, click **Virtual Machine Clouds**. This opens the page where you can configure quotas for this plan.

8. Under **basic**, select the VMM Management Server and Virtual Machine Cloud you wish to offer to your tenants. Clouds that can offer shielded VMs will be displayed with **(shielding supported)** next to their name.

9. Select the quotas you want to apply in this Plan. (For example, limits on CPU core and RAM usage). Make sure to leave the **Allow Virtual Machines To Be Shielded** checkbox selected.

   ![Settings for virtual machine clouds in Windows Azure Pack](../media/Guarded-Fabric-Shielded-VM/guarded-host-azure-pack-03-virtual-machine-clouds.png)
    
10. Scroll down to the section titled **templates**, and then select one or more templates to offer to your tenants. You can offer both shielded and unshielded templates to tenants, but a shielded template must be offered to give tenants end-to-end assurances about the integrity of the VM and their secrets.

11. In the **networks** section, add one or more networks for your tenants.

12. After setting any other settings or quotas for the Plan, click **Save** at the bottom.

13. At the top left of the screen, click on the arrow to take you back to the **Plan** page.

14. At the bottom of the screen, change the Plan from being **Private** to **Public** so that tenants can subscribe to the Plan.

    ![Change access for a plan in Windows Azure Pack](../media/Guarded-Fabric-Shielded-VM/guarded-host-azure-pack-04-change-access.png)

    At this point, Windows Azure Pack is configured and tenants will be able to subscribe to the plan you just created and deploy shielded VMs. For additional steps that tenants need to complete, see [Shielded VMs for tenants - Deploying a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md).

## See also

- [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
