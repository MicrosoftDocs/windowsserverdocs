---
title: Customizing the AD FS Sign-in Pages
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e03555a7-b08c-40c6-9e7a-6f1bace7d66f
author: billmath
---
# Customizing the AD FS Sign-in Pages
  
## Overview  
With this release of [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], several changes have been made to improve the experience for both administrators and users. Numerous capabilities to enable administrators to customize the sign\-in experience have been added to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. The new design provides [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlets for administrators to customize standard elements for common scenarios. In addition, all of the customizations are stored in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] configuration store that is commonly shared across the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] service. As a result, you only have to do this task one time for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] service and do not have to repeat this task for every node in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] farm. The following is a list of improvements that have been added to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]:  
  
-   **No more dependence on IIS** \- [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is now built directly on top of HTTP.SYS and does not require the installation of Internet Information Services \(IIS\).  
  
-   **Built\-in webpage customization** – The appearance and behavior of webpages can be customized to provide a tailored user experience. These customizations include the following:  
  
    -   **Logo and illustration** \- The logo and illustration of pages can be easily updated and changed with a simple [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlet. It is no longer necessary to modify any of the webpage code in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
    -   **Customization of standard Links** \- Most organizations have some notion of standard links for IT support, home page, and a privacy link. These elements can be configured and displayed on [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] webpages.  
  
    -   **Customization of web themes** \- At the heart of the customizations is the notion of a web theme. This feature enables the administrator to customize the entire appearance and behavior of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] pages. Each web theme supports all of the elements that were described previously.  
  
-   **Customization for error pages** \- When something goes wrong, an error page is displayed to the end user. A few enhancements have been made to provide a better user experience. For example, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] now support sending error details to an IT help desk if required by using one click.  
  
    -   **Customized "Access denied" messages** – End users often get confused when they get a generic "Access denied" message. [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] now supports customized "Access denied" messages to enable organizations to provide customized instructions for its end users. This customization supports HTML content and can be set globally or on the basis of a relying party trust.  
  
-   **Responsive design to cater to different form factors** \- [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] now supports automatic adjustment of size and positioning of elements through cascading style sheets \(CSS\). For example, in the smartphone scenario where the form factor is limited in width, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in pages would automatically adjust and also hide the illustration.  
  
-   **Improved user experience for home realm discovery** –[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] now supports home realm discovery by looking up organizational account suffixes that a claims provider supports or by looking up the claims provider list that is configured for a relying party trust. [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] also supports by\-passing home realm discovery for intranet access.  
  
-   **Support for updating the password** – Users can change their password without having to connect to the corporate network.  
  
## Customizing the AD FS  sign\-in experience  
The following topics describe how to customize the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in experience.  
  
### General sign\-in page  
Out of the box, you notice the appearance and behavior of the sign\-in experience to be similar to the appearance and behavior that is offered by Windows Azure Active Directory. The name of the organization, which is obtained during setup, is displayed by default. This page, as most of the other pages, can be customized and tailored to your organization’s requirements. The customization includes changing the logo, the illustration, adding additional descriptions, and links. The following illustrations show an example of the default sign\-in page and a customized sign\-in page. Use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlets to modify and customize your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in page.  
  
![](../Image/ADFS_Blue_Custom1.png)  
  
The following is an example of a customized sign\-in page.  
  
![](../Image/ADFS_Blue_Custom2.png)  
  
#### Change company name  
To change the name of the company that is displayed on the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlet and syntax. This value is set by default by using the value from the Federation Service display name that you entered during setup.  
  
```  
Set-AdfsGlobalWebContent –CompanyName "Contoso Corp"  
```  
  
