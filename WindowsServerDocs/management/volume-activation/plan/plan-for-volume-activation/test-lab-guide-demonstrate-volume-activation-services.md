---
title: Test Lab Guide: Demonstrate volume Activation Services
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d4804395-4923-4ab0-9dc4-6d1f145ac69d
---
# Test Lab Guide: Demonstrate volume Activation Services
This test lab guide describes the steps for configuring the volume Activation Services server role in a  Windows Server 2012  demonstration or test environment. Although the same steps can be used to deploy volume Activation Services in a production environment, additional planning would be needed to ensure that your volume Activation Services deployment meets the needs of your environment.

## Setting up volume Activation Services in a test environment
The following steps are needed to set up volume Activation Services in a  Windows Server 2012  test lab:

1.  Step 1: Set up the base test lab configuration

2.  Step 2: Install the volume Activation Services server role

3.  Step 3: Configure active directory\-based Activation

4.  Step 4: verify that active directory\-based Activation works

5.  Step 5: Configure Key management Services \(KMS\)

6.  Step 6: verify that KMS volume activation works

### Step 1: Set up the base test lab infrastructure
Test labs enable you to get valuable hands\-on experience with new products and technologies. The following base test lab configuration uses a predefined and tested methodology that results in a working configuration. The following instructions define what servers to create, how to configure the operating systems and system services, and how to install and configure additional products or technologies. This enables you to see all of the front\-end and back\-end components that are required for a product or technology, such as volume Activation Services, or for a multiproduct or technology solution.

##### To prepare a base test lab infrastructure

1.  create the base configuration test lab as described in the following document: [Test Lab Guide: Base Configuration](http://go.microsoft.com/fwlink/?LinkId=236358) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=236358\). The base configuration test lab contains the following computers:

    -   **DC1** A domain controller running  Windows Server 2012 .

        > [!NOTE]
        > AD DS must be at the  Windows Server 2012  schema level to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the  Windows Server 2012  version of Adprep.exe. for more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx).A new installation of  Windows Server 2012  and AD DS with the configuration settings that are described in the base configuration test lab guide will be at the  Windows Server 2012  schema level.

    -   **APP1** A computer running  Windows Server 2012  that can be configured as a Key management Service host.

    -   **CLIENT1** A computer running Windows 8 or  Windows Server 2012  to serve as a volume licensing client for active directory\-based Activation.

    -   **CLIENT2 \(optional\)** A computer running Windows 7 or Windows Server 2008 R2 that is added to the base configuration to test active directory\-based Activation and KMS activation at the same time.

        > [!NOTE]
        > Configuration of CLIENT2 is not covered in the base configuration test lab guide.

2.  complete all the network configuration tasks for the base test lab.

    > [!NOTE]
    > Local administrator permissions are needed on all computers in this configuration to complete these setup steps. Enterprise admin permissions are needed to manage or modify active directory Domain Services on DC1.

### Step 2: Install the volume Activation Services server role
The volume Activation server role can be installed by using Windows Server manager, Windows powershell DISM cmdlets, or Windows powershell Servermanager cmdlets.

##### To install volume Activation Services by using Server manager:

1.  On either server running  Windows Server 2012 , open **Windows Server manager**

2.  Click **manage**, click **add Roles and Features**, and then click **Next**.

3.  On the **select installation type** page, select **Role\-based or Feature\-based installation**, and then click **Next**.

4.  On the **select destination server** page, select DC1 from the **SERver POOL**, and then click **Next**.

5.  On the **select server roles** page, select **volume Activation Services**, and then click **Next** three times.

6.  On the **Confirm installation selections** page, confirm that the information is correct, then click **Install**.

7.  On the **Installation progress** page, wait until the progress indicator shows that the installation was successful. Because additional configuration is required, click the **volume Activation Tools** link. at this point, move to Steps 3 or 5 later in this document to configure either KMS\-based volume activation or active directory\-based Activation.

##### To install the volume Activation Services by using the DISM cmdlets

1.  To import the DISM cmdlets, open a Command prompt window, type **import\-module dism**, and then press ENTER.

2.  Open a Windows powershell console and at the command prompt, type the following command, then press ENTER: **enable\-windowsoptionalfeature \-online \-featurename volumeActivation\-Full\-Role**

##### To install the volume Activation Services by using the Servermanager cmdlets

1.  To import the Servermanager cmdlets, open a Command prompt window and type: **import\-module servermanager**

2.  Open a Windows powershell console and at the command prompt, type the following command, then press ENTER: **Install\-WindowsFeature volumeActivation**

### Step 3: Configure active directory\-based Activation

##### To configure active directory\-based Activation

1.  On DC1, open Server manager, select **Tools**, and then click **volume Activation Tools**.

