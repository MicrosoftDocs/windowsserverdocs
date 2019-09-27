---
title: Deploy Work Folders with AD FS and Web Application Proxy - Step 3, Set Up Work Folders
ms.prod: windows-server
ms.technology: storage-work-folders
ms.topic: article
manager: klaasl
ms.author: jeffpatt
author: JeffPatt24
ms.date: 4/5/2017
ms.assetid: 5a43b104-4d02-4d73-a385-da1cfb67e341
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set-up Work Folders

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the third step in deploying Work Folders with Active Directory Federation Services (AD FS) and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set Up AD FS](deploy-work-folders-adfs-step1.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](deploy-work-folders-adfs-step2.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](deploy-work-folders-adfs-step4.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](deploy-work-folders-adfs-step5.md)  
  
> [!NOTE]
>   The instructions covered in this section are for a Windows Server 2019 or Windows Server 2016 environment. If you're using Windows Server 2012 R2, follow the [Windows Server 2012 R2 instructions](https://technet.microsoft.com/library/dn747208(v=ws.11).aspx).

To set up Work Folders, use the following procedures.  
  
## Pre\-installment work  
In order to install Work Folders, you must have a server that is joined to the domain and running Windows Server 2016. The server must have a valid network configuration.  
  
For the test example, join the machine that will run Work Folders to the Contoso domain and set up the network interface as described in the following sections. 

### Set the server IP address  
Change your server IP address to a static IP address. For the test example, use IP class A, which is 192.168.0.170 / subnet mask: 255.255.0.0 / Default Gateway: 192.168.0.1 / Preferred DNS: 192.168.0.150 (the IP address of your domain controller). 
  
### Create the CNAME record for Work Folders  
To create the CNAME record for Work Folders, follow these steps:  
  
1.  On your domain controller, open **DNS Manager**.  
  
2.  Expand the Forward Lookup Zones folder, right-click on your domain, and click **New Alias (CNAME)**.  
  
3.  In the **New Resource Record** window, in the **Alias name** field, enter the alias for Work Folders. In the test example, this is **workfolders**.  
  
4.  In the **Fully qualified domain name** field, the value should be **workfolders.contoso.com**.  
  
5.  In the **Fully qualified domain name for target host** field, enter the FQDN for the Work Folders server. In the test example, this is **2016-WF.contoso.com**.  
  
6.  Click **OK**.  
  
To accomplish the equivalent steps via Windows PowerShell, use the following command. The command must be executed on the domain controller.  
  
```powershell  
Add-DnsServerResourceRecord  -ZoneName "contoso.com" -Name workfolders -CName  -HostNameAlias 2016-wf.contoso.com   
```  
  
### Install the AD FS certificate  
Install the AD FS certificate that was created during AD FS setup into the local computer certificate store, using these steps:  
  
1.  Click **Start**, and then click **Run**.  
  
2.  Type **MMC**.  
  
3.  On the **File** menu, click **Add/Remove Snap-in**.  
  
4.  In the **Available snap-ins** list, select **Certificates**, and then click **Add**. The Certificates Snap-in Wizard starts.  
  
5.  Select **Computer account**, and then click **Next**.  
  
6.  Select **Local computer: (the computer this console is running on)**, and then click **Finish**.  
  
7.  Click **OK**.  
  
8.  Expand the folder **Console Root\Certificates\(Local Computer)\Personal\Certificates**.  
  
9. Right-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
10. Browse to the folder that contains the AD FS certificate, and follow the instructions in the wizard to import the file and place it in the certificate store.

11. Expand the folder **Console Root\Certificates\(Local Computer)\Trusted Root Certification Authorities\Certificates**.  
  
12. Right-click **Certificates**, click **All Tasks**, and then click **Import**.  
  
13. Browse to the folder that contains the AD FS certificate, and follow the instructions in the wizard to import the file and place it in the Trusted Root Certification Authorities store.  
  
### Create the Work Folders self-signed certificate  
To create the Work Folders self-signed certificate, follow these steps:  
  
