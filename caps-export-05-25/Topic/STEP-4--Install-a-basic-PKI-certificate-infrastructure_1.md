---
title: STEP 4: Install a basic PKI certificate infrastructure_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3551765-a4ce-440a-aebc-cf4c949f6f59
author: vhorne
---
# STEP 4: Install a basic PKI certificate infrastructure_1
  
## Step 4: Install a basic PKI certificate infrastructure for site\-to\-site certificate authentication method.  
Of the three authentication types available for site\-to\-site connections, EAP, preshared key and certificates, use of certificates is recommended.  In the next step you will change the site\-to\-site authentication method to certificates.  
  
There are three steps to adding a certificate infrastructure.  
  
1.  Install and configure 3\-DC1 as a domain controller.  
  
2.  Install an enterprise root certification authority \(CA\) on 3\-DC1.  
  
3.  Enable computer certificate auto\-enrollment for the corp.fabrikam.com domain.  
  
4.  Configure the client\-server authentication template.  
  
5.  Join 3\-APP1 and 3\-EDGE1 to the corp.fabrikam.com domain  
  
DC1 provides the following services:  
  
-   A domain controller for the corp.fabrikam.com Active Directory Domain Services \(AD DS\) domain  
  
-   A DNS server for the corp.fabrikam.com DNS domain  
  
DC1 configuration consists of the following:  
  
-   Install the operating system  
  
-   Configure TCP\/IP  
  
-   Install active Directory and DNS  
  
-   Create a user account in Active Directory  
  
First, install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as a standalone server.  
  
#### To install the operating system on 3\-DC1  
  
1.  Start the installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Follow the instructions to complete the installation, specifying [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] \(full installation\) and a strong password for the local Administrator account. Log on using the local Administrator account.  
  
3.  Connect 3\-DC1 to a network that has Internet access and run Windows Update to install the latest updates for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
4.  Connect DC1 to the Corpnet subnet.  
  
Next, configure the TCP\/IP protocol with a static IP address of 10.6.0.3 and the subnet mask of 255.255.255.0.  
  
#### To configure TCP\/IP on 3\-DC1  
  
1.  In Server Manager, click **Local Server** in the console tree. Click the link next to **Wired Ethernet Connection**.  
  
    > [!NOTE]  
    > The link may not immediately appear. Wait for the network interfaces to be enumerated.  
  
2.  In **Network Connections**, right\-click **Wired Ethernet Connection**, and then click **Properties**. Note that the "Wired Ethernet Connection" interface name may be different on your computer.  
  
3.  Click **Internet Protocol Version 4 \(TCP\/IPv4\)**, and then click **Properties**.  
  
4.  Select **Use the following IP address**. In IP address, type **10..6.0.3**. In **Subnet mask**, type **255.255.255.0**. Select **Use the following DNS server addresses**. In **Preferred DNS server**, type **127.0.0.1**.  
  
5.  Click **OK** and then close the **Wired Ethernet Properties** dialog.  
  
6.  Close the **Network Connections** window.  
  
7.  In Server Manager, click **Local Server** in the console tree. Click the link next to **Computer name** in the Properties tile.  
  
8.  On the **Computer Name** tab of the **System Properties** dialog, click **Change**.  
  
9. In **Computer name**, type **3\-DC1**, click **OK** twice, and then click **Close**. When you are prompted to restart the computer, click **Restart Now**.  
  
