---
title: Configure hosts for live migration
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5e3c405-cb76-4ff2-8042-c2284448c435
---
# Configure hosts for live migration
This article shows you how to configure hosts that aren't clustered so you can do live migrations between them. To configure clustered hosts, use tools for Failover Clustering.

To configure non-clustered hosts, you'll need: 

-  A user account with permission to perform the various steps. Membership in local Hyper\-V Administrators group or the Administrators group on both the source and destination computers satisfies this requirement, unless you're configuring constrained delegation. Membership in the Domain Administrators group is required to configure constrained delegation.

-  A computer running [!INCLUDE[winthreshold_server_2_mdincludes/winthreshold_server_2_md.md)] with the Hyper\-V management tools installed. For instructions, see [http:\/\/technet.microsoft.com\/library\/hh857623.aspx](http://technet.microsoft.com/library/hh857623.aspx). 

-   The Hyper\-V role in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] is installed on the source and destination servers, and at least one running virtual machine exists on the source computer. For instructions, see [Install the Hyper\-V role and configure a virtual machine](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d).

    > [!WARNING]
    > In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] Hyper\-V live migration has been updated to support migrating Hyper\-V virtual machines in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] to Hyper\-V in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]. Moving a virtual machine to a down\-level server running Hyper\-V is not supported.

-   The source and destination computers either belong to the same Active Directory domain, or belong to domains that trust each other.

In addition to ensuring all prerequisites are met, consider the following planning decisions. These decisions determine how you configure and perform live migrations.

-   Do you plan to sign on to each server to perform the given task \(either through a local console session, a Remote Desktop session, or a remote Windows PowerShell session\), or do you want perform the tasks with remote management tools? The answer determines whether you should select Kerberos or Credential Security Support Provider \(CredSSP\) to authenticate live migration traffic. To manage the tasks with remote management tools, configure constrained delegation and select Kerberos as the authentication protocol. Otherwise, you must sign on to the source computer to perform a live migration, and CredSSP is used to authenticate the live migration.

    > [!NOTE]
    > The requirement of signing in to the source computer has implications that might not be obvious. For example, if you sign in to TestServer01 to move a virtual machine to TestServer02, and then want to move the virtual machine back to TestServer01, the operation will fail unless you sign in to TestServer02 before you try to move the virtual machine back to TestServer01.
    > 
    > If the connection between the source and destination computers cannot be authenticated, an error occurs and the following message is displayed:
    > 
    > **Virtual machine migration operation failed at migration Source.**
    > 
    > **Failed to establish a connection with host***\<computer name>***: No credentials are available in the security package \0x8009030E\).**

-   Live migration performance options. Applies to Hyper\-V in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].

    The performance options can reduce overhead on the network and CPU usage in addition to the reducing the amount of time for a live migration. Hyper\-V administrators can configure the appropriate live migration performance options based on their environment and requirements.

    The following live migrations performance options are available.

    |Option|Description|
    |----------|---------------|
    |TCP\/IP|The memory of the virtual machine is copied to the destination server over a TCP\/IP connection. This is the same method that is used in Hyper\-V in Windows Server 2012.|
    |Compression|The memory content of the virtual machine that is being migrated is compressed and then copied to the destination server over a TCP\/IP connection. **Note:** This is the **default** setting in Hyper\-V in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].|
    |SMB|The memory content of the virtual machine is copied to the destination server over a SMB 3.0 connection.<br /><br />-   SMB Direct is used when the network adapters on the source and destination servers have Remote Direct Memory Access \(RDMA\) capabilities enabled.<br />-   SMB Multichannel automatically detects and uses multiple connections when a proper SMB Multichannel configuration is identified.<br /><br />For more information, see [Improve Performance of a File Server with SMB Direct](Improve-Performance-of-a-File-Server-with-SMB-Direct.md).|

-   Will you allow live migration traffic through any available network, or isolate the traffic to specific networks? As a security best practice, we recommend that you isolate the traffic onto trusted, private networks because live migration traffic is not encrypted when it is sent over the network. Network isolation can be achieved through a physically isolated network or through another trusted networking technology such as VLANs.
## <a name="BKMK_Step1"></a>Step 1: \[Optional\] Configure constrained delegation
If you have decided to use Kerberos to authenticate live migration traffic, configure constrained delegation before you proceed to the rest of the steps. As noted in the “Prerequisites” section, you must use an account that is a member of the Domain Administrators group to configure constrained delegation.

> [!NOTE]
> [!INCLUDE[wps_howtorun](includes/wps_howtorun_md.md)]

#### To configure constrained delegation

1.  Open the Active Directory Users and Computers snap\-in. For example, to do this from Server Manager, select the server if it not already selected. After the server is selected, click **Tools**, and then click **Active Directory Users and Computers**. This opens the Active Directory Users and Computers snap\-in.

2.  From the navigation pane, select the domain and double\-click the **Computers** folder.

3.  From the Computers folder, right\-click the computer account of the source server and then click **Properties**.