> [!NOTE]  
> You can also use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Integrated Scripting Environment \(ISE\) to change the company name. By using the [!INCLUDE[wps_2](../Token/wps_2_md.md)] ISE, you can display content in a Unicode\-compliant environment. For additional information, see [Introducing the Windows PowerShell ISE](http://technet.microsoft.com/library/dd315244.aspx).  
  
#### Change company logo  
To change the logo of the company that is displayed on the sign\-in page, use the following PowerShell [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
> [!IMPORTANT]  
> We recommend the dimensions for the logo to be 260x35 @ 96 dpi with a file size of no greater than 10 KB.  
  
```  
Set-AdfsWebTheme -TargetName default -Logo @{path="c:\Contoso\logo.png"}  
```  
  
> [!NOTE]  
> The `TargetName` parameter is required. The default theme that is released with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is named *default*.  
  
#### Change Illustration  
To change the illustration, the graphic on the left, which is displayed on the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlet and syntax.  
  
> [!IMPORTANT]  
> We recommend the dimensions for the illustration to be 1420x1080 pixels @ 96 DPI with a file size of no greater than 200 KB.  
  
```  
Set-AdfsWebTheme -TargetName default -Illustration @{path="c:\Contoso\illustration.png"}  
  
```  
  
#### Add sign\-in page description  
To add a sign\-in page description to the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -SignInPageDescriptionText "<p>Sign-in to Contoso requires device registration. Click <A href='http://fs1.contoso.com/deviceregistration/'>here</A> for more information.</p>"  
  
```  
  
> [!IMPORTANT]  
> The string for the `SignInPageDescriptionText` parameter supports both pure HTML with the tags and without. Therefore, you can also run the following cmdlet without using the <p> tag.  `Set-AdfsGlobalWebContent -SignInPageDescriptionText "Sign-in to Contoso requires device registration. Click <A href='http://fs1.contoso.com/deviceregistration/'>here</A> for more information."`  
>   
> After the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support. All customized content takes a locale parameter. When you configure localized content, it should be configured with a country\-less locale first, for example, "en", before you configure country and region\-specific locale such as "en\-us".  
  
#### Add Help Desk Link  
To add the help desk link that is displayed on the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] PowerShell cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -HelpDeskLink https://fs1.contoso.com/help/ -HelpDeskLinkText Help  
```  
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Help*. The advantage of using the default is that they are localized to all client locales. After the page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.  
  
#### Add Home Link  
To add the home link that is displayed on the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -HomeLink https://fs1.contoso.com/home/ -HomeLinkText Home  
```  
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Home*. The advantage of using the default is that they are localized to all client locales. after the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.  
  
#### Add Privacy Link  
To add the privacy link that is displayed on the sign\-in page, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -PrivacyLink https://fs1.contoso.com/privacy/ -PrivacyLinkText Privacy  
```  
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Privacy*. The advantage of using the default is that the pages are localized to all client locales. After the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support. All customized content takes a locale parameter. When you configure localized content, you should configure it with a country\-less locale first, for example, "en", before you configure country and region\-specific locale, such as "en\-us".  
  
### Custom Web Themes  
The theme that is shipped out\-of\-the\-box is called Default. You can export the default theme and use it so that you can start quickly. You can customize the appearance and behavior, which includes the layout by modifying the .css file, import and apply this new theme, and then you can use the customized appearance and behavior. Using the .css file also makes it easier to work with your web designers.  
  
The following cmdlet creates a custom web theme, which duplicates the default web theme.  
  
```  
New-AdfsWebTheme –Name custom –SourceName default  
```  
  
You can modify the .css file and configure the new web theme by using the new .css file. To export a web theme, use the following cmdlet.  
  
```  
Export-AdfsWebTheme –Name default –DirectoryPath c:\theme  
```  
  
To apply the .css file to the new theme, use the following cmdlet.  
  
```  
Set-AdfsWebTheme –TargetName custom –StyleSheet @{path=”c:\NewTheme.css”}  
  
```  
  
The following cmdlet creates a custom web theme from a new style sheet.  
  
```  
New-AdfsWebTheme –Name custom –StyleSheet @{path=”c:\NewTheme.css”} –RTLStyleSheetPath c:\NewRtlTheme.css  
  
```  
  
To apply the custom web theme to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], use the following cmdlet.  
  
```  
Set-AdfsWebConfig -ActiveThemeName custom  
  
```  
  
To add JavaScript to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], use the following cmdlet.  
  
