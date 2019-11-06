---
title: Set up hosts for live migration without Failover Clustering
description: "Gives instructions for setting up live migration in a non-clustered environment"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5e3c405-cb76-4ff2-8042-c2284448c435
author: KBDAzure
ms.author: kathydav
ms.date: 9/30/2016
---
# Set up hosts for live migration without Failover Clustering

>Applies To: Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

This article shows you how to set up hosts that aren't clustered so you can do live migrations between them. Use these instructions if you didn't set up live migration when you installed Hyper-V, or if you want to change the settings. To set up clustered hosts, use tools for Failover Clustering.

## Requirements for setting up live migration

To set up non-clustered hosts for live migration, you'll need:

-  A user account with permission to perform the various steps. Membership in the local Hyper-V Administrators group or the Administrators group on both the source and destination computers meets this requirement, unless you're configuring constrained delegation. Membership in the Domain Administrators group is required to configure constrained delegation.

- The Hyper-V role in Windows Server 2016 or Windows Server 2012 R2 installed on the source and destination servers. You can do a live migration between hosts running Windows Server 2016 and Windows Server 2012 R2 if the virtual machine is at least version 5. <br>For version upgrade instructions, see [Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016](Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md). For installation instructions, see [Install the Hyper-V role on Windows Server](../get-started/Install-the-Hyper-V-role-on-Windows-Server.md).

- Source and destination computers that either belong to the same Active Directory domain, or belong to domains that trust each other.
- The Hyper-V management tools installed on a computer running Windows Server 2016 or Windows 10, unless the tools are installed on the source or destination server and you'll run the tools from the server.

## Consider options for authentication and networking

Consider how you want to set up the following:

-  **Authentication**: Which protocol will be used to authenticate live migration traffic between the source and destination servers? The choice determines whether you'll need to sign on to the source server before starting a live migration:
   - Kerberos lets you avoid having to sign in to the server, but requires constrained delegation to be set up. See below for instructions.
   - CredSSP lets you avoid configuring constrained delegation, but requires you sign in to the source server. You can do this  through a local console session, a Remote Desktop session, or a remote Windows PowerShell session.

      CredSPP requires signing in for situations that might not be obvious. For example, if you sign in to TestServer01 to move a virtual machine to TestServer02, and then want to move the virtual machine back to TestServer01, you'll need to sign in to TestServer02 before you try to move the virtual machine back to TestServer01. If you don't do this, the authentication attempt fails, an error occurs, and the following message is displayed:

      "Virtual machine migration operation failed at migration Source.
      Failed to establish a connection with host *computer name*: No credentials are available in the security package 0x8009030E."

-   **Performance**: Does it makes sense to configure performance options? These options can reduce network and CPU usage, as well as make live migrations go faster. Consider your requirements and your infrastructure, and test different configurations to help you decide. The options are described at the end of step 2.

-  **Network preference**: Will you allow live migration traffic through any available network, or isolate the traffic to specific networks? As a security best practice, we recommend that you isolate the traffic onto trusted, private networks because live migration traffic is not encrypted when it is sent over the network. Network isolation can be achieved through a physically isolated network or through another trusted networking technology such as VLANs.

## <a name="BKMK_Step1"></a>Step 1: Configure constrained delegation (optional)
If you have decided to use Kerberos to authenticate live migration traffic, configure constrained delegation using an account that is a member of the Domain Administrators group.

### Use the Users and Computers snap-in to configure constrained delegation

