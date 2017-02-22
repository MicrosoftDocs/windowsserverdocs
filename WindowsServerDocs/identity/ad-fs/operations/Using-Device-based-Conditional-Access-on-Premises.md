---
ms.assetid: 77d40715-f09a-4fac-b584-7a40beea1170
title: Using Device-based Conditional Access on-Premises
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: identity-adfs
ms.tgt_pltfrm: na
ms.topic: article
author: billmath
ms.author: billmath
---
# Using Device-based Conditional Access on-Premises

>Applies To: Windows Server 2016
>
This document describes conditional access policies based on devices in a hybrid scenario where the on-premises directories are connected to Azure AD using Azure AD Connect.     
  
## AD FS and Hybrid conditional access  
  
AD FS provides the on premises component of conditional access policies in a hybrid scenario.  When you register devices with Azure AD for conditional access to cloud resources, the Azure AD Connect device write back capability makes device registration information available on premises for AD FS policies to consume and enforce.  This way, you have a consistent approach to access control policies for both on premises and cloud resources.  
  
![conditional access](media/Using-Device-based-Conditional-Access-on-Premises/ADFS_ITPRO4.png)  
  
### Types of registered devices  
There are three kinds of registered devices, all of which are represented as Device objects in Azure AD and can be used for conditional access with AD FS on premises as well.  
  
  
  
 |Add Work or School Account  |Azure AD Join  |Windows 10 Domian Join    
---------|---------|---------|---------  
Description    |  Users add their work or school account to their BYOD device interactively.  **Note:** Add Work or School Account is the replacement for Workplace Join in Windows 8/8.1       | Users join their Windows 10 work device to Azure AD.|Windows 10 domain joined devices automatically register with Azure AD.           
How users log in to the device     |  No login to Windows as the work or school account.  Login using a Microsoft account.       |   Login to Windows as the (work or school) account that registered the device.      |     Login using AD account.      
How devices are managed    |      MDM Policies (with additional Intune enrollment)   | MDM Policies (with additional Intune enrollment)        |   Group Policy, System Center Configuration Manager (SCCM)        
 W10 Settings location    | Settings – Accounts – Your account – Add a work or school account        | Settings – System – About – Join Azure AD       |   Settings – System – About – Join a domain        
Also available for iOS and Android Devices?   |    Yes     |       No  |   No        
  
