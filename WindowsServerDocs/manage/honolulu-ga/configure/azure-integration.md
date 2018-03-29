---
author: nwashburn-ms
---

# Configuring Azure integration

[Content goes here]

[TODO:legacy-content-begin]

# Connect your gateway to Azure

To allow the Honolulu gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (e.g. to protect VMs managed in Honolulu using Azure Site Recovery), you must first connect your Honolulu gateway to Azure. This must only be done once for your Honolulu gateway and is preserved upon updating your gateway to a newer version.

To connect your gateway, you must run the [New-AadApp.ps1 PowerShell script](https://aka.ms/HonoluluAzureConnectScript) available for download (there is also a hyperlink in the Honolulu UI for this download), which creates a web application in Azure AD with the name "SME-*gateway*" and registers the application with the Honolulu gateway. This allows Honolulu to connect to Azure resources like AAD on your behalf. The script can be run from any machine that has access to the Honolulu gateway and to Azure, with the Honolulu gateway URL as the -GatewayEndpoint parameter. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com"

If you are NOT using port 443, the GatewayEndpoint parameter should contain the port (i.e. https://myComputer:6516).

If there are multiple tenants associated with your Azure account, you can use the -TenantId parameter to specify the tenant in which you want to create the AAD application and associate with your Honolulu gateway. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

This script requires two Azure PowerShell modules: AzureRm.Resources and AzureAD. If you do not have these modules installed, execute the following commands in an elevated PowerShell console:

    PS C:>Install-Module AzureRM.Resources
    PS C:>Install-Module AzureAD

After running the script, you must refresh the browser page from which you are accessing the Honolulu gateway. 

### Other considerations

If you have already configured your gateway for Azure connectivity when setting up Azure Site Recovery and used the New-AsrAadApp.ps1 available in our documentation prior to the 1803 release, you will need to delete your existing AAD application by navigating to the Azure portal > **Azure Active Directory** > **Application registration** > **All applications** and searching "ASR" (the old AAD app will be named "ASR-Honolulu-*gateway*"). Then run the [New-AadApp.ps1 script](https://aka.ms/HonoluluAzureConnectScript) to create the replacement application with the correct permissions.


# Protect your Honolulu-managed Hyper-V Virtual Machines with Azure Site Recovery 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012 and Windows 10

Project Honolulu streamlines the process of replicating your virtual machines on your Hyper-V servers or clusters, making it easier to leverage the power of Azure from your own datacenter. To automate setup, you can connect the Honolulu gateway to Azure.

## What is Azure Site Recovery and how does it work with Honolulu? 

**Azure Site Recovery** is an Azure service that replicates workloads running on VMs so that your business-critical infrastructure is protected in case of a disaster.  [Learn more about Azure Site Recovery](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-overview).

Azure Site Recovery consists of two components: **replication** and **failover**. The replication portion protects your VMs in case of disaster by replicating the target VM's VHD to an Azure storage account. You can then failover these VMs and run them in Azure in the event of a disaster. You can also perform a test failover without impacting your primary VMs to test the recovery process in Azure.

Completing setup for the replication component alone is sufficient to protect your VM in the case of disaster. However, you will not be able to start the VM in Azure until you have configured the failover portion. The failover portion can be setup at the time you wish to failover to an Azure VM, and is not required as part of initial setup. If the host server goes down and you haven't yet configured the failover component, you can configure it at that time and access the workloads of the protected VM. However, it is a good practice to configure the failover related settings before a disaster.
 
## In this guide

This guide outlines the steps to configure replication settings and create a recovery plan from within the Azure portal, enabling Honolulu to start VM replication and protect your VMs.

## Prerequisites and planning

- The target servers hosting the VMs you wish to protect must have Internet access to replicate to Azure.
- [Connect your Honolulu gateway to Azure](https://aka.ms/HonoluluGatewayAzureSetup).
- [Review the capacity planning tool to evaluate the requirements for successful replication and failover](https://docs.microsoft.com/en-us/azure/site-recovery/hyper-v-site-walkthrough-capacity).

## Step 1: Install the ASR agent onto your target host and setup ASR requirements in Azure

> [!NOTE] 
> You need to do this step once per host server or cluster containing VMs targeted for protection.

1. Navigate to the server or cluster hosting VMs you wish to protect (either with Server Manager or Hyper-Converged Cluster Manager).
2. Go to **Virtual Machines** > **Inventory**.
3. Select any VM (this doesn't need to be the VM you want to protect).
4. Select **More** > **Protect VM**.
5. Login to your Azure Account in the popup dialog.
6. Enter the required parameters:

 - **Subscription:** The Azure subscription you want to use for replication of VMs on this host.
 - **Location:** The Azure region where the ASR resources should be created.
 - **Storage Account:** The storage account where replicated VM workloads on this host will be saved.
 - **Vault:** Choose a name for the Azure Site Recovery vault for protected VMs on this host.

7.  Select **Setup ASR**.
8.  Wait until you see the notification: **Site Recovery Setting Completed**.
 
This could take up to 10 minutes. You can watch the progress by going to **Notifications** (the bell icon at the top right).

>[!NOTE]
> This step automatically installs the ASR agent onto the target server or nodes (if configuring on a cluster), creates a **Resource Group** with the **Storage Account** and **Vault** specified, in the **Location** specified. This will also register the target host with the ASR service and configure a default replication policy.

## Step 2: Select Virtual Machines to protect

1. Navigate back to the server or cluster you configured in step 2 above, and go to **Virtual Machines > Inventory**.
2. Select the VM you want to protect.
3. Select **More** > **Protect VM**.
4. Review the [capacity requirements for protecting the VM](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-capacity-planner).

    If you want to use a premium storage account, [create one in the Azure portal](https://docs.microsoft.com/en-us/azure/storage/common/storage-premium-storage). The **Create New** option provided in the Honolulu pane will create a standard storage account.

5. Enter the name of the **Storage Account** to use for this VM's replication and select **Protect VM**. This step enables replication for the selected Virtual Machine. 

6. ASR will start replication. Replication is completed and the VM is protected when the value in the **Protected** column of the **Virtual Machine Inventory** grid changes to **Yes**. This can take several minutes.  

## Step 3: Configure and run a test failover in the Azure Portal

 Although this step does not need to be completed when starting VM replication (the VM will already be protected with just replication), we recommend you configure failover settings when setting up Azure Site Recovery. If you want to prepare for failover to an Azure VM, complete the following steps:

1. [Set up an Azure network](https://docs.microsoft.com/en-us/azure/site-recovery/hyper-v-site-walkthrough-prepare-azure) the failed-over VM will attach to this VNET. Note that the other steps listed in the linked page are completed automatically by Honolulu;  you only need to set up the Azure network.

2. [Run a test failover](https://docs.microsoft.com/en-us/azure/site-recovery/hyper-v-site-walkthrough-test-failover).

## Step 4: Create Recovery plans

**Recovery Plan** is a feature in Azure Site Recovery that lets you failover and recover an entire application comprising a collection of VMs. While it is possible to recover protected VMs individually, by adding the VMs comprising an application to a recovery plan, you'll be able to failover the entire application through the recovery plan. You can also use the test failover feature of Recovery Plan to test the recovery of the application. Recovery Plan lets you group VMs, sequence the order in which they should be brought up during a failover, and automate additional steps to be performed as part of the recovery process. Once you've protected your VMs, you can go to the Azure Site Recovery vault in the Azure portal and create recovery plans for these VMs. [Learn more about recovery plans](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-create-recovery-plans).

## Monitoring replicated VMs in Azure ##

To verify there are no failures in server registration, go to the **Azure portal** > **All resources** > **Recovery Services Vault**  (the one you specified in Step 2) > **Jobs** > **Site Recovery Jobs**.

You can monitor VM replication by going to the **Recovery Services Vault** > **Replicated Items**.

To see all servers that are registered to the vault, go to **Recovery Services Vault** > **Site Recovery Infrastructure** > **Hyper-V hosts** (under the Hyper-V sites section).

## Known issue ##

When registering ASR with a cluster, if a node fails to install ASR or register to the ASR service, your VMs may not be protected. Verify that all nodes in the cluster are registered in the Azure portal by going to the **Recovery Services vault** > **Jobs** > **Site Recovery Jobs**.


# Manage Azure IaaS Virtual Machines with Honolulu

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

You can use Project Honolulu to manage your Azure VMs as well as on-premises machines. There are several different configurations possible. This article will walk through you those options to help you decide which configuration makes sense for your scenario.

## Manage with an on-premises Honolulu gateway

If you've already installed Honolulu on an on-premises gateway (either on Windows 10 or Windows Server 2016), you can use this same gateway to manage Windows 10 or Windows Server 2012, 2012R2, or 2016 VMs in Azure. 

### Connecting to VMs with a public IP

If your target VMs (the VMs you wish to manage with Honolulu) have public IPs, you can add them to your Honolulu gateway by IP address, or by FQDN. There are a couple considerations to take into account:

You must enable WinRM access to your target VM by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

You must also enable inbound connections to port 5985 for WinRM over HTTP in order for Honolulu to manage the target VM:

1. Run the following PS script on the target VM to enable inbound connections to port 5985 on the guest OS:   
`?Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any`

2. You must also open the port in Azure networking:

    - select your Azure VM, select **Networking**, then **Add inbound port rule**. 
    - In the **Port ranges** field, enter **5985**.
    
    If your Honolulu gateway has a static IP, you can select to only allow inbound WinRM access from your Honolulu gateway for added security.
    To do this, select **Advanced** at the top of the "Add inbound security rule" pane.

    For **Source**, select **IP Addresses**, then enter the Source IP address corresponding to your Honolulu gateway.

    - For **Protocol** select **TCP**.
    - The rest can be left as default.

> [!NOTE]
> You must create custom port rule. The WinRM port rule provided by Azure networking uses port 5986 (over HTTPS) instead of 5985 (over HTTP). 

### Connecting to VMs without a public IP

If your target Azure VMs do not have public IPs, and wish to manage these VMs from a Honolulu gateway deployed in your on-premises network, you will need to configure your on-premises network to have connectivity to the VNet on which the target VMs are connected. There are 3 ways you can do this: ExpressRoute, Site-to-Site VPN, or Point-to-Site. [Learn which connectivity option makes sense in your environment.](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-plan-design) 

Ensure WinRM is running on your target VM(s) by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

If you run into any issues, consult [Troubleshoot Project Honolulu](https://docs.microsoft.com/en-us/windows-server/manage/honolulu/honolulu-troubleshoot) to see if additional steps are required for configuration (for example, if you are connecting using a local administrator account or are not domain joined).

## Manage with a Honolulu gateway deployed in Azure

### Deployment considerations
You can manage Azure VMs without any on-premises dependency by deploying Project Honolulu in the VNet where your target VMs are connected. 

To manage VMs outside of the VNet on which the Honolulu gateway is deployed, you must establish VNet-to-VNet connectivity between the VNet of the Honolulu gateway and the VNet of the target servers. This connectivity can be established with VNet Peering, VNet-to-VNet connection, or a Site-to-Site connection. [Learn more about which VNet-to-VNet connectivity option makes sense in your environment.](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-resource-manager-portal)

### Installing Honolulu in an Azure VM
Honolulu can be installed on an existing or newly deployed VM in your environment. The VM that you choose for Honolulu installation must have a public IP and DNS name. 

Before installing Project Honolulu on your desired gateway VM, you will need to install a SSL certificate to use for HTTPS communication, or you can choose to use a self-signed certificate generated by Project Honolulu. However, you will get a warning when trying to connect from a browser if you choose the latter option. You can bypass this warning in Edge by clicking "Details" > "Go on to the webpage" or in Chrome by selecting "Advanced" > "Proceed to [webpage]". We recommend you only use self-signed certificates for test environments.


#### Install Project Honolulu onto your desired gateway VM:
> [!NOTE]
> These instructions are for installing on full server with desktop experience. 

1. Visit [https://aka.ms/HonoluluDownload](https://aka.ms/HonoluluDownload) on your local machine to download Project Honolulu to your local machine 

2. Establish a remote desktop connection to the VM, then copy the MSI from your local machine and paste into the VM

3. Double click the MSI to begin installation and step through the installer

   - By default, the installer chooses port 443 (HTTPS), which is recommended. If you wish to select a different port, note that you will need to open that port in your firewall as well. 

   - If you have already installed an SSL certificate on the VM, ensure you select that option and enter the thumbprint

4. Start the Project Honolulu service (run C:/Program Files/Project Honolulu (Technical Preview)/sme.exe)

[Learn more about deploying Project Honolulu.](https://docs.microsoft.com/en-us/windows-server/manage/honolulu/deployment-guide)

#### Configure your gateway VM to enable HTTPS port access: 

1. Navigate to your VM in the Azure portal and select **Networking**. 

2. Select **Add inbound port rule** and select **HTTPS** under **Service**. 

> [!NOTE]
> If you chose a port other than the default 443, choose **Custom** under Service and enter the port you chose in step 3 under **Port ranges**. 

 

At this point, you should be able to access Project Honolulu from a modern browser (Edge or Chrome) on your local machine by navigating to the DNS name of your gateway VM. 

> [!NOTE]
> If you selected a port other than 443, you can access Project Honolulu by navigating to https://< DNS name of your VM >:< custom port >

In order to add other VMs in the VNet, ensure WinRM is running on the target VMs by running the following in PowerShell or the Command Prompt on the target VM: `winrm quickconfig`

[TODO:legacy-content-end]