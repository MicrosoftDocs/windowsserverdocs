---
title: STEP 4 Install and Configure RSA and EDGE1
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess with OTP Authentication and RSA SecurID for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d46ede6f-1a21-414d-b8c3-6b5c87344b9d
ms.author: pashort
author: shortpatti
---
# STEP 4 Install and Configure RSA and EDGE1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

RSA is the RADIUS and OTP server, and is installed prior to configuring RADIUS and OTP.  
  
You will perform the following steps to configure the RSA deployment:  
  
1. Install the operating system on the RSA server. Install  Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012 on the RSA server.  
  
2. Configure TCP/IP on RSA. Configure TCP/IP settings on the RSA server.  
  
3. Copy Authentication Manager installation files to the RSA server. After installing the operating system on RSA, copy the Authentication Manager files to the RSA computer.  
  
4. Join the RSA server to the CORP domain. Join RSA to the CORP domain.  
  
5. Disable Windows Firewall on RSA. Disable the Windows Firewall on the RSA server.  
  
6. Install RSA Authentication Manager on the RSA server. Install RSA Authentication Manager.  
  
7. Configure RSA Authentication Manager. Configure Authentication Manager.  
  
8. Create DAProbeUser. Create a user account for probing purposes.  
  
9. Install RSA SecurID software token on CLIENT1. Install RSA SecurID software token on CLIENT1.  
  
10. Configure EDGE1 as an RSA Authentication Agent. Configure RSA Authentication Agent on EDGE1.  
  
11. Configure EDGE1 to support OTP authentication. Configure OTP for DirectAccess, and verify the configuration.  
  
## <a name="InstallOS"></a>Install the operating system on the RSA server  
  
1.  On RSA, start the installation of  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  .  
  
2.  Follow the instructions to complete the installation, specifying  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  (Full Installation) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect RSA to a network that has Internet access and run Windows Update to install the latest updates for  Windows Server 2016,  Windows Server 2012 R2  or  Windows Server 2012  , and then disconnect from the Internet.  
  
4.  Connect RSA to the Corpnet subnet.  
  
## <a name="TCP"></a>Configure TCP/IP on RSA  
  
1.  In Initial Configuration Tasks, click **Configure networking**.  
  
2.  In **Network Connections**, right-click **Local Area Connection**, and then click **Properties**.  
  
3.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  Click **Use the following IP address**. In **IP address**, type **10.0.0.5**. In **Subnet mask**, type **255.255.255.0**. In **Default Gateway**, type **10.0.0.2**. Click **Use the following DNS server addresses**, in **Preferred DNS server**, type **10.0.0.1**.  
  
5.  Click **Advanced**, and then click the **DNS** tab.  
  
6.  In **DNS suffix for this connection**, type **corp.contoso.com**, and then click **OK** twice.  
  
7.  On the **Local Area Connection Properties** dialog box, click **Close**.  
  
8.  Close the **Network Connections** window.  
  
## <a name="copyinstfiles"></a>Copy Authentication Manager installation files to the RSA server  
  
1.  On the RSA server create the folder C:\RSA Installation.  
  
2.  Copy the contents of the RSA Authentication Manager 7.1 SP4 media to the C:\RSA Installation folder.  
  
3.  Create the subfolder C:\RSA Installation\License and Token.  
  
4.  Copy the RSA license files to C:\RSA Installation\License and Token.  
  
## <a name="JoinDomain"></a>Join the RSA server to the CORP domain  
  
1.  Right-click **My Computer**, and click **Properties**.  
  
2.  In the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
3.  In **Computer Name**, type **RSA**. In **Member of**, click **Domain**, type **corp.contoso.com**, and click **OK**.  
  
4.  When you are prompted for a user name and password, type **User1** and its password, and click **OK**.  
  
5.  On the domain welcoming dialog box click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
9. After the computer has restarted, type **User1** and the password, select CORP in the **Log on to:** drop down list, and click **OK**.  
  
## <a name="BKMK_Firewall"></a>Disable Windows Firewall on RSA  
  
1.  Click **Start**, click **Control Panel**, click **System and Security**, and click **Windows Firewall**.  
  