4.  In the Properties dialog box, click the **Delegation** tab.

5.  On the delegation tab, select **Trust this computer for delegation to the specified services only**. Under that option, select **Use Kerberos only**.

6.  Click **Add**.

7.  In the Add Services dialog box, click **Users or Computers**.

8.  In the **Select Users or Computers** dialog box, type the name of the destination server. Click **Check Names** to verify that you typed the name correctly, and then click **OK**.

9. In the Add Services dialog box, in the list of available services, do the following and then click **OK**.

    -   To move virtual machine storage, select **cifs**. This is required if you want to move the storage along with the virtual machine, as well as if you want to move only a virtual machine’s storage. If the server is configured to use SMB storage for Hyper\-V, this should already be selected.

    -   To move virtual machines, select **Microsoft Virtual System Migration Service**.

10. On the **Delegation** tab of the Properties dialog box, verify that the services you selected in the previous step are listed as the services to which the destination computer can present delegated credentials. Click **OK**.

11. From the **Computers** folder, select the computer account of the destination server and repeat the process. In the **Select Users or Computers** dialog box, be sure to specify the name of the source server.

    > [!NOTE]
    > The configuration changes do not take effect until the following has occurred:
    > 
    > -   The changes have replicated to the domain controllers that the servers running Hyper\-V are logged into.
    > -   A new kerboros ticket has been issued.

## <a name="BKMK_Step2"></a>Step 2: Configure the source and destination computers for live migration
In this step, you will enable live migrations, configure the source and destination servers so they will send and receive live migrations, optionally configure the authentication protocol. When you configure the servers, you choose whether to allow live migration traffic on any available network, or only on specified networks. As a security best practice, we recommend that you select specific networks to use for live migration traffic, as discussed in the “Prerequisites” section.

#### To configure the source and destination computers for live migration

1.  Open Hyper\-V Manager if it is not already open. \(From Server Manager, click **Tools** and then click **Hyper\-V Manager**.\)

2.  In the navigation pane, select one of the servers that you want to configure for live migrations. \(If none of the servers are listed, click **Hyper\-V Manager** in the navigation pane. Then, in the **Action** pane, click **Connect to Server** and specify each server name. After that, select one of the servers in navigation pane.\)

3.  In the **Action** pane, click **Hyper\-V Settings**.

4.  In Hyper\-V Settings dialog box, click **Live Migrations**.

5.  In the **Live Migrations** pane, check **Enable incoming and outgoing live migrations**.

6.  Under **Simultaneous live migrations**, specify a different number if you don’t want to use the default of 2.

7.  Under **Incoming live migrations**, if you want to use specific network connections to accept live migration traffic, click **Add** to type the IP address information. Otherwise, click **Use any available network for live migration**. Click **OK**.

8.  If you have configured constrained delegation, expand **Live Migrations** and then select **Advanced Features**.

    In the **Advanced Features** pane, under **Authentication protocol**, select Kerberos.

9. Click **OK**.

10. Select the other server in Hyper\-V Manager and repeat the remaining steps.

![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**

[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]

To use Windows PowerShell to configure a server running Hyper\-V for live migration, you can use the Enable\-VMMigration, Set\-VMMigrationNetwork, and Set\-VMHost cmdlets, depending on how you want to configure the host. The following example commands configure live migration on the local host, allow incoming migration traffic only on the specified network, and specify Kerberos as the authentication protocol. Each line represents a separate command.

```
PS C:\> Enable-VMMigration

PS C:\> Set-VMMigrationNetwork 192.168.10.1

PS C:\> Set-VMHost –VirtualMachineMigrationAuthenticationType Kerberos

```

## <a name="BKMK_Performance"></a>Step3: \[optional\] Configure performance options for live migration

> [!NOTE]
> This applies to Hyper\-V in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].

In this step, you configure the live migration performance options. The performance options can reduce overhead on the network and CPU usage in addition to the reducing the amount of time for a live migration. Hyper\-V administrators can configure the appropriate live migration performance options based on their environment and requirements.

#### To configure live migration performance options

1.  From Hyper\-V Manager, in the navigation pane, select one of the servers you want to configure for live migrations.

2.  In the **Action** pane, click **Hyper\-V Settings**.

3.  In the Hyper\-V Settings dialog box, expand **Live Migrations** and then select **Advanced Features**.

4.  In the **Advanced Features** pane, under **Performance options**, select the appropriate option for your environment, and then click **OK**.

    > [!NOTE]
    > When you enable live migration the first time the default setting for **Performance options** is **Compression**.

![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**

[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]

To use Windows PowerShell to configure a server running Hyper\-V for live migration, you can use the Enable\-VMMigration, Set\-VMMigrationNetwork, and Set\-VMHost cmdlets, depending on how you want to configure the host. The following example command sets the live migration performance option to SMB.

```
PS C:\> Set-VMHost -VirtualMachineMigrationPerformanceOption SMB

```


  