10. After restarting, login using the local Administrator account.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-NetIPAddress -InterfaceAlias "Wired Ethernet Connection" -IPv4Address 10.6.0.3 -PrefixLength 24  
Set-DnsClientServerAddress -InterfaceAlias "Wired Ethernet Connection" -ServerAddresses 127.0.0.1  
Rename-Computer 3-DC1  
Restart-Computer  
```  
  
Next, configure 3\-DC1 as a domain controller and DNS server for the corp.fabrikam.com domain.  
  
#### To configure 3\-DC1 as a domain controller and DNS server  
  
1.  Launch **Server Manager**.  
  
2.  On the **Dashboard** screen, under **Configure this local server**, click **Add roles and features**.  
  
3.  Click **Next** three times to get to the server role selection screen.  
  
4.  In the **Select Server Roles** dialog, select **Active Directory Domain Services**. Click **Add Features** when prompted, and then click **Next**.  
  
5.  In the **Select features** dialog, click **Next**.  
  
6.  In the **Active Directory Domain Services** dialog, click **Next**.  
  
7.  In the **Confirm installation selections** dialog, click **Install**. Wait for the installation to complete.  
  
8.  In the **Installation Progress** dialog, click the **Promote this server to a Domain Controller** link.  
  
    > [!NOTE]  
    > If you close the "Installation Progress" dialog before it presents the promotion link, click the gray Tasks flag in the upper right section of **Server Manager**. When the installation is complete you will see the **Promote this server to a Domain Controller** link.  
  
9. In the **Deployment Configuration** dialog, select **Add a new forest**. In the **Root domain name** field, type **corp.fabrikam.com**. Click **Next**.  
  
10. In the **Domain Controller Options** dialog, leave the default values, specify a strong DSRM password twice, and then click **Next** four times to accept default settings for DNS, NetBIOS, and directory paths.  
  
11. In the **Review Options** dialog, review your selections and then click **Next**.  
  
    > [!NOTE]  
    > You can also click the **View script** button to review and save the PowerShell commands that Server Manager will run during DC Promotion.  
  
12. In the **Prerequisites Check** dialog, allow the validation to complete and verify that no errors are reported.  Since this is the first DNS server deployment in the forest, you can safely ignore all warnings regarding DNS delegation. Click **Install** to start the domain controller promotion. Allow the installation to complete.  
  
13. Allow the domain controller to restart. After the server restarts, logon using the CORP\\Administrator credentials.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)].  
  
```  
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools  
Install-ADDSForest -DomainName corp.fabrikam.com  
  
```  
  
> [!NOTE]  
> Windows PowerShell in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] implements dynamic module loading. Using the **Import\-Module** cmdlet is no longer required; instead, simply invoking the cmdlet, alias, or function automatically loads the module.  To see loaded modules, use the **Get\-Module** cmdlet.  
  
Next, create a user account in Active Directory that will be used when logging in to CORP domain member computers.  
  
#### To create a user account in Active Directory  
  
1.  From the Start screen, click **Active Directory Administrative Center**.  
  
2.  In the console tree, click the arrow to expand **corp \(local\)**, and then double\-click **Users**. This adds Users as a recent navigation link in the console tree.  
  
3.  In the **Tasks** pane, click **New**, and then click **User**.On the **New Object \- User** dialog box, in **Full name**, type **EDGE1**, and in **User logon name**, type **EDGE1**, and then click **Next**.  
  
4.  In the **Create User** dialog, type **EDGE1** next to **Full name** and type **EDGE1** next to **User SamAccountName logon: corp\\**.  
  
5.  In **Password**, type the password that you want to use for this account, and in **Confirm password**, type the password again.  
  
6.  Under **Password options**, select **Other password options**, and select **Password never expires**.  
  
7.  Scroll down to access the **Member of** section of the **Create User** dialog, and click **Add**. Type **Domain Admins; Enterprise Admins**, and then click **OK**.  
  
8.  Click **OK** to close the **Create User** dialog.  
  
9. Exit the Active Directory Administrative Center.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-ADUser -SamAccountName EDGE1 -AccountPassword (read-host "Set user password" -assecurestring) -name "EDGE1" -enabled $true -PasswordNeverExpires $true -ChangePasswordAtLogon $false   
  
Add-ADPrincipalGroupMembership -Identity "CN=EDGE1,CN=Users,DC=corp,DC=fabrikam,DC=com" -MemberOf "CN=Enterprise Admins,CN=Users,DC=corp,DC=contoso,DC=com","CN=Domain Admins,CN=Users,DC=corp,DC=fabrikam,DC=com"  
  
```  
  
#### To install the Certification Services server role on 3\-DC1  
  
1.  On the **Server Manager Dashboard** screen, under **Configure this local server**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select Server Roles** page, select **Active Directory Certificate Services**, click **Add Features** when prompted, and then click **Next**.  
  
4.  Click **Next** three times to accept the default settings, and then click **Install**.  
  
5.  Wait for the installation to complete.  
  
6.  In the **Installation Progress** dialog, click the **Configure Active Directory Certificate Services** on the destination server link.  
  
