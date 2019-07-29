---
title: "Integrate an On-Premises Exchange Server with Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b56a21e2-c9e3-4ba9-97d9-719ea6a0854b
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Integrate an On-Premises Exchange Server with Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This guide provides information and basic instructions to help you set up and integrate an on-premises server that is running Exchange Server with a server that is running Windows Server Essentials.  

 You should read this guide before attempting to deploy an on-premises server that is running Exchange Server on a Windows Server Essentials network.  

> [!NOTE]
>  Exchange Server 2010 does not support installation on computers that are running Windows Server 2012.  

## Prerequisites  
 Before installing Exchange Server on a Windows Server Essentials network, make sure that you complete the tasks outlined in this section.  

-   [Set up a server that is running Windows Server Essentials](Integrate-an-On-Premises-Exchange-Server-with-Windows-Server-Essentials.md#BKMK_SetUpSBS8)  

-   [Prepare a second server on which to install Exchange Server](Integrate-an-On-Premises-Exchange-Server-with-Windows-Server-Essentials.md#BKMK_SecondServer)  

-   [Configure your Internet domain name](Integrate-an-On-Premises-Exchange-Server-with-Windows-Server-Essentials.md#BKMK_DomainNames)  

###  <a name="BKMK_SetUpSBS8"></a> Set up a server that is running Windows Server Essentials  
 You must have already set up a server that is running Windows Server Essentials. This will be the domain controller for the server that is running Exchange Server. For information about how to set up Windows Server Essentials, see [Install Windows Server Essentials](../install/Install-Windows-Server-Essentials.md).  

###  <a name="BKMK_SecondServer"></a> Prepare a second server on which to install Exchange Server  
 You must install Exchange Server on a second server that is running a version of the Windows Server operating system that officially supports running Exchange Server 2010 or Exchange Server 2013. You must then join the second server to the Windows Server Essentials domain.  

 For information about how to join a second server to the Windows Server Essentials domain, see Join a second server to the network in [Get Connected](../use/Get-Connected-in-Windows-Server-Essentials.md).  

> [!NOTE]
>  Microsoft does not support installing Exchange Server on a server that is running Windows Server Essentials.  

###  <a name="BKMK_DomainNames"></a> Configure your Internet domain name  
 To integrate an on-premises server that is running Exchange Server with Windows Server Essentials, you must have registered a valid Internet domain name for your business (such as *contoso.com*). You must also work with your domain name provider to create the DNS resource records that Exchange Server requires.  

 For example, if your company Internet domain name is contoso.com and you want to use the fully qualified domain name (FQDN) of *mail.contoso.com* to reference your on-premises server that is running Exchange Server, work with your domain name provider to create the DNS resource records in the following table.  


| Resource record name |     Record type     |                                                                         Record setting                                                                          |                                                                                                                                                                                                                                                              Description                                                                                                                                                                                                                                                              |
|----------------------|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|         mail         |      host (A)       |                                                        Address=*public IP address assigned by your ISP*                                                         |                                                                                                                                                                                                   Exchange Server will receive mail addressed to mail.contoso.com.<br /><br /> You can use a different name at your own selection.                                                                                                                                                                                                    |
|          MX          | mail exchanger (MX) |                                            Hostname=@<br /><br /> Address=mail.contoso.com<br /><br /> Preference=0                                             |                                                                                                                                                                                                      Provides email message routing for email@contoso.com to arrive at your on-premises server that is running Exchange Server.                                                                                                                                                                                                       |
|         SPF          |     text (TXT)      |                                                                        v=spf1 a mx ~all                                                                         |                                                                                                                                                                                                                      Resource record that helps prevent email sent from your server as being identified as spam.                                                                                                                                                                                                                      |
|  autodiscover._tcp   |    service (SRV)    | Service: _autodiscover<br /><br /> Protocol: _tcp<br /><br /> Priority: 0<br /><br /> Weight: 0<br /><br /> Port: 443<br /><br /> Target host: mail.contoso.com | Enables Microsoft Office Outlook and mobile devices to automatically discover your on-premises server that is running Exchange Server.<br /><br /> **Note:** You can also configure an autodiscover host (A) resource record and point the record to the public IP address of your on-premises server that is running Exchange Server. However, if you implement this option, you must also provide subject alternative name (SAN) SSL certificate that supports both the mail.contoso.com and autodiscover.contoso.com domain names. |

> [!NOTE]
>  -   Replace instances of *contoso.com* in this example with the Internet domain name that you registered.  

 You must choose a different FQDN for your on-premises server that is running Exchange Server than the FQDN you are using for the server that is running Windows Server Essentials. For example, you can choose to use *remote.contoso.com* as the FQDN that computers use to access the server running Windows Server Essentials from the Internet. You can use *mail.contoso.com* as the FQDN that is used to route email to your on-premises server that is running Exchange Server.  

## Install Exchange Server  
 The Exchange Server integration feature on Windows Server Essentials supports the following versions of Exchange Server:  

- Exchange Server 2013  

- Exchange Server 2010 with Service Pack 1 (SP1)  

  Before you install the Exchange Server on the second server, you must first add the current administrator account to the **Enterprise Admins** group.  

#### To add the current administrator account to the Enterprise Admins group  

1.  Log on to Windows Server Essentials as an administrator.  

2.  Run Windows PowerShell as an administrator.  

3.  At the Windows PowerShell command prompt, type **Add-ADGroupMember "Enterprise Admins" $env:username**, and then press Enter.  

#### To install Exchange Server  

1.  Log on to the second server as an administrator.  

2.  Open your Internet browser, and then navigate to the [Exchange Server Deployment Assistant](https://go.microsoft.com/fwlink/p/?LinkID=249163) website.  

3.  Click **On-Premises Only**.  

4.  Click the new installation option for the version of Exchange Server that you will install.  

    > [!NOTE]
    >  If you are migrating from an installation of Windows Small Business Server, you should select the appropriate upgrade option that covers the migration steps.  

5.  On the next page, accept the default settings, and then click **Next**.  

    > [!NOTE]
    >  If you plan to use public folders in the new installation of Exchange Server, change that setting to **Yes**.  

6.  Follow the step-by-step instructions in the checklist to deploy Exchange Server.  

     The Exchange Server Deployment Assistant also allows you to:  

    -   Print a copy of the checklist.  

    -   Send a copy of the checklist to an email recipient.  

    -   Download the checklist as a PDF file.  

> [!NOTE]
> - You must always choose to install the Management Tools on the server that is running Exchange Server. The Management Tools are required by the Exchange Server Integration feature on Windows Server Essentials.  
>   -   If you need to configure virtual directories, we recommend that you also set the **InternalUrl** property to be the same URL as the **ExternalUrl** property for each virtual directory. For more information, see [Managing Client Access Server Virtual Directories](https://go.microsoft.com/fwlink/p/?LinkId=251058) at the Exchange Server 2010 online Help website.  
>   -   If you want to access Outlook Web Access (OWA) from within the Remote Web Access site on Windows Server Essentials, you must set the External URL property for OWA.  

 If you are installing Exchange Server 2010 in a clean setup, you can also use the following scripts to set up Exchange Server.  

#### To use scripts to set up Exchange Server  

1.  Open Notepad, and paste the following script into a new file:  

```powershell
Import-Module ServerManager

Add-WindowsFeature NET-Framework,RSAT-ADDS,Web-Server,Web-Basic-Auth,Web-Windows-Auth,Web-Metabase,Web-Net-Ext,Web-Lgcy-Mgmt-Console,WAS-Process-Model,RSAT-Web-Server,Web-ISAPI-Ext,Web-Digest-Auth,Web-Dyn-Compression,NET-HTTP-Activation,Web-Asp-Net,Web-Client-Auth,Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Http-Redirect,Web-Http-Tracing,Web-ISAPI-Filter,Web-Request-Monitor,Web-Static-Content,Web-WMI,RPC-Over-HTTP-Proxy  Restart
```

2. Save the file as **InstallDependencies.ps1**.  

3. Copy the Exchange SSL certificate to a location on the server.  

4. Open a new Notepad file, and copy the following text to the file:  

```powershell
param (
    [string]
    [Parameter(Mandatory=$true, HelpMessage = "The path to your Certificate file, must be a *.pfx format")]
    $CertPath = "c:\certificates\ExchangeCertificate.pfx",
    [Security.SecureString]
    [Parameter(Mandatory=$true, HelpMessage = "The password of your cert")]
    $CertPassword = $null,
    [string]
    [Parameter(Mandatory=$true, HelpMessage = "Domain Name, eg. contoso.com")]
    $DomainName = "contoso.com",
    [string]
    [Parameter(Mandatory=$true, HelpMessage = "Server IP Address, eg. 192.168.0.1")]
    $ServerIpAddress = "192.168.0.1",
    [string]
    [Parameter(Mandatory=$true, HelpMessage = "Internal Ip Range, eg. 192.168.0.0-192.168.0.255")]
    $InternalIpRange = "192.168.0.0-192.168.0.255"
)

#Import Exchange Certificate, and Enable it for POP IIS IMAP SMTP services.

Import-ExchangeCertificate  -FileData ([Byte[]]$(Get-content -Path $CertPath  -Encoding byte  -ReadCount 0)) -Password:$CertPassword -Force | Enable-ExchangeCertificate -Services 'POP, IIS, IMAP, SMTP' -Force

#New AcceptedDomain and set it to default

New-AcceptedDomain  -Name "official name"  -DomainName $domainname

Set-AcceptedDomain  -Identity "official name"  -MakeDefault $true

#New EmailAddress Policy

$address = "%m@" + $DomainName

New-EmailAddressPolicy -Name "Windows Server Essentials Email Address Policy" -IncludedRecipients AllRecipients -EnabledPrimarySMTPAddressTemplate $address

#Set owa and ecp VirtualDirectory ExternalUrl

$hostname = "mail." + $DomainName

$owa = "https://" + $hostname + "/owa"

$ecp = "https://" + $hostname + "/ecp"

$activesync = "https://" + $hostname + "/Microsoft-Server-ActiveSync"

$oab = "https://" + $hostname + "/OAB"

$ews = "https://" + $hostname + "/EWS/Exchange.asmx"

Get-OwaVirtualDirectory | Set-OwaVirtualDirectory  -ExternalUrl $owa  -InternalUrl $owa

Get-EcpVirtualDirectory | Set-EcpVirtualDirectory  -ExternalUrl $ecp  -InternalUrl $ecp

Get-ActiveSyncVirtualDirectory | Set-ActiveSyncVirtualDirectory -ExternalUrl $activesync  -InternalUrl $activesync

Get-OABVirtualDirectory | Set-OABVirtualDirectory -ExternalUrl $oab -InternalUrl $oab -RequireSSL:$true

Get-WebServicesVirtualDirectory | Set-WebServicesVirtualDirectory -ExternalUrl $ews -InternalUrl $ews -BasicAuthentication:$True -Force

#Enable outlook Anywhere

Enable-OutlookAnywhere  -ClientAuthenticationMethod:Basic  -ExternalHostname:$hostname  -SSLOffloading:$false

#new receive/send connector

$machinename = get-content env:computername

$bindingIpaddress = $ServerIpAddress + ":25"

$ReceiveConnectorName = $machinename + "\Default " + $machinename

Set-ReceiveConnector $ReceiveConnectorName -RemoteIPRanges $InternalIpRange

New-ReceiveConnector -Name "WSE Internet Receive Connector" -Usage "Internet" -Bindings $bindingIpaddress -Fqdn $hostname -Enabled $true -Server $machinename -AuthMechanism Tls,BasicAuth,BasicAuthRequireTLS,Integrated

New-SendConnector -Name "WSE Internet SendConnector" -Usage "Internet" -AddressSpaces 'SMTP:*;1' -IsScopedConnector $false -DNSRoutingEnabled $true -UseExternalDNSServersEnabled $true -SourceTransportServers $machinename
```

5. Set the parameters at the beginning of the script to reflect your networking environment.  

6. Save the file as **ConfigureExchange.ps1**.  

7. Run Windows PowerShell as an administrator.  

8. At the Windows PowerShell command prompt, type **Set-ExecutionPolicy RemoteSigned**, and then press Enter.  

9. Run the script **InstallDependencies.ps1**.  

10. Restart the server, and then Run Windows PowerShell as an administrator.  

11. At the Windows PowerShell command prompt, run the following script:  

    `E:\setup.com /mode:install /roles:mb,ht,ca /OrganizationName:"First Organization"`  

   > [!NOTE]
   >  Be sure to type the correct path to the Exchange Server setup program.  

12. When Exchange Server setup is complete, open Exchange Management Shell as an administrator.  

13. At the Exchange Management Shell command prompt, type **Set-ExecutionPolicy RemoteSigned**, and then press Enter.  

14. Run the script **ConfigureExchange.ps1**.  

15. Restart the server.  

> [!NOTE]
>  If you decide to use a publicly trusted SSL certificate instead of a self-issued certificate, you can follow the instructions in the setup guide to create a certificate request and send it to your selected Certification Authority. You can also use an Exchange PowerShell cmdlet to create a certificate request. An example follows.  
>   
>  `New-ExchangeCertificate -GenerateRequest -SubjectName "C=US, S=Washington, L=Redmond, O=contoso, OU=contoso, CN=mail.contoso.com" -DomainName mail.contoso.com -PrivateKeyExportable $true | Set-Content -path "c:\Docs\MyCertRequest.req"`  
>   
>  Customize the script parameters to reflect your networking environment.  

## Post-installation tasks  
 This section describes server configuration tasks you may need to complete in the post-installation phase that contains information specific to setting up an on-premises server that is running Exchange Server on a Windows Server Essentials network.  

### Add the public email domain and configure the email address policies  

> [!NOTE]
>  This is a required task if you are performing a clean setup. Skip this step if you are migrating from Windows Small Business Server.  

 You must specify your email domain to be the default accepted domain, and then configure the email address policy.  

##### To add your email domain as the default accepted domain  

1.  Follow the instructions in the Exchange Server article [Create an Accepted Domain](https://go.microsoft.com/fwlink/p/?LinkId=249174) to add an accepted domain.  

2.  Log on to the second server as an administrator, open the Exchange Management Console, and then navigate to the **Hub Transport** tab of the **Organization Configuration**.  

3.  In the Exchange Management Console work pane, right-click the new accepted domain, and then click **Set as Default**.  

4.  Follow the instructions in the Exchange Server article [Create an Email Address Policy](https://go.microsoft.com/fwlink/p/?LinkId=249179) to create a new email address policy. You can accept all of the default values except the email address. For email address, specify your public email domain.  

### Create SMTP Send and Receive connectors  

> [!NOTE]
>  This is a required task.  

 You must configure an SMTP Send connector and an SMTP Receive connector for outbound/inbound transmission of email messages.  

 To create an SMTP Send connector, follow the instructions in the Exchange Server article [Create an SMTP Send Connector](https://technet.microsoft.com/library/aa997285.aspx).  

 To create an SMTP Receive connector, follow the instructions in the Exchange Server article [Create an SMTP Receive Connector](https://technet.microsoft.com/library/bb125159.aspx).  

 As an option, you can refer to the script earlier in this document for creating the send and receive connectors by using Exchange PowerShell cmdlets.  

### Configure the network router  

> [!NOTE]
>  This is a required task if you are performing a clean setup. If you are migrating from Windows Small Business Server, see [Migrate Server Data to Windows Server Essentials](../migrate/Migrate-Server-Data-to-Windows-Server-Essentials.md) for instructions about how to configure the network.  

 At minimum, you must configure the following port settings on the router:  

|Router port|Destination IP|Destination port|Note|  
|-----------------|--------------------|----------------------|----------|  
|25 (SMTP)|Internal IP of the on-premises server that is running Exchange Server.|25||  
|80 (HTTP)|Internal IP of the server that is running Windows Server Essentials|80||  
|443 (HTTPS)|Internal IP of the server that is running Windows Server Essentials|443||  

 If you support the POP3 or IMAP messaging protocols on your network, you must also configure port forwardings for those protocols. For related information, see the section **Client Access Servers** in the topic [Exchange Network Port Reference](https://go.microsoft.com/fwlink/p/?LinkId=250773) in the Exchange Server TechNet Library.  

> [!NOTE]
> - We recommend that you configure static IP addresses for the server that is running Windows Server Essentials and for the second server that is running Exchange Server. For instructions about how to configure a static IP address on a computer running Windows Server 2003 or Windows Server 2008 R2, see [Configure a Static IP Address](https://technet.microsoft.com/library/cc754203\(v=ws.10\).aspx) in the Windows Server TechNet Library  
> 
>   **Note:** The DNS server setting should always point to the IP address of the server that is running Windows Server Essentials.  
>   -   On the router, make sure that the IP addresses of the server that is running Windows Server Essentials and the server that is running Exchange Server either are reserved, or are out of the DHCP IP addresses range.  
>   -   The router configuration in this section assumes that you have only one public IP address assigned by your Internet Service Provider (ISP). If you have multiple public IP addresses, you can assign a different IP address to the server that is running Windows Server Essentials and to the server that is running Exchange Server, and then create port forwardings based on the public IP addresses.  

### Enable on-premises Exchange Server integration on Windows Server Essentials  

> [!NOTE]
>  If you are migrating from a Windows Small Business Server installation, we recommend that you skip this step for now and run it after you uninstall the previous installation of Exchange Server on the Source Server.  

 After you install and configure a server that is running Exchange Server, you must enable the on-premises Exchange Server integration on the server that is running Windows Server Essentials.  

##### To enable on-premises Exchange Server integration from the Dashboard  

1.  Log on to the server that is running Windows Server Essentials as an administrator, and then open the Dashboard.  

2.  On the **Home** page, click **Connect to My Email Service**, and then click **Integrate your Exchange Server**.  

3.  In the information pane, click **Set up Exchange Server Integration**.  

4.  Follow the instructions in the wizard.  

### Configure a reverse proxy  

> [!NOTE]
>  This is a required task if you have only one Internet connection from your Internet Service Provider.  

 Both Windows Server Essentials and Exchange Server support some remote access scenarios for network users. For example, if you turn on Anywhere Access on the server that is running Windows Server Essentials, you can remotely access the Remote Web Access site or use virtual private networking (VPN) to remotely connect to the Windows Server Essentials network. To remotely access email messages, you must use Outlook Anywhere, Outlook Web Access (OWA), or ActiveSync.  

 If Windows Server Essentials and the server running Exchange Server are both connected to the same router and there is only one inbound Internet connection from your Internet Service Provider to the router, you must use a reverse proxy solution to route different types of remote access requests from the Internet based on the destination host names. We recommend that you use the Microsoft supported IIS Application Request Routing (ARR) extension as your reverse proxy solution. For more information about IIS Application Request Routing, visit the [Application Request Routing website](https://go.microsoft.com/fwlink/p/?LinkId=249181).  

##### To install and configure Application Request Routing  

1. Log on to Windows Server Essentials as an administrator.  

2. Open your Internet browser, and navigate to the [Application Request Routing website](https://go.microsoft.com/fwlink/p/?LinkId=249181).  

3. On the ARR website, click **Install**, and then follow the instructions to install ARR.  

   > [!NOTE]
   >  You must select the URL Rewrite Module during ARR installation.  
   >   
   >  You may receive an error at the end of the ARR installation that KB 2589179 for ARR 2.5 did not install successfully. You can safely ignore this error.  

4. When ARR installation is complete, restart the **Remote Desktop Gateway** service if it is not running.  

   > [!NOTE]
   >  After you install ARR, the **Remote Desktop Gateway** service may be stopped. To manually restart the service, open the **Services** administrative tool, and then restart the **Remote Desktop Gateway** service.  

5. [Download KB2732764 for ARR 2.5](https://go.microsoft.com/fwlink/?LinkID=258302), and then install the update on the server that is running Windows Server Essentials.  

6. Copy the SSL certificate file for Exchange Server to the server that is running Windows Server Essentials. The certificate file must contain the private key, and it must be in the PFX file format.  

   > [!NOTE]
   >  If you are using a self-issued certificate, follow the instruction in the Exchange Server article [Export an Exchange Certificate](https://technet.microsoft.com/library/dd351274.aspx) to export the certificate.  

7. Depending on which version of Windows Server Essentials you are running, do one of the following:  

   -   On Windows Server Essentials: Open a command window as an administrator, and then open the %ProgramFiles%\Windows Server\Bin directory  

   -   On Windows Server Essentials: Open a command window as an administrator, and then open the %Windir%\System32\Essentials directory.  

8. Based on your installation scenario, follow one of these steps to configure ARR:  

   - If you are performing a clean setup, run the following command:  

      **ARRConfig config  -cert** *path to the certificate file* **-hostnames** *host names for Exchange Server* ****  

     > [!NOTE]
     >  For example; **ARRConfig config  -cert ***c:\temp\certificate.pfx***  -hostnames ***mail.contoso.com*****  
     > 
     >  Replace *mail.contoso.com* with the name of your domain that is protected by the certificate.  

   - In you are migrating from Windows Small Business Server, run the following command:  

      **ARRConfig config  -cert** *path to the certificate file* **-hostnames** *host names for Exchange Server* **-targetserver** *server name of Exchange Server* ****  

      For example; **ARRConfig config  -cert ***c:\temp\certificate.pfx***  -hostnames ***mail.contoso.com*** -targetserver ***ExchangeSvr*****  

      Replace *mail.contoso.com* with the name of your domain. Replace *ExchangeSvr* with the name of your server that is running Exchange Server.  

9. When prompted, type the password for the certificate.  

> [!NOTE]
> - The host names that you provide must be contained in the SSL certificate that you purchased for Exchange Server.  
>   -   If you have multiple host names, use a comma (,) to separate them.  

 To verify that the configuration works, try to access the OWA website for your server that is running Exchange Server (https://mail. *yourdomainname*.com/owa) from a computer that is not a member of the domain. To troubleshoot connectivity issues, you can also use the online [Microsoft Remote Connectivity Analyzer](https://go.microsoft.com/fwlink/p/?LinkId=249455) tool.  

### Configure Split DNS for Exchange Server  

> [!NOTE]
>  This is a recommended task.  

 Split DNS allows you to configure different IP addresses in DNS for the same host name, depending on where the DNS request originates. If the client computer is on the intranet, the DNS request resolves to an intranet IP address. If the client computer is on the Internet, the DNS request resolves to an Internet IP address. This is transparent to users.  

 We recommend that you configure split DNS in such a way that enables users to always use the same host name to access Exchange Server services, regardless of their location.  

##### To configure Split DNS for Exchange Server  

1.  Log on to Windows Server Essentials as an administrator, and then open DNS Manager.  

2.  In the DNS Manager console tree, right-click your server, and then click **New Zone**. The **New Zone Wizard** appears.  

3.  On the **Zone Type** page of the wizard, accept the default option, and then click **Next**.  

4.  On the **Active Directory Zone Replication Scope** page, accept the default option, and then click **Next**.  

5.  On the **Forward or Reverse Lookup Zone** page, accept or select **Forward lookup zone**, and then click **Next**.  

6.  On the **Zone Name** page, type the FQDN of your server that is running Exchange Server (for example; *mail.contoso.com*), and then click **Next**.  

7.  On the **Dynamic Update** page, accept the default option, click **Next**, and then click **Finish**.  

8.  In the DNS Manager console tree, right-click the new forward lookup zone, and then click **New Host (A or AAAA)**.  

9. On the **New Host** page, leave the **Name** field blank, type the intranet IP address of your server that is running Exchange Server, and then click **Add Host**.  

    > [!NOTE]
    >  When you leave the **Name** field blank, the server uses the parent domain name by default.  

10. On the **New Host** page, click **Done**.  

> [!NOTE]
>  If you use ActiveSync but cannot synchronize the email for some mailbox accounts, determine if those accounts are members of one or more protected groups such as Domain Administrators. For related information that can help you resolve this issue, see [Exchange ActiveSync Returned an HTTP 500 Error](https://technet.microsoft.com/library/dd439375\(EXCHG.80\).aspx).  

## Related topics  
 For more information about integrating an on-premises Exchange Server, see the following sections.  

### What happens if I disable Exchange integration?  
 If you disable integration with an on-premises Exchange Server, you will no longer be able to use the Windows Server Essentials Dashboard to view, create, or manage Exchange Server mailboxes.  

### What do I need to know about email accounts?  
 A hosted email solution is configured on your server. A solution from a hosted email provider, such as Microsoft  Office 365, can provide individual email accounts for network users. When you run the Add a User Account Wizard in Windows Server Essentials to create a user account, the wizard attempts to add the user account to the available hosted email solution. At the same time, the wizard assigns an email name (alias) to the user, and sets the maximum size of the mailbox (quota). The maximum size of the mailbox varies depending on the email provider that you use. After adding the user account, you can continue to manage the mailbox alias and quota information from the properties page for the user. For full management of your user accounts and hosted email provider, use the management console of your hosted provider. Depending on your provider, you can access their management console either from a web-based portal, or from a tab in the server Dashboard.  

 The alias that you provide when you run the Add a User Account Wizard is sent to the hosted email provider as the suggested name for the user alias. For example, if the user alias is *FrankM*, the user's email address might be <em>FrankM@Contoso.com</em>.  

 In addition, the password that you set for the user in the Add a User Account Wizard will be the initial password of the user in the hosted email solution.  

 Finally, if you delete the user by using the Delete a User Account Wizard on the server, the wizard also sends a request to the hosted email provider to delete the user from their system as well. The provider may delete both the user's account and the email that is associated with the account.  

 For user information about how to set up required email client software, or how to access an email account, refer to the help documentation provided by your hosted email provider.  

### What is a mailbox quota?  
 The amount of storage space that is allocated for a network user's Exchange mailbox data is known as the mailbox quota.  

 When you run the **Set up Exchange Server Integration** task on the Dashboard, the wizard adds a page to the Add User Account Wizard that allows you to choose whether to enforce mailbox quotas, and to specify the quota size. By default, the **Enforce mailbox quotas** option is selected (on), and user mailboxes are assigned 2 GB of storage space. Exchange administrators can customize the mailbox quota settings to suit the needs of their business.  

## See also  

-   [System Requirements for Windows Server Essentials](../get-started/system-requirements.md)  

-   [Manage Email Service Integration](Manage-Email-Service-Integration-in-Windows-Server-Essentials.md)  

-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
