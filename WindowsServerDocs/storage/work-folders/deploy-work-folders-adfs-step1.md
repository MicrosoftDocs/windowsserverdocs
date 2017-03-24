This topic describes the first step in deploying Work Folders with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] and Web Application Proxy. You can find the other steps in this process in these topics:  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Overview.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%202,%20AD%20FS%20Post-Configuration%20Work.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 3, Set Up Work Folders](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%203,%20Set%20Up%20Work%20Folders.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 4, Set Up Web Application Proxy](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%204,%20Set%20Up%20Web%20Application%20Proxy.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy: Step 5, Set Up Clients](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%205,%20Set%20Up%20Clients.md)  
  
-   [Deploy Work Folders with AD FS and Web Application Proxy using Windows PowerShell](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy%20using%20Windows%20PowerShell.md)  
  
 To set up [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for use with Work Folders, use the following procedures.  
  
## Pre-installment work  
 If you intend to convert the test environment that you're setting up with these instructions to production, there are two things that you might want to do before you start:  
  
-   Set up an Active Directory domain administrator account to use to run the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] service. For the test environment example, you will use the default contoso\administrator account, but it is not recommended that you use the default administrator account for a production environment.  
  
-   Obtain a Secure Sockets Layer (SSL) subject alternative name (SAN) certificate for server authentication. For the test example, you will use a self-signed certificate, but for production, you should use a publicly trusted certificate.  
  
 Obtaining these items can take some time, depending on your company's policies, so it can be beneficial to start the request process for the items before you begin to create the test environment.  
  
 There are many commercial certificate authorities (CAs) from which you can purchase the certificate. You can find a list of the CAs that are trusted by Microsoft in [KB article 931125](http://support.microsoft.com/kb/931125). Another alternative is to get a certificate from your company's enterprise CA.  
  
 For the test environment, you will use a self-signed certificate that is created by one of the provided scripts.  
  
> [!NOTE]
>  [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] does not support Cryptography Next Generation (CNG) certificates, which means that you cannot create the self-signed certificate by using the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet New-SelfSignedCertificate. You can, however, use the makecert.ps1 script included in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap/) blog post. This script creates a self-signed certificated that works with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] and prompts for the SAN names that will be needed to create the certificate.  
  
 Next, do the additional pre-installment work described in the following sections.  
  
### Create an AD FS self-signed certificate  
 To create an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] self-signed certificate, follow these steps:  
  
1.  Download the scripts included included in the [Deploying Work Folders with AD FS and Web Application Proxy](https://blogs.technet.microsoft.com/filecab/2014/03/03/deploying-work-folders-with-ad-fs-and-web-application-proxy-wap/) blog post and then copy the file makecert.ps1 to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] machine.  
  
2.  Open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] window with admin privileges.  
  
3.  Set the execution policy to unrestricted:  
  
    ```powershell  
    PS C:\temp\scripts> .\makecert.ps1 C:\temp\scripts> Set-ExecutionPolicy –ExecutionPolicy  Unrestricted   
    ```  
  
4.  Change to the directory where you copied the script.  
  
5.  Execute the makecert script:  
  
    ```powershell  
    PS C:\temp\scripts> .\makecert.ps1  
    ```  
  
6.  When you are prompted to change the subject certificate, enter the new value for the subject. In this example, the value is `blueadfs.contoso.com`.  
  
7.  When you are prompted to enter SAN names, press Y and then enter the SAN names, one at a time.  
  
     For this example, type `blueadfs.contoso.com` and press Enter, then type `enterpriseregistration.contoso.com` and press Enter.  
  
     When all of the SAN names have been entered, press Enter on an empty line.  
  
8.  When you are prompted to install the certificates to the Trusted Root Certification Authority store, press Y.  
  
 The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] certificate must be a SAN certificate with the following values:  
  
 *<AD FS service name\>.<domain\>*  
  
 `enterpriseregistration.` *<domain\>*  
  
 *<machine name\>.<domain\>*  
  
 In the test example, the values are:  
  
 `blueadfs.contoso.com`  
  
 `enterpriseregistration.contoso.com`  
  
 `2012R2-ADFS.contoso.com`  
  
 The enterpriseregistration SAN is needed for Workplace Join.  
  
### Set the server IP address  
 Change your server IP address to a static IP address. For the test example, use IP class A, which is 192.168.0.160 / subnet mask: 255.255.0.0 / Default Gateway: 192.168.0.1 / Preferred DNS: 192.168.0.150 (the IP address of your domain controller).  
  
## Install the AD FS role service  
 To install [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], follow these steps:  
  
1.  Log on to the physical or virtual machine on which you plan to install [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], open Server Manager, and start the Add Roles and Features Wizard.  
  
2.  On the **Select server roles** page, select the Active Directory Federation Services role, and then click **Next**.  
  
3.  If you plan to use your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server as part of a hybrid deployment and will use DirSync, on the **Select features** page, select **.NET Framework 3.5 Features**. Otherwise, leave the default selections in place. Click **Next**.  
  
    > [!NOTE]
    >  To install .NET 3.5, you must mount the Windows Server ISO as a DVD drive in your VHD.  
  