2.  Click **Turn Windows Firewall on or off**.  
  
3.  **Turn off Windows Firewall** for all settings.  
  
4.  Click **OK** and close Windows Firewall.  
  
## <a name="install"></a>Install RSA Authentication Manager on the RSA server  
  
1.  If the Security Warning message appears at any time during this process, click **Run** to continue.  
  
2.  Open the C:\RSA Installation folder and double-click **autorun.exe**.  
  
3.  Click **Install Now**, click **Next**, select the top option for the Americas, and click **Next**.  
  
4.  Select **I accept the terms of the license agreement**, and click **Next**.  
  
5.  Select **Primary Instance**, and click **Next**.  
  
6.  In the **Directory Name:** field type **C:\RSA**, and click **Next**.  
  
7.  Verify that the server name (RSA.corp.contoso.com) and IP address are correct, and click **Next**.  
  
8.  Browse to C:\RSA Installation\License and Token, and click **Next**.  
  
9. On the **Verify license file** page, click **Next**.  
  
10. In the **User ID** field type **Administrator**, and in the **Password** and **Confirm Password** fields type a strong password. Click **Next**.  
  
11. On the log selection screen, accept the defaults and click **Next**.  
  
12. On the summary screen, click **Install**.  
  
13. After installation is complete, click **Finish**.  
  
## <a name="confiauthmgr"></a>Configure RSA Authentication Manager  
  
1.  If the RSA Security Console does not open automatically, then on the RSA computer desktop double-click "RSA Security Console".  
  
2.  If the security certificate warning / security alert appears, click **Continue to this website** or click **Yes** to proceed, and add this site to trusted sites, if requested.  
  
3.  In the **User ID** field type **Administrator** and click **OK**.  
  
4.  In the **Password** field type the password for the Administrator account and click **Log On**.  
  
5.  Insert Token information.  
  
    1.  In the **RSA Security Console** click **Authentication** and click **SecurID Tokens**.  
  
    2.  Click **Import Tokens Job**, and then click **Add New**.  
  
    3.  In the **Import Options** section click **Browse**. Browse to and select the tokens XML file in the C:\ RSA Installation\License and Token folder and click **Open**.  
  
    4.  Click **Submit Job** on the bottom of the page.  
  
6.  Create OTP new user.  
  
    1.  In the **RSA Security Console** click the **Identity** tab, click **Users**, and click **Add New**.  
  
    2.  In the **Last Name:** section type **User**, and in the **User ID:** section type **User1** (UserID must be the same as the AD username used for this lab).  In the **Password:** and **Confirm Password:** sections type a strong password. Clear the **'Require user to change password at next logon'** check box and click **Save**.  
  
7.  Assign User1 to one of the imported tokens.  
  
    1.  On the **Users** page click **User1** and click **SecurID Tokens**.  
  
    2.  Click **SecurID Tokens** and click **Assign Token**.  
  
    3.  Under the **Serial Number** heading click the first number listed, and click **Assign**.  
  
    4.  Click the assigned token, and click **Edit**. In the **SecurID PIN Management** section for **User Authentication Requirement**, select **Do not require PIN (only tokencode)**.  
  
    5.  Click **Save and Distribute Token**.  
  
    6.  On the **Distribute Software Token** page in the **Basics** section, click **Issue Token File (SDTID)**.  
  
    7.  On the **Distribute Software Token** page in the **Token File Options** section, clear the **Enable copy protection** check box. Click **No Password** and **Next**.  
  
    8.  On the **Distribute Software Token** page in the **Download File** section, click **Download Now**. Click **Save**. Browse to C:\RSA Installation and click **Save** and **Close**.  
  
    9. Minimize the **RSA Security Console** for use later.  
  
