---
title: Deploy Work Folders with AD FS and Web Application Proxy - Step 1, Set Up AD FS
ms.prod: windows-server-threshold
ms.technology: storage-work-folders
ms.topic: article
manager: klaasl
ms.author: jeffpatt
author: JeffPatt24
ms.date: 10/18/2018
ms.assetid: 938cdda2-f17e-4964-9218-f5868fd96735
---
# Deploy Work Folders with AD FS and Web Application Proxy: Step 1, Set-up AD FS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the first step in deploying Work Folders with Active Directory Federation Services (AD FS) and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](deploy-work-folders-adfs-step2.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](deploy-work-folders-adfs-step3.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](deploy-work-folders-adfs-step4.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](deploy-work-folders-adfs-step5.md)  
  
> [!NOTE]
>   The instructions covered in this section are for a Windows Server 2019 or Windows Server 2016 environment. If you're using Windows Server 2012 R2, follow the [Windows Server 2012 R2 instructions](https://technet.microsoft.com/library/dn747208(v=ws.11).aspx).

To set up AD FS for use with Work Folders, use the following procedures.  
  
## Pre\-installment work  
If you intend to convert the test environment that you're setting up with these instructions to production, there are two things that you might want to do before you start:  
  
-   Set up an Active Directory domain administrator account to use to run the AD FS service.
  
-   Obtain a Secure Sockets Layer (SSL) subject alternative name (SAN) certificate for server authentication. For the test example, you will use a self-signed certificate but for production you should use a publicly trusted certificate.  
  
Obtaining these items can take some time, depending on your company's policies, so it can be beneficial to start the request process for the items before you begin to create the test environment.  
  
There are many commercial certificate authorities (CAs) from which you can purchase the certificate. You can find a list of the CAs that are trusted by Microsoft in [KB article 931125](https://support.microsoft.com/kb/931125). Another alternative is to get a certificate from your company's enterprise CA.  
  
For the test environment, you will use a self-signed certificate that is created by one of the provided scripts.  
  
> [!NOTE]  
> AD FS does not support Cryptography Next Generation (CNG) certificates, which means that you cannot create the self-signed certificate by using the Windows PowerShell cmdlet  New-SelfSignedCertificate. You can, however, use the makecert.ps1 script included in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap) blog post. This script creates a self\-signed certificated that works with AD FS and prompts for the SAN names that will be needed to create the certificate.  
  
Next, do the additional pre-installment work described in the following sections.  
  
### Create an AD FS self\-signed certificate  
To create an AD FS self-signed certificate, follow these steps:  
  
1.  Download the scripts provided in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap) blog post and then copy the file makecert.ps1 to the AD FS machine.  
  
2.  Open a Windows PowerShell window with admin privileges.  
  
3.  Set the execution policy to unrestricted:  
  
    ```powershell  
    Set-ExecutionPolicy –ExecutionPolicy Unrestricted   
    ```  
  
4.  Change to the directory where you copied the script.  
  
5.  Execute the makecert script:  
  
    ```powershell  
    .\makecert.ps1  
    ```  
  
6.  When you are prompted to change the subject certificate, enter the new value for the subject. In this example, the value is **blueadfs.contoso.com**.  
  
7.  When you are prompted to enter SAN names, press Y and then enter the SAN names, one at a time.  
  
    For this example, type **blueadfs.contoso.com** and press Enter, then type **2016-adfs.contoso.com** and press Enter, then type **enterpriseregistration.contoso.com** and press Enter.  
  
    When all of the SAN names have been entered, press Enter on an empty line.  
  
8.  When you are prompted to install the certificates to the Trusted Root Certification Authority store, press Y.  
  
The AD FS certificate must be a SAN certificate with the following values:  

-   AD FS service name.domain

-   enterpriseregistration.domain

-   AD FS server name.domain

In the test example, the values are:  
  
-   **blueadfs.contoso.com**
  
-   **enterpriseregistration.contoso.com**
  
-   **2016-adfs.contoso.com**
  
The enterpriseregistration SAN is needed for Workplace Join.  
  
### Set the server IP address  
Change your server IP address to a static IP address. For the test example, use IP class A, which is 192.168.0.160 / subnet mask: 255.255.0.0 / Default Gateway: 192.168.0.1 / Preferred DNS: 192.168.0.150 (the IP address of your domain controller\).  
  