4.  On the **Active Directory Federation Services (AD FS)** page, you will see a message that states that the Web Application Proxy role cannot be installed on the same computer as [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. Click **Next**.  
  
5.  If you did not choose to install .NET 3.5, click **Install** on the confirmation page.  
  
     If you chose to install .NET 3.5, the confirmation page prompts you to specify an alternate source path. Click **Specify an alternate source path** and provide an alternate source path to the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] ISO, such as d:\sources\SxS. Then click **Install** on the confirmation page.  
  
> [!NOTE]
>  If you didn't mount the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] ISO, the **Results** page displays an error message that says that the source files could not be found. In this case, you must mount the ISO and restart the installation process for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
 To accomplish the equivalent installation of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] via [!INCLUDE[wps_2](../Token/wps_2_md.md)], use these commands:  
  
```powershell  
Add-WindowsFeature RSAT-AD-Tools  
Add-WindowsFeature AD FS-Federation –IncludeManagementTools  
# Install the .NET 3.5 features only if you plan to use DirSync# Replace E:\sources with the location of the mounted ISO in your VHD.  
Add-WindowsFeature NET-Framework-Features –Source <drive>:\sources\SxS   
```  
  
## Configure AD FS  
 Next, configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] by using either Server Manager or [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
### Configure AD FS by using Server Manager  
 To configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] by using Server Manager, follow these steps:  
  
1.  Open Server Manager.  
  
2.  Click the **Notifications** flag at the top of the Server Manager window, and then click **Configure the federation service on this server**.  
  
3.  The Active Directory Federation Services Configuration Wizard launches. On the **Connect to AD DS** page, enter the domain administrator account that you want to use as the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] account, and click **Next**.  
  
4.  On the **Specify Service Properties** page, enter the subject name of the SSL certificate to use for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] communication. In the test example, this is `blueadfs.contoso.com`.  
  
5.  Enter the Federation Service name. In the test example, this is `blueadfs.contoso.com`. Click **Next**.  
  
    > [!NOTE]
    >  The Federation Service name must not use the name of an existing server in the environment. If you do use the name of an existing server, the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] installation will fail and must be restarted.  
  
6.  On the **Specify Service Account** page, enter the name that you would like to use for the managed service account. For the test example, select **Create a Group Managed Service Account**, and in **Account Name**, enter `ADFSService`. Click **Next**.  
  
7.  On the **Specify Configuration Database** page, select **Create a database on this server using Windows Internal Database**, and click **Next**.  
  
8.  The **Review Options** page shows you an overview of the options you have selected. Click **Next**.  
  
9. The **Pre-requisite Checks** page indicates whether all the prerequisite checks passed successfully. If there are no issues, click **Configure**.  
  
    > [!NOTE]
    >  If you used the name of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server or any other existing machine for the Federation Service Name, an error message is displayed. You must start the installation over and choose a name other than the name of an existing machine.  
  
10. When the configuration completes successfully, the **Results** page confirms that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] was successfully configured.  
  
### Configure AD FS by using PowerShell  
 To accomplish the equivalent configuration of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] via [!INCLUDE[wps_2](../Token/wps_2_md.md)], use the following commands.  
  
 To install [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]:  
  
```powershell  
Add-WindowsFeature RSAT-AD-Tools  
Add-WindowsFeature ADFS-Federation -IncludeManagementTools   
```  
  
 To create the managed service account:  
  
```powershell  
New-ADServiceAccount "ADFSService"-Server 2012R2-DC.contoso.com -Path "CN=Managed Service Accounts,DC=Contoso,DC=COM"   -DNSHostName 2012R2-ADFS.contoso.com -ServicePrincipalNames HTTP/2012R2-ADFS,HTTP/2012R2-ADFS.contoso.com  
```  
  
 After you configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], you must set up an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] farm by using the managed service account that you created in the previous step and the certificate you created in the pre-configuration steps.  
  
 To set up an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] farm:  
  
```powershell  
$cert = Get-ChildItem CERT:\LocalMachine\My |where {$_.Subject -match blueadfs.contoso.com} | sort $_.NotAfter -Descending | select -first 1    
$thumbprint = $cert.Thumbprint  
Install-ADFSFarm -CertificateThumbprint $thumbprint -FederationServiceDisplayName "Contoso Corporation" –FederationServiceName blueadfs.contoso.com -GroupServiceAccountIdentifier contoso\ADFSService$ -OverwriteConfiguration -ErrorAction Stop  
```  
  
 Next step: [Deploy Work Folders with AD FS and Web Application Proxy: Step 2, AD FS Post-Configuration Work](../Topic/Deploy%20Work%20Folders%20with%20AD%20FS%20and%20Web%20Application%20Proxy:%20Step%202,%20AD%20FS%20Post-Configuration%20Work.md)  
  
## See Also  
 [Work Folders](../Topic/Work%20Folders%20Overview.md)