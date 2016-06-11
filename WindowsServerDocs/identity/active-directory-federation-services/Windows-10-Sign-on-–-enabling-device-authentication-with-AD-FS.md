---
title: Windows 10 Sign on – enabling device authentication with AD FS
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: ad-health-connect
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6af35f7-a4ec-40f6-a7fe-a42f7e6855c6
---
# Windows 10 Sign on – enabling device authentication with AD FS

## Description
Domain Join in Windows 10 provides the following benefits after being connected to Azure AD:

-   SSO \(single\-sign\-on\) to Azure AD resources from anywhere.

-   Strong authentication and convenient sign\-in with Microsoft Passport and Windows Hello.

Conditional access and MDM integration with Azure AD provides the additional benefits:

-   Ability to restrict access to domain joined computers and\/or devices compliant with organizational device policies.

AD FS in Windows Server 2016 provides the ability to extend the above benefits and device policies to on premises resources protected by AD FS.

## Pre\-requisites
The following are a list of pre\-requisites that are required prior to completing this document. This document assumes that AD FS has been installed and an AD FS farm has been created.

-   An Azure AD subscription with Azure AD Premium \(to enable device write back for on premises conditional access \- a free trial is fine\)

-   Intune subscription \(for MDM integration and device compliance scenarios\)

-   Azure AD Connect November 2015 QFE or later.

-   Windows Server 2016 build 10586  or newer for AD FS

-   Windows Server 2016 domain controller
    with Windows Server 2016 schema.

-   Windows 10 client build 10586 or newer, joined to the above domain.

## Setup Active Directory and AD FS
To setup Active Directory and AD FS use the following procedure:

#### To setup AD and AD FS

1.  Create a new AD FS farm using Windows Server 2016 Preview

    -   Ensure the domain is running  Windows Server 2016 Preview

    -   Ensure the Active Directory schema version is at least 85

    -   Create the AD FS farm

        > [!NOTE]
        > You will need to set\-adfsproperties –enableidpinitiatedsignonpage $true to enable the sign on page.   This is disabled by default.

        -   Setup  a new AD FS farm using Windows Server 2016 Preview

        -   Mixed farm migration of  an AD FS farm using Windows Server 2012 R2 to 2016