```  
Set-AdfsWebTheme -TargetName custom -AdditionalFileResource @{Uri=’ /adfs/portal/script/onload.js’;path="D:\inetpub\adfsassets\script\onload.js"}  
  
```  
  
### Custom Error Messages  
You can configure custom error messages that can be tailored to your organization. The following illustration shows a customized error page description and a generic error message. Use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets to customize your error messages.  
  
![](../Image/ADFS_Blue_Custom3.png)  
  
#### Customize the error page description  
To customize the error page description, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageDescriptionText "This is Contoso's error page description"  
```  
  
#### Customize a generic error message  
To customize the generic error message, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageGenericErrorMessage "This is a generic error message.  Contact Contoso IT for assistance."  
  
```  
  
#### Customize an authorization error message  
To customize the authorization error message, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageAuthorizationErrorMessage "You have received an Authorization error.  Contact Contoso IT for assistance."  
  
```  
  
#### Customize a device authentication error message  
To customize the device authentication error message, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageDeviceAuthenticationErrorMessage "Your device is not authorized.  Contact Contoso IT for assistance."  
  
```  
  
#### Customize a support email error message  
You can configure a support email address in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. If configured, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] automatically shows a link for end users to email the error details.  
  
To customize the support email error message, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageSupportEmail  "admin@contoso.com"  
  
```  
  
#### Customize a relying party authorization message  
You can configure a relying party authorization error message in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
To customize the relying party error message, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsRelyingPartyWebContent -Name fedpassive -ErrorPageAuthorizationErrorMessage "<p> You need to be a member of Security Auditors to access this site. Click <A href='http://accessrequest/'>here</A> for more information.</p>“  
  
```  
  
### Home Realm Discovery  
When the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] client first requests a resource, the resource federation server has no information about the realm of the client. The resource federation server responds to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] client with a **Client Realm Discovery** page, where the user selects the home realm from a list. The list values are populated from the display name property in the Claims Provider Trusts. Use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets to modify and customize the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Home Realm Discovery experience.  
  
![](../Image/ADFS_Blue_Custom4.png)  
  
> [!WARNING]  
> Be aware that the Claims Provider name that shows up for local Active Directory is the federation service display name.  
  
#### Configure Identity Provider to use certain email suffixes  
An organization can federate with multiple claims providers. [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] now provides the in\-box capability for administrators to list the suffixes, for example, @us.contoso.com, @eu.contoso.com, that is supported by a claims provider and enable it for suffix\-based discovery. With this configuration, end users can type in their organizational account, and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] automatically selects the corresponding claims provider.  
  
To configure an identity provider \(IDP\), such as `fabrikam`, to use certain email suffixes, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsClaimsProviderTrust -TargetName fabrikam -OrganizationalAccountSuffix @("fabrikam.com";"fabrikam2.com")  
  
```  
  
#### Configure an identity provider list per relying party  
For some scenarios, an organizations might want end users to only see the claims providers that are specific to an application so that only a subset of claims provider are displayed on the home realm discovery page.  
  
To configure an IDP list per relying party \(RP\), use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsRelyingPartyTrust -TargetName claimapp -ClaimsProviderName @("Fabrikam","Active Directory")  
  
```  
  
#### Bypass Home Realm Discovery for the intranet  
Most organizations only support their local Active Directory for any user who accesses from inside their firewall. In those cases, administrators can configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to bypass home realm discovery for the intranet.  
  
To bypass HRD for the intranet, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsProperties -IntranetUseLocalClaimsProvider $true  
  
