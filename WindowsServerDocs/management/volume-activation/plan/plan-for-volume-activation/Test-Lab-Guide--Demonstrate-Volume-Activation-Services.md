---
title: Test Lab Guide: Demonstrate Volume Activation Services
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d4804395-4923-4ab0-9dc4-6d1f145ac69d
---
# Test Lab Guide: Demonstrate Volume Activation Services
This test lab guide describes the steps for configuring the Volume Activation Services server role in a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] demonstration or test environment. Although the same steps can be used to deploy Volume Activation Services in a production environment, additional planning would be needed to ensure that your Volume Activation Services deployment meets the needs of your environment.

## Setting up Volume Activation Services in a test environment
The following steps are needed to set up Volume Activation Services in a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] test lab:

1.  Step 1: Set up the base test lab configuration

2.  Step 2: Install the Volume Activation Services server role

3.  Step 3: Configure Active Directory\-based Activation

4.  Step 4: Verify that Active Directory\-based Activation works

5.  Step 5: Configure Key Management Services \(KMS\)

6.  Step 6: Verify that KMS volume activation works

### Step 1: Set up the base test lab infrastructure
Test labs enable you to get valuable hands\-on experience with new products and technologies. The following base test lab configuration uses a predefined and tested methodology that results in a working configuration. The following instructions define what servers to create, how to configure the operating systems and system services, and how to install and configure additional products or technologies. This enables you to see all of the front\-end and back\-end components that are required for a product or technology, such as Volume Activation Services, or for a multiproduct or technology solution.

##### To prepare a base test lab infrastructure

1.  Create the base configuration test lab as described in the following document: [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/?LinkId=236358) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=236358\). The base configuration test lab contains the following computers:

    -   **DC1** A domain controller running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)].

        > [!NOTE]
        > AD DS must be at the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] schema level to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] version of Adprep.exe. For more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx).A new installation of [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and AD DS with the configuration settings that are described in the base configuration test lab guide will be at the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] schema level.

    -   **APP1** A computer running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] that can be configured as a Key Management Service host.

    -   **CLIENT1** A computer running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] to serve as a volume licensing client for Active Directory\-based Activation.

    -   **CLIENT2 \(optional\)** A computer running Windows 7 or Windows Server 2008 R2 that is added to the base configuration to test Active Directory\-based Activation and KMS activation at the same time.

        > [!NOTE]
        > Configuration of CLIENT2 is not covered in the base configuration test lab guide.

2.  Complete all the network configuration tasks for the base test lab.

    > [!NOTE]
    > Local administrator permissions are needed on all computers in this configuration to complete these setup steps. Enterprise admin permissions are needed to manage or modify Active Directory Domain Services on DC1.

### Step 2: Install the Volume Activation Services server role
The Volume Activation server role can be installed by using Windows Server Manager, Windows PowerShell DISM cmdlets, or Windows PowerShell ServerManager cmdlets.

##### To install Volume Activation Services by using Server Manager:

1.  On either server running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], open **Windows Server Manager**

2.  Click **Manage**, click **Add Roles and Features**, and then click **Next**.

3.  On the **Select installation type** page, select **Role\-based or Feature\-based installation**, and then click **Next**.

4.  On the **Select destination server** page, select DC1 from the **SERVER POOL**, and then click **Next**.

5.  On the **Select server roles** page, select **Volume Activation Services**, and then click **Next** three times.

6.  On the **Confirm installation selections** page, confirm that the information is correct, then click **Install**.

7.  On the **Installation progress** page, wait until the progress indicator shows that the installation was successful. Because additional configuration is required, click the **Volume Activation Tools** link. At this point, move to Steps 3 or 5 later in this document to configure either KMS\-based volume activation or Active Directory\-based Activation.

##### To install the Volume Activation Services by using the DISM cmdlets

1.  To import the DISM cmdlets, open a Command Prompt window, type **import\-module dism**, and then press ENTER.

2.  Open a Windows PowerShell console and at the command prompt, type the following command, then press ENTER: **enable\-windowsoptionalfeature \-online \-featurename VolumeActivation\-Full\-Role**

##### To install the Volume Activation Services by using the ServerManager cmdlets

1.  To import the ServerManager cmdlets, open a Command Prompt window and type: **import\-module servermanager**

2.  Open a Windows PowerShell console and at the command prompt, type the following command, then press ENTER: **Install\-WindowsFeature VolumeActivation**

### Step 3: Configure Active Directory\-based Activation

##### To configure Active Directory\-based Activation

1.  On DC1, open Server Manager, select **Tools**, and then click **Volume Activation Tools**.

2.  On the **Select Volume Activation Method** page, select **Active Directory\-based Activation**. If the account you are currently using does not have enterprise administrator permissions, enter the credentials for an account that has permissions to create a new container on the domain controller, and then click **Next**.

