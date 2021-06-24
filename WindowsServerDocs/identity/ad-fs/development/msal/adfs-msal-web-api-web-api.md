---
title: AD FS MSAL Web API calling Web API (On Behalf of Scenario)
description: Learn how to build a Web API calling another Web API.
author: billmath
ms.author: billmath
manager: daveba
ms.date: 08/09/2019
ms.topic: article
---

# Scenario: Web API calling Web API (On Behalf Of Scenario)
> Applies To: AD FS 2019 and later

Learn how to build a Web API calling another Web API On Behalf Of the user.

Before reading this article, you should be familiar with the [AD FS concepts](../ad-fs-openid-connect-oauth-concepts.md) and [On-Behalf_Of flow](../../overview/ad-fs-openid-connect-oauth-flows-scenarios.md#on-behalf-of-flow)

## Overview


- A client (Web App) - not represented on the diagram below - calls a protected Web API and provides a JWT bearer token in its "Authorization" Http header.
- The protected Web API validates the token and uses the MSAL [AcquireTokenOnBehalfOf](/dotnet/api/microsoft.identitymodel.clients.activedirectory.authenticationcontext.acquiretokenasync#Microsoft_IdentityModel_Clients_ActiveDirectory_AuthenticationContext_AcquireTokenAsync_System_String_Microsoft_IdentityModel_Clients_ActiveDirectory_ClientCredential_Microsoft_IdentityModel_Clients_ActiveDirectory_UserAssertion_) method to request (from AD FS) another token so that it can, itself, call a second web API (named the downstream web API) on behalf of the user.
- The protected web API uses this token to call a downstream API. It can also call AcquireTokenSilentlater to request tokens for other downstream APIs (but still on behalf of the same user). AcquireTokenSilent refreshes the token when needed.

     ![overview](media/adfs-msal-web-api-web-api/webapi1.png)

To better understand how to configure on behalf of auth scenario in ADFS, let's use a sample available [here](https://github.com/microsoft/adfs-sample-msal-dotnet-webapi-to-webapi-onbehalfof) and walkthrough the app registration and code configuration steps.

## Pre-requisites

- GitHub client tools
- AD FS 2019 or later configured and running
- Visual Studio 2013 or later

## App Registration in AD FS

This section shows how to register the Native App as a public client and Web APIs as Relying Parties (RP) in AD FS

  1. In AD FS Management, right-click on **Application Groups** and select **Add Application Group**.

  2. On the Application Group Wizard, for the **Name** enter **WebApiToWebApi** and under **Client-Server applications** select the **Native application accessing a Web API** template. Click **Next**.

      ![Screenshot of the Welcome page of the Add Application Group Wizard showing the Native application accessing a Web API template highlighted.](media/adfs-msal-web-api-web-api/webapi2.png)

  3. Copy the **Client Identifier** value. It will be used later as the value for **ClientId** in the application's **App.config** file. Enter the following for **Redirect URI:** - https://ToDoListClient. Click **Add**. Click **Next**.

      ![Screenshot of the Native application page of the Add Application Group Wizard showing the redirect U R I .](media/adfs-msal-web-api-web-api/webapi3.png)

  4. On the Configure Web API screen, enter the **Identifier:** https://localhost:44321/. Click **Add**. Click **Next**. This value will be used later in the application's **App.config** and **Web.Config** files.

      ![Screenshot of the Configure Web API page of the Add Application Group Wizard showing the correct identifier.](media/adfs-msal-web-api-web-api/webapi4.png)

  5. On the Apply Access Control Policy screen, select **Permit everyone** and click **Next**.

      ![Screenshot of the Choose Access Control Policy page of the Add Application Group Wizard showing the Permit everyone option highlighted.](media/adfs-msal-web-api-web-api/webapi5.png)

  6. On the Configure Application Permissions screen, select **openid** and **user_impersonation**. Click **Next**.

      ![Screenshot of the Configure Application Permissions page of the Add Application Group Wizard showing open I D selected.](media/adfs-msal-web-api-web-api/webapi6.png)

  7. On the Summary screen, click **Next**.

  8. On the Complete screen, click **Close**.


  9. In AD FS Management, click on **Application Groups** and select **WebApiToWebApi** application group. Right-click and select **Properties**.

      ![Screenshot of the A D F S Management dialog box showing the WebApiToWebApi group highlighted and the Properties option in the dropdown list.](media/adfs-msal-web-api-web-api/webapi7.png)

  10. On WebApiToWebApi properties screen, click **Add application…**.

      ![Screenshot of the WebApiToWebApi Properties dialog box showing the WebApiToWebApi - Web A P I application listed.](media/adfs-msal-web-api-web-api/webapi8.png)

  11. Under Standalone applications, select **Server application**.

      ![Screenshot of the Welcome page of the Add a new application to WebApiToWebApi wizard showing the Server application option highlighted.](media/adfs-msal-web-api-web-api/webapi9.png)

  12. On Server Application screen, add https://localhost:44321/ as the **Client Identifier** and **Redirect URI**.

      ![Screenshot of the Server application page of the Add a new application to WebApiToWebApi wizard showing the correct client identifier and redirect U R I.](media/adfs-msal-web-api-web-api/webapi10.png)

  13. On Configure Application Credentials screen, select **Generate a shared secret**. Copy the secret for later use.

      ![Screenshot of the Configure Application Credentials application page of the Add a new application to WebApiToWebApi wizard showing the Generate a shared secret option selected and the generated shared secret highlighted.](media/adfs-msal-web-api-web-api/webapi11.png)

  14. On the Summary screen, click **Next**.

  15. On the Complete screen, click **Close**.

  16. In AD FS Management, click on **Application Groups** and select **WebApiToWebApi** application group. Right-click and select **Properties**.

      ![Second screenshot of the A D F S Management dialog box showing the WebApiToWebApi group highlighted and the Properties option in the dropdown list.](media/adfs-msal-web-api-web-api/webapi12.png)

  17. On WebApiToWebApi properties screen, click **Add application…**.

      ![Second screenshot of the WebApiToWebApi Properties dialog box showing the WebApiToWebApi - Web A P I application listed.](media/adfs-msal-web-api-web-api/webapi13.png)

  18. Under Standalone applications, select **Web API**.

      ![Screenshot of the Welcome page of the Add a new application to WebApiToWebApi wizard showing the Web A P I option highlighted.](media/adfs-msal-web-api-web-api/webapi14.png)

  19. On Configure Web API, add https://localhost:44300 as the **Identifier**.

      ![Screenshot of the Configure Web A P I page of the Add a new application to WebApiToWebApi wizard showing the correct redirect U R I.](media/adfs-msal-web-api-web-api/webapi15.png)

  20. On the Apply Access Control Policy screen, select **Permit everyone** and click **Next**.

      ![Screenshot of the Choose Access Control Policy page of the Add a new application to WebApiToWebApi wizard showing the Permit everyone option highlighted.](media/adfs-msal-web-api-web-api/webapi16.png)

  21. On the Configure Application Permissions screen, click **Next**.

      ![Screenshot of the Configure Application Permissions page of the Add a new application to WebApiToWebApi wizard showing the Next option called out.](media/adfs-msal-web-api-web-api/webapi17.png)

  22. On the Summary screen, click **Next**.

  23. On the Complete screen, click **Close**.

  24. Click OK on WebApiToWebApi – Web API 2 Properties screen

  25. On WebApiToWebApi Properties screen, select **WebApiToWebApi – Web API** and click **Edit…**.

      ![Screenshot of the WebApiToWebApi Properties dialog box showing the WebApiToWebApi - Web A P I application highlighted.](media/adfs-msal-web-api-web-api/webapi18.png)

  26. On WebApiToWebApi – Web API Properties screen, select **Issuance Transform Rules** tab and click **Add Rule…**.

      ![Screenshot of the WebApiToWebApi - Web A P I Properties dialog box showing the Issuance Transform Rules tab.](media/adfs-msal-web-api-web-api/webapi19.png)

  27. On Add Transform Claim Rule Wizard, select **Send Claims Using a Custom Rule** from dropdown and click **Next**.

      ![Screenshot of the Select Rule Template page of the Add Transform Claim Rule Wizard showing the Send Claims Using a Custom Rule option selected.](media/adfs-msal-web-api-web-api/webapi20.png)

  28. Enter **PassAllClaims** in **Claim rule name:** field and **x:[] => issue(claim=x);** claim rule in Custom rule: field and click Finish.

      ![Screenshot of the Configure Rule page of the Add Transform Claim Rule Wizard showing the configuration explained above.](media/adfs-msal-web-api-web-api/webapi21.png)

  29. Click OK on WebApiToWebApi – Web API Properties screen

  30. On WebApiToWebApi Properties screen, select select WebApiToWebApi – Web API 2 and click Edit…</br>
  ![Screenshot of the WebApiToWebApi Properties dialog box showing the WebApiToWebApi - Web A P I 2 application highlighted.](media/adfs-msal-web-api-web-api/webapi22.png)

  31. On WebApiToWebApi – Web API 2 Properties screen, select Issuance Transform Rules tab and click Add Rule…

  32. On Add Transform Claim Rule Wizard, select Send Claims Using a Custom Rule from dropdown and click Next
  ![Second screenshot of the Select Rule Template page of the Add Transform Claim Rule Wizard showing the Send Claims Using a Custom Rule option selected.](media/adfs-msal-web-api-web-api/webapi23.png)

  33. Enter PassAllClaims in Claim rule name: field and **x:[] => issue(claim=x);** claim rule in **Custom rule:** field and click **Finish**.

      ![Second screenshot of the Configure Rule page of the Add Transform Claim Rule Wizard showing the configuration explained above.](media/adfs-msal-web-api-web-api/webapi24.png)

  34.  Click OK on WebApiToWebApi – Web API 2 Properties screen and then on WebApiToWebApi Properties screen.


## Code Configuration

This section shows how to configure a Web API to call another Web API

  1. Download the sample from [here](https://github.com/microsoft/adfs-sample-msal-dotnet-webapi-to-webapi-onbehalfof)

  2. Open the sample using Visual Studio

  3. Open the App.config file. Modify the following:
       - ida:Authority - enter https://[your AD FS hostname]/adfs/
       - ida:ClientId - enter the value from #3 in App Registration in AD FS section above.
       - ida:RedirectUri - enter the value from #3 in App Registration in AD FS section above.
       - todo:TodoListResourceId – enter the Identifier value from #4 in App Registration in AD FS section above
       - ida: todo:TodoListBaseAddress - enter the Identifier value from #4 in App Registration in AD FS section above.

            ![Screenshot of the App config file showing the modified values.](media/adfs-msal-web-api-web-api/webapi25.png)

  4. Open the Web.config file under ToDoListService. Modify the following:
       - ida:Audience - enter the Client Identifier value from #12 in App Registration in AD FS section above
       - ida:ClientId - enter the Client Identifier value from #12 in App Registration in AD FS section above.
       - Ida: ClientSecret - enter the shared secret copied from #13 in App Registration in AD FS section above.
       - ida:RedirectUri - enter the RedirectUri value from #12 in App Registration in AD FS section above.
       - ida: AdfsMetadataEndpoint - enter https://[your AD FS hostname]/federationmetadata/2007-06/federationmetadata.xml
       - ida:OBOWebAPIBase - enter the Identifier value from #19 in App Registration in AD FS section above.
       - ida:Authority - enter https://[your AD FS hostname]/adfs

          ![Screenshot of the web config file under ToDoListService showing the modified values.](media/adfs-msal-web-api-web-api/webapi26.png)

 5. Open the Web.config file under WebAPIOBO. Modify the following:
       - ida: AdfsMetadataEndpoint - enter https://[your AD FS hostname]/federationmetadata/2007-06/federationmetadata.xml
       - ida:Audience - enter the Client Identifier value from #12 in App Registration in AD FS section above

          ![Screenshot of the web config file under WebAPIOBO showing the modified values.](media/adfs-msal-web-api-web-api/webapi27.png)

## Test the sample

This section shows how to test the sample configured above.

Once the code changes are made rebuild the solution

  1. On Visual Studio, right click on solution and select **Set StartUp Projects…**

      ![Screenshot of the list that appears when you right-click the solution with the Set Start Up Projects option highlighted.](media/adfs-msal-web-api-web-api/webapi28.png)

  2. On the Properties pages make sure **Action** is set to **Start** for each of the Projects, except TodoListSPA.

      ![Screenshot of the Solution Property Pages dialog box showing the Multiple startup project option selected and all of the projects' actions set to Start.](media/adfs-msal-web-api-web-api/webapi29.png)

  3. At the top of Visual Studio, click the green arrow.

      ![Screenshot of the Visual Studio UI with the Start option called out.](media/adfs-msal-web-api-web-api/webapi30.png)

  4. On the Native App's Main Screen, click on **Sign In**.

      ![Screenshot of the To Do List Client dialog box.](media/adfs-msal-web-api-web-api/webapi31.png)

     If you don't see the native app screen, search and remove *msalcache.bin files from the folder where project repo is saved on your system.

  5. You will be re-directed to the AD FS sign-in page. Go ahead and sign in.

      ![Screenshot of the Sign In page.](media/adfs-msal-web-api-web-api/webapi32.png)

  6. Once signed-in, enter text Web Api to Web Api Call in the **Create a To Do item**. Click **Add item**.  This will call the Web API (To Do List Service) which then calls Web API 2 (WebAPIOBO) and adds the item in the cache.

      ![Screenshot of the To Do List Client dialog box with the new to do item populating the To Do Items section.](media/adfs-msal-web-api-web-api/webapi33.png)

 ## Next Steps
[AD FS OpenID Connect/OAuth flows and Application Scenarios](../../overview/ad-fs-openid-connect-oauth-flows-scenarios.md)


