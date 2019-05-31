---
ms.assetid: 276a7f7d-5faa-4c00-a51c-3fa511fe52f9
title: Set up an AD FS lab environment
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath

---
# Set up an AD FS lab environment

This topic outlines the steps to configure a test environment that can be used to complete the walkthroughs in the following walkthrough guides:  
  
-   [Walkthrough: Workplace Join with an iOS Device](Walkthrough--Workplace-Join-with-an-iOS-Device.md)  
  
-   [Walkthrough: Workplace Join with a Windows Device](Walkthrough--Workplace-Join-with-a-Windows-Device.md)  
  
-   [Walkthrough Guide: Manage Risk with Conditional Access Control](Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md)  
  
-   [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)  
  
> [!NOTE]  
> We do not recommend that you install the web server and the federation server on the same computer.  
  
To set up this test environment, complete the following steps:  
  
1.  [Step 1: Configure the domain controller (DC1)](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_1)  
  
2.  [Step 2: Configure the federation server (ADFS1) with Device Registration Service](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_4)  
  
3.  [Step 3: Configure the web server (WebServ1) and a sample claims-based application](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_5)  
  
4.  [Step 4: Configure the client computer (Client1)](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_10)  
  
## <a name="BKMK_1"></a>Step 1: Configure the domain controller (DC1)  
For the purposes of this test environment, you can call your root Active Directory domain **contoso.com** and specify <strong>pass@word1</strong> as the administrator password.  
  