2.  On the **select volume Activation Method** page, select **active directory\-based Activation**. if the account you are currently using does not have enterprise administrator permissions, enter the credentials for an account that has permissions to create a new container on the domain controller, and then click **Next**.

3.  Enter the KMS host key and an optional name for the active directory object, and then click **Next**.

    > [!NOTE]
    > Although license data is presented in English, the optional name option supports the Unicode character set, which enables you to more easily identify each volume license key in any language.

4.  Activate the key online or by phone, and then click **Commit**. if you have no other changes, click **Close**.

After the KMS host key has been activated, client computers that are joined to a domain running  Windows Server 2012  or Windows 8 with generic volume license keys \(GVLKs\) installed will automatically activate without user intervention.

### Step 4: verify that active directory\-based Activation works
All active directory\-based Activation events are logged to the Windows Application event log under the Source: Microsoft\-Windows\-Security\-SPP. Look at Event 12308 for confirming information.

With clients running  Windows Server 2012  or Windows 8, activation should occur automatically the next time the computer is started and the user logs on.

> [!NOTE]
> if you set up multiple domain controllers, replication between domain controllers must be complete before clients can access this data. Therefore, in a production environment, you might need to wait until replication is complete before you start the client system and the user logs on to complete active directory\-based Activation.

##### To verify that active directory\-based Activation works

1.  Log on to CLIENT1.

2.  Open Windows Explorer, right\-click **computer**, and select **Properties**.

3.  Scroll down to the **Windows activation** section and verify that this client has been activated.

> [!importANT]
> active directory\-based Activation will not work for operating systems earlier than  Windows Server 2012  or Windows 8. It also will not work with Microsoft Office 2010. Use KMS volume activation to activate Windows clients and applications that do not support active directory\-based Activation.

### Step 5: Configure Key management Services
In earlier versions of Windows, Key management Services \(KMS\) could be installed only from the command line. The following procedure describes how to complete this task by using the volume Activation Tools console in  Windows Server 2012 .

##### To configure KMS

1.  On DC1, open the **volume Activation Tools** console.

    if you did not open the console when you completed the server role installation in Step 2, open Server manager, click **volume Activation Services**, right\-click the name of the server on which you installed the server role, and then select **volume Activation Tools**. When the volume Activation Tools console is open, click **Next**.

2.  select **Key management Service \(KMS\)** and select APP1 as the server that you want to install KMS on.

3.  if the account you are using does not have administrator permissions on APP1, enter the User name and Password for an account that does in the boxes, and then click **Alternate credentials \(optional\)**.

    After you have completed both tasks, click **Next**.

4.  On the **manage KMS Host** page, enter your **KMS host key**, and then click **Commit**.

5.  On the **Product Key Installation Succeeded** page, click **Activate Products**, and then click **Next**.

6.  Activate your key online or by phone, and then click **Next**.

7.  On the **Configure Key management Service options** page, review the default configuration options, click **Commit**, and then click **Close** if you have no other changes.

    > [!NOTE]
    > Administrators should validate the firewall configurations in their environment to ensure that the appropriate exceptions are enabled for KMS traffic. if you need to change the firewall or other default options at a later date, you can open the volume Activation Tools console and return to this dialog box at any time to modify the configuration.

### Step 6: verify that KMS volume activation works
You can verify KMS volume activation from the KMS host server, APP1 and from the client computer, CLIENT2.

> [!NOTE]
> if you set up and configured active directory\-based Activation before configuring KMS activation, you must use a client computer that is not running Windows 8 or  Windows Server 2012 to verify that KMS activation works. Otherwise, the activation will be complete before your clients contact the server that is hosting KMS.

> [!importANT]
> KMS volume activation requires a minimum threshold of 25 computers before activation quests will be processed. The verification process described here will increment the activation count each time a client computer contacts the KMS host. However, unless the activation threshold is reached, the verification will take the form of an error message rather than a confirmation message.

##### To verify that KMS volume activation works

1.  On APP1, open the event log and confirm that DNS publishing is successful.

    On CLIENT2, open a Command prompt window, type **Slmgr.vbs \/ato**, and then press ENTER. The response should show the license state and detailed Windows version information.

2.  On either CLIENT2 or APP1, open an elevated Command prompt window, type **Slmgr \/dlv**, and then press ENTER. The response should return an error that states the KMS activation count is too low. This confirms that KMS is functioning correctly, even though the client has not been activated.

## additional information
for more information about volume Activation Services, see the [volume Activation Overview]().

for more information that can help you prepare to deploy volume Activation Services in your organization, see [plan for volume Activation](../plan-volume-activation.md).

for more information about Microsoft test lab guides, see [Test Lab Guides](http://go.microsoft.com/fwlink/?LinkID=202817) on the Microsoft TechNet Wiki.

To provide the authors of this guide with feedback or suggestions for improvement, send an email message to [tlgfb@microsoft.com](mailto:tlgfb@microsoft.com).