1.  Download the scripts provided in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap) blog post and then copy the file makecert.ps1 to the Work Folders machine.  
  
2.  Open a Windows PowerShell window with admin privileges.  
  
3.  Set the execution policy to unrestricted:  
  
    ```powershell  
    PS C:\temp\scripts> Set-ExecutionPolicy -ExecutionPolicy Unrestricted   
    ```  
  
4.  Change to the directory where you copied the script.  
  
5.  Execute the makeCert script:  
  
    ```powershell  
    PS C:\temp\scripts> .\makecert.ps1  
    ```  
  
6.  When you are prompted to change the subject certificate, enter the new value for the subject. In this example, the value is **workfolders.contoso.com**.  
  
7.  When you are prompted to enter subject alternative name (SAN) names, press Y and then enter the SAN names, one at a time.  
  
    For this example, type **workfolders.contoso.com**, and press Enter. Then type **2016-WF.contoso.com** and press Enter.  
  
    When all of the SAN names have been entered, press Enter on an empty line.  
  
8.  When you are prompted to install the certificates to the Trusted Root Certification Authority store, press Y.  
  
The Work Folders certificate must be a SAN certificate with the following values:  
  
-   **workfolders**.**domain**  
  
-   **machine name**.**domain**  
  
In the test example, the values are:  
  
-   **workfolders.contoso.com**  
  
-   **2016-WF.contoso.com**  
  
## Install Work Folders  
To install the Work Folders role, follow these steps:  
  
1.  Open **Server Manager**, click **Add roles and features**, and click **Next**.  
  
2.  On the **Installation Type** page, select **Role-based or feature-based installation**, and click **Next**.  
  
3.  On the **Server Selection** page, select the current server, and click **Next**.  
  
4.  On the **Server Roles** page, expand **File and Storage Services**, expand **File and iSCSI Services**, and then select **Work Folders**.  
  
5.  On the **Add Roles and Feature Wizard** page, click **Add Features**, and click **Next**.  
  
6.  On the **Features** page, click **Next**.  
  
7.  On the **Confirmation** page, click **Install**.  
  
## Configure Work Folders  
To configure Work Folders, follow these steps:  
  
1.  Open **Server Manager**.  
  
2.  Select **File and Storage Services**, and then select **Work Folders**.  
  
3.  On the **Work Folders** page, start the **New Sync Share Wizard**, and click **Next**.  
  
4.  On the **Server and Path** page, select the server where the sync share will be created, enter a local path where the Work Folders data will be stored, and click **Next**.  
  
    If the path doesn't exist, you'll be prompted to create it. Click **OK**.  
  
5.  On the **User Folder Structure** page, select **User alias**, and then click **Next**.  
  
6.  On the **Sync Share Name** page, enter the name for the sync share. For the test example, this is **WorkFolders**. Click **Next**.  
  
7.  On the **Sync Access** page, add the users or groups that will have access to the new sync share. For the test example, grant access to all domain users. Click **Next**.  
  
8.  On the **PC Security Policies** page, select **Encrypt work folders** and **Automatically lock page and require a password**. Click **Next**.  
  
9. On the **Confirmation** page, click **Create** to finish the configuration process.  
  
## Work Folders post-configuration work  
To finish setting up Work Folders, complete these additional steps:  
  
-   Bind the Work Folders certificate to the SSL port  
  
-   Configure Work Folders to use AD FS authentication  
  
-   Export the Work Folders certificate (if you are using a self-signed certificate)  
  
### Bind the certificate  
Work Folders communicates only over SSL and must have the self-signed certificate that you created earlier (or that your certificate authority issued) bound to the port.  
  
There are two methods that you can use to bind the certificate to the port via Windows PowerShell: IIS cmdlets and netsh.  
  
#### Bind the certificate by using netsh  
To use the netsh command-line scripting utility in Windows PowerShell, you must pipe the command to netsh. The following example script finds the certificate with the subject **workfolders.contoso.com** and binds it to port 443 by using netsh:  
  