7.  On the **Credentials** screen, click **Next**.  
  
8.  On the **Role Services** page, select **Certification Authority**, and click **Next**.  
  
9. Click **Next** seven times to accept the default configuration options for Enterprise Root CA.  
  
10. On the confirmation screen, click **Configure**.  
  
11. Verify that configuration succeeded, and click **Close**.  
  
12. Click **Close** in the **Add Roles and Features Wizard**.  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Install-WindowsFeature AD-Certificate -IncludeManagementTools  
Install-AdcsCertificationAuthority -Force  
  
```  
  
Next, configure Group Policy on 3\-DC1 so that domain members automatically request computer certificates.  
  
#### To enable computer certificate auto\-enrollment  
  
1.  On 3\-DC1, from the **Start** screen, click **Group Policy Management**.  
  
2.  In the console tree, open **Forest: corp.contoso.com\\Domains\\corp.contoso.com**.  
  
3.  In the console tree, right\-click **Default Domain Policy**, and then click **Edit**.  
  
4.  In the console tree of the **Group Policy Management Editor**, open **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.  
  
5.  In the details pane, double\-click **Certificate Services Client – Auto\-Enrollment**. In **Configuration Model**, select **Enabled**.  
  
6.  Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**. Click **OK**.  
  
Next, configure a custom client\-server authentication template.  
  
#### To configure the client\-server authentication template  
  
1.  On **3\-DC1**, from the **Start** screen, click **Certification Authority**.  
  
2.  In the details pane, expand **corp\-3\-DC1\-CA**.  
  
3.  Right\-click **Certificate Templates** and select **Manage**.  
  
4.  In the Certificate Templates console, right\-click **Workstation Authentication** and click **Duplicate Template**.  
  
5.  On the **General** tab, change the **Template display name** to **Client\-Server Authentication** and select **Publish certificate in Active Directory**.  
  
6.  On the **Extensions** tab, click **Application Policies** and then click **Edit**. Click **Add**, and then select **Server Authentication**. Click **OK**. Click **Add** and select **IP security IKE intermediate**. Click **OK** twice to return to the **Properties of New Template** dialog..  
  
7.  Click the **Security** tab. For **Domain Computers**, select the checkbox to Allow **Autoenroll**. Click **OK**. Close the **Certificate Templates Console**.  
  
8.  In the **Certification Authority** snap\-in console tree, right\-click **Certificate Templates** and select **New**, and then **Certificate Template to Issue**.On the **Extensions** tab, **click Application Policie**s and then click **Edit**. Click **Add,** and then select **Server Authentication**. Click **OK** twice to return to the **Properties of New Template** dialog.  
  
9. Select **Client\-Server Authentication** and then click **OK**.  
  
10. Close the **Certification Authority console**.  
  
Next, join 3\-EDGE1 to the corp.fabrikam.com domain.  
  
#### To join 3\-EDGE to the corp.fabrikam.com domain  
  
1.  In **Server Manager**, click **Local Server** in the console tree. Click the link next to **Computer name** in the **Properties** tile.  
  
2.  In the **System Properties** dialog box, click the **Computer Name** tab. On the **Computer Name** tab, click **Change**.  
  
3.  In Computer Name, type **APP1**. Under **Member of**, click **Domain**, and then type **corp.contoso.com**.  
  
4.  Click **OK**.  
  
5.  When you are prompted for a user name and password, type **User1** and its password, and then click **OK**.  
  
6.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
7.  When you are prompted that you must restart the computer, click **OK**.  
  
8.  On the **System Properties** dialog box, click **Close**.  
  
9. When you are prompted to restart the computer, click **Restart Now**.  
  
10. After the computer restarts, click the **Switch User arrow icon**, then click **Other User** and log on to the CORP domain with the **User1** account.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Rename-Computer -NewName 3-EDGE1  
Restart-Computer  
Add-Computer -DomainName corp.fabrikam.com  
Restart-Computer  
  
```  
  
#### To obtain an additional certificate for 3\-EDGE1  
  
1.  On 3\-EDGE1, click **Start**, type **mmc** and then click **mmc**. Click **Yes** at the **User Account Control** prompt.  
  