1.  Open the Active Directory Users and Computers snap-in. (From Server Manager, select the server if it's not selected, click **Tools** >> **Active Directory Users and Computers**).

2.  From the navigation pane in **Active Directory Users and Computers**, select the domain and double-click the **Computers** folder.

3.  From the **Computers** folder, right-click the computer account of the source server and then click **Properties**.

4.  From **Properties**, click the **Delegation** tab.

5.  On the delegation tab, select **Trust this computer for delegation to the specified services only** and then select **Use any authentication protocol**.

6.  Click **Add**.

7.  From **Add Services**, click **Users or Computers**.

8.  From **Select Users or Computers**, type the name of the destination server. Click **Check Names** to verify it, and then click **OK**.

9. From **Add Services**, in the list of available services, do the following and then click **OK**:

    -   To move virtual machine storage, select **cifs**. This is required if you want to move the storage along with the virtual machine, as well as if you want to move only a virtual machine's storage. If the server is configured to use SMB storage for Hyper-V, this should already be selected.

    -   To move virtual machines, select **Microsoft Virtual System Migration Service**.

10. On the **Delegation** tab of the Properties dialog box, verify that the services you selected in the previous step are listed as the services to which the destination computer can present delegated credentials. Click **OK**.

11. From the **Computers** folder, select the computer account of the destination server and repeat the process. In the **Select Users or Computers** dialog box, be sure to specify the name of the source server.

The configuration changes take effect after both of the following happen:

  -  The changes are replicated to the domain controllers that the servers running Hyper-V are logged into.
  -  The domain controller issues a new Kerberos ticket.

## <a name="BKMK_Step2"></a>Step 2: Set up the source and destination computers for live migration
This step includes choosing options for authentication and networking. As a security best practice, we recommend that you select specific networks to use for live migration traffic, as discussed above. This step also shows you how to choose the performance option.

### Use Hyper-V Manager to set up the source and destination computers for live migration

1.  Open Hyper-V Manager. (From Server Manager, click **Tools** >>**Hyper-V Manager**.)

2.  In the navigation pane, select one of the servers. (If it isn't listed, right-click **Hyper-V Manager**, click **Connect to Server**, type the server name, and click **OK**. Repeat to add more servers.)

3.  In the **Action** pane, click **Hyper-V Settings** >>**Live Migrations**.

4.  In the **Live Migrations** pane, check **Enable incoming and outgoing live migrations**.

5.  Under **Simultaneous live migrations**, specify a different number if you don't want to use the default of 2.

6.  Under **Incoming live migrations**, if you want to use specific network connections to accept live migration traffic, click **Add** to type the IP address information. Otherwise, click **Use any available network for live migration**. Click **OK**.

7.  To choose Kerberos and performance options, expand **Live Migrations** and then select **Advanced Features**.

    - If you have configured constrained delegation, under **Authentication protocol**, select **Kerberos**.
    - Under **Performance options**, review the details and choose a different option if it's appropriate for your environment.

8. Click **OK**.

9. Select the other server in Hyper-V Manager and repeat the steps.

### Use Windows PowerShell to set up the source and destination computers for live migration

Three cmdlets are available for configuring live migration on non-clustered hosts: [Enable-VMMigration](https://technet.microsoft.com/library/hh848544.aspx), [Set-VMMigrationNetwork](https://technet.microsoft.com/library/hh848467.aspx), and [Set-VMHost](https://technet.microsoft.com/library/hh848524.aspx). This example uses all three and does the following:
  - Configures live migration on the local host
  - Allows incoming migration traffic only on a specific network
  - Chooses Kerberos as the authentication protocol

Each line represents a separate command.

```PowerShell
PS C:\> Enable-VMMigration

PS C:\> Set-VMMigrationNetwork 192.168.10.1

PS C:\> Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos
```

Set-VMHost also lets you choose a performance option (and many other host settings). For example, to choose SMB but leave the authentication protocol set to the default of CredSSP, type:

```PowerShell
PS C:\> Set-VMHost -VirtualMachineMigrationPerformanceOption SMB
```

This table describes how the performance options work.

|Option|Description|
|----------|---------------|
    |TCP/IP|Copies the memory of the virtual machine to the destination server over a TCP/IP connection.|
    |Compression|Compresses the memory content of the virtual machine before copying it to the destination server over a TCP/IP connection. **Note:** This is the **default** setting.|
    |SMB|Copies the memory of the virtual machine to the destination server over a SMB 3.0 connection.<br /><br />- SMB Direct is used when the network adapters on the source and destination servers have Remote Direct Memory Access (RDMA) capabilities enabled.<br />- SMB Multichannel automatically detects and uses multiple connections when a proper SMB Multichannel configuration is identified.<br /><br />For more information, see [Improve Performance of a File Server with SMB Direct](https://technet.microsoft.com/library/jj134210(WS.11).aspx).|

 ## Next steps

 After you set up the hosts, you're ready to do a live migration. For instructions, see [Use live migration without Failover Clustering to move a virtual machine](../manage/Use-live-migration-without-Failover-Clustering-to-move-a-virtual-machine.md).
