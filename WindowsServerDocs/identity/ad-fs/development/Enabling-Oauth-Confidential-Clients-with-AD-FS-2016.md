---
ms.assetid: 5a64e790-6725-4099-aa08-8067d57c3168
title: Enabling Oauth Confidential Clients with AD FS 2016
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Enabling Oauth Confidential Clients with AD FS 2016

>Applies To: Windows Server 2016

Building on the initial Oauth support in AD FS in Windows Server 2012 R2, AD FS 2016 introduces support for clients capable of maintaining their own secret, such as an app or service running on a web server.  These clients are known as confidential clients.    
Below is a schematic of a web application running on a web server and serving as a confidential client to AD FS:  
  
## Pre-requisites  
The following are a list of pre-requisites that are required prior to completing this document. This document assumes that AD FS has been installed and an AD FS farm has been created.  
  
-   An Azure AD subscription (a free trial is fine)  
  
-   GitHub client tools  
  
-   AD FS in Windows Server 2016 TP4 or later  
  
-   Visual Studio 2013 or later.  
  
## Create an Application Group in AD FS 2016  
The following section describes how to configure the application group in AD FS 2016.  
  
#### Create the Application Group  
  
1.  In AD FS Management, right-click on Application Groups and select **Add Application Group**.  
  
2.  On the Application Group Wizard, for the name enter **ADFSOAUTHCC** and under **Standalone applications** select the **Server application or Website** template.  Click **Next**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_2.PNG)  
  
3.  Copy the **Client Identifier** value.  It will be used later as the value for **ida:ClientId** in the applications web.config file.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_3.PNG)  
  
4.  Enter the following for **Redirect URI:** - **https://localhost:44323**.  Click **Add**. Click **Next**.  
  
5.  On the **Configure Application Credentials** screen, place a check in **Generate a shared secret**and copy the secret.  This will be used later as the value for **ida:AppKey** in the applications web.config file.  Click **Next**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_4.PNG)  
  
6.  On the **Summary** screen,  click **Next**.  
  
7.  On the **Complete** screen,  click **Close**.  
  
8.  Now, on the right-click the new Application Group and select **Properties**.  
  
9. On **ADFSOAUTHCC Properties** click **Add application**.  
  
10. On the **Add a new application to Sample Application** select **Web API**and click **Next**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_6.PNG)  
  
11. On the **Configure Web API** screen, enter the following for **Identifier** - **https://contoso.com/WebApp**.  Click **Add**. Click **Next**.  This value will be used later for **ida:GraphResourceId** in the applications web.config file.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_9.PNG)  
  
12. On the **Choose Access Control Policy** screen, select **Permit everyone** and click **Next**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_7.PNG)  
  
13. On the **Configure Application Permissions** screen,  make sure**user_impersonation** is selected and click **Next**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_8.PNG)  
  
14. On the **Summary** screen,  click **Next**.  
  
15. On the **Complete** screen,  click **Close**.  
  
16. On the **ADFSOAUTHCC Properties** click **OK**.  
  
## Upgrade the database  
Visual Studio 2015 was used in creating this walkthrough.   In order to get the example working with Visual Studio 2015 you will need to update the database file.  Use the following procedure to do this.  
  
This section discusses how to download the sample Web API and upgrade the database in Visual Studio 2015.   We will be using the Azure AD sample that is [here](https://github.com/Azure-Samples/active-directory-dotnet-webapp-webapi-oauth2-useridentity).  
  
To download the sample project, use Git Bash and type the following:  
  
```  
git clone https://github.com/Azure-Samples/active-directory-dotnet-webapp-webapi-oauth2-useridentity.git  
```  
  
![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_10.PNG)  
  
#### To upgrade the database file  
  
1.  Open the project in Visual Studio, there will be a pop-up telling you that the app requires SQL Server 2102 Express or you will need to upgrade the database.  Click Ok.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_12.PNG)  
  
2.  Next compile the application by selecting Build -> Build Solution at the top.  This will restore all of the NuGet packages.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_13.PNG)  
  
3.  Now at the top, select **View** -> **Server Explorer**.  Once that opens, under **Data Connections**, right-click **DefaultConnection** and select **Modify Connection**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_14.PNG)  
  
4.  On **Modify Connection**, select **Advanced**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_15.PNG)  
  
5.  On the Advanced Properties, locate Data Source and use the drop-down to change it from **(LocalDb\v11.0)** to **(LoaclDB)MSSQLLocalDB**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_16.PNG)  
  