For more information on the different ways to register devices, see also:  
* [Using Windows 10 devices in your workplace](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-windows10-devices/)  
* [Setting up Windows 10 devices for work](https://jairocadena.com/2016/01/18/setting-up-windows-10-devices-for-work-domain-join-azure-ad-join-and-add-work-or-school-account/)  
[Join Windows 10 Mobile to Azure Active Directory](https://technet.microsoft.com/itpro/windows/manage/join-windows-10-mobile-to-azure-active-directory)  
  
### How Windows 10 User and Device Sign on is different from previous versions  
For Windows 10 and AD FS 2016 there are some new aspects of device registration and authentication you should know about (especially if you are very familiar with device registration and “workplace join” in previous releases).  
  
First, in Windows 10 and AD FS in Windows Server 2016, device registration and authentication is no longer based solely on an X509 user certificate.  There is a new and more robust protocol that provides better security and a more seamless user experience.  The key differences are that, for Windows 10 Domain Join and Azure AD Join, there is an X509 computer certificate and a new credential called a PRT.  You can read all about it [here](https://jairocadena.com/2016/01/18/how-domain-join-is-different-in-windows-10-with-azure-ad/) and [here](https://jairocadena.com/2016/02/01/azure-ad-join-what-happens-behind-the-scenes/).  
  
Second, Windows 10 and AD FS 2016 support user authentication using Microsoft Passport for Work, which you can read about [here](https://jairocadena.com/2016/03/09/azure-ad-and-microsoft-passport-for-work-in-windows-10/) and [here](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-passport-deployment/).  
  
AD FS 2016 provides seamless device and user SSO based on both PRT and Passport credentials.  Using the steps in this document, you can enable these capabilities and see them work.  
  
### Device Access Control Policies  
Devices can be used in simple AD FS access control rules such as:  
* allow access only from a registered device   
* require multi factor authentication when a device is not registered  
  
These rules can then be combined with other factors such as network access location and multi factor authentication, creating rich conditional access policies such as:  
* require multi factor authentication for unregistered devices accessing from outside the corporate network, except for members of a particular group or groups  
  
With AD FS 2016, these policies can be configured specifically to require a particular device trust level as well: either **authenticated**, **managed**, or **compliant**.  
  
For more information on configuring AD FS access control policies, see [Access control policies in AD FS](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md).  
  
#### Authenticated devices  
Authenticated devices are registered devices that are not enrolled in MDM (Intune and 3rd party MDMs for Windows 10, Intune only for iOS and Android).   
  
Authenticated devices will have the **isManaged** AD FS claim with value **FALSE**. (Whereas devices that are not registered at all will lack this claim.)  Authenticated devices (and all registered devices) will have the isKnown AD FS claim with value **TRUE**.  
  
#### Managed Devices:   
  
Managed devices are registered devices that are enrolled with MDM.  
  
Managed devices will have the isManaged AD FS claim with value **TRUE**.  
  
#### Devices compliant (with MDM or Group Policies)  
Compliant devices are registered devices that are not only enrolled with MDM but compliant with the MDM policies. (Compliance information originates with the MDM and is written to Azure AD.)  
  
Compliant devices will have the **isCompliant** AD FS claim with value **TRUE**.    
  
For complete list of AD FS 2016 device and conditional access claims, see Reference.  
  
## Configuring On Premises Conditional Access using registered devices (TP5)  
  
### Infrastructure pre-requisites  
  
1. An Azure AD subscription with Azure AD Premium (to enable device write back for on premises conditional access - a free trial is fine)  
2.  Intune subscription (only required for MDM integration for device compliance scenarios – a free trial is fine)  
3.  Azure AD Connect (November 2015 QFE or later)  
4.  Windows Server 2016 build 10586 or newer for AD FS  
5.  Windows Server 2016 Active Directory schema (schema level 85 or higher) (required for msDS-IsCompliant attribute for device compliance scenarios)  
6.  Windows Server 2016 domain controller (only required for Microsoft Passport for Work)  
7.  Windows 10 client build 10586 or newer, joined to the above domain (required for Windows 10 Domain Join and Microsoft Passport for Work scenarios only)  
8.  Azure AD user account with Azure AD Premium license assigned (for registering the device)  
  
### Enable Azure AD Device Registration  
To configure this scenario, you must configure the device registration capability in Azure AD.  
To do this, follow the steps under [Setting up Azure AD Join in your organization](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-setup/)  
  
### Setup AD FS  
1. Create the a [new AD FS 2016 farm](https://technet.microsoft.com/library/dn486775.aspx).   
2.  Or [migrate](../../ad-fs/deployment/Upgrading-to-AD-FS-in-Windows-Server-2016.md) a farm to AD FS 2016 from AD FS 2012 R2  
4. Deploy [Azure AD Connect](https://azure.microsoft.com/documentation/articles/active-directory-aadconnectfed-whatis/) using the Custom path to connect AD FS to Azure AD.  
  
### Configure Device Write Back and Device Authentication  
Note: If you ran Azure AD Connect using Express Settings, the correct AD objects have been created for you.  However, in most AD FS scenarios, Azure AD Connect was run with Custom Settings to configure AD FS, so the below steps are necessary.  
  
#### Create AD objects for AD FS Device Authentication  
If your AD FS farm is not already configured for Device Authentication (you can see this in the AD FS Management console under Service -> Device Registration), use the following steps to create the correct AD DS objects and configuration.  
  
Note: The below commands require Active Directory administration tools, so if your federation server is not also a domain controller, first install the tools using step 1 below.  Otherwise you can skip step 1.  
  
1.  Run the Add Roles & Features wizard and select feature Remote Server Administration tools -> Role Administration Tools -> AD DS and AD LDS Tools -> Choose both the Active Directory module for Windows PowerShell and the AD DS Tools.  
2.  On your AD FS primary server, ensure you are logged in as AD DS user with Enterprise Admin (EA) privileges and open an elevated powershell prompt.  Then, execute the following PowerShell commands:  
    1. Import-module activedirectory  
    2. PS C:\ &gt; Initialize-ADDeviceRegistration –ServiceAccountName “&lt;AD FS service account name&gt;”  
    3. Note: If your AD FS service is configured to use a GMSA account, enter the account name in the format “domain\accountname$”  
    4. The above PSH creates the following objects  
        1. RegisteredDevices container under the AD domain partition  
        2. Device Registration Service container and object under Configuration --> Services --> Device Registration Configuration  
        3. Device Registration Service DKM container and object under Configuration --> Services --> Device Registration Configuration  
          
####        Create Service Connection Point (SCP) in AD  
If you plan to use Windows 10 domain join (with automatic registration to Azure AD) as described here, execute the following commands to create a service connection point in AD DS  
1.  PS C:>Import-Module -Name "C:\Program Files\Microsoft Azure Active Directory Connect\AdPrep\AdSyncPrep.psm1"  
{if necessary, copy the AdSyncPrep.psm1 file from your Azure AD Connect server}  
2.  PS C:>$aadAdminCred = Get-Credential  
{provide your Azure AD global administrator credentials, such as adminuser@contoso.onmicrosoft.com}  
3.  PS C:>Initialize-ADSyncDomainJoinedComputerSync –AdConnectorAccount [AD connector account name] -AzureADCredentials $aadAdminCred  
a.  Where the [AD connector account name] is the name of the account you configured in Azure AD Connect when adding your on premises AD DS directory  
4.  The above commands enable Windows 10 clients to find the correct Azure AD domain to join by creating the serviceConnectionpoint object in AD DS.  
  
#### Prepare AD for Device Write Back   
To ensure AD DS objects and containers are in the correct state for write back of devices from Azure AD, do the following.  
1.  PS C:>Initialize-ADSyncDeviceWriteBack –DomainName &lt;AD DS domain name&gt; –AdConnectorAccount [AD connector account name]  
    1. Where the [AD connector account name] is the name of the account you configured in Azure AD Connect when adding your on premises AD DS directory in domain\accountname format  
    2. The above command creates the following objects for device write back to AD DS, if they do not exist already, and allows access to the specified AD connector account name  
        1. RegisteredDevices container in the AD domain partition  
        2. Device Registration Service container and object under Configuration --> Services --> Device Registration Configuration  
  
#### Enable Device Write Back in Azure AD Connect  
If you have not done so before, enable device write back in Azure AD Connect by running the wizard a second time and selecting “Customize Synchronization Options”, then checking the box for device write back and selecting the forest in which you have run the above cmdlets  
  
#### Configure Device Authentication in AD FS  
Using an elevated PowerShell command window, configure AD FS policy by executing the following command  
PS C:>Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationEnabled $true  
  
#### Check your configuration  
For your reference, below is a comprehensive list of the AD DS devices, containers and permissions required for device write-back and authentication to work  
1.  object of type ms-DS-DeviceContainer at CN=RegisteredDevices,DC=&lt;domain&gt;  
a.  read access to the AD FS service account   
b.  read/write access to the Azure AD Connect sync AD connector account   
2.  Container CN=Device Registration Configuration,CN=Services,CN=Configuration,DC=&lt;domain&gt;  
3.  Container Device Registration Service DKM under the above container  
4.  object of type serviceConnectionpoint at CN=&lt;guid&gt;, CN=Device Registration Configuration,CN=Services,CN=Configuration,DC=&lt;domain&gt;  
a.  read/write access to the specified AD connector account name on the new object  
5.  object of type msDS-DeviceRegistrationServiceContainer at CN=Device Registration Services,CN=Device Registration Configuration,CN=Services,CN=Configuration,DC=&ltdomain>  
6.  object of type msDS-DeviceRegistrationService in the above container  
  
#### See it work  
To evaluate the new claims and policies, first register a device.  For example, you can Azure AD Join a Windows 10 computer using the Settings app under System -> About, or you can setup Windows 10 domain join with automatic device registration following the additional steps [here](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-devices-group-policy/).  For information on joining Windows 10 mobile devices, see the document [here](https://technet.microsoft.com/itpro/windows/manage/join-windows-10-mobile-to-azure-active-directory).  
  
For easiest evaluation, sign on to AD FS using a test application that shows a list of claims. You will be able to see new claims including isManaged, isCompliant, and trusttype.  If you enable Microsoft Passport for work, you will also see the prt claim.  
  
For a complete list of AD FS 2016 conditional access, devices, and Windows 10, see reference.  
  
### Configure Additional Scenarios  
#### Automatic Registration for Windows 10 Domain Joined computers  
To enable automatic device registration for Windows 10 domain joined computers, follow steps 1 and 2 [here](https://azure.microsoft.com/documentation/articles/active-directory-azureadjoin-devices-group-policy/).   
This will help you achieve the following:  
  
1. Ensure your service connection point in AD DS exists and has the proper permissions (we created this object above, but it does not hurt to double check).  
2. Ensure AD FS is configured properly  
3. Ensure your AD FS system has the correct endpoints enabled and claim rules configured   
4. Configure the group policy settings required for automatic device registration of domain joined computers   
  
#### Microsoft Passport for Work   
For information on enabling Windows 10 with Microsoft Passport for Work, see [Enable Microsoft Passport for Work in your organization.](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-passport-deployment/)  
  
#### Automatic MDM enrollment   
To enable automatic MDM enrollment of registered devices so that you can use the isCompliant claim in your access control policy, follow the steps [here.](https://blogs.technet.microsoft.com/ad/2015/08/14/windows-10-azure-ad-and-microsoft-intune-automatic-mdm-enrollment-powered-by-the-cloud/)  
  
### Troubleshooting  
1.  if you get an error on Initialize-ADDeviceRegistration that complains about an object already existing in the wrong state, such as “The drs service object has been found without all the required attributes”, you may have executed Azure AD Connect powershell commands previously and have a partial configuration in AD DS.  Try deleting manually the objects under CN=Device Registration Configuration,CN=Services,CN=Configuration,DC=&lt;domain&gt; and trying again.  
2.  For Windows 10 domain joined clients  
    1. To verify that device authentication is working, sign on to the domain joined client as a test user account. To trigger provisioning quickly, lock and unlock the desktop at least one time.   
    2. Instructions to check for stk key credential link on AD DS object (does sync still have to run twice?)  
3.  If you get an error upon trying to register a Windows computer that the device was already enrolled, but you are unable or have already unenrolled the device, you may have a fragment of device enrollment configuration in the registry.  To investigate and remove this, use the following steps:  
    1. On the Windows computer, open Regedit and navigate to HKLM\Software\Microsoft\Enrollments   
    2. Under this key, there will be many subkeys in the GUID form.  Navigate to the subkey which has ~17 values in it and has "EnrollmentType" of  “6” [MDM joined] or “13” (Azure AD joined)  
    3. Modify EnrollmentType to 0  
    4. Try the device enrollment or registration again  
  
### Related Articles  
* [Securing access to Office 365 and other apps connected to Azure Active Directory](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access/)  
* [Conditional access device policies for Office 365 services](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access-device-policies/)  
* [Setting up on-premises conditional access using Azure Active Directory Device Registration](https://azure.microsoft.com/en-us/documentation/articles/active-directory-conditional-access-on-premises-setup/)  
* [Connect domain-joined devices to Azure AD for Windows 10 experiences](https://azure.microsoft.com/en-us/documentation/articles/active-directory-azureadjoin-devices-group-policy/)  
  
## Reference  
#### Complete list of new AD FS 2016 and device claims  
  
* http://schemas.microsoft.com/ws/2014/01/identity/claims/anchorclaimtype  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/implicitupn  
* http://schemas.microsoft.com/2014/03/psso  
* http://schemas.microsoft.com/2015/09/prt  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn  
* http://schemas.microsoft.com/ws/2008/06/identity/claims/primarygroupsid  
* http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid  
* http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name  
* http://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname  
* http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/registrationid  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/displayname  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/identifier  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/ostype  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/osversion  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/ismanaged  
* http://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser  
* http://schemas.microsoft.com/2014/02/devicecontext/claims/isknown  
* http://schemas.microsoft.com/2014/02/deviceusagetime  
* http://schemas.microsoft.com/2014/09/devicecontext/claims/iscompliant  
* http://schemas.microsoft.com/2014/09/devicecontext/claims/trusttype  
* http://schemas.microsoft.com/claims/authnmethodsreferences  
* http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-user-agent  
* http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-endpoint-absolute-path  
* http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork  
* http://schemas.microsoft.com/2012/01/requestcontext/claims/client-request-id  
* http://schemas.microsoft.com/2012/01/requestcontext/claims/relyingpartytrustid  
* http://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-ip  
* http://schemas.microsoft.com/2014/09/requestcontext/claims/userip  
* http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod  
  