2.  Connect AD FS to Azure AD

    -   [Install](https://azure.microsoft.com/en-us/documentation/articles/active-directory-aadconnect/)Azure AD Connect, November 2015 release

        -   Use the Custom path in the wizard so that you can use the federation option for sign on

3.  Prepare AD

    -   On your AD FS primary server, ensure you are logged in as AD DS user with Enterprise Admin \(EA\) privileges and open an elevated powershell prompt

    -   The below commands require Active Directory administration tools, so if your federation server is not also a domain controller, first install the tools using the following steps:

        -   Run the Add Roles & Features wizard and select feature Remote Server Administration tools \-> Role Administration Tools \-> AD DS and AD LDS Tools \-> Choose both the Active Directory module for Windows PowerShell and the AD DS Tools.

        -   From the same elevated PowerShell command prompt, run Import\-module activedirectory

    -   Execute the following AD FS PowerShell commands:

        ```
        PS C:\>Initialize-ADDeviceRegistration –ServiceAccountName “<AD FS service account name>”
        ```

        > [!NOTE]
        > If your AD FS service is configured to use a GMSA account, enter the account name in the format “domain\\accountname$”

        ```
        PS C:\>Enable-AdfsDeviceRegistration

        PS C:\>Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationEnabled $true
        ```

    -   Execute the following commands to create a service connection point in AD DS \(if you have installed Azure AD Connect on a separate server from your AD FS server, copy the AdSyncPrep.psm1 file from your Azure AD Connect server to your federation server\):

        ```
        PS C:\>Import-Module -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AdPrep\AdSyncPrep.psm1"
        PS C:\>$aadAdminCred = Get-Credential 
        {provide your Azure AD global administrator credentials, such as adminuser@contoso.com}
        Initialize-ADSyncDomainJoinedComputerSync –AdConnectorAccount [AD connector account name] -AzureADCredentials $aadAdminCred
        ```

        -   Where the \[AD connector account name\] is the name of the account you configured in Azure AD Connect when adding your on premises AD DS directory.

        -   The above commands achieve the following in AD DS:

            -   Create a new object of type serviceConnectionpoint at CN\=<guid>, CN\=Device Registration Configuration,CN\=Services,CN\=Configuration,DC\=<domain>

            -   Allow read\/write access to the specified AD connector account name on the new object

    -   Execute the following command to create the container for device write back to AD DS

        ```
        PS C:\>Initialize-ADSyncDeviceWriteBack –DomainName <AD DS domain name> –AdConnectorAccount “domain\ADconnectoraccountname”
        ```

    -   The above command achieves the following in AD DS:

        -   Create a new object of type ms\-DS\-DeviceContainer at CN\=RegisteredDevices,DC\=<domain>

        -   Create a new object of type msDS\-DeviceRegistrationServiceContainer at CN\=Device Registration Services,CN\=Device Registration Configuration,CN\=Services,CN\=Configuration,DC\=<domain>

        -   Creates a new object of type msDS\-DeviceRegistrationService in the above container

        -   Allows access to the specified AD connector account name

4.  Enable device write back in Azure AD Connect

    -   If you have not done so before, enable device write back in Azure AD Connect by running the wizard a second time and selecting “Customize Synchronization Options”, then checking the box for device write back and selecting the forest in which you have run the above cmdlets

5.  Ensure AD FS is configured properly.

    -   a.	Ensure the following endpoints are enabled in AD FS

        -   adfs\/services\/trust\/13\/windowstransport

        -   adfs\/services\/trust\/2005 \/windowstransport

    -   If necessary, use the following powershell command to enable

        ```
        PS C:\>Enable-AdfsEndpoint -TargetAddressPath "/adfs/services/trust/13/windowstransport"
        ```

        ```
        PS C:\>Enable-AdfsEndpoint -TargetAddressPath "/adfs/services/trust/2005/windowstransport"
        ```

    -   Double check that Azure AD Connect has configured the following claim rules on the AD FS Relying Party trust for Microsoft Office 365 Identity Platform:

        ```
        $rule1 = '@RuleName = "Issue object GUID" 
                  c1:[Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "515$", Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"] &&
                  c2:[Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname", Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"] 
                  => issue(store = "Active Directory", types = ("http://schemas.microsoft.com/identity/claims/onpremobjectguid"), query = ";objectguid;{0}", param = c2.Value);'

        $rule2 = '@RuleName = "Issue account type for domain joined computers" 
                  c:[Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "515$", Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"] 
                  => issue(Type = "http://schemas.microsoft.com/ws/2012/01/accounttype", Value = "DJ");'

        $rule3 = '@RuleName = "Pass through primary SID" 
                  c1:[Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "515$", Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"] && 
                  c2:[Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid", Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"] 
                  => issue(claim = c2);'
        ```

## Configure Group Policy for device registration
Configure Automatic Device Registration via Group Policy in Active Directory: You can use an Active Directory Group Policy to configure your Windows 10 domain joined devices to automatically register with Azure AD. To do this please see the following step\-by\-step instructions:

#### To configure group policy for device registration

1.  Open Server Manager and navigate to **Tools** > **Group Policy Management.**

2.  From **Group Policy Management**, navigate to the domain node that corresponds to the domain in which you would like to enable Automatic Workplace Join.

3.  Right\-click **Group Policy Objects** and select New. Give your Group Policy object a name, for example, Automatic Device Registration. Click OK.

4.  Right\-click on your new Group Policy object and then select **Edit.**

5.  Navigate to **Computer Configuration > Policies > Administrative Templates > Windows Components > Workplace Join.**

    > [!NOTE]
    > The Group Policy template has been renamed in Windows 10.
    > 
    > If you are running the Group Policy tool from a Windows 10 computer, the policy will appear as: 
    > **Register domain joined computers as devices**
    > 
    > The policy will be located under the following location:
    > **Computer Configuration\/Policies\/Administrative Templates\/Windows Components\/Device  Registration**.

6.  Right\-click Automatically workplace join client computers and then select Edit.

7.  Select the Enabled radio button and then click Apply. Click OK.

8.  You may now link the Group Policy object to a location of your choice. For example:

    -   A specific Organizational Unit \(OU\) in AD where Windows 10 domain\-joined computers will be located.

    -   A specific security group containing Windows 10 domain\-joined computers that will be auto\-registered with Azure AD.

## Configure Windows Passport
For information on configuring Windows Passport see  [Enable Microsoft Passport for work in the organization.](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-passport-deployment/)

## Check your configuration
To verify that device authentication is working, sign on to the domain joined client as a test user account.  To trigger provisioning quickly, lock and unlock the desktop at least one time.  For easiest evaluation, sign on to AD FS using a test application that shows a list of claims.  You will be able to see new claims including isManaged, isCompliant, trusttype and prt.

For your reference, below is a comprehensive list of the AD DS devices, containers and permissions required for device write\-back and authentication to work

-   object of type ms\-DS\-DeviceContainer at CN\=RegisteredDevices,DC\=<domain>

    -   read access to the AD FS service account

    -   read\/write access to the Azure AD Connect sync AD connector account

-   Container CN\=Device Registration Configuration,CN\=Services,CN\=Configuration,DC\=<domain>

-   Container Device Registration Service DKM under the above container

-   object of type serviceConnectionpoint at CN\=<guid>, CN\=Device Registration Configuration,CN\=Services,CN\=Configuration,DC\=<domain>

    -   read\/write access to the specified AD connector account name on the new object

-   object of type msDS\-DeviceRegistrationServiceContainer at CN\=Device Registration Services,CN\=Device Registration Configuration,CN\=Services,CN\=Configuration,DC\=<domain>

-   object of type msDS\-DeviceRegistrationService in the above container