6.  Click Ok. Click Ok.  Click Yes to upgrade the database.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_17.PNG)  
  
7.  When this completes, over on the right, copy the value in the box next to **Connection String.**  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_18.PNG)  
  
8.  Now, open the Web.config file and replace the value that is in connectionString with the value you copied above.  Save the Web.config file.  
  
    > [!NOTE]  
    > The steps above are necessary so that we can get the new connectionString.  Otherwise, when we run Update-Database below it will error out.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_19.PNG)  
  
9. At the top of Visual Studio, select **View** -> **Other Windows** -> **Package Manager Console**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_20.PNG)  
  
10. At the bottom, in the Package Manager Console enter:  `Enable-Migrations` and hit enter.  
  
    > [!NOTE]  
    > If you get an error that says Enable-Migrations is not recognized as a cmdlet, enter Install-Package EntityFramework to update the EntityFramework.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_21.PNG)  
  
11. At the bottom, in the Package Manager Console enter:  `Add-Migration <anynamehere>` and hit enter.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_22.PNG)  
  
12. At the bottom, in the Package Manager Console enter:  `Update-Database` and hit enter.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_23.PNG)  
  
## Modify the WebApi in Visual Studio  
  
#### To Modify the Sample Web API  
  
1.  Open the sample using Visual Studio.  
  
2.  Open the web.config file.  Modify the following values:  
  
    -   ida:ClientId - enter the value from #3 above.  
  
    -   ida:AppKey - enter the value from #5 above.  
  
    -   ida:GraphResourceId - enter the value from #11 above.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_24.PNG)  
  
3.  Open the Startup.Auth.cs file under App_Start and make the following changes:  
  
    -   Comment out the following lines:  
  
        ```  
        //private static string aadInstance = ConfigurationManager.AppSettings["ida:AADInstance"];  
        //private static string tenant = ConfigurationManager.AppSettings["ida:Tenant"];  
        //public static readonly string Authority = String.Format(CultureInfo.InvariantCulture, aadInstance, tenant);  
        ```  
  
        ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_25.PNG)  
  
    -   Add the following in it's place:  
  
        ```  
        public static readonly string Authority = "https://<your_fsname>/adfs";  
        ```  
  
        where <your_fsname> is replaced with the DNS portion of your federation service url, for example adfs.contoso.com  
  
        ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_26.PNG)  
  
4.  Open the UserProfileController.cs file and make the following changes:  
  
    -   Comment out the following:  
  
        ```  
        //authContext = new AuthenticationContext(Startup.Authority, new TokenDbCache(userObjectID));  
        ```  
  
    -   Replace both occurrences with the following:  
  
        ```  
        authContext = new AuthenticationContext(Startup.Authority, false, new TokenDbCache(userObjectID));  
        ```  
  
        ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_27.PNG)  
  
    -   Comment out the following:  
  
        ```  
        //authContext = new AuthenticationContext(Startup.Authority);  
        ```  
  
    -   Replace both occurrences with the following:  
  
        ```  
        authContext = new AuthenticationContext(Startup.Authority, false);  
        ```  
  
        ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_28.PNG)  
  
    -   Now comment out all instances of the following:  
  
        ```  
        Uri redirectUri = new Uri(Request.Url.GetLeftPart(UriPartial.Authority.ToString() + "/OAuth");  
        ```  
  
    -   Replace all occurrences with the following:  
  
        ```  
        Uri redirectUri = new Uri(Request.Url.GetLeftPart(UriPartial.Authority.ToString());  
        ```  
  
        ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_34.PNG)  
  
## Test the Solution  
In this section we will test the confidential client solution.  Use the following procedure to test the solution.  
  
#### Testing the confidential client solution  
  
1.  At the top of Visual Studio, make sure Internet Explorer is selected and click the green arrow.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_36.png)  
  
2.  Once the ASP.Net page comes up, click on **Register**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_31.PNG)  
  
3.  Enter a username and password and then click **Register**.  This creates a local account in the SQL database.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_31.PNG)  
  
4.  Notice now, the ASP.NET site says Hello bsimon!.  Click **Profile**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_32.PNG)  
  
5.  This brings up a page without any information and says that we must click here to sign-in.  Click **here**.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_33.PNG)  
  
6.  You will now be prompted to sign-in to AD FS.  
  
    ![AD FS Oauth](media/Enabling-Oauth-Confidential-Clients-with-AD-FS-2016/AD_FS_Confidential_35.PNG)  
  


