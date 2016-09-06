---
title: AD FS user sign-in customization
description:
author: billmath
manager: femila
ms.date: 07/13/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
---
# AD FS user sign-in customization

>Applies To: Windows Server 2016, Windows Server 2012 R2

AD FS provides a number of options for administrators to customize and tailor the end-user experience to meet their corporate needs.  The following page will serve as a central location for customization.  

The following is a list of improvements that have been added to AD FS:  
  
-   **No more dependence on IIS** \- AD FS is now built directly on top of HTTP.SYS and does not require the installation of Internet Information Services \(IIS\).  
  
-   **Built\-in webpage customization** – The appearance and behavior of webpages can be customized to provide a tailored user experience. These customizations include the following:  
  
    -   **Logo and illustration** \- The logo and illustration of pages can be easily updated and changed with a simple Windows PowerShell PowerShell cmdlet. It is no longer necessary to modify any of the webpage code in AD FS.  
  
    -   **Customization of standard Links** \- Most organizations have some notion of standard links for IT support, home page, and a privacy link. These elements can be configured and displayed on AD FS webpages.  
  
    -   **Customization of web themes** \- At the heart of the customizations is the notion of a web theme. This feature enables the administrator to customize the entire appearance and behavior of the AD FS pages. Each web theme supports all of the elements that were described previously. Customizing the web themes can now be done on a per RP level with Windows Server 2016.

![](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png) 
    
  
-   **Customization for error pages** \- When something goes wrong, an error page is displayed to the end user. A few enhancements have been made to provide a better user experience. For example, AD FS now support sending error details to an IT help desk if required by using one click.  
  
    -   **Customized "Access denied" messages** – End users often get confused when they get a generic "Access denied" message. AD FS now supports customized "Access denied" messages to enable organizations to provide customized instructions for its end users. This customization supports HTML content and can be set globally or on the basis of a relying party trust.  
  
-   **Responsive design to cater to different form factors** \- AD FS now supports automatic adjustment of size and positioning of elements through cascading style sheets \(CSS\). For example, in the smartphone scenario where the form factor is limited in width, AD FS sign\-in pages would automatically adjust and also hide the illustration.  
  
-   **Improved user experience for home realm discovery** –AD FS now supports home realm discovery by looking up organizational account suffixes that a claims provider supports or by looking up the claims provider list that is configured for a relying party trust. AD FS also supports by\-passing home realm discovery for intranet access.  
  
-   **Support for updating the password** – Users can change their password without having to connect to the corporate network.  




Use the table below to find detailed information on AD FS customization.

Topic|Description|
-----|-----|
[AD FS Customization in Windows Server 2016](AD-FS-Customization-in-Windows-Server-2016.md)|New customization options available for AD FS in Windows Server 2016|
[Change the company name](Change-the-company-name-on-the-AD-FS-sign-in-page.md)|Steps for displaying your companies name on the sign-in page|
[Change the company logo](Change-the-company-logo-on-the-AD-FS-sign-in-page.md)|Steps for changing the logo that appears on the sign-in-page|
[Change the illustration](Change-the-illustration-on-the-AD-FS-sign-in-page.md)|Steps for changing the illustration that appears on the sign-in page|
[Add sign-in description](Add-sign-in-page-description.md)|Steps for adding a description to the sign-in page|
[Add help desk link](Add-Help-Desk-Link.md)|Steps for adding a help desk link|
[Add home link](Add-Home-Link.md)|Steps for adding a home link|
[Add privacy link](Add-Privacy-Link.md)|Steps for adding a privacy link|
[Custom web themes](Custom-Web-Themes-in-AD-FS.md)|Information on using custom web themes
[Custom error messages](Custom-error-messages-for-AD-FS-sign-in-page.md)|Steps for customizing error messages
[Home Realm Discovery](Home-Realm-Discovery-Customization.md)|Steps for customizing Home Realm Discovery|
[Update Password Customization](Update-password-customization.md)|Steps for enabling and customizing the update password page|
[Multi-factor authentication and external auth providers customization](Multi-factor-authentication-and-external-auth-providers-customization.md)|Information on using MFA and external auth providers|
[Customization for Localization](Customization-for-Localization.md)|Information on localization considerations
[Removing the Microsoft copyright](Remove-the-Microsoft-copyright.md)|Steps on removing the Microsoft copyright
[Customizing the display names and descriptions for authentication methods](Customize-the-display-names-and-descriptions-for-authentication-methods.md)|Steps on customizing display names and descriptions for authentication methods
[Advanced Customization](Advanced-Customization-of-AD-FS-Sign-in-Pages.md)|Advanced customization options using the onload.js file.