2.  Click **File**, and then click **Add\/Remove Snap\-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the **Certificates** snap\-in, open **Certificates \(Local Computer\)\\Personal\\Certificates**.Click **Next** three times to accept the default settings, and then click **Install**.  
  
5.  Right\-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice  
  
7.  On the **Request Certificates** page, click **Client Server Authentication** and then click **More information is required to enroll for this certificate**.  
  
8.  On the **Subject** tab of the **Certificate Properties** dialog box, in **Subject name**, for **Type**, select **Common Name**.  
  
9. In **Value**, type **3\-EDGE1.corp.fabrikam.com**, and then click **Add**.  
  
10. Click **OK**, click **Enroll**, and then click **Finish**.  
  
11. In the **Details** pane of the **Certificates** snap\-in, verify that a new certificate with the name **3\-EDGE1.corp.fabrikam.com** was enrolled with **Intended Purposes of Client Authentication, Server Authentication, IP security IKE intermediate**.  
  
12. Close the console window. If you are prompted to save settings, click **No**.  
  
#### To install the Certification Services server role on DC1  
  
1.  On the **Server Manager Dashboard** screen, under **Configure this local server**, click **Add roles and features**.  
  
2.  Click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select Server Roles** page, select **Active Directory Certificate Services**, click **Add Features** when prompted, and then click **Next**.  
  
4.  Click **Next** three times to accept the default settings, and then click **Install**.  
  
5.  Wait for the installation to complete.  
  
6.  In the **Installation Progress** dialog, click the **Configure Active Directory Certificate Services** on the destination server link.  
  
7.  On the **Credentials** screen, click **Next**.  
  
8.  On the **Role Services** page, select **Certification Authority**, and click **Next**.  
  
9. Click **Next** seven times to accept the default configuration options for Enterprise Root CA.  
  
10. On the confirmation screen, click **Configure**.  
  
11. Verify that configuration succeeded, and click **Close**.  
  
12. Click **Close** in the **Add Roles and Features Wizard**.  
  
Next, configure Group Policy on DC1 so that domain members automatically request computer certificates.  
  
#### To enable computer certificate auto\-enrollment  
  
1.  On DC1, from the **Start** screen, click **Group Policy Management**.  
  
2.  In the console tree, open **Forest: corp.contoso.com\\Domains\\corp.contoso.com**.  
  
3.  In the console tree, right\-click **Default Domain Policy**, and then click **Edit**.  
  
4.  In the console tree of the **Group Policy Management Editor**, open **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**.  
  
5.  In the details pane, double\-click **Certificate Services Client – Auto\-Enrollment**. In **Configuration Model**, select **Enabled**.  
  
6.  Select **Renew expired certificates, update pending certificates, and remove revoked certificates** and **Update certificates that use certificate templates**. Click **OK**.  
  
Next, configure a custom client\-server authentication template.  
  
#### To configure the client\-server authentication template  
  
1.  On **DC1**, from the **Start** screen, click **Certification Authority**.  
  
2.  In the details pane, expand **corp\-DC1\-CA**.  
  
3.  Right\-click **Certificate Templates** and select **Manage**.  
  
4.  In the Certificate Templates console, right\-click **Workstation Authentication** and click **Duplicate Template**.  
  
5.  On the **General** tab, change the **Template display name** to **Client\-Server Authentication** and select **Publish certificate in Active Directory**.  
  
6.  On the **Extensions** tab, click **Application Policies** and then click **Edit**. Click **Add**, and then select **Server Authentication**. Click **OK**. Click **Add** and select **IP security IKE intermediate**. Click **OK** twice to return to the **Properties of New Template** dialog..  
  
7.  Click the **Security** tab. For **Domain Computers**, select the checkbox to Allow **Autoenroll**. Click **OK**. Close the **Certificate Templates Console**.  
  
8.  In the **Certification Authority** snap\-in console tree, right\-click **Certificate Templates** and select **New**, and then **Certificate Template to Issue**.On the **Extensions** tab, **click Application Policie**s and then click **Edit**. Click **Add,** and then select **Server Authentication**. Click **OK** twice to return to the **Properties of New Template** dialog.  
  
9. Select **Client\-Server Authentication** and then click **OK**.  
  
10. Close the **Certification Authority console**.  
  
Next, join 3\-EDGE1 to the corp.fabrikam.com domain.  
  