```  
  
> [!IMPORTANT]  
> Please note that if an identity provider list for a relying party has been configured, even though the previous setting has been enabled and the user accesses from the intranet, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] still shows the home realm discovery \(HRD\) page. To bypass HRD in this case, you have to ensure that "Active Directory" is also added to the IDP list for this relying party.  
  
### Update password  
In some instances, users might not be able to connect to the corporate network to change their account password. This factor can be problematic especially for remote employees who might live far from the nearest corporate office. For these specific cases, the update password page can be used by only connecting to the Internet.  
  
You can customize the update password page by providing your own description for the page. This feature is only available for a workplace\-joined device.  
  
> [!WARNING]  
> The update password page is only available for Workplace Joined devices and is disabled by default. For more information about Workplace Join and configuring a federation server with Device Registration Service, see [Overview: Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](http://technet.microsoft.com/library/dn280945.aspx).  
>   
> To enable the password update page, go to AD FS Management under Endpoints. The endpoint for update password is located at the bottom under Other \- \/adfs\/portal\/updatepassword\/. Once you have enabled the endpoint, you must restart the AD FS service. This must be done manually. You can then navigate to https:\/\/<fqdn>\/adfs\/portal\/updatepassword\/ on a workplace joined device and you should see the update password page.  
  
![](../Image/ADFS_Blue_Custom5.png)  
  
#### Customize the Update Password page description  
To customize the update password page description, use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet and syntax.  
  
```  
Set-AdfsGlobalWebContent -UpdatePasswordPageDescriptionText "This is the Contoso Update Password page."  
  
```  
  
### Multi\-factor authentication and external authentication providers  
In [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], the support for multifactor authentication is provided out\-of\-the\-box. For example, you can configure [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to use built\-in Certificate Authentication as the second factor authentication. You can also use external authentication providers. This approach can enable [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]to integrate with additional services, such as Windows Azure Active Authentication, or you can develop your own provider. See [Solution Guide: Manage Risk with Multi\-factor Access Control](http://technet.microsoft.com/library/dn280937.aspx) for more information about how to register external authentication provider by using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
We recommend that an external authentication provider use the classes that are defined in the .css file that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] provides to author the authentication UI. You can use the following cmdlet to export the default web theme and inspect the user interface classes and elements that are defined in the .css file. The .css file can be used in the development of the sign\-in user interface of an external authentication provider.  
  
```  
Export-AdfsWebTheme -Name default -DirectoryPath C:\theme  
```  
  
The following is an example of the sign\-in user interface, which is highlighted in RED, by an external authentication provider. The user interface uses the UI classes in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] .css file.  
  
![](../Image/ADFS_Blue_Custom8.png)  
  
Before you write a new custom authentication method, we recommend that you study the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] theme and style definitions to understand the content authoring requirements.  
  
-   A custom authentication method only authors an HTML segment on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in page and not the full page. You should use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]’s style definition to get the consistent appearance and behavior.  
  
    ![](../Image/ADFS_Blue_Custom9.png)  
  
-   Be aware that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] administrators can customize the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] styles. . We do not recommend to hardcode your own styles. Instead, we recommend to use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] styles whenever possible.  
  
-   Out\-of\-the box, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] styles are authored with one left\-to\-right \(LTR\) style and one right\-to\-left \(RTL\). Administrators can customize both, and can provide language\-specific styles through the web theme definition. Each style sheet has three sections with respective comments:  
  
    -   **theme styles** \- These styles should not and cannot be used. These styles are meant to define theme across all pages. They are defined by an element ID purposely so that they are not reused.  
  
    -   **common styles** \- These are the styles that should be used for your content.  
  
    -   **form factor styles** \- These are styles for different form factors. You should understand this section to ensure that your content works with different form factors, for example, phones and tablets.  
  
For additional information, see [Solution Guide: Manage Risk with Multi\-factor Access Control](http://technet.microsoft.com/library/dn280937.aspx) and [Solution Guide: Manage Risk with Additional Multi\-Factor Authentication for Sensitive Applications](http://tnstage.redmond.corp.microsoft.com/library/dn280949.aspx).  
  
### Localization  
Localizing web content into languages other than English is possible. Be aware of the following considerations when you localize.  
  
After the content is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support. All customized content takes a locale parameter. When you configure localized content, configure it with a country\-less locale first, for example, "en", before you configure a country and region\-specific locale such as "en\-us".  
  
The following shows some additional code examples.  
  
```  
Set-AdfsWebTheme -TargetName default -Logo @{Locale="";Path="c:\contoso.png"}  
  