8.  Configure Authentication Manager as RADIUS server.  
  
    1.  On the RSA computer desktop double-click **"RSA Security Operations Console"**.  
  
    2.  If the security certificate warning / security alert appears, click **Continue to this website** or click **Yes** to proceed, and add this site to trusted sites if requested.  
  
    3.  Enter the User ID and Password and click **Log On**.  
  
    4.  Click **Deployment Configuration - RADIUS - Configure Server**.  
  
    5.  On the **Additional Credentials Required** page enter the administrator User ID and Password and click **OK**.  
  
    6.  On the **Configure RADIUS Server** page enter the same password used for the administrator user for the **Secrets** and **Master Password**. Enter the Administrator User ID and Password, and click **Configure**.  
  
    7.  Verify that the message **'Successfully configured RADIUS server'** is displayed. Click **Done**. Close the **RSA Operations Console**.  
  
    8.  Switch back to the **"RSA Security Console"**.  
  
    9. On the **RADIUS** tab click **RADIUS Servers**. Verify that rsa.corp.contoso.com is listed.  
  
9. Configure RSA server as RSA Authentication Client.  
  
    1.  On the **RADIUS** tab, click **RADIUS Clients** and **Add New**.  
  
    2.  Click the **ANY RADIUS Client** check box.  
  
    3.  Type a strong password of your choice in the **Shared Secret** field. You will use this same password later when configuring EDGE1 for OTP.  
  
    4.  Leave the **IP Address** field blank, and the **Make / Model** entry as **Standard RADIUS**.  
  
    5.  Click **Save without RSA Agent**.  
  
10. Create files required for configuring EDGE1 as a RSA Authentication Agent.  
  
    1.  On the **Access** tab, highlight **Authentication Agents**, and click **Add New**.  
  
    2.  Type **EDGE1** in the **Hostname** field, and click **Resolve IP**.  
  
    3.  Notice that the IP address for EDGE1 is now displayed in the **IP Address** field. Click **Save**.  
  
11. Generate a configuration file for the EDGE1 server (AM_Config.zip).  
  
    1.  On the **Access** tab, highlight **Authentication Agents**, and click **Generate Configuration File**.  
  
    2.  On the **Generate Configuration File** page click **Generate Config File**, and then click **Download Now**.  
  
    3.  Click **Save**, browse to C:\ RSA Installation, and click **Save**.  
  
    4.  Click **Close** on the **Download Complete** dialog.  
  
12. Generate a node secret file for the EDGE1 server (EDGE1_NodeSecret.zip).  
  
    1.  On the **Access** tab, highlight **Authentication Agents**, and click **Manage Existing**.  
  
    2.  Click the current configured node EDGE1, and click **Manage Node Secret**.  
  
    3.  Check the **Create a new random node secret, and export the node secret to a file** check box.  
  
    4.  Enter the same password used for the administrator user in the **Encryption Password** and **Confirm Encryption Password** fields, and click **Save**.  
  
    5.  On the **Node Secret File Generated** page click **Download Now**.  
  
    6.  On the **File Download** dialog click **Save**, browse to C:\RSA Installation, and click **Save**. Click **Close** on the **Download Complete** dialog.  
  
    7.  From the RSA Authentication Manager media copy \auth_mgr\windows-x86_64\am\rsa-ace_nsload\win32-5.0-x86\agent_nsload.exe to C:\RSA Installation.  
  
## <a name="BKMK_DAProbeUser"></a>Create DAProbeUser  
  
1.  In the **RSA Security Console** click the **Identity** tab, click **Users**, and click **Add New**.  
  
2.  In the **Last Name:** section type **Probe**, and in the **User ID:** section type **DAProbeUser**. In the **Password:** and **Confirm Password:** sections type a strong password. Clear the **'Require user to change password at next logon'** check box and click **Save**.  
  
## <a name="InstToken"></a>Install RSA SecurID software token on CLIENT1  
Use this procedure to install SecurID software token on CLIENT1.  
  
#### Install SecurID software token  
  
1.  On the CLIENT1 computer, create the folder C:\RSA Files. Copy the file Software_Tokens.zip from C:\RSA Installation on the RSA computer to C:\RSA Files. Extract the file User1_000031701832.SDTID to C:\RSA Files on CLIENT1.  
  
2.  Access the RSA SecurID software token media source, and double-click RSASECURIDTOKEN410 in the **SecurID SoftwareToken client app** folder to start the RSA SecurID installation. If the **Open File - Security Warning** message appears, then click **Run**.  
  