## Install the AD FS role service  
To install AD FS, follow these steps:  
  
1.  Log on to the physical or virtual machine on which you plan to install AD FS, open **Server Manager**, and start the Add Roles and Features Wizard.  
  
2.  On the **Server Roles** page, select the **Active Directory Federation Services** role, and then click **Next**.  
  
3.  On the **Active Directory Federation Services (AD FS)** page, you will see a message that states that the Web Application Proxy role cannot be installed on the same computer as AD FS. Click **Next**.  
  
4.  Click **Install** on the confirmation page.  
  
To accomplish the equivalent installation of AD FS via Windows PowerShell, use these commands:  
  
```powershell  
Add-WindowsFeature RSAT-AD-Tools  
Add-WindowsFeature ADFS-Federation –IncludeManagementTools  
```  
  
## Configure AD FS  
Next, configure AD FS by using either Server Manager or Windows PowerShell.  
  
### Configure AD FS by using Server Manager  
To configure AD FS by using Server Manager, follow these steps:  
  
1.  Open Server Manager.  
  
2.  Click the **Notifications** flag at the top of the Server Manager window, and then click **Configure the federation service on this server**.  
  
3.  The Active Directory Federation Services Configuration Wizard launches. On the **Connect to AD DS** page, enter the domain administrator account that you want to use as the AD FS account, and click **Next**.  
  
4.  On the **Specify Service Properties** page, enter the subject name of the SSL certificate to use for AD FS communication. In the test example, this is **blueadfs.contoso.com**.  
  
5.  Enter the Federation Service name. In the test example, this is **blueadfs.contoso.com**. Click **Next**.  
  
    > [!NOTE]  
    > The Federation Service name must not use the name of an existing server in the environment. If you do use the name of an existing server, the AD FS installation will fail and must be restarted.  
  
6.  On the **Specify Service Account** page, enter the name that you would like to use for the managed service account. For the test example, select **Create a Group Managed Service Account**, and in **Account Name**, enter **ADFSService**. Click **Next**.  
  
7.  On the **Specify Configuration Database** page, select **Create a database on this server using Windows Internal Database**, and click **Next**.  
  
8.  The **Review Options** page shows you an overview of the options you have selected. Click **Next**.  
  
9. The **Pre-requisite Checks** page indicates whether all the prerequisite checks passed successfully. If there are no issues, click **Configure**.  
  
    > [!NOTE]  
    > If you used the name of the AD FS server or any other existing machine for the Federation Service Name, an error message is displayed. You must start the installation over and choose a name other than the name of an existing machine.  
  
10. When the configuration completes successfully, the **Results** page confirms that AD FS was successfully configured.  
  
### Configure AD FS by using PowerShell  
To accomplish the equivalent configuration of AD FS via Windows PowerShell, use the following commands.  
  
To install AD FS:  
  
```powershell  
Add-WindowsFeature RSAT-AD-Tools  
Add-WindowsFeature ADFS-Federation -IncludeManagementTools   
```  
  
To create the managed service account:  
  
```powershell  
New-ADServiceAccount "ADFSService"-Server 2016-DC.contoso.com -Path "CN=Managed Service Accounts,DC=Contoso,DC=COM" -DNSHostName 2016-ADFS.contoso.com -ServicePrincipalNames HTTP/2016-ADFS,HTTP/2016-ADFS.contoso.com  
```  
  
After you configure AD FS, you must set up an AD FS farm by using the managed service account that you created in the previous step and the certificate you created in the pre-configuration steps.  
  
To set up an AD FS farm:  
  
```powershell  
$cert = Get-ChildItem CERT:\LocalMachine\My |where {$_.Subject -match blueadfs.contoso.com} | sort $_.NotAfter -Descending | select -first 1    
$thumbprint = $cert.Thumbprint  
Install-ADFSFarm -CertificateThumbprint $thumbprint -FederationServiceDisplayName "Contoso Corporation" –FederationServiceName blueadfs.contoso.com -GroupServiceAccountIdentifier contoso\ADFSService$ -OverwriteConfiguration -ErrorAction Stop  
```  
  
Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](deploy-work-folders-adfs-step2.md)  
  
## See Also  
[Work Folders Overview](Work-Folders-Overview.md)  
  

