---
ms.assetid: 434fd617-373a-405e-bae4-da324ea83efc
title: Windows Server 2012 R2 AD FS Deployment Guide
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Configure a Federation Server

After you install the Active Directory Federation Services \(AD FS\) role service on your computer, you are ready to configure this computer to become a federation server. You can do one of the following:  
  
-   [Configure the first federation server in a new federation server farm](assetId:///e340cf8f-acf3-4cba-8135-a9353b85e714#BKMK_1)  
  
-   [Add a federation server to an existing federation server farm](assetId:///e340cf8f-acf3-4cba-8135-a9353b85e714#BKMK_2)  
  
## <a name="BKMK_1"></a>Configure the first federation server in a new federation server farm  
  
### To configure the first federation server in a new federation server farm by using the Active Directory Federation Service Configuration Wizard  
  
> [!NOTE]  
> Ensure that you have domain administrator permissions or have domain administrator credentials available before you perform this procedure.  
  
1.  On the Server Manager **Dashboard** page, click the **Notifications** flag, and then click **Configure the federation service on the server**.  
  
    The **Active Directory Federation Service Configuration Wizard** opens.  
  
2.  On the **Welcome** page, select **Create the first federation server in a federation server farm**, and then click **Next**.  
  
3.  On the **Connect to AD DS** page, specify an account by using domain administrator permissions for the Active Directory \(AD\) domain to which this computer is joined, and then click **Next**.  
  
4.  On the **Specify Service Properties** page, do the following, and then click **Next**:  
  
    -   Import the .pfx file that contains the Secure Socket Layer \(SSL\) certificate and key that you have obtained earlier. In [Step 2: Enroll an SSL Certificate for AD FS](../../ad-fs/deployment/Enroll-an-SSL-Certificate-for-AD-FS.md), you have obtained this certificate and copied it onto the computer that you want to configure as a federation server. To import the .pfx file via the wizard, click **Import**, and then browse to the file’s location. Enter the password for the .pfx file when you are prompted.  
  
    -   Provide a name for your federation service. For example, **fs.contoso.com**. This name must match one of the subject or subject alternative names in the certificate.  
  
    -   Provide a display name for your federation service. For example, **Contoso Corporation**. Users see this name on the Active Directory Federation Services \(AD FS\) sign\-in page.  
  
5.  On the **Specify Service Account** page, specify a service account. You can either create or use an existing group Managed Service Account \(gMSA\) or use an existing domain user account. If you select the option to create a new gMSA account, specify a name for the new account. If you select the option to use an existing gMSA or domain account, click **Select** to select an account.  
  
    > [!NOTE]  
    > The benefit of using a gMSA account is its auto\-negotiated password update feature.  
  
    > [!WARNING]  
    > If you want to use a gMSA account, you must have at least one domain controller in your environment that is running the  Windows Server 2012  operating system.  
    >   
    > If the gMSA option is disabled, and you see an error message, such as **Group Managed Service Accounts are not available because the KDS Root Key has not been set**, you can enable gMSA in your domain by running the following Windows PowerShell command on a domain controller, which runs Windows Server 2012 or later, in your Active Directory domain: `Add-KdsRootKey –EffectiveTime (Get-Date).AddHours(-10)`. Then return to the wizard, click **Previous**, and then click **Next** to re\-enter the **Specify Service Account** page. The gMSA option should now be enabled. You can select it and enter a gMSA account name that you want to use.  
  
6.  On the **Specify Configuration Database** page, specify an AD FS configuration database, and then click **Next**. You can either create a database on this computer by using Windows Internal Database \(WID\), or you can specify the location and the instance name of Microsoft SQL Server.  
  
    For more information, see [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md).  
  
    > [!IMPORTANT]  
    > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012 and SQL Server 2014.  
  
7.  On the **Review Options** page, verify your configuration selections, and then click **Next**.  
  
8.  On the **Pre\-requisite Checks** page, verify that all prerequisite checks are successfully completed, and then click **Configure**.  
  
9. On the **Results** page, review the results and check whether the configuration is completed successfully, and then click **Next steps required for completing your federation service deployment**. For more information, see [Next steps for completing your AD FS installation](https://go.microsoft.com/fwlink/p/?LinkId=286704). Click **Close** to exit the wizard.  
  
### <a name="BKMK_3"></a>To configure the first federation server in a new federation server farm via Windows PowerShell  
You can create a new federation server farm by using either a new or existing gMSA account or an existing domain user account.  
  
-   **If you want to create a new federation server by using a new gMSA account, do the following:**  
  
    > [!IMPORTANT]  
    > You must have domain administrator permissions to create the first federation server in a new federation server farm.  
  
    1.  On the computer that you want to configure as a federation server, ensure that the required SSL certificate has been imported into the **Local Computer\\My Store** directory. You can verify whether the SSL certificate has been imported by running the following command in the Windows PowerShell command window: `dir Cert:\LocalMachine\My`. The certificate is listed by its thumbprint in the **Local Computer\\My Store** directory.  
  
    2.  On your domain controller, open the Windows PowerShell command window and run the following command to verify whether the KDS Root Key has been created in your domain: `Get-KdsRootKey –EffectiveTime (Get-Date).AddHours(-10)`. If it has not been created so that the output displays no information, run the following command to create the key: `Add-KdsRootKey –EffectiveTime (Get-Date).AddHours(-10)`.  
  
    3.  On the computer that you want to configure as a federation server, open the Windows PowerShell command window, and run the following command:  
  
        ```  
        Install-AdfsFarm -CertificateThumbprint <certificate_thumbprint> -FederationServiceName <federation_service_name> -GroupServiceAccountIdentifier <domain>\<GMSA_Name>$  
        ```  
  
        > [!WARNING]  
        > The `$` sign at the end of the previous command is required.  
  
        To obtain the value for `<certificate_thumbprint>`, run `dir Cert:\LocalMachine\My`, and then select the thumbprint of your SSL certificate. The value of `<federation_service_name>` is the name of your federation service, for example, **fs.contoso.com**.  
  
        > [!NOTE]  
        > If this is NOT the first time that you run this command, add the `OverwriteConfiguration` parameter.  
  
        > [!NOTE]  
        > The previous command creates a WID farm. If you want to create a SQL Server server farm, you must have an instance of SQL Server already installed and operational.  
        >   
        > You can use the following command to create the first federation server in a new farm that uses an instance of SQL Server: `Install-AdfsFarm -CertificateThumbprint <certificate_thumbprint> -FederationServiceName <federation_service_name> -GroupServiceAccountIdentifier <domain>\<GMSA_name>$ -SQLConnectionString "Data Source=<SQL_Host_Name?\<SQL_instance_ name>;Integrated Security=True"` where **<SQL\_Host\_Name>** is the name of the server on which SQL Server is running, and **<SQL\_instance\_name>** is the name of the instance of SQL Server. If you use the default instance of SQL Server, use a **SQLConnectionString** value of "**Data Source\=<SQL\_Host\_Name>;Integrated Security\=True**".  
  
        > [!IMPORTANT]  
        > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.  
  
-   **If you want to create a new federation server by using an existing domain user account, do the following:**  
  
    1.  On the computer that you want to configure as a federation server, ensure that the required SSL certificate has been imported into the **Local Computer\\My Store** directory. You can verify whether the SSL certificate has been imported by running the following command in the Windows PowerShell command window: `dir Cert:\LocalMachine\My`. The certificate is listed by its thumbprint in the **Local Computer\\My Store** directory.  
  
    2.  On the computer that you want to configure as a federation server, open the Windows PowerShell command window, and then run the following command: `$fscred = Get-Credential`. Enter the domain user account credentials that you want to use for the federation service account in the format domain\\user name.  
  
    3.  In the same Windows PowerShell command window, run the following command:  
  
        ```  
        Install-AdfsFarm -CertificateThumbprint <certificate_thumbprint> -FederationServiceName <federation_service_name> -ServiceAccountCredential $fscred  
        ```  
  
        To obtain the value for **<certificate\_thumbprint>**, run `dir Cert:\LocalMachine\My`, and then select the thumbprint of your SSL certificate. The value of **<federation\_service\_name>** is the name of your federation service, for example, fs.contoso.com.  
  
        > [!NOTE]  
        > If this is NOT the first time that you run this command, add the `OverwriteConfiguration` parameter.  
  
        > [!NOTE]  
        > The previous command creates a WID farm. If you want to create a SQL Server farm, you must have the instance of SQL Server already installed and operational.  
        >   
        > You can use the following command to create the first federation server in a new farm that uses an instance of SQL Server: `Install-AdfsFarm -CertificateThumbprint <certificate_thumbprint> -FederationServiceName <federation_service_name> -ServiceAccountCredential $fscredential -SQLConnectionString "Data Source=<SQL_Host_Name>\<SQL_instance_ name>;Integrated Security=True"` where **SQL\_Host\_Name** is the name of the server on which SQL Server is running, and **SQL\_instance\_name** is the name of the instance of SQL Server. If you use the default instance of SQL Server, use a **SQLConnectionString** value of "**Data Source\=<SQL\_Host\_Name>;Integrated Security\=True**".  
  
        > [!IMPORTANT]  
        > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012 and SQL Server 2014.  
  
## <a name="BKMK_2"></a>Add a federation server to an existing federation server farm  
  
> [!IMPORTANT]  
> Ensure that you have completed [Step 3: Install the AD FS Role Service](../../ad-fs/deployment/Install-the-AD-FS-Role-Service.md), before you start any of the procedures in this section.  
  
> [!IMPORTANT]  
> Ensure that you have obtained a valid SSL server authentication certificate before you complete this procedure.  
  
### To add a federation server to an existing federation server farm via the Active Directory Federation Service Configuration Wizard  
  
1.  On the Server Manager **Dashboard** page, click the **Notifications** flag, and then click **Configure the federation service on the server**.  
  
    The **Active Directory Federation Service Configuration Wizard** opens.  
  
2.  On the **Welcome** page, select **Add a federation server to a federation server farm**, and then click **Next**.  
  
3.  On the **Connect to AD DS** page, specify an account by using domain administrator permissions for the AD domain to which this computer is joined, and then click **Next**.  
  
4.  On the **Specify Farm** page, provide the name of the primary federation server in a farm that uses WID or specify the database host name and the database instance name of an existing federation server farm that uses SQL Server.  
  
    > [!WARNING]  
    > In Windows Server® 2012 R2, there is a workaround to specify the default instance of SQL Server. The workaround is to not use the user interface. Instead, use the steps in [To configure the first federation server in a new federation server farm via Windows PowerShell](Configure-a-Federation-Server.md#BKMK_3).  
  
    > [!IMPORTANT]  
    > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012.  
  
5.  On the **Specify SSL Certificate** page, import the .pfx file that contains the SSL certificate and key that you have obtained previously. This certificate is the required service authentication certificate. In [Step 2: Enroll an SSL Certificate for AD FS](../../ad-fs/deployment/Enroll-an-SSL-Certificate-for-AD-FS.md), you have obtained this certificate and copied it to the computer that you want to configure as a federation server. To import the .pfx file via the wizard, click **Import** and browse to the file’s location. Enter the password for the .pfx file when you are prompted.  
  
6.  On the **Specify Service Account** page, specify the same service account that you configured when you created the first federation server in the farm. You can use an existing group Managed Service Account or an existing domain user account.  
  
    > [!IMPORTANT]  
    > The account that you specify must be the same account as the account that was used on the primary federation server in this farm.  
  
7.  On the **Review Options** page, verify your configuration selections, and then click **Next**.  
  
8.  On the **Pre\-requisite Checks** page, verify that all prerequisite checks are successfully completed, and then click **Configure**.  
  
9. On the **Results** page, review the results and check whether the configuration is completed successfully, and then click **Next steps required for completing your federation service deployment**. For more information, see [Next steps for completing your AD FS installation](https://go.microsoft.com/fwlink/p/?LinkId=286704). Click **Close** to exit the wizard.  
  
### To add a federation server to an existing federation server farm via Windows PowerShell  
You can add a federation server to an existing farm by using either an existing gMSA account or an existing domain user account.  
  
-   If you want to join a federation server to a farm by using an existing gMSA account, do the following:  
  
    1.  On the computer that you want to configure as a federation server, ensure that the required SSL certificate has been imported into the **Local Computer\\My Store** directory. You can verify whether the SSL certificate has been imported by running the following command in the Windows PowerShell command window: `dir Cert:\LocalMachine\My`. The certificate is listed by its thumbprint in the **Local Computer\\My Store** directory.  
  
    2.  On the computer that you want to configure as a federation server, open the Windows PowerShell command window, and run the following command.  
  
        ```  
        Add-AdfsFarmNode -GroupServiceAccountIdentifier <domain>\<GMSA_name>$ -PrimaryComputerName <first_federation_server_hostname> -CertificateThumbprint <certificate_thumbprint>  
        ```  
  
        `<domain>\<GMSA_name>` is your AD domain and the name of your gMSA account in that domain. `<first_federation_server_hostname>` is the host name of the primary federation server in this existing farm.  
  
        You can obtain the value for `<certificate_thumbprint>` by running `dir Cert:\LocalMachine\My` in the previous step.  
  
        > [!NOTE]  
        > If this is NOT the first time that you run this command, add the `OverwriteConfiguration` parameter.  
  
        > [!NOTE]  
        > The previous command creates a WID farm node. If you want to create a server farm node of computers running SQL Server, you must have the instance of SQL Server already installed and operational.  
        >   
        > You can use the following command to add a federation server to an existing farm that is using an instance of SQL Server: `Add-AdfsFarmNode -GroupServiceAccountIdentifier <domain>\<GMSA_name>$ -SQLConnectionString "Data Source=<SQL_Host_Name>\<SQL_instance_ name>;Integrated Security=True"` where **SQL\_Host\_Name** is the name of the server on which SQL Server is running, and **SQL\_instance\_name** is the name of the instance of SQL Server. If you use the default instance of SQL Server, use a **SQLConnectionString** value of "**Data Source\=<SQL\_Host\_Name>;Integrated Security\=True**".  
  
        > [!IMPORTANT]  
        > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012 and SQL Server 2014.  
  
-   If you want to join a federation server to a farm by using an existing domain user account, do the following:  
  
    1.  On the computer that you want to configure as a federation server, open the Windows PowerShellcommand window, and then run the following command: `$fscred = get-credential`. Enter the domain user account credentials that you want to use for the federation service account in the format domain\\user name.  
  
    2.  On the computer that you want to configure as a federation server, ensure that the required SSL certificate has been imported into the **Local Computer\\My Store** directory. You can verify whether the SSL certificate has been imported by running the following command in the Windows PowerShellcommand window: `dir Cert:\LocalMachine\My`. The certificate is listed by its thumbprint in the **Local Computer\\My Store** directory.  
  
    3.  In the same Windows PowerShell command window, run the following command.  
  
        ```  
        Add-AdfsFarmNode -ServiceAccountCredential $fscred -PrimaryComputerName <first_federation_server_hostname> -CertificateThumbprint <certificate_thumbprint>  
        ```  
  
        > [!NOTE]  
        > If this is NOT the first time that you run this command, add the `OverwriteConfiguration` parameter.  
  
        > [!NOTE]  
        > The previous command creates a WID farm node. If you want to create a server farm node of computers running SQL Server, you must have the instance of SQL Server already installed and operational. You can use the following command to add a federation server to an existing farm by using an instance of SQL Server: `Add-AdfsFarmNode -ServiceAccountCredential $fscred -SQLConnectionString "Data Source=<SQL_Host_Name>\<SQL_instance_ name>;Integrated Security=True"` where **SQL\_Host\_Name** is the name of the server on which the instance of SQL Server is running, and **SQL\_instance\_name** is the name of the instance of SQL Server. If you use the default instance of SQL Server, use a **SQLConnectionString** value of "**Data Source\=<SQL\_Host\_Name>;Integrated Security\=True**".  
  
        > [!IMPORTANT]  
        > If you want to create an AD FS farm and use SQL Server to store your configuration data, you can use SQL Server 2008 and newer versions, including SQL Server 2012 and SQL Server 2014.  
  
## See Also 

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
  