#### To join 3\-EDGE to the corp.fabrikam.com domain  
  
1.  In **Server Manager**, click **Local Server** in the console tree. Click the link next to **Computer name** in the **Properties** tile.  
  
2.  In the **System Properties** dialog box, click the **Computer Name** tab. On the **Computer Name** tab, click **Change**.  
  
3.  In Computer Name, type **APP1**. Under **Member of**, click **Domain**, and then type **corp.contoso.com**.  
  
4.  Click **OK**.  
  
5.  When you are prompted for a user name and password, type **User1** and its password, and then click **OK**.  
  
6.  When you see a dialog box welcoming you to the corp.contoso.com domain, click **OK**.  
  
7.  When you are prompted that you must restart the computer, click **OK**.  
  
8.  On the **System Properties** dialog box, click **Close**.  
  
9. When you are prompted to restart the computer, click **Restart Now**.  
  
10. After the computer restarts, click the **Switch User arrow icon**, then click **Other User** and log on to the CORP domain with the **User1** account.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Rename-Computer -NewName 3-EDGE1  
Restart-Computer  
Add-Computer -DomainName corp.fabrikam.com  
Restart-Computer  
  
```  
  
Next, create a user account in Active Directory that will be used when logging in to CORP domain member computers.  
  
#### To create a user account in Active Directory of DC1  
  
1.  From the Start screen, click **Active Directory Administrative Center**.  
  
2.  In the console tree, click the arrow to expand **corp \(local\)**, and then double\-click **Users**. This adds Users as a recent navigation link in the console tree.  
  
3.  In the **Tasks** pane, click **New**, and then click **User**.On the **New Object \- User** dialog box, in **Full name**, type **3\-EDGE1**, and in **User logon name**, type **EDGE1**, and then click **Next**.  
  
4.  In the **Create User** dialog, type **3\-EDGE1** next to **Full name** and type **3\-EDGE1** next to **User SamAccountName logon: corp\\**.  
  
5.  In **Password**, type the password that you want to use for this account, and in **Confirm password**, type the password again.  
  
6.  Under **Password options**, select **Other password options**, and select **Password never expires**.  
  
7.  Scroll down to access the **Member of** section of the **Create User** dialog, and click **Add**. Type **Domain Admins; Enterprise Admins**, and then click **OK**.  
  
8.  Click **OK** to close the **Create User** dialog.  
  
9. Exit the Active Directory Administrative Center.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
New-ADUser -SamAccountName EDGE1 -AccountPassword (read-host "Set user password" -assecurestring) -name "3-EDGE1" -enabled $true -PasswordNeverExpires $true -ChangePasswordAtLogon $false   
  
Add-ADPrincipalGroupMembership -Identity "CN=3-EDGE1,CN=Users,DC=corp,DC=contoso,DC=com" -MemberOf "CN=Enterprise Admins,CN=Users,DC=corp,DC=contoso,DC=com","CN=Domain Admins,CN=Users,DC=corp,DC=contoso,DC=com"  
  
```  
  
#### To obtain an additional certificate for EDGE1  
  
1.  On EDGE1, click **Start**, type **mmc** and then click **mmc**. Click **Yes** at the **User Account Control** prompt.  
  
2.  Click **File**, and then click **Add\/Remove Snap\-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, select **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the **Certificates** snap\-in, open **Certificates \(Local Computer\)\\Personal\\Certificates**.Click **Next** three times to accept the default settings, and then click **Install**.  
  
5.  Right\-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice  
  
7.  On the **Request Certificates** page, click **Client Server Authentication** and then click **More information is required to enroll for this certificate**.  
  
8.  On the **Subject** tab of the **Certificate Properties** dialog box, in **Subject name**, for **Type**, select **Common Name**.  
  
9. In **Value**, type **EDGE1.corp.contoso.com**, and then click **Add**.  
  
10. Click **OK**, click **Enroll**, and then click **Finish**.  
  
11. In the **Details** pane of the **Certificates** snap\-in, verify that a new certificate with the name **EDGE1.corp.contoso.com** was enrolled with **Intended Purposes of Client Authentication, Server Authentication, IP security IKE intermediate**.  
  
12. Close the console window. If you are prompted to save settings, click **No**.  
  