-   Install the AD DS role service and install Active Directory Domain Services (AD DS) to make your computer a domain controller in  Windows Server 2012 R2 . This action upgrades your AD DS schema as part of the domain controller creation. For more information and step-by-step instructions, see[https://technet.microsoft.com/ library/hh472162.aspx](https://technet.microsoft.com/library/hh472162.aspx).  
  
### <a name="BKMK_2"></a>Create test Active Directory accounts  
After your domain controller is functional, you can create a test group and test user accounts in this domain and add the user account to the group account. You use these accounts to complete the walkthroughs in the walkthrough guides that are referenced earlier in this topic.  
  
Create the following accounts:  
  
- User: **Robert Hatley** with the following credentials: User name: **RobertH** and password: <strong>P@ssword</strong>  
  
- Group: **Finance**  
  
For information about how to create user and group accounts in Active Directory (AD), see [https://technet.microsoft.com/library/cc783323%28v=ws.10%29.aspx](https://technet.microsoft.com/library/cc783323%28v=ws.10%29.aspx).  
  
Add the **Robert Hatley** account to the **Finance** group. For information on how to add a user to a group in Active Directory, see [https://technet.microsoft.com/library/cc737130%28v=ws.10%29.aspx](https://technet.microsoft.com/library/cc737130%28v=ws.10%29.aspx).  
  
### Create a GMSA account  
The group Managed Service Account (GMSA) account is required during the Active Directory Federation Services (AD FS) installation and configuration.  
  
##### To create a GMSA account  
  
1.  Open a Windows PowerShell command window and type:  
  
    ```  
    Add-KdsRootKey –EffectiveTime (Get-Date).AddHours(-10)  
    New-ADServiceAccount FsGmsa -DNSHostName adfs1.contoso.com -ServicePrincipalNames http/adfs1.contoso.com  
  
    ```  
  
## <a name="BKMK_4"></a>Step 2: Configure the federation server (ADFS1) by using Device Registration Service  
To set up another virtual machine, install  Windows Server 2012 R2  and connect it to the domain **contoso.com**. Set up the computer after you have joined it to the domain, and then proceed to install and configure the AD FS role.  
  
For a video, see [Active Directory Federation Services How-To Video Series: Installing an AD FS Server Farm](https://technet.microsoft.com/video/dn469436).  
  
### Install a server SSL certificate  
You must install a server Secure Socket Layer (SSL) certificate on the ADFS1 server in the local computer store. The certificate MUST have the following attributes:  
  
-   Subject Name (CN): adfs1.contoso.com  
  
-   Subject Alternative Name (DNS): adfs1.contoso.com  
  
-   Subject Alternative Name (DNS): enterpriseregistration.contoso.com  
  
For more information about setting up SSL certificates, see [Configure SSL/TLS on a Web site in the domain with an Enterprise CA](https://social.technet.microsoft.com/wiki/contents/articles/12485.configure-ssltls-on-a-web-site-in-the-domain-with-an-enterprise-ca.aspx).  
  
[Active Directory Federation Services How-To Video Series: Updating Certificates](https://technet.microsoft.com/video/adfs-updating-certificates).  
  
### Install the AD FS server role  
  
##### To install the Federation Service role service  
  
1. Log on to the server by using the domain administrator account administrator@contoso.com.  
  
2. Start Server Manager. To start Server Manager, click **Server Manager** on the Windows **Start** screen, or click **Server Manager** on the Windows taskbar on the Windows desktop. On the **Quick Start** tab of the **Welcome** tile on the **Dashboard** page, click **Add roles and features**. Alternatively, you can click **Add Roles and Features** on the **Manage** menu.  
  
3. On the **Before you begin** page, click **Next**.  
  
4. On the **Select installation type** page, click **Role-based or feature-based installation**, and then click **Next**.  
  
5. On the **Select destination server** page, click **Select a server from the server pool**, verify that the target computer is selected, and then click **Next**.  
  
6. On the **Select server roles** page, click **Active Directory Federation Services**, and then click **Next**.  
  
7. On the **Select features** page, click **Next**.  
  
8. On the **Active Directory Federation Service (AD FS)** page, click **Next**.  
  
9. After you verify the information on the **Confirm installation selections** page, select the **Restart the destination server automatically if required** check box, and then click **Install**.  
  
10. On the **Installation progress** page, verify that everything installed correctly, and then click **Close**.  
  
### Configure the federation server  
The next step is to configure the federation server.  
  
##### To configure the federation server  
  
1.  On the Server Manager **Dashboard** page, click the **Notifications** flag, and then click **Configure the federation service on the server**.  
  
    The **Active Directory Federation Service Configuration Wizard** opens.  
  
2.  On the **Welcome** page, select **Create the first federation server in a federation server farm**, and then click **Next**.  
  
3.  On the **Connect to AD DS** page, specify an account with domain administrator rights for the **contoso.com** Active Directory domain that this computer is joined to, and then click **Next**.  
  
4.  On the **Specify Service Properties** page, do the following, and then click **Next**:  
  
    -   Import the SSL certificate that you have obtained earlier. This certificate is the required service authentication certificate. Browse to the location of your SSL certificate.  
  
    -   To provide a name for your federation service, type **adfs1.contoso.com**. This value is the same value that you provided when you enrolled an SSL certificate in Active Directory Certificate Services (AD CS).  
  
    -   To provide a display name for your federation service, type **Contoso Corporation**.  
  
5.  On the **Specify Service Account** page, select **Use an existing domain user account or group Managed Service Account**, and then specify the GMSA account **fsgmsa** that you created when you created the domain controller.  
  
6.  On the **Specify Configuration Database** page, select **Create a database on this server using Windows Internal Database**, and then click **Next**.  
  
7.  On the **Review Options** page, verify your configuration selections, and then click **Next**.  
  
8.  On the **Pre-requisite Checks** page, verify that all prerequisite checks were successfully completed, and then click **Configure**.  
  
9. On the **Results** page, review the results, check whether the configuration has completed successfully, and then click **Next steps required for completing your federation service deployment**.  
  
### Configure Device Registration Service  
The next step is to configure Device Registration Service on the ADFS1 server. For a video, see [Active Directory Federation Services How-To Video Series: Enabling the Device Registration Service](https://technet.microsoft.com/video/adfs-how-to-enabling-the-device-registration-service).  
  
##### To configure Device Registration Service for Windows Server 2012 RTM  
  
1.  > [!IMPORTANT]  
    > **The following step applies to the Windows Server 2012 R2 RTM build.**  
  
    Open a Windows PowerShell command window and type:  
  
    ```  
    Initialize-ADDeviceRegistration  
    ```  
  
    When you are prompted for a service account, type **contosofsgmsa$**.  
  
    Now run the Windows PowerShell cmdlet.  
  
    ```  
    Enable-AdfsDeviceRegistration  
    ```  
  
2.  On the ADFS1 server, in the **AD FS Management** console, navigate to **Authentication Policies**. Select **Edit Global Primary Authentication**. Select the check box next to **Enable Device Authentication**, and then click **OK**.  
  
### Add Host (A) and Alias (CNAME) Resource Records to DNS  
On DC1, you must ensure that the following Domain Name System (DNS) records are created for Device Registration Service.  
  
|Entry|Type|Address|  
|---------|--------|-----------|  
|adfs1|Host (A)|IP address of the AD FS server|  
|enterpriseregistration|Alias (CNAME)|adfs1.contoso.com|  
  
You can use the following procedure to add a host (A) resource record to corporate DNS name servers for the federation server and Device Registration Service.  
  
Membership in the Administrators group or an equivalent is the minimum requirement to complete this procedure. Review details about using the appropriate accounts and group memberships in the  HYPERLINK "<https://go.microsoft.com/fwlink/?LinkId=83477>" Local and Domain Default Groups (<https://go.microsoft.com/fwlink/p/?LinkId=83477>).  
  
##### To add a host (A) and alias (CNAME) resource records to DNS for your federation server  
  
1.  On DC1, from Server Manager, on the **Tools** menu, click **DNS** to open the DNS snap-in.  
  
2.  In the console tree, expand DC1, expand **Forward Lookup Zones**, right-click **contoso.com**, and then click **New Host (A or AAAA)**.  
  
3.  In **Name,** type the name you want to use for your AD FS farm. For this walkthrough, type **adfs1**.  
  
4.  In **IP address**, type the IP address of the ADFS1 server. Click **Add Host**.  
  
5.  Right-click **contoso.com**, and then click **New Alias (CNAME)**.  
  
6.  In the **New Resource Record** dialog box, type **enterpriseregistration** in the **Alias name** box.  
  
7.  In the Fully Qualified Domain Name (FQDN) of the target host box, type **adfs1.contoso.com**, and then click **OK**.  
  
    > [!IMPORTANT]  
    > In a real-world deployment, if your company has multiple user principal name (UPN) suffixes, you must create multiple CNAME records, one for each of those UPN suffixes in DNS.  
  
## <a name="BKMK_5"></a>Step 3: Configure the web server (WebServ1) and a sample claims-based application  
Set up a virtual machine (WebServ1) by installing the  Windows Server 2012 R2  operating system and connect it to the domain **contoso.com**. After it is joined to the domain, you can proceed to install and configure the Web Server role.  
  
To complete the walkthroughs that were referenced earlier in this topic, you must have a sample application that is secured by your federation server (ADFS1).  
  
You can download Windows Identity Foundation SDK ([https://www.microsoft.com/download/details.aspx?id=4451](https://www.microsoft.com/download/details.aspx?id=4451), which includes a sample claims-based application.  
  
You must complete the following steps to set up a web server with this sample claims-based application.  
  
> [!NOTE]  
> These steps have been tested on a web server that runs the  Windows Server 2012 R2  operating system.  
  
1.  [Install the Web Server Role and Windows Identity Foundation](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_15)  
  
2.  [Install Windows Identity Foundation SDK](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_13)  
  
3.  [Configure the simple claims app in IIS](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_9)  
  
4.  [Create a relying party trust on your federation server](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_11)  
  
### <a name="BKMK_15"></a>Install the Web Server role and Windows Identity Foundation  
  
1. > [!NOTE]  
   > You must have access to the  Windows Server 2012 R2  installation media.  
  
   Log on to WebServ1 by using <strong>administrator@contoso.com</strong> and the password <strong>pass@word1</strong>.  
  
2. From Server Manager, on the **Quick Start** tab of the **Welcome** tile on the **Dashboard** page, click **Add roles and features**. Alternatively, you can click **Add Roles and Features** on the **Manage** menu.  
  
3. On the **Before you begin** page, click **Next**.  
  
4. On the **Select installation type** page, click **Role-based or feature-based installation**, and then click **Next**.  
  
5. On the **Select destination server** page, click **Select a server from the server pool**, verify that the target computer is selected, and then click **Next**.  
  
6. On the **Select server roles** page, select the check box next to **Web Server (IIS)**, click **Add Features**, and then click **Next**.  
  
7. On the **Select features** page, select **Windows Identity Foundation 3.5**, and then click **Next**.  
  
8. On the **Web Server Role (IIS)** page, click **Next**.  
  
9. On the **Select role services** page, select and expand **Application Development**. Select **ASP.NET 3.5**, click **Add Features**, and then click **Next**.  
  
10. On the **Confirm installation selections** page, click **Specify an alternate source path**. Enter the path to the Sxs directory that is located in the  Windows Server 2012 R2  installation media. For example D:SourcesSxs. Click **OK**, and then click **Install**.  
  
### <a name="BKMK_13"></a>Install Windows Identity Foundation SDK  
  
1.  Run WindowsIdentityFoundation-SDK-3.5.msi to install Windows Identity Foundation SDK 3.5 (https://www.microsoft.com/download/details.aspx?id=4451). Choose all of the default options.  
  
### <a name="BKMK_9"></a>Configure the simple claims app in IIS  
  
1.  Install a valid SSL certificate in the computer certificate store. The certificate should contain the name of your web server, **webserv1.contoso.com**.  
  
2.  Copy the contents of C:Program Files (x86)Windows Identity Foundation SDKv3.5SamplesQuick StartWeb ApplicationPassiveRedirectBasedClaimsAwareWebApp to C:InetpubClaimapp.  
  
3.  Edit the **Default.aspx.cs** file so that no claim filtering takes place. This step is performed to ensure that the sample application displays all the claims that are issued by the federation server. Do the following:  
  
    1.  Open **Default.aspx.cs** in a text editor.  
  
    2.  Search the file for the second instance of `ExpectedClaims`.  
  
    3.  Comment out the entire `IF` statement and its braces. Indicate comments by typing “//” (without the quotes) at the beginning of a line.  
  
    4.  Your `FOREACH` statement should now look like this code example.  
  
        ```  
        Foreach (claim claim in claimsIdentity.Claims)  
        {  
           //Before showing the claims validate that this is an expected claim  
           //If it is not in the expected claims list then don’t show it  
           //if (ExpectedClaims.Contains( claim.ClaimType ) )  
           // {  
              writeClaim( claim, table );  
           //}  
        }  
  
        ```  
  
    5.  Save and close **Default.aspx.cs**.  
  
    6.  Open **web.config** in a text editor.  
  
    7.  Remove the entire `<microsoft.identityModel>` section. Remove everything starting from `including <microsoft.identityModel>` and up to and including `</microsoft.identityModel>`.  
  
    8.  Save and close **web.config**.  
  
4.  **Configure IIS Manager**  
  
    1.  Open **Internet Information Services (IIS) Manager**.  
  
    2.  Go to **Application Pools**, right-click **DefaultAppPool** to select **Advanced Settings**. Set **Load User Profile** to **True**, and then click **OK**.  
  
    3.  Right-click **DefaultAppPool** to select **Basic Settings**. Change the **.NET CLR Version** to **.NET CLR Version v2.0.50727**.  
  
    4.  Right-click **Default Web Site** to select **Edit Bindings**.  
  
    5.  Add an **HTTPS** binding to port **443** with the SSL certificate that you have installed.  
  
    6.  Right-click **Default Web Site** to select **Add Application**.  
  
    7.  Set the alias to **claimapp** and the physical path to **c:inetpubclaimapp**.  
  
5.  To configure **claimapp** to work with your federation server, do the following:  
  
    1.  Run FedUtil.exe, which is located in **C:Program Files (x86)Windows Identity Foundation SDKv3.5**.  
  
    2.  Set the application configuration location to **C:inetputclaimappweb.config** and set the application URI to the URL for your site, **https://webserv1.contoso.com /claimapp/**. Click **Next**.  
  
    3.  Select **Use an existing STS** and browse to your AD FS server's metadata URL **https://adfs1.contoso.com/federationmetadata/2007-06/federationmetadata.xml**. Click **Next**.  
  
    4.  Select **Disable certificate chain validation**, and then click **Next**.  
  
    5.  Select **No encryption**, and then click **Next**. On the **Offered claims** page, click **Next**.  
  
    6.  Select the check box next to **Schedule a task to perform daily WS-Federation metadata updates**. Click **Finish**.  
  
    7.  Your sample application is now configured. If you test the application URL **https://webserv1.contoso.com/claimapp**, it should redirect you to your federation server. The federation server should display an error page because you have not yet configured the relying party trust. In other words, you have not secured this test application by AD FS.  
  
You must now secure your sample application that runs on your web server with AD FS. You can do this by adding a relying party trust on your federation server (ADFS1). For a video, see [Active Directory Federation Services How-To Video Series: Add a Relying Party Trust](https://technet.microsoft.com/video/adfs-how-to-add-a-relying-party-trust).  
  
### <a name="BKMK_11"></a>Create a relying party trust on your federation server  
  
1.  On you federation server (ADFS1), in the **AD FS Management console**, navigate to **Relying Party Trusts**, and then click **Add Relying Party Trust**.  
  
2.  On the **Select Data Source** page, select **Import data about the relying party published online or on a local network**, enter the metadata URL for **claimapp**, and then click **Next**. Running FedUtil.exe created a metadata .xml file. It is located at   
    **https://webserv1.contoso.com/claimapp/federationmetadata/2007-06/federationmetadata.xml**.  
  
3.  On the **Specify Display Name** page, specify the **display name** for your relying party trust, **claimapp**, and then click **Next**.  
  
4.  On the **Configure Multi-factor Authentication Now?** page, select **I do not want to specify multi-factor authentication setting for this relying party trust at this time**, and then click **Next**.  
  
5.  On the **Choose Issuance Authorization Rules** page, select **Permit all users to access this relying party**, and then click **Next**.  
  
6.  On the **Ready to Add Trust** page, click **Next**.  
  
7.  On the **Edit Claim Rules** dialog box, click **Add Rule**.  
  
8.  On the **Choose Rule Type** page, select **Send Claims Using a Custom Rule**, and then click **Next**.  
  
9. On the **Configure Claim Rule** page, in the **Claim rule name** box, type **All Claims**. In the **Custom rule** box, type the following claim rule.  
  
    ```  
    c:[ ]  
    => issue(claim = c);  
  
    ```  
  
10. Click **Finish**, and then click **OK**.  
  
## <a name="BKMK_10"></a>Step 4: Configure the client computer (Client1)  
Set up another virtual machine and install Windows 8.1. This virtual machine must be on the same virtual network as the other machines. This machine should NOT be joined to the Contoso domain.  
  
The client MUST trust the SSL certificate that is used for the federation server (ADFS1), which you set up in [Step 2: Configure the federation server (ADFS1) with Device Registration Service](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md#BKMK_4). It must also be able to validate certificate revocation information for the certificate.  
  
You also must set up and use a Microsoft account to log on to Client1.  
  
## See Also  
[Active Directory Federation Services How-To Video Series: Installing an AD FS Server Farm](https://technet.microsoft.com/video/dn469436)  
[Active Directory Federation Services How-To Video Series: Updating Certificates](https://technet.microsoft.com/video/adfs-updating-certificates)  
[Active Directory Federation Services How-To Video Series: Add a Relying Party Trust](https://technet.microsoft.com/video/adfs-how-to-add-a-relying-party-trust)  
[Active Directory Federation Services How-To Video Series: Enabling the Device Registration Service](https://technet.microsoft.com/video/adfs-how-to-enabling-the-device-registration-service)  
[Active Directory Federation Services How-To Video Series: Installing the Web Application Proxy](https://technet.microsoft.com/video/dn469438)  
  
