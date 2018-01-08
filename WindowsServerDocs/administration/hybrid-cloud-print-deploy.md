---
title: How to Setup Microsoft Hybrid Cloud Print Solution
description: "How to Setup Microsoft Hybrid Cloud Print Solution"
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
ms.date: 1/5/2018
---

# How to Setup Microsoft Hybrid Cloud Print Solution

>Applies To: Windows Server 2016

This topic, for IT administrators, describes the end-to-end deployment of the Microsoft Hybrid Cloud Print solution. This solution layers on top of existing Windows Server(s) running as Print Server, and enables Azure Active Directory joined, and MDM managed devices, to discover and print to organization managed printers.

## Pre-requisites

There are a number of subscriptions, services, and computers you'll need to aquire before starting this installation. They are as follows:

-   Azure AD premium subscription
    See [Get started with an Azure subscription](https://azure.microsoft.com/en-us/trial/get-started-active-directory/), for a trial subscription to Azure. 

-   MDM service, such as Intune
    See [Microsoft Intune](https://www.microsoft.com/en-us/cloud-platform/microsoft-intune), for a trial subscription to Intune.

-   Windows Server running as Active Directory
    See [Step-By-Step: Setting up Active Directory in Windows Server 2016](https://blogs.technet.microsoft.com/canitpro/2017/02/22/step-by-step-setting-up-active-directory-in-windows-server-2016/), for help setting up Active Directory.

-   Domain joined Windows Server 2016 running as Print Server
    See [Install roles, role services, and features by using the add Roles and Features Wizard](https://docs.microsoft.com/en-us/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features#BKMK_installarfw), for information on how to install roles and role services on Windows Server.

-   Azure AD Connect
    See [Custom installation of Azure AD Connect](https://docs.microsoft.com/en-us/azure/active-directory/connect/active-directory-aadconnect-get-started-custom), for help setting up Azure AD Connect.

-   Azure Application Proxy Connector on a separate domain joined Windows Server machine
    See [Get started with Application Proxy and install the connector](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-application-proxy-enable), for help setting up Azure Application Proxy Connector.

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
2. Launch the Azure AD Connect installation package and select "Use express settings"
3. Enter the information requested in the installation process and click "Install"

### Step 2 - Install Hybrid Cloud Print package on the Print Server

1. Install the Hybrid Cloud Print PowerShell modules
    -  Run the following commands from an elevated PowerShell command prompt
        - `find-module -Name "PublishCloudPrinter"` to confirm that the machine can reach the PowerShell Gallery (PSGallery)
        - `install-module -Name "PublishCloudPrinter"`

    > NOTE: You may see a messaging stating that 'PSGallery' is an untrusted repository.  Enter 'y' to continue with the installation.

2. Install the Hybrid Cloud Print solution
    - In the same elevated PowerShell command prompt, change directory to `C:\Program Files\WindowsPowerShell\Modules\PublishCloudPrinter\1.0.0.0`
    - Run <br>
        `CloudPrintDeploy.ps1 -AzureTenant <Domain name used by Azure AD Connect> -AzureTenantGuid <Azure AD Directory ID>`
3.  Configure the 2 IIS endpoints to support SSL
    -   The SSL certificate can be a self-signed cert or one issued from some trusted Certificate Authority (CA)
    -  If using self-signed cert, make sure the cert is imported to the client machine(s)
4.  Install SQLite package
    - Open an elevated PowerShell command prompt
    - Run the following command to download System.Data.SQLite nuget packages <br>
        `Register-PackageSource -Name nuget.org -ProviderName NuGet -Location https://www.nuget.org/api/v2/ -Trusted -Force`
    - Run the following command to install the packages<br>
    `Install-Package system.data.sqlite [-requiredversion x.x.x.x] -providername nuget`

    > NOTE: It is recommended to download and install the latest version by leaving out the "-requiredversion" option.

5.  Copy the SQLite dlls to the MopriaCloudService Webapp \<bin\> folder (**C:\\inetpub\\mcs\\bin**): <br>
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

6.  Update the `c:\inetpub\mcs\web.config` file to include the SQLite version x.x.x.x in the following \<runtime\>/\<assemblyBinding\> sections: <br>
    `<dependentAssembly>
        <assemblyIdentity name="System.Data.SQLite" culture="neutral" publicKeyToken="db937bc2d44ff139" />
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
    </dependentAssembly>`

7. Create the SQLite database:
    -  Download and install the SQLite Tools binaries from <https://www.sqlite.org/>
    -  Go to **c:\\inetpub\\mcs\\Database** directory
    -  Execute the following command to create the database in this directory:
        `sqlite3.exe MopriaDeviceDb.db ".read MopriaSQLiteDb.sql"`
    -  From File Explorer, open up the MopriaDeviceDb.db file properties to add Users/Groups which are allowed to publish to Mopria database in the Security tab
        - Recommend only adding the required Admin user group.
8. Register the 2 web app with Azure AD to support OAuth2 authentication
    -   Login as the Global Admin to the Azure AD tenant management portal
        1. Go "Applications" tab to add print endpoint
            -   Add application, select "Add an application my organization is developing"
            -   Provide an appropriate name and select "Web Application and/or Web API"
            -   Sign-on URL = "http://MicrosoftEnterpriseCloudPrint/CloudPrint"
            -   App ID URL = "http://MicrosoftEnterpriseCloudPrint/CloudPrint"
            -   Make sure the "Windows Azure Active Directory" delegated permission setting is set to "Sign in and read user profile".
        2.  Repeat for the discovery endpoint
            -   Sign-on URL = "http://MopriaDiscoveryService/CloudPrint"
            -   App ID URL = "http://MopriaDiscoveryService/CloudPrint"
            -   Make sure the "Windows Azure Active Directory" delegated permission setting is set to "Sign in and read user profile".
        3.  Repeat for the native client application
            -   When providing the app name, make sure you select "Native Client Application" as the "Type"
            -   Redirect URI = "https://\<services-machine-endpoint\>/RedirectUrl"
        4.  Go into the Native Client App "All settings"
            -   Copy the "Application ID" value to be used for later setup steps
            -   Select to "Required permissions"
                1.  Click "Add application"
                2.  Search for the print endpoint and the discovery endpoint by the name you defined when creating the app endpoint
                3.  Add the 2 endpoints
                4.  Make sure the "Delegated Permissions:" option for each app endpoint is enabled.
                5.  For the "Windows Azure Active Directory", set the "Delegated Permissions:" option to "Sign in and read user profile".
                6.  Make sure you click the "Save" button at the bottom
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
    - Go to the **Applications** tab
    - Click **Add**
    - Select **Publish an application that will be accessible from outside your network** and fill in the fields
        - Name: Any name you wish
        - Internal URL: This is the internal URL to the Mopria Discovery Cloud Service which your WAP machine can access
        - Preauthentication Method: Azure Active Directory
        - Internal Authentication Method: Integrated Windows Authentication
        - Internal Application SPN: set to the SPN you specified in 3, above

    >   Note: If you don’t find all the settings above, add the proxy with the settings available and then select the application proxy you just created and go to the "Configure" tab and add all the above information.

5. Repeat 4, above, for the Enterprise Cloud Print Service and provide the Internal URL to your Enterprise Cloud Print Service
6. Go to the "Application Proxy -> Configure" tab to configure the external URL of the Mopria Discovery Cloud Service endpoint and the Enterprise Cloud Print Service endpoint
7. Go back to the Azure AD tenant management portal and go into the Native Client App settings
    - Select **Required permissions**
        - Add the 2 new proxy applications you just created
        - Grant Delegated Permissions for these 2 applications

    >   Note: The https://&lt;services-machine-endpoint&gt;/mcs URL mentioned below should be the External URL you setup for your Mopria Cloud Service and/or Enterprise Cloud Print Service.

8. Enable Windows Authentication in IIS for the Mopria Cloud Service and Enterprise Cloud Print Service machine(s)
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
    - AzureTenantGuid = Directory ID of your Azure AD tenant
    - AzureNativeWebAppClientId = "Client ID" value of the Native Web App that you registered in Azure AD management portal
    - MopriaCloudServiceEndPoint = Internet URL of the Mopria Discovery Service Azure Application Proxy created in sequence 3.6 (must be exactly the same including the trailing /)
    - MopriaDiscoveryResourceId = Internet URL of the Mopria Discovery Service Azure Application Proxy created in sequence 3.6 (must be exactly the same including the trailing /)
    - CloudPrintResourceId = Internet URL of the Enterprise Cloud Print Service Azure Application Proxy created in sequence 3.6 (must be exactly the same including the trailing /)

>   Note: If the Enterprise Cloud Print policy group is not available, but the MDM provider supports OMA-URI settings, then you can set the same policies.  Please refer to this <a href="https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-enterprisecloudprint#enterprisecloudprint-cloudprintoauthauthority">article</a> for additional info.

- OMA-URI
    - `CloudPrintOAuthAuthority = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintOAuthAuthority`
        - Value = `https://login.microsoftonline.com/`\<Azure AD Directory ID\>
    - `CloudPrintOAuthClientId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintOAuthClientId`
        - Value = \<Azure AD Native App's Application ID\>
    - `CloudPrintResourceId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrintResourceId`
        - Value = Internet URL of the Enterprise Cloud Print Service as specified in sequence 3.6
    - `CloudPrinterDiscoveryEndPoint = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/CloudPrinterDiscoveryEndPoint`
        - Value = Internet URL of the Mopria Discovery Service as specified in sequence 3.6
    - `MopriaDiscoveryResourceId = ./Vendor/MSFT/Policy/Config/EnterpriseCloudPrint/MopriaDiscoveryResourceId`
        - Value = Internet URL of the Mopria Discovery Service as specified in sequence 3.6
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

        > NOTE: You can enter all of the required parameter values in the command line as well.<br>
**Publish-CloudPrinter** PowerShell command syntax: <br>
Publish-CloudPrinter -Printer \<string\> -Manufacturer \<string\> -Model \<string\> -OrgLocation \<string\> -Sddl \<string\> -DiscoveryEndpoint \<string\> -PrintServerEndpoint \<string\> -AzureClientId \<string\> -AzureTenantGuid \<string\> [-DiscoveryResourceId \<string\>] <br>
Sample command:
`publish-cloudprinter -Printer EcpPrintTest -Manufacturer Microsoft -Model FilePrinterEcp -OrgLocation '{"attrs": [{"category":"country", "vs":"USA", "depth":0}, {"category":"organization", "vs":"MyCompany", "depth":1}, {"category":"site", "vs":"MyCity, State", "depth":2}, {"category":"building", "vs":"Building 1", "depth":3}, {"category":"floor\_number", "vn":1, "depth":4}, {"category":"room\_name", "vs":"1111", "depth":5}]}' -Sddl "O:BAG:DUD:(A;OICI;FA;;;WD)" -DiscoveryEndpoint https://<services-machine-endpoint>/mcs -PrintServerEndpoint https://<services-machine-endpoint>/ecp -AzureClientId <Native Web App ID> -AzureTenantGuid <Azure AD Directory ID>`


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