3.  Enter the KMS host key and an optional name for the Active Directory object, and then click **Next**.

    > [!NOTE]
    > Although license data is presented in English, the optional name option supports the Unicode character set, which enables you to more easily identify each volume license key in any language.

4.  Activate the key online or by phone, and then click **Commit**. If you have no other changes, click **Close**.

After the KMS host key has been activated, client computers that are joined to a domain running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] with generic volume license keys \(GVLKs\) installed will automatically activate without user intervention.

### Step 4: Verify that Active Directory\-based Activation works
All Active Directory\-based Activation events are logged to the Windows Application event log under the Source: Microsoft\-Windows\-Security\-SPP. Look at Event 12308 for confirming information.

With clients running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], activation should occur automatically the next time the computer is started and the user logs on.

> [!NOTE]
> If you set up multiple domain controllers, replication between domain controllers must be complete before clients can access this data. Therefore, in a production environment, you might need to wait until replication is complete before you start the client system and the user logs on to complete Active Directory\-based Activation.

##### To verify that Active Directory\-based Activation works

1.  Log on to CLIENT1.

2.  Open Windows Explorer, right\-click **Computer**, and select **Properties**.

3.  Scroll down to the **Windows activation** section and verify that this client has been activated.

> [!IMPORTANT]
> Active Directory\-based Activation will not work for operating systems earlier than [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]. It also will not work with Microsoft Office 2010. Use KMS volume activation to activate Windows clients and applications that do not support Active Directory\-based Activation.

### Step 5: Configure Key Management Services
In earlier versions of Windows, Key Management Services \(KMS\) could be installed only from the command line. The following procedure describes how to complete this task by using the Volume Activation Tools console in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)].

##### To configure KMS

1.  On DC1, open the **Volume Activation Tools** console.

    If you did not open the console when you completed the server role installation in Step 2, open Server Manager, click **Volume Activation Services**, right\-click the name of the server on which you installed the server role, and then select **Volume Activation Tools**. When the Volume Activation Tools console is open, click **Next**.

2.  Select **Key Management Service \(KMS\)** and select APP1 as the server that you want to install KMS on.

3.  If the account you are using does not have administrator permissions on APP1, enter the User name and Password for an account that does in the boxes, and then click **Alternate credentials \(optional\)**.

    After you have completed both tasks, click **Next**.

4.  On the **Manage KMS Host** page, enter your **KMS host key**, and then click **Commit**.

5.  On the **Product Key Installation Succeeded** page, click **Activate Products**, and then click **Next**.

6.  Activate your key online or by phone, and then click **Next**.

7.  On the **Configure Key Management Service options** page, review the default configuration options, click **Commit**, and then click **Close** if you have no other changes.

    > [!NOTE]
    > Administrators should validate the firewall configurations in their environment to ensure that the appropriate exceptions are enabled for KMS traffic. If you need to change the firewall or other default options at a later date, you can open the Volume Activation Tools console and return to this dialog box at any time to modify the configuration.

### Step 6: Verify that KMS volume activation works
You can verify KMS volume activation from the KMS host server, APP1 and from the client computer, CLIENT2.

> [!NOTE]
> If you set up and configured Active Directory\-based Activation before configuring KMS activation, you must use a client computer that is not running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]to verify that KMS activation works. Otherwise, the activation will be complete before your clients contact the server that is hosting KMS.

> [!IMPORTANT]
> KMS volume activation requires a minimum threshold of 25 computers before activation quests will be processed. The verification process described here will increment the activation count each time a client computer contacts the KMS host. However, unless the activation threshold is reached, the verification will take the form of an error message rather than a confirmation message.

##### To verify that KMS volume activation works

1.  On APP1, open the event log and confirm that DNS publishing is successful.

    On CLIENT2, open a Command Prompt window, type **Slmgr.vbs \/ato**, and then press ENTER. The response should show the license state and detailed Windows version information.

2.  On either CLIENT2 or APP1, open an elevated Command Prompt window, type **Slmgr \/dlv**, and then press ENTER. The response should return an error that states the KMS activation count is too low. This confirms that KMS is functioning correctly, even though the client has not been activated.

## Additional information
For more information about Volume Activation Services, see the [Volume Activation Overview](Volume-Activation-Overview.md).

For more information that can help you prepare to deploy Volume Activation Services in your organization, see [Plan for Volume Activation](../Plan-for-Volume-Activation.md).

For more information about Microsoft test lab guides, see [Test Lab Guides](http://go.microsoft.com/fwlink/?LinkID=202817) on the Microsoft TechNet Wiki.

To provide the authors of this guide with feedback or suggestions for improvement, send an email message to [tlgfb@microsoft.com](mailto:tlgfb@microsoft.com).


