---
title: Deploy Windows Server Hybrid Cloud Print - Passthrough Auth
description: "How to set up Microsoft Hybrid Cloud Print with passthrough authentication"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: Windows Server 2016
ms.tgt_pltfrm: na
ms.topic:
ms.assetid: fc239aec-e719-47ea-92fc-d82a7247c5e9
author: msjimwu
ms.author: coreyp
manager: dongill
ms.date: 3/15/2018
---

# Deploy Windows Server Hybrid Cloud Print with Passthrough Authentication

>Applies To: Windows Server 2016

This topic, for IT administrators, describes the end-to-end deployment of the Microsoft Hybrid Cloud Print solution. This solution layers on top of existing Windows Server(s) running as Print Server, and enables Azure Active Directory (Azure AD) joined, and MDM managed, devices to discover and print to organization managed printers.

## Pre-requisites

There are a number of subscriptions, services, and computers you'll need to acquire before starting this installation. They are as follows:

- Azure AD premium subscription

  See [Get started with an Azure subscription](https://azure.microsoft.com/trial/get-started-active-directory/), for a trial subscription to Azure.

- MDM service, such as Intune

  See [Microsoft Intune](https://www.microsoft.com/en-us/cloud-platform/microsoft-intune), for a trial subscription to Intune.

- Windows Server running Active Directory

  See [Step-By-Step: Setting up Active Directory in Windows Server 2016](https://blogs.technet.microsoft.com/canitpro/2017/02/22/step-by-step-setting-up-active-directory-in-windows-server-2016/), for help setting up Active Directory.

- Domain joined Windows Server 2016 running as Print Server

- A separate domain joined Windows Server machine running as Connector Server

- Public facing domain name

  You can use the domain name created for you by Azure, or purchase your own domain name.

## Deployment steps

This guide outlines five (5) installation steps:

- Step 1: Install Azure AD Connect to sync between Azure AD and on-premises AD
- Step 2: Register and configure Azure web applications
- Step 3: Install roles and Hybrid Cloud Print package on the Print Server
- Step 4: Configure the required MDM policies
- Step 5: Publish shared printers

### Step 1 - Install Azure AD Connect to sync between Azure AD and on-premises AD

1. On the on-premise Windows Server machine running Active Directory, download and install the Azure AD Connect software. See [Getting started with Azure AD Connect using express settings](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-install-express)


### Step 2 - Register and configure Azure web applications

1. Install Application Proxy on the Connector Server. See [Tutorial: Add an on-premises application for remote access through Application Proxy in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/application-proxy-add-on-premises-application)

2. Login to Azure portal to register web apps
    - Under Azure Active Directory, go to **App registrations** > **New registration**

    ![AAD App Registration 1](../media/hybrid-cloud-print/AAD-AppRegistration.png)

    - Enter an app name for Mopria Discovery service. Click **Register** to finish

    ![AAD App Registration 2](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria.png)

    - Repeat for Enterprise Cloud Print service
    - Repeat for native app
    - A total of three applications should be displayed under App registrations

    ![AAD App Registration 3](../media/hybrid-cloud-print/AAD-AppRegistration-AllApps.png)

3. Expose API
    - While still in the App registrations blade, click on the Mopria Discovery Service app, select **Expose an API**, then click on **Set** next to Application ID URI

    ![AAD Expose API 1](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria-ExposeAPI.png)

    - Click on **Save** without changing the default value for Application ID URI. This value just needs to be set now and will be changed later

    ![AAD Expose API 2](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria-ExposeAPI-Save.png)

    - Click on **Add a scope**

    ![AAD Expose API 3](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria-ExposeAPI-AddScope.png)

    - Provide a scope name, allow both admins and users to consent, enter consent description, and then click on **Add scope** to finish

    ![AAD Expose API 4](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria-ExposeAPI-ScopeName.png)

    - Repeat for Enterprise Cloud Print service. Use a different scope name and consent description

    ![AAD Expose API 5](../media/hybrid-cloud-print/AAD-AppRegistration-ECP-ExposeAPI-ScopeName.png)

4. Add API permission
    - Return to App registrations blade. Click on the native app and select API permissions. Click on **Add a permission**

    ![AAD API Permission 1](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission.png)

    - Switch to **APIs my organization uses**, then use the search box to find Mopria Discovery Service added earlier. Click on the service from the search result

    ![AAD API Permission 2](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-Mopria.png)

    - Select **Delegated permissions**. Check the box next to the API scope. Click on **Add permissions**

    ![AAD API Permission 3](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-Mopria-Add.png)

    - Repeat to add permissions to Enterprise Cloud Print Service

    ![AAD API Permission 4](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-ECP-Add.png)

    - Once returned to the API permissions blade, wait 10 seconds before clicking on **Grand admin consent...**

    ![AAD API Permission 5](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-GrantConsent.png)

    - Click on **Yes** when prompted

    ![AAD API Permission 6](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-GrantConsent-Yes.png)

    - Verify that the status column of the API permission is displayed with green check marks

    ![AAD API Permission 7](../media/hybrid-cloud-print/AAD-AppRegistration-APIPermission-Verify.png)

5. Configure URL in Enterprise applications
    - Go to **Azure Active Directory** > **Enterprise applications** > **All applications**. Search for the Mopria Discovery Service and click on it

    ![AAD App Proxy 1](../media/hybrid-cloud-print/AAD-EnterpriseApp-AllApps.png)

    - Click on **Application proxy**. Enter internal Url using the format `https://<fully qualified domain name of the Print Server>/msc/`. Click on **Save** to finish

    ![AAD App Proxy 2](../media/hybrid-cloud-print/AAD-EnterpriseApp-Mopria-AppProxy.png)

    - Repeat for Enterprise Cloud Print service. Note the internal URL is `https://<fully qualified domain name of the Print Server>/ecp/`

    ![AAD App Proxy 3](../media/hybrid-cloud-print/AAD-EnterpriseApp-ECP-AppProxy.png)

    - Go to **Azure Active Directory** > **App registrations**. Click on the Mopria Discovery Service. Under **Overview**, note that the Application ID URI has been changed from the default to one that contains `msappproxy` in its name. The URI will be used during Print Server setup, in client MDM policy, and for publishing printer

    ![AAD App Proxy 4](../media/hybrid-cloud-print/AAD-AppRegistration-Mopria-Overview.png)

6. Configure redirect URI in the native app
    - Go to **Azure Active Directory** > **App registrations**. Click on the native app. Go to **Overview** and copy the **Application (client) ID**

    ![AAD Redirect URI 1](../media/hybrid-cloud-print/AAD-AppRegistration-Native-Overview.png)

    - Go to **Authentication**. Change the **TYPE** dropdown box to `Public...`, and enter two redirect URIs using the format below, where `<NativeClientAppID>` is from the previous step:

            `ms-appx-web://Microsoft.AAD.BrokerPlugin/<NativeClientAppID>`

            `web://Microsoft.AAD.BrokerPlugin/S-1-15-2-3784861210-599250757-1266852909-3189164077-45880155-1246692841-283550366`

    ![AAD Redirect URI 2](../media/hybrid-cloud-print/AAD-AppRegistration-Native-Authentication.png)

    - Click **Save** to finish

### Step 3 - Install roles and Hybrid Cloud Print package on the Print Server

1. Make sure the Print Server has all the available Windows Update installed. Note: Server 2019 must be patched to build 17763.165 or above
    - Install the following server roles:
        - Print Server role
        - Internet Information Service (IIS)
    - See [Install roles, role services, and features by using the add Roles and Features Wizard](https://docs.microsoft.com/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features#BKMK_installarfw) for details on how to install server roles

    ![Print Server Roles](../media/hybrid-cloud-print/PrintServer-Roles.png)

2. Install the Hybrid Cloud Print PowerShell modules
    - Run the following commands from an elevated PowerShell command prompt

            `find-module -Name "PublishCloudPrinter"` to confirm that the machine can reach the PowerShell Gallery (PSGallery)

            `install-module -Name "PublishCloudPrinter"`
            > NOTE: You may see a messaging stating that 'PSGallery' is an untrusted repository.  Enter 'y' to continue with the installation.

    ![Print Server Publish Cloud Printer](../media/hybrid-cloud-print/PrintServer-PublishCloudPrinter.png)

3. Install the Hybrid Cloud Print solution
    - In the same elevated PowerShell command prompt, change directory to the one below (quotation marks needed):

            `"C:\Program Files\WindowsPowerShell\Modules\PublishCloudPrinter\1.0.0.0"`

    - Run

            `.\CloudPrintDeploy.ps1 -AzureTenant <Azure Active Directory domain name> -AzureTenantGuid <Azure Active Directory ID>`

    - Refer to the screenshot below to find the Azure Active Directory domain name

    ![Print Server How to Get AAD Domain Name](../media/hybrid-cloud-print/PrintServer-GetAADDomainName.png)

    - Refer to the screenshot below to find the Azure Active Directory ID

    ![Print Server Cloud Print Deploy](../media/hybrid-cloud-print/PrintServer-GetAADId.png)

    - The output of the CloudPrintDeploy script looks like this:

    ![Print Server Cloud Print Deploy](../media/hybrid-cloud-print/PrintServer-CloudPrintDeploy.png)

    - Check the log file to see if there is any error:
    `C:\Program Files\WindowsPowerShell\Modules\PublishCloudPrinter\1.0.0.0>notepad CloudPrintDeploy.log`

4. Open RegitEdit in an elevated command prompt. Go to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudPrint\EnterpriseCloudPrintService
    - Make sure AzureAudience is set to the Application ID URI of Enterprise Cloud Print app
    - Make sure AzureTenant is set to the Azure AD domain name

    ![Print Server ECP Registry Keys](../media/hybrid-cloud-print/PrintServer-RegEdit-ECP.png)

5. Go to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudPrint\MopriaDiscoveryService
    - Make sure AzureAudience is the Application ID URI of Mopria Discovery Service app
    - Make sure AzureTenant is the Azure AD domain name
    - Make sure URL is the Application ID URI of Mopria Discovery Service app

    ![Print Server Mopria Registry Keys](../media/hybrid-cloud-print/PrintServer-RegEdit-Mopria.png)

6. Run iisreset in an elevate Powershell command prompt. This will ensure any registry change made in the previous step takes effect.

7. Configure the IIS endpoints to support SSL
    - The SSL certificate can be a self-signed cert or one issued from a trusted Certificate Authority (CA)
    - If using self-signed cert, make sure the cert is imported to the client machine(s)
    - If you register your domain with 3rd party provider, you will need to configure the IIS endpoints with SSL certificate. See this [guide](https://www.sslsupportdesk.com/microsoft-server-2016-iis-10-10-5-ssl-installation/) for detail.

8. Install SQLite package
   - Open an elevated PowerShell command prompt
   - Run the following command to download System.Data.SQLite nuget packages

            `Register-PackageSource -Name nuget.org -ProviderName NuGet -Location https://www.nuget.org/api/v2/ -Trusted -Force`

   - Run the following command to install the packages

            `Install-Package system.data.sqlite [-requiredversion x.x.x.x] -providername nuget`

   > NOTE: It is recommended to download and install the latest version by leaving out the "-requiredversion" option.

    ![Print Server Mopria Registry Keys](../media/hybrid-cloud-print/PrintServer-InstallSQLite.png)

9. Copy the SQLite dlls to the MopriaCloudService Webapp bin folder (C:\inetpub\wwwroot\MopriaCloudService\bin). 
    - Create a .ps1 file containing the following PowerShell script. 
    - Change to the $version variable to the SQLite version installed in previous step.
    - Run the .ps1 file in an elevated PowerShell command prompt

    ```powershell
    ...
    $source = "\Program Files\PackageManagement\NuGet\Packages"
    $core = "System.Data.SQLite.Core"
    $linq = "System.Data.SQLite.Linq"
    $ef6 = "System.Data.SQLite.EF6"
    $version = "x.x.x.x"
    $target = "C:\inetpub\wwwroot\MopriaCloudService\bin"

    xcopy /y "$source\$core.$version\lib\net46\System.Data.SQLite.dll" "$target\"
    xcopy /y "$source\$core.$version\build\net46\x86\SQLite.Interop.dll" "$target\x86\"
    xcopy /y "$source\$core.$version\build\net46\x64\SQLite.Interop.dll" "$target\x64\"
    xcopy /y "$source\$linq.$version\lib\net46\System.Data.SQLite.Linq.dll" "$target\"
    xcopy /y "$source\$ef6.$version\lib\net46\System.Data.SQLite.EF6.dll" "$target\"
    ...
    ```

10. Update the c:\inetpub\wwwroot\MopriaCloudService\web.config file to include the SQLite version x.x.x.x in the following `<runtime>/<assemblyBinding>` sections:

    ```xml
    ...
    <dependentAssembly>
    assemblyIdentity name="System.Data.SQLite" culture="neutral" publicKeyToken="db937bc2d44ff139" /
    <bindingRedirect oldVersion="0.0.0.0-x.x.x.x" newVersion="x.x.x.x" />
    </dependentAssembly>
    <dependentAssembly>
    <assemblyIdentity name="System.Data.SQLite.Core" culture="neutral" publicKeyToken="db937bc2d44ff139" />
    <bindingRedirect oldVersion="0.0.0.0-x.x.x.x" newVersion="x.x.x.x" />
    </dependentAssembly>
    <dependentAssembly>
    <assemblyIdentity name="System.Data.SQLite.EF6" culture="neutral" publicKeyToken="db937bc2d44ff139" />
    <bindingRedirect oldVersion="0.0.0.0-x.x.x.x" newVersion="x.x.x.x" />
    </dependentAssembly>
    <dependentAssembly>
    <assemblyIdentity name="System.Data.SQLite.Linq" culture="neutral" publicKeyToken="db937bc2d44ff139" />
    <bindingRedirect oldVersion="0.0.0.0-x.x.x.x" newVersion="x.x.x.x" />
    </dependentAssembly>
    ...
    ```

11. Create the SQLite database
    - Download and install the SQLite Tools binaries from `https://www.sqlite.org/`
    - Go to `c:\inetpub\wwwroot\MopriaCloudService\Database` directory
    - Execute the following command to create the database in this directory:

            `sqlite3.exe MopriaDeviceDb.db ".read MopriaSQLiteDb.sql"`

    - From File Explorer, open up the MopriaDeviceDb.db file properties to add Users/Groups which are allowed to publish to Mopria database in the Security tab

    ![Print Server Mopria Registry Keys](../media/hybrid-cloud-print/PrintServer-SQLiteDB.png)

### Step 4 - Configure the required MDM policies

- Login to your MDM provider
- Find the Enterprise Cloud Print policy group and configure the policies following the guidelines below:
  - CloudPrintOAuthAuthority = `https://login.microsoftonline.com/\<Azure AD Directory ID\>`
  - CloudPrintOAuthClientId = "Application ID" value of the Native Web App that you registered in Azure AD management portal
  - CloudPrinterDiscoveryEndPoint = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.3 (must be exactly the same but without the trailing /)
  - MopriaDiscoveryResourceId = The "App ID URI" of the Web app / API for the discovery endpoint registered in Step 2.8.  You can find this under the Settings -> Properties of the app
  - CloudPrintResourceId = The "App ID URI" of the Web app / API for the print endpoint registered in Step 2.8. You can find this under the Settings -> Properties of the app
  - DiscoveryMaxPrinterLimit = \<a positive integer\>

>   Note: If you are using Microsoft Intune service, you can find these settings under the "Cloud Printer" category.

|Intune Display Name                     |Policy                         |
|----------------------------------------|-------------------------------|
|Printer discovery URL                   |CloudPrinterDiscoveryEndpoint  |
|Printer access authority URL            |CloudPrintOAuthAuthority       |
|Azure native client app GUID            |CloudPrintOAuthClientId        |
|Print service resource URI              |CloudPrintResourceId           |
|Maximum printers to query(Mobile only)  |DiscoveryMaxPrinterLimit       |
|Printer discovery service resource URI  |MopriaDiscoveryResourceId      |


>   Note: If the Cloud Print policy group is not available, but the MDM provider supports OMA-URI settings, then you can set the same policies.  Please refer to this <a href="https://docs.microsoft.com/windows/client-management/mdm/policy-csp-enterprisecloudprint#enterprisecloudprint-cloudprintoauthauthority">article</a> for additional info.

- OMA-URI
    - `CloudPrintOAuthAuthority = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintOAuthAuthority`
        - Value = `https://login.microsoftonline.com/`\<Azure AD Directory ID\>
    - `CloudPrintOAuthClientId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintOAuthClientId`
        - Value = \<Azure AD Native App's Application ID\>
    - `CloudPrinterDiscoveryEndPoint = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrinterDiscoveryEndPoint`
        - Value = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.3 (must be exactly the same but without the trailing /)
    - `MopriaDiscoveryResourceId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/MopriaDiscoveryResourceId`
        - Value = The "App ID URI" of the Web app / API for the discovery endpoint registered in Step 2.8.  You can find this under the Settings -> Properties of the app
    - `CloudPrintResourceId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintResourceId`
        - Value = The "App ID URI" of the Web app / API for the print endpoint registered in Step 2.8. You can find this under the Settings -> Properties of the app
    - `DiscoveryMaxPrinterLimit = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/DiscoveryMaxPrinterLimit`
        - Value = \<a positive integer\>
  
### Step 5 - Publish desired shared printers
1. Install desired printer on the Print Server
2. Share the printer through the Printer Properties UI
3. Select the desired set of users to grant access
4. Save the changes and close out the printer properties window
5. From a Windows 10 Fall Creator Update machine, open an elevated Windows PowerShell command prompt
   1. Run the following commands
      - `find-module -Name "PublishCloudPrinter"` to confirm that the machine can reach the PowerShell Gallery (PSGallery)
      - `install-module -Name "PublishCloudPrinter"`

        >   NOTE: You may see a messaging stating that 'PSGallery' is an untrusted repository.  Enter 'y' to continue with the installation.

      - Publish-CloudPrinter
        - Printer = The shared printer name that was defined
        - Manufacturer = Printer manufacturer
        - Model = Printer model
        - OrgLocation = A JSON string specifying the printer location,
            e.g.:
            `{"attrs": [{"category":"country", "vs":"USA", "depth":0}, {"category":"organization", "vs":"Microsoft", "depth":1}, {"category":"site", "vs":"Redmond, WA", "depth":2}, {"category":"building", "vs":"Building 1", "depth":3}, {"category":"floor\_number", "vn":1, "depth":4}, {"category":"room\_name", "vs":"1111", "depth":5}]}`
        - Sddl = SDDL string representing permissions for the printer. This can be obtained by modifying the Printer Properties Security tab appropriately and then running the following command in a command prompt:
            `(Get-Printer PrinterName -full).PermissionSDDL`
            e.g. "G:DUD:(A;OICI;FA;;;WD)"

          > NOTE: You will need to add **`O:BA`** as prefix to the result from the command prompt command above before setting the value as the SDDL setting.  Example: SDDL = `O:BAG:DUD:(A;OICI;FA;;;WD)`

        - DiscoveryEndpoint = https://&lt;services-machine-endpoint&gt;/mcs
        - PrintServerEndpoint = https://&lt;services-machine-endpoint&gt;/ecp
        - AzureClientId = Application ID of the registered Native Web App value from above
        - AzureTenantGuid = Directory ID of your Azure AD tenant
        - DiscoveryResourceId = [Optional] Application ID of the proxied Mopria Discovery Cloud Service

        > NOTE: You can enter all of the required parameter values in the command line as well.<br>
        **Publish-CloudPrinter** PowerShell command syntax: <br>
        Publish-CloudPrinter -Printer \<string\> -Manufacturer \<string\> -Model \<string\> -OrgLocation \<string\> -Sddl \<string\> -DiscoveryEndpoint \<string\> -PrintServerEndpoint \<string\> -AzureClientId \<string\> -AzureTenantGuid \<string\> [-DiscoveryResourceId \<string\>] <br>
        Sample command:
        `publish-cloudprinter -Printer EcpPrintTest -Manufacturer Microsoft -Model FilePrinterEcp -OrgLocation '{"attrs": [{"category":"country", "vs":"USA", "depth":0}, {"category":"organization", "vs":"MyCompany", "depth":1}, {"category":"site", "vs":"MyCity, State", "depth":2}, {"category":"building", "vs":"Building 1", "depth":3}, {"category":"floor\_number", "vn":1, "depth":4}, {"category":"room\_name", "vs":"1111", "depth":5}]}' -Sddl "O:BAG:DUD:(A;OICI;FA;;;WD)" -DiscoveryEndpoint https://<services-machine-endpoint>/mcs -PrintServerEndpoint https://<services-machine-endpoint>/ecp -AzureClientId <Native Web App ID> -AzureTenantGuid <Azure AD Directory ID> -DiscoveryResourceId <Proxied Mopria Discovery Cloud Service App ID>`


## Verifing the deployment
On an Azure AD joined device that has the MDM policies configured:
- Open a web browser and to go to https://&lt;services-machine-endpoint&gt;/mcs/services
- You should see the JSON text describing the set of functionality of this endpoint
- Go to "OS Settings -\> Devices -\> Printers & scanners"
    - You should see a "Search for cloud printers" link
    - Click on the link
    - Click the “Please select a search location” link
        - You should see the device location hierarchy
    - Pick a location and click **OK** and then click **Search** button to find the printers
    - Select printer and click **Add device** button
    - After successful printer installation, print to the printer from your favorite app

>   Note: If using the “EcpPrintTest” printer, you can find the output file in the Print Server machine under “C:\\ECPTestOutput\\EcpTestPrint.xps” location.