```powershell  
$subject = "workfolders.contoso.com"   
Try  
{  
#In case there are multiple certificates with the same subject, get the latest version   
$cert = Get-ChildItem CERT:\LocalMachine\My |where {$_.Subject -match $subject} | sort $_.NotAfter -Descending | select -first 1    
$thumbprint = $cert.Thumbprint  
$Command = "http add sslcert ipport=0.0.0.0:443 certhash=$thumbprint appid={CE66697B-3AA0-49D1-BDBD-A25C8359FD5D} certstorename=MY"  
$Command | netsh  
}  
Catch  
{  
"     Error: unable to locate certificate for $($subject)"  
Exit  
}   
```  
  
#### Bind the certificate by using IIS cmdlets  
You can also bind the certificate to the port by using IIS management cmdlets, which are available if you installed the IIS management tools and scripts.  
  
> [!NOTE]  
> Installation of the IIS management tools doesn't enable the full version of Internet Information Services (IIS) on the Work Folders machine; it only enables the management cmdlets. There are some possible benefits to this setup. For example, if you're looking for cmdlets to provide the functionality that you get from netsh. When the certificate is bound to the port via the New-WebBinding cmdlet, the binding is not dependent on IIS in any way. After you do the binding, you can even remove the Web-Mgmt-Console feature, and the certificate will still be bound to the port. You can verify the binding via netsh by typing **netsh http show sslcert**.  
  
The following example uses the New-WebBinding cmdlet to find the certificate with the subject **workfolders.contoso.com** and bind it to port 443:  
  
```powershell  
$subject = "workfolders.contoso.com"  
Try  
{  
#In case there are multiple certificates with the same subject, get the latest version   
$cert =Get-ChildItem CERT:\LocalMachine\My |where {$_.Subject -match $subject } | sort $_.NotAfter -Descending | select -first 1   
$thumbprint = $cert.Thumbprint  
New-WebBinding -Name "Default Web Site" -IP * -Port 443 -Protocol https  
#The default IIS website name must be used for the binding. Because Work Folders uses Hostable Web Core and its own configuration file, its website name, 'ECSsite', will not work with the cmdlet. The workaround is to use the default IIS website name, even though IIS is not enabled, because the NewWebBinding cmdlet looks for a site in the default IIS configuration file.   
Push-Location IIS:\SslBindings  
Get-Item cert:\LocalMachine\MY\$thumbprint | new-item *!443  
Pop-Location  
}  
Catch  
{  
"     Error: unable to locate certificate for $($subject)"  
Exit  
}   
```  
  
### Set up AD FS authentication  
To configure Work Folders to use AD FS for authentication, follow these steps:  
  
1.  Open **Server Manager**.  
  
2.  Click **Servers**, and then select your Work Folders server in the list.  
  
3.  Right-click the server name, and click **Work Folders Settings**.  
  
4.  In the **Work Folder Settings** window, select **Active Directory Federation Services**, and type in the Federation Service URL. Click **Apply**.  
  
    In the test example, the URL is **https://blueadfs.contoso.com**.  
  
The cmdlet to accomplish the same task via Windows PowerShell is:  
  
```powershell  
Set-SyncServerSetting -ADFSUrl "https://blueadfs.contoso.com"   
```  
  
If you're setting up AD FS with self-signed certificates, you might receive an error message that says the Federation Service URL is incorrect, unreachable, or a relying party trust has not been set up.  
  
This error can also happen if the AD FS certificate was not installed on the Work Folders server or if the CNAME for AD FS was not set up correctly. You must correct these issues before proceeding.  
  
### Export the Work Folders certificate  
The self-signed Work Folders certificate must be exported so that you can later install it on the following machines in the test environment:  
  
-   The server that is used for Web Application Proxy  
  
-   The domain-joined Windows client  
  
-   The non-domain-joined Windows client  
  
To export the certificate, follow the same steps you used to export the AD FS certificate earlier, as described in [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](deploy-work-folders-adfs-step2.md), Export the AD FS certificate.  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](deploy-work-folders-adfs-step4.md)  
  
## See Also  
[Work Folders Overview](Work-Folders-Overview.md)  
  