3.  On the **RSA SecurID Software Token - InstallShield Wizard** dialog click **Next** twice.  
  
4.  Accept the license agreement, and click **Next**.  
  
5.  On the **Setup Type** dialog select **Typical**, click **Next**, and click **Install**.  
  
6.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
7.  Select the **Launch RSA SecurID Software Token** check box, and click **Finish**.  
  
8.  Click **Import from File**.  
  
9. Click **Browse**, select C:\RSA Files\User1_000031701832.SDTID, and click **Open**.  
  
10. Click **OK** twice.  
  
## <a name="configAuthAgt"></a>Configure EDGE1 as an RSA Authentication Agent  
Use this procedure to configure EDGE1 to perform RSA authentication.  
  
#### Configure the RSA Authentication Agent  
  
1. On EDGE1 open Windows Explorer and create the folder C:\RSA Files. Browse to the RSA ACE Installation media.  
  
2. Copy the files agent_nsload.exe, AM_Config.zip and EDGE1_NodeSecret.zip from the RSA media to C:\RSA Files.  
  
3. Extract the contents of both zip files to the following locations:  
  
   1.  C:\Windows\system32\  
  
   2.  C:\Windows\SysWOW64\  
  
4. Copy agent_nsload.exe to C:\Windows\SysWOW64\\.  
  
5. Open an elevated command prompt and navigate to C:\Windows\SysWOW64.  
  
6. Type **agent_nsload.exe -f nodesecret.rec -p <password>** where <password> is the strong password that you created during the initial RSA configuration. Press Enter.  
  
7. Copy C:\Windows\SysWOW64\securid to C:\Windows\System32.  
  
## <a name="configOTP"></a>Configure EDGE1 to support OTP authentication  
Use this procedure to configure OTP for DirectAccess, and verify the configuration.  
  
#### Configure OTP for DirectAccess  
  
1.  On EDGE1, open Server Manager, and click **REMOTE ACCESS** in the left pane.  
  
2.  Right-click **EDGE1** in the SERVERS pane, and select **Remote Access Management**.  
  
3.  Click **Configuration**.  
  
4.  In the **DirectAccess Setup** window, under **Step 2 - Remote Access Server**, click **Edit**.  
  
5.  Click **Next** three times, and in the **Authentication** section select **Two factor authentication** and **Use OTP**, and ensure that **Use computer certificates** is checked. Verify that the root CA is set to **CN=corp-APP1-CA**. Click **Next**.  
  
6.  In the **OTP RADIUS Server** section, double-click the blank **Server Name** field.  
  
7.  In the **Add a RADIUS Server** dialog, type **RSA** in the **Server name** field. Click **Change** next to the **Shared secret** field, and type the same password that you used when configuring the RADIUS clients on the RSA server in the **New secret** and **Confirm new secret** fields. Click **OK** twice, and click **Next**.  
  
    > [!NOTE]  
    > If the RADIUS server is in a domain that is different than the Remote Access server, then the **Server Name** field must specify the FQDN of the RADIUS server.  
  
8.  In the **OTP CA Servers** section select APP1.corp.contoso.com, and click **Add**. Click **Next**.  
  
9. On the **OTP Certificate Templates** page click **Browse** to select a certificate template used for the enrollment of certificates that are issued for OTP authentication, and on the **Certificate Templates** dialog box select **DAOTPLogon**. Click **OK**. Click **Browse** to select a certificate template used to enroll the certificate used by the Remote Access server to sign OTP certificate enrollment requests, and on the **Certificate Templates** dialog box select **DAOTPRA**. Click **Ok**. Click **Next**.  
  
10. On the **Remote Access Server Setup** page click **Finish**, and click **Finish** on the **DirectAccess Expert Wizard**.  
  
11. On the **Remote Access Review** dialog box click **Apply**, wait for the DirectAccess policy to be updated, and click **Close**.  
  
12. On the **Start** screen, type**powershell.exe**, right-click **powershell**, click **Advanced**, and click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
13. In the Windows PowerShell window, type **gpupdate /force** and press ENTER.  
  
14. Close and reopen the Remote Access Management Console and verify that all OTP settings are correct.  
  


