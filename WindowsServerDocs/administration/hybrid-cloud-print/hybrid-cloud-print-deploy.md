---
title: Deploy Windows Server Hybrid Cloud Print
description: "How to set up Microsoft Hybrid Cloud Print"
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

# Deploy Windows Server Hybrid Cloud Print with Pre-Authentication

>Applies To: Windows Server 2016

This topic, for IT administrators, describes the end-to-end deployment of the Microsoft Hybrid Cloud Print solution. This solution layers on top of existing Windows Server(s) running as Print Server, and enables Azure Active Directory joined, and MDM managed, devices to discover and print to organization managed printers.

## Pre-requisites

There are a number of subscriptions, services, and computers you'll need to acquire before starting this installation. They are as follows:

-   Azure AD premium subscription
    
    See [Get started with an Azure subscription](https://azure.microsoft.com/trial/get-started-active-directory/), for a trial subscription to Azure. 

-   MDM service, such as Intune
    
    See [Microsoft Intune](https://www.microsoft.com/en-us/cloud-platform/microsoft-intune), for a trial subscription to Intune.

-   Windows Server running as Active Directory

    See [Step-By-Step: Setting up Active Directory in Windows Server 2016](https://blogs.technet.microsoft.com/canitpro/2017/02/22/step-by-step-setting-up-active-directory-in-windows-server-2016/), for help setting up Active Directory.

-   Domain joined Windows Server 2016 running as Print Server
    
    See [Install roles, role services, and features by using the add Roles and Features Wizard](https://docs.microsoft.com/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features#BKMK_installarfw), for information on how to install roles and role services on Windows Server.

-   Azure AD Connect
    
    See [Custom installation of Azure AD Connect](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-get-started-custom), for help setting up Azure AD Connect.

-   Azure Application Proxy Connector on a separate domain joined Windows Server machine
    
    See [Get started with Application Proxy and install the connector](https://docs.microsoft.com/azure/active-directory/active-directory-application-proxy-enable), for help setting up Azure Application Proxy Connector.

-   Public facing domain name
    
    You can use the domain name created for you by Azure, or purchase your own domain name.

## Deployment steps

This guide outlines five (5) installation steps:

- Step 1: Install Azure AD Connect to sync between Azure AD and on-premises AD
- Step 2: Install Hybrid Cloud Print package on the Print Server
- Step 3: Install Azure Application Proxy (AAP) with Kerberos Constrained Delegation (KCD)
- Step 4: Configure the required MDM policies
- Step 5: Publish shared printers

### Step 1 - Install Azure AD Connect to sync between Azure AD and on-premises AD
1. On the Windows Server Active Directory machine, download the Azure AD Connect software
2. Launch the Azure AD Connect installation package and select **Use express settings**
3. Enter the information requested in the installation process and click **Install**

### Step 2 - Install Hybrid Cloud Print package on the Print Server

1. Install the Hybrid Cloud Print PowerShell modules
   - Run the following commands from an elevated PowerShell command prompt
      - `find-module -Name "PublishCloudPrinter"` to confirm that the machine can reach the PowerShell Gallery (PSGallery)
      - `install-module -Name "PublishCloudPrinter"`

     > NOTE: You may see a messaging stating that 'PSGallery' is an untrusted repository.  Enter 'y' to continue with the installation.

2. Install the Hybrid Cloud Print solution
    - In the same elevated PowerShell command prompt, change directory to `C:\Program Files\WindowsPowerShell\Modules\PublishCloudPrinter\1.0.0.0`
    - Run <br>
        `CloudPrintDeploy.ps1 -AzureTenant <Domain name used by Azure AD Connect> -AzureTenantGuid <Azure AD Directory ID>`
3. Configure the 2 IIS endpoints to support SSL
   -   The SSL certificate can be a self-signed cert or one issued from some trusted Certificate Authority (CA)
   -  If using self-signed cert, make sure the cert is imported to the client machine(s)
4. Install SQLite package
   - Open an elevated PowerShell command prompt
   - Run the following command to download System.Data.SQLite nuget packages <br>
       `Register-PackageSource -Name nuget.org -ProviderName NuGet -Location https://www.nuget.org/api/v2/ -Trusted -Force`
   - Run the following command to install the packages<br>
   `Install-Package system.data.sqlite [-requiredversion x.x.x.x] -providername nuget`

   > NOTE: It is recommended to download and install the latest version by leaving out the "-requiredversion" option.

5. Copy the SQLite dlls to the MopriaCloudService Webapp \<bin\> folder (**C:\\inetpub\\wwwroot\\MopriaCloudService\\bin**): <br>
   - The SQLite binaries should be at “\\Program Files\\PackageManagement\\NuGet\\Packages”

           \\System.Data.SQLite.**Core**.x.x.x.x\\lib\\net46\\System.Data.SQLite.dll
           --\> \<bin\>\\System.Data.SQLite.dll  
           \\System.Data.SQLite.**Core**.x.x.x.x\\build\\net46\\x86\\SQLite.Interop.dll
           --\> \<bin\>\\**x86**\\SQLite.Interop.dll  
           \\System.Data.SQLite.**Core**.x.x.x.x\\build\\net46\\x64\\SQLite.Interop.dll
           --\> \<bin\>\\**x64**\\SQLite.Interop.dll
           \\System.Data.SQLite.**Linq**.x.x.x.x\\lib\\net46\\System.Data.SQLite.Linq.dll
           --\> \<bin\>\\System.Data.SQLite.Linq.dll  
           \\System.Data.SQLite.**EF6**.x.x.x.x\\lib\\net46\\System.Data.SQLite.EF6.dll
           --\> \<bin\>\\System.Data.SQLite.EF6.dll

   > NOTE: x.x.x.x is the SQLite version installed above.

6. Update the `c:\inetpub\wwwroot\MopriaCloudService\web.config` file to include the SQLite version x.x.x.x in the following \<runtime\>/\<assemblyBinding\> sections:

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

7. Create the SQLite database:
    -  Download and install the SQLite Tools binaries from <https://www.sqlite.org/>
    -  Go to **c:\\inetpub\\wwwroot\\MopriaCloudService\\Database** directory
    -  Execute the following command to create the database in this directory:
        `sqlite3.exe MopriaDeviceDb.db ".read MopriaSQLiteDb.sql"`
    -  From File Explorer, open up the MopriaDeviceDb.db file properties to add Users/Groups which are allowed to publish to Mopria database in the Security tab
        - Recommend only adding the required Admin user group.
8. Register the 2 web app with Azure AD to support OAuth2 authentication
   - Login as the Global Admin to the Azure AD tenant management portal
     1. Go "App registrations" tab to add print endpoint
        - Add application, select "New application registration"
        - Provide an appropriate name and select "Web app / API"
        - Sign-on URL = "<http://MicrosoftEnterpriseCloudPrint/CloudPrint>"
     2. Repeat for the discovery endpoint
        - Sign-on URL = "<http://MopriaDiscoveryService/CloudPrint>"
     3. Repeat for the native client application
        -   When providing the app name, make sure you select "Native Client Application" as the "Application type"
        -   Redirect URI = "https://\<services-machine-endpoint\>/RedirectUrl"
     4. Go into the Native Client App "Settings"
        -   Copy the "Application ID" value to be used for later setup steps
        -   Select "Required permissions"
            1.  Click "Add"
            2.  Click "Select an API"
            3.  Search for the print endpoint and the discovery endpoint by the name you defined when creating the app endpoint
            4.  Add the 2 endpoints
            5.  Make sure the "Delegated Permissions" option for each app endpoint is enabled
            6.  Make sure you click the "Done" button at the bottom
            7.  Click "Grant Permissions", once both endpoints have been added.  Select "Yes" when prompted to approve request.
        -   Go to “REDIRECT URIS” and add the following redirect URIs to the list:
            `ms-appx-web://Microsoft.AAD.BrokerPlugin/\<NativeClientAppID\>`
            `ms-appx-web://Microsoft.AAD.BrokerPlugin/S-1-15-2-3784861210-599250757-1266852909-3189164077-45880155-1246692841-283550366`

### Step 3 - Install Azure Application Proxy (AAP) with Kerberos Constrained Delegation (KCD)
1. Login to your Azure AD (AAD) tenant management portal
    - In the AAD menu list, select "Application proxy"
    - Click "Enable application proxy" at the top of the screen
    - Download the "Application Proxy Connector" to a domain joined Windows Server machine that will act as the Web Application Proxy (WAP).
2. On the WAP machine, login as an Administrator and install the "Application Proxy Connector"
    - During installation, give the application proxy connector the credentials to your Azure tenet that you want to enable AAP on
    - Make sure the WAP machine is domain joined to your on-premises Active Directory
3. On the Active Directory machine, go to **Tools -> Users and Computers**
    - Select the machine that is running the Application Proxy Connector
    - Right-click and select **Properties -> Delegation** tab
    - Select **Trust this computer for delegation to specified services only.**
    - Select **Use any authentication protocol.**
    - Under **Services to which this account can present delegated credentials**
        - Add the value for the SPN identity of the machine running the Services (MopriaDiscoveryService and MicrosoftEnterpriseCloudPrint service)
            - For SPN, enter the SPN of the machine itself, i.e.
                    "HOST/\<MachineName\>.\<Domain\>"<br>
                `HOST/appServer.Contoso.com`
4. Go back to the AAD tenant management portal and add the application proxies
   - Go to the **Enterprise applications** tab
   - Click **New application**
   - Select **On-premises application** and fill in the fields
       - Name: Any name you wish
       - Internal URL: This is the internal URL to the Mopria Discovery Cloud Service which your WAP machine can access
       - External URL: Configure as appropriate for your organization
       - Preauthentication Method: Azure Active Directory

     >   Note: If you don’t find all the settings above, add the proxy with the settings available and then select the application proxy you just created and go to the **Application proxy** tab and add all the above information.

   - Once created, go back to **Enterprise applications** -> **All applications**, select the new application you just created
   - Go to **Single sign-on**, make sure the "Single Sign-on Mode" is set to "Integrated Windows Authentication"
   - Set the "Internal Application SPN" to the SPN you specified in Step 3.3, above
   - Make sure the "Delegated Login Identity" is set to "User principal name"

5. Repeat 4, above, for the Enterprise Cloud Print Service and provide the Internal URL to your Enterprise Cloud Print Service
6. Go back to the Azure AD tenant management portal and go to **App registrations** and select the Native Client App -> "Settings"
    - Select **Required permissions**
        - Add the 2 new proxy applications you just created
        - Grant Delegated Permissions for these 2 applications
        - Once both proxy applications have been added, click "Grant Permissions".  Select "Yes" when prompted to approve request.

7. Enable Windows Authentication in IIS for the Mopria Cloud Service and Enterprise Cloud Print Service machine(s)
    - Make sure Windows Authentication feature is installed:
        1. Open Server Manager
        2. Click **Manage**
        3. Click **Add Roles and Features**
        4. Select **Role-based or feature-based installation**
        5. Select the Server
        6. Under Web Server (IIS) -> Web Server -> Security, select **Windows Authentication**
        7. Click next until you finish installation
    - Enable Windows Authentication in IIS:
        1. Open Internet Information Services (IIS) Manager
        2. For each service/site:
            1.  Select the service/site
            2.  Double click **Authentication**
            3.  Click **Windows Authentication** and click **Enable** under **Actions**

### Step 4 - Configure the required MDM policies
- Login to your MDM provider
- Find the Enterprise Cloud Print policy group and configure the policies following the guidelines below:
  - CloudPrintOAuthAuthority = https://login.microsoftonline.com/\<Azure AD Directory ID\>
  - CloudPrintOAuthClientId = "Application ID" value of the Native Web App that you registered in Azure AD management portal
  - CloudPrinterDiscoveryEndPoint = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.3 (must be exactly the same but without the trailing /)
  - MopriaDiscoveryResourceId = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.4 (must be exactly the same including the trailing /)
  - CloudPrintResourceId = External URL of the Enterprise Cloud Print Service Azure Application Proxy created in Step 3.5 (must be exactly the same including the trailing /)
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
        - Value = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.4 (must be exactly the same including the trailing /)
    - `CloudPrintResourceId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintResourceId`
        - Value = External URL of the Enterprise Cloud Print Service Azure Application Proxy created in Step 3.5 (must be exactly the same including the trailing /)
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

        - DiscoveryEndpoint = External URL of the Mopria Discovery Service Azure Application Proxy created in Step 3.4
        - PrintServerEndpoint = External URL of the Enterprise Cloud Print Service Azure Application Proxy created in Step 3.5
        - AzureClientId = Application ID of the registered Native Web App value from above
        - AzureTenantGuid = Directory ID of your Azure AD tenant
        - DiscoveryResourceId = [Optional] Application ID of the proxied Mopria Discovery Cloud Service

        > NOTE: You can enter all of the required parameter values in the command line as well.<br>
        **Publish-CloudPrinter** PowerShell command syntax: <br>
        Publish-CloudPrinter -Printer \<string\> -Manufacturer \<string\> -Model \<string\> -OrgLocation \<string\> -Sddl \<string\> -DiscoveryEndpoint \<string\> -PrintServerEndpoint \<string\> -AzureClientId \<string\> -AzureTenantGuid \<string\> [-DiscoveryResourceId \<string\>] <br>
        Sample command:
        `publish-cloudprinter -Printer EcpPrintTest -Manufacturer Microsoft -Model FilePrinterEcp -OrgLocation '{"attrs": [{"category":"country", "vs":"USA", "depth":0}, {"category":"organization", "vs":"MyCompany", "depth":1}, {"category":"site", "vs":"MyCity, State", "depth":2}, {"category":"building", "vs":"Building 1", "depth":3}, {"category":"floor\_number", "vn":1, "depth":4}, {"category":"room\_name", "vs":"1111", "depth":5}]}' -Sddl "O:BAG:DUD:(A;OICI;FA;;;WD)" -DiscoveryEndpoint https://<services-machine-endpoint>/mcs -PrintServerEndpoint https://<services-machine-endpoint>/ecp -AzureClientId <Native Web App ID> -AzureTenantGuid <Azure AD Directory ID> -DiscoveryResourceId <Proxied Mopria Discovery Cloud Service App ID>`


## Verifying the deployment
On an Azure AD joined device that has the MDM policies configured:
- Open a web browser and to go to https://&lt;services-machine-endpoint&gt;/mcs/services (the external URL for the discovery endpoint)
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