Set-AdfsWebTheme -TargetName default -Illustration @{Locale="";Path="c:\illustration.png"}  
  
```  
  
The following shows some additional code examples.  
  
```  
Set-AdfsGlobalWebContent -ErrorPageDescriptionText "This is Contoso's error page description" –locale "en"  
  
```  
  
```  
Set-AdfsGlobalWebContent -ErrorPageDescriptionText "Il s'agit de description de page erreur de Contoso" –locale "fr"  
  
```  
  
If you want to customize the web content to languages other than English that requires the input of Unicode, we recommend that you use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] ISE. For additional information see [Introducing the Windows PowerShell ISE](http://technet.microsoft.com/library/dd315244.aspx).  
  
### Removing the Microsoft copyright  
By default, the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] pages contain the Microsoft copyright. To remove this copyright from your customized pages, you can use the following procedure.  
  
##### To remove the Microsoft copyright  
  
1.  Create a custom theme that is based on the default.  
  
    ```  
    New-AdfsWebTheme –Name custom –SourceName default  
  
    ```  
  
2.  Export the theme by specifying the output folder.  
  
    ```  
    Export-AdfsWebTheme -Name custom -DirectoryPath C:\customWebTheme  
  
    ```  
  
3.  Locate the Style.css file that is located in the output folder. By using the previous example, the path would be C:\\CustomWebTheme\\Css\\Style.css.  
  
4.  Open the Style.css file with an editor, such as Notepad.  
  
5.  Locate the `#copyright` portion, and then change it to the following:  
  
    ```  
    #copyright {color:#696969; display:none;}  
  
    ```  
  
6.  Create a custom theme that is based on the new Style.css file.  
  
    ```  
    Set-AdfsWebTheme -TargetName custom -StyleSheet @{locale="";path="C:\customWebTheme\css\style.css"}  
  
    ```  
  
7.  Activate the new theme.  
  
    ```  
    Set-AdfsWebConfig -ActiveThemeName custom  
  
    ```  
  
### Customizing the display names and descriptions for authentication methods  
To customize the display names and descriptions for authentication methods you can use the `Set-AdfsAuthenticationProviderWebContent` PowerShell cmdlt.  In order to use this cmdlt, you must first obtain the name of the authentication method you wish to customize.  This can be done using `Get-AdfsGlobalAuthenticationPolicy`.  In the example below we see that, on our sign\-in page, the following is displayed:  “Sign in using an X.509 certificate”.  We want to simplify this for our users.  
  
![](../Image/ADFS_Customize_Update1.PNG)  
  
So first we get the name of the authentication method and then we edit the displayed text.  
  
```  
Get-AdfsGlobalAuthenticationPolicy  
  
AdditionalAuthenticationProvider      : {}  
DeviceAuthenticationEnabled           : False  
PrimaryIntranetAuthenticationProvider : {FormsAuthentication, CertificateAuthentication}  
PrimaryExtranetAuthenticationProvider : {FormsAuthentication, CertificateAuthentication}  
WindowsIntegratedFallbackEnabled      : True  
  
Set-AdfsAuthenticationProviderWebContent -Name CertificateAuthentication -DisplayName "Sign in with a certificate"  
```  
  
![](../Image/ADFS_Customize_Update2.PNG)  
  
Now we see that our display message has changed.  
  
![](../Image/ADFS_Customize_Update3.PNG)  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
