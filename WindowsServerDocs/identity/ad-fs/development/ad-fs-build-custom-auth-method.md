---
title: Build a Custom Authentication Method for AD FS in Windows Server 
description: This scenario describes how to build a custom authentication method for AD FS in Windows Server.
author: billmath
ms.author: billmath
manager: daveba
ms.date: 05/23/2019
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Build a Custom Authentication Method for AD FS in Windows Server

This walkthrough provides instructions for implementing a custom authentication method for AD FS in Windows Server 2012 R2. For more information, see [Additional Authentication Methods](https://msdn.microsoft.com/library/dn758113\(v=msdn.10\)).


> [!WARNING]
> The example that you can build here is&nbsp;for educational purposes only. &nbsp;These instructions are for the simplest, most minimal implementation possible to expose the required elements of the model.&nbsp; There is no authentication back end, error processing, or configuration data. 
> <P></P>



## Setting up the development box

This walk-through uses Visual Studio 2012.  The project can be built using any development environment that can create a .NET class for Windows. The project must target .NET 4.5 because the **BeginAuthentication** and **TryEndAuthentication** methods use the type **System.Security.Claims.Claim**, part of .NET Framework version 4.5.There is one reference required for the project:


<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Reference dll</strong></p></td>
<td><p><strong>Where to find it</strong></p></td>
<td><p><strong>Required for</strong></p></td>
</tr>
<tr class="even">
<td><p>Microsoft.IdentityServer.Web.dll</p></td>
<td><p>The dll is located in %windir%\ADFS on a Windows Server 2012 R2 server on which AD FS has been installed.</p>
<p></p>
<p>This dll must be copied to the development machine and an explicit reference created in the project.</p></td>
<td><p>Interface types including IAuthenticationContext, IProofData</p></td>
</tr>
</tbody>
</table>


## Create the provider

1.  In Visual Studio 2012: Choose File-\>New-\>Project...

2.  Select Class Library and be sure you are targeting .NET 4.5.

    ![create the provider](media/ad-fs-build-custom-auth-method/Dn783423.71a57ae1-d53d-462b-a846-5b3c02c7d3f2(MSDN.10).jpg "create the provider")

3.  Make a copy of **Microsoft.IdentityServer.Web.dll** from %windir%\\ADFS on the Windows Server 2012 R2 server where AD FS has been installed and paste it in your Project folder on your development machine.

4.  In **Solution Explorer**, right click **References** and **Add Reference...**

5.  Browse to your local copy of **Microsoft.IdentityServer.Web.dll** and **Add...**

6.  Click **OK** to confirm the new reference:

    ![create the provider](media/ad-fs-build-custom-auth-method/Dn783423.f18df353-9259-4744-b4b6-dd780ce90951(MSDN.10).jpg "create the provider")

    You should now be set up to resolve all of the types required for the provider. 

7.  Add a new class to your project (Right click your project, **Add...Class...**) and give it a name like **MyAdapter**, shown below:

    ![create the provider](media/ad-fs-build-custom-auth-method/Dn783423.6b6a7a8b-9d66-40c7-8a86-a2e3b9e14d09(MSDN.10).jpg "create the provider")

8.  In the new file MyAdapter.cs, replace the existing code with the following:

        using System;
         using System.Collections.Generic;
         using System.Linq;
         using System.Text;
         using System.Threading.Tasks;
         using System.Globalization;
         using System.IO;
         using System.Net;
         using System.Xml.Serialization;
         using Microsoft.IdentityServer.Web.Authentication.External;
         using Claim = System.Security.Claims.Claim;

         namespace MFAadapter
         {
         class MyAdapter : IAuthenticationAdapter
         {

         }
         }

    Now you should be able to F12 (right click – Go To Definition) on IAuthenticationAdapter to see the set of required interface members. 

    Next, you can do a simple implementation of these.

9.  Replace the entire contents of your class with the following:

        namespace MFAadapter
         {
         class MyAdapter : IAuthenticationAdapter
         {
         public IAuthenticationAdapterMetadata Metadata
         {
         //get { return new <instance of IAuthenticationAdapterMetadata derived class>; }
         }

         public IAdapterPresentation BeginAuthentication(Claim identityClaim, HttpListenerRequest request, IAuthenticationContext authContext)
         {
         //return new instance of IAdapterPresentationForm derived class

         }

         public bool IsAvailableForUser(Claim identityClaim, IAuthenticationContext authContext)
         {
         return true; //its all available for now

         }

         public void OnAuthenticationPipelineLoad(IAuthenticationMethodConfigData configData)
         {
         //this is where AD FS passes us the config data, if such data was supplied at registration of the adapter

         }

         public void OnAuthenticationPipelineUnload()
         {

         }

         public IAdapterPresentation OnError(HttpListenerRequest request, ExternalAuthenticationException ex)
         {
         //return new instance of IAdapterPresentationForm derived class

         }

         public IAdapterPresentation TryEndAuthentication(IAuthenticationContext authContext, IProofData proofData, HttpListenerRequest request, out Claim[] outgoingClaims)
         {
         //return new instance of IAdapterPresentationForm derived class

         }

         }
         }

10. We are not ready to build yet... there are two more interfaces to go.

    Add two more classes to your project: one is for the metadata, and the other for the presentation form.  You can add these within the same file as the class above.

        class MyMetadata : IAuthenticationAdapterMetadata
         {

         }

         class MyPresentationForm : IAdapterPresentationForm
         {

         }

11. Next, you can add the required members for each.First, the metadata (with helpful inline comments)

        class MyMetadata : IAuthenticationAdapterMetadata
         {
         //Returns the name of the provider that will be shown in the AD FS management UI (not visible to end users)
         public string AdminName
         {
         get { return "My Example MFA Adapter"; }
         }

         //Returns an array of strings containing URIs indicating the set of authentication methods implemented by the adapter 
         /// AD FS requires that, if authentication is successful, the method actually employed will be returned by the
         /// final call to TryEndAuthentication(). If no authentication method is returned, or the method returned is not
         /// one of the methods listed in this property, the authentication attempt will fail.
         public virtual string[] AuthenticationMethods 
         {
         get { return new[] { "http://example.com/myauthenticationmethod1", "http://example.com/myauthenticationmethod2" }; }
         }

         /// Returns an array indicating which languages are supported by the provider. AD FS uses this information
         /// to determine the best language\locale to display to the user.
         public int[] AvailableLcids
         {
         get
         {
         return new[] { new CultureInfo("en-us").LCID, new CultureInfo("fr").LCID};
         }
         }

         /// Returns a Dictionary containing the set of localized friendly names of the provider, indexed by lcid. 
         /// These Friendly Names are displayed in the "choice page" offered to the user when there is more than 
         /// one secondary authentication provider available.
         public Dictionary<int, string> FriendlyNames
         {
         get
         {
         Dictionary<int, string> _friendlyNames = new Dictionary<int, string>();
         _friendlyNames.Add(new CultureInfo("en-us").LCID, "Friendly name of My Example MFA Adapter for end users (en)");
         _friendlyNames.Add(new CultureInfo("fr").LCID, "Friendly name translated to fr locale");
         return _friendlyNames;
         }
         }

         /// Returns a Dictionary containing the set of localized descriptions (hover over help) of the provider, indexed by lcid. 
         /// These descriptions are displayed in the "choice page" offered to the user when there is more than one 
         /// secondary authentication provider available.
         public Dictionary<int, string> Descriptions
         {
         get 
         {
         Dictionary<int, string> _descriptions = new Dictionary<int, string>();
         _descriptions.Add(new CultureInfo("en-us").LCID, "Description of My Example MFA Adapter for end users (en)");
         _descriptions.Add(new CultureInfo("fr").LCID, "Description translated to fr locale");
         return _descriptions; 
         }
         }

         /// Returns an array indicating the type of claim that the adapter uses to identify the user being authenticated.
         /// Note that although the property is an array, only the first element is currently used.
         /// MUST BE ONE OF THE FOLLOWING
         /// "https://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname"
         /// "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn"
         /// "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
         /// "https://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"
         public string[] IdentityClaims
         {
         get { return new[] { "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn" }; }
         }

         //All external providers must return a value of "true" for this property.
         public bool RequiresIdentity
         {
         get { return true; }
         }
        }

    Next, the presentation form:

        class MyPresentationForm : IAdapterPresentationForm
         {
         /// Returns the HTML Form fragment that contains the adapter user interface. This data will be included in the web page that is presented
         /// to the cient.
         public string GetFormHtml(int lcid)
         {
         string htmlTemplate = Resources.FormPageHtml; //todo we will implement this
         return htmlTemplate;
         }

         /// Return any external resources, ie references to libraries etc., that should be included in 
         /// the HEAD section of the presentation form html. 
         public string GetFormPreRenderHtml(int lcid)
         {
         return null;
         }

         //returns the title string for the web page which presents the HTML form content to the end user
         public string GetPageTitle(int lcid)
         {
         return "MFA Adapter";
         }


~~~
     }
~~~

12. Note the ‘todo' for the **Resources.FormPageHtml** element above. 

   You can fix it in a minute, but first let's add the final required return statements, based on the newly implemented types, to your initial MyAdapter class.  To do this, add the items in *Italic* below to your existing IAuthenticationAdapter implementation:

       class MyAdapter : IAuthenticationAdapter
        {
        public IAuthenticationAdapterMetadata Metadata
        {
        //get { return new <instance of IAuthenticationAdapterMetadata derived class>; }
        get { return new MyMetadata(); }
        }

        public IAdapterPresentation BeginAuthentication(Claim identityClaim, HttpListenerRequest request, IAuthenticationContext authContext)
        {
        //return new instance of IAdapterPresentationForm derived class
        return new MyPresentationForm();
        }

        public bool IsAvailableForUser(Claim identityClaim, IAuthenticationContext authContext)
        {
        return true; //its all available for now
        }

        public void OnAuthenticationPipelineLoad(IAuthenticationMethodConfigData configData)
        {
        //this is where AD FS passes us the config data, if such data was supplied at registration of the adapter

        }

        public void OnAuthenticationPipelineUnload()
        {

        }

        public IAdapterPresentation OnError(HttpListenerRequest request, ExternalAuthenticationException ex)
        {
        //return new instance of IAdapterPresentationForm derived class
        return new MyPresentationForm();
        }

        public IAdapterPresentation TryEndAuthentication(IAuthenticationContext authContext, IProofData proofData, HttpListenerRequest request, out Claim[] outgoingClaims)
        {
        //return new instance of IAdapterPresentationForm derived class
        outgoingClaims = new Claim[0];
        return new MyPresentationForm();
        }

        }

13. Now for the resource file containing the html fragment. Create a new text file in your project folder with the following contents:

       <div id="loginArea">
        <form method="post" id="loginForm" >
        <!-- These inputs are required by the presentation framework. Do not modify or remove -->
        <input id="authMethod" type="hidden" name="AuthMethod" value="%AuthMethod%"/>
        <input id="context" type="hidden" name="Context" value="%Context%"/>
        <!-- End inputs are required by the presentation framework. -->
        <p id="pageIntroductionText">This content is provided by the MFA sample adapter. Challenge inputs should be presented below.</p>
        <label for="challengeQuestionInput" class="block">Question text</label>
        <input id="challengeQuestionInput" name="ChallengeQuestionAnswer" type="text" value="" class="text" placeholder="Answer placeholder" />
        <div id="submissionArea" class="submitMargin">
        <input id="submitButton" type="submit" name="Submit" value="Submit" onclick="return AuthPage.submitAnswer()"/>
        </div>
        </form>
        <div id="intro" class="groupMargin">
        <p id="supportEmail">Support information</p>
        </div>
        <script type="text/javascript" language="JavaScript">
        //<![CDATA[
        function AuthPage() { }
        AuthPage.submitAnswer = function () { return true; };
        //]]>
        </script></div>

14. Then, select **Project-\>Add Component... Resources** file and name the file **Resources**, and click **Add:**

   ![create the provider](media/ad-fs-build-custom-auth-method/Dn783423.3369ad8f-f65f-4f36-a6d5-6a3edbc1911a(MSDN.10).jpg "create the provider")

15. Then, within the **Resources.resx** file, choose **Add Resource...Add existing file**.  Navigate to the text file (containing the html fragment) that you saved above.

   Ensure your GetFormHtml code resolves the name of the new resource correctly by the resources file (.resx file) name prefix followed by the name of the resource itself:

       public string GetFormHtml(int lcid)
       {
        string htmlTemplate = Resources.MfaFormHtml; //Resxfilename.resourcename
        return htmlTemplate;
       }

   You should now be able to build.

## Build the adapter

The adapter should be built into a strongly named .NET assembly that can be installed into the GAC in Windows.  To achieve this in a Visual Studio project, complete the following steps:

1.  Right click your project name in Solution Explorer and click **Properties**.

2.  On the **Signing** tab, check **Sign the assembly** and choose **\<New...\>** under **Choose a strong name key file:**  Enter a key file name and password and click **OK**.  Then ensure **Sign the assembly** is checked and **Delay sign only** is unchecked.  The properties **Signing** page should look like this:

    ![build the provider](media/ad-fs-build-custom-auth-method/Dn783423.0b1a1db2-d64e-4bb8-8c01-ef34296a2668(MSDN.10).jpg "build the provider")

3.  Then build the solution.

## Deploy the adapter to your AD FS test machine

Before an external provider can be invoked by AD FS, it must be registered in the system.  Adapter providers must provide an installer which performs the necessary installation actions including installation in the GAC, and the installer must support registration in AD FS.  If that is not done, the administrator needs to execute the Windows PowerShell steps below.  These steps can be used in the lab to enable testing and debugging.

### Prepare the test AD FS machine

Copy files and add to GAC.

1.  Ensure you have a Windows Server 2012 R2 computer or virtual machine.

2.  Install the AD FS role service and configure a farm with at least one node.

    For detailed steps to setup a federation server in a lab environment, see the [Windows Server 2012 R2 AD FS Deployment Guide](https://msdn.microsoft.com/library/dn486820\(v=msdn.10\)).

3.  Copy the Gacutil.exe tools to the server.

    Gacutil.exe can be found in **%homedrive%\\Program Files (x86)\\Microsoft SDKs\\Windows\\v8.0A\\bin\\NETFX 4.0 Tools\\** on a Windows 8 machine.  You will need the **gacutil.exe** file itself as well as the **1033**, **en-US**, and the other localized resource folder below the **NETFX 4.0 Tools** location.

4.  Copy your provider file(s) (one or more strong name signed .dll files) to the same folder location as **gacutil.exe** (the location is just for convenience)

5.  Add your .dll file(s) to the GAC on each AD FS federation server in the farm:

    Example: using command line tool GACutil.exe to add a dll to the GAC: `C:\>.\gacutil.exe /if .\<yourdllname>.dll`

    To view the resulting entry in the GAC:`C:\>.\gacutil.exe /l <yourassemblyname>`

6.  

### Register your provider in AD FS

Once the above pre-requisites are met, open a Windows PowerShell command window on your federation server and enter the following commands (note that if you are using federation server farm that uses Windows Internal Database, you must execute these commands on the primary federation server of the farm):

1.  `Register-AdfsAuthenticationProvider –TypeName YourTypeName –Name “AnyNameYouWish” [–ConfigurationFilePath (optional)]`

    Where YourTypeName is your .NET strong type name: "YourDefaultNamespace.YourIAuthenticationAdapterImplementationClassName, YourAssemblyName, Version=YourAssemblyVersion, Culture=neutral, PublicKeyToken=YourPublicKeyTokenValue, processorArchitecture=MSIL"

    This will register your external provider in AD FS, with the Name you provided as AnyNameYouWish above.

2.  Restart the AD FS service (using the Windows Services snap-in, for example).

3.  Run the following command: `Get-AdfsAuthenticationProvider`.

    This shows your provider as one of the providers in the system.

    Example:

        PS C:\>$typeName = "MFAadapter.MyAdapter, MFAadapter, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e675eb33c62805a0, processorArchitecture=MSIL”
        PS C:\>Register-AdfsAuthenticationProvider -TypeName $typeName -Name “MyMFAAdapter”
        PS C:\>net stop adfssrv
        PS C:\>net start adfssrv

    If you have the device registration service enabled in your AD FS environment, also execute the following:  `PS C:\>net start drs`

    To verify the registered provider, use the following command:`PS C:\>Get-AdfsAuthenticationProvider`.

    This shows your provider as one of the providers in the system.

### Create the AD FS authentication policy that invokes your adapter

#### Create the authentication policy using the AD FS Management snap-in

1.  Open the AD FS Management snap-in (from the Server Manager **Tools** menu).

2.  Click **Authentication Policies**.

3.  In the center pane, under **Multi-Factor Authentication**, click the **Edit** link to the right of **Global Settings**.

4.  Under **Select additional authentication methods** at the bottom of the page, check the box for your provider's AdminName. Click **Apply**.

5.  To provide a “trigger” to invoke MFA using your adapter, under **Locations** check both **Extranet** and **Intranet**, for example. Click **OK**. (To configure triggers per relying party, see “Create the authentication policy using Windows PowerShell” below.)

6.  Check the results using the following commands:

    First use `Get-AdfsGlobalAuthenticationPolicy`. You should see your provider Name as one of the AdditionalAuthenticationProvider values.

    Then use `Get-AdfsAdditionalAuthenticationRule`. You should see the rules for Extranet and Intranet configured as a result of your policy selection in the administrator UI.

#### Create the authentication policy using Windows PowerShell

1.  First, enable the provider in global policy:

    `PS C:\>Set-AdfsGlobalAuthenticationPolicy -AdditionalAuthenticationProvider “YourAuthProviderName”`


~~~
> [!NOTE]
> Note that the value provided for the AdditionalAuthenticationProvider parameter corresponds to the value you provided for the “Name” parameter in the Register-AdfsAuthenticationProvider cmdlet above and to the “Name” property from Get-AdfsAuthenticationProvider cmdlet output. 
> <P></P>


Example:`PS C:\>Set-AdfsGlobalAuthenticationPolicy –AdditionalAuthenticationProvider “MyMFAAdapter”`
~~~

2. Next, configure global or relying-party-specific rules to trigger MFA:

   Example 1: to create global rule to require MFA for External requests:`PS C:\>Set-AdfsAdditionalAuthenticationRule –AdditionalAuthenticationRules 'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", value == "false"] => issue(type = "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn" );'`

   Example 2: to create MFA rules to require MFA for external requests to a specific relying party.  (Note that individual providers cannot be connected to individual relying parties in AD FS in Windows Server 2012 R2).

       PS C:\>$rp = Get-AdfsRelyingPartyTrust –Name <Relying Party Name>
       PS C:\>Set-AdfsRelyingPartyTrust –TargetRelyingParty $rp –AdditionalAuthenticationRules 'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", value == "false"] => issue(type = "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn" );'

### Authenticate with MFA using your adapter

Finally, perform the steps below to test your adapter:

1.  Ensure the AD FS global Primary authentication type is configured as Forms Authentication for both Extranet and Intranet (this makes your demo easier to authenticate as a specific user)

    1.  In the AD FS snap-in, under **Authentication Policies**, in the **Primary Authentication** area, click **Edit** next to **Global Settings**.

        1.  Or just click the **Primary** tab from the **Multi-factor policy** UI.

2.  Ensure **Forms Authentication** is the only option checked for both the Extranet and the Intranet authentication method.  Click **OK**.

3.  Open the IDP initiated sign-on html page (https://\<fsname\>/adfs/ls/idpinitiatedsignon.htm) and sign in as a valid AD user in your test environment.

4.  Enter credentials for primary authentication.

5.  You should see the MFA forms page with example challenge questions appear. 

    If you have more than one adapter configured, you will see the MFA choice page with your friendly name from above.

    ![authenticate with adapter](media/ad-fs-build-custom-auth-method/Dn783423.c98d2712-cbd3-4cb9-ac03-2838b81c4f63(MSDN.10).jpg "authenticate with adapter")

    ![authenticate with adapter](media/ad-fs-build-custom-auth-method/Dn783423.fd3aefc0-ef6c-4a8c-a737-4914c78ff2d2(MSDN.10).jpg "authenticate with adapter")

You now have a working implementation of the interface and you have the knowledge of how the model works. You can trym as an extra example to set break points in the BeginAuthentication as well as the TryEndAuthentication.  Notice how BeginAuthentication is executed when the user first enters the MFA form, whereas TryEndAuthentication is triggered at each Submit of the form.

## Update the adapter for successful authentication

But wait – your example adapter will never successfully authenticate\!  This is because nothing in your code returns null for TryEndAuthentication.

By completing the procedures above, you created a basic adapter implementation and added it to an AD FS server.  You can get the MFA forms page, but you cannot yet authenticated because you have not yet put the correct logic in your TryEndAuthentication implementation.  So let's add that.

Recall your TryEndAuthentication implementation:

    public IAdapterPresentation TryEndAuthentication(IAuthenticationContext authContext, IProofData proofData, HttpListenerRequest request, out Claim[] outgoingClaims)
     {
     //return new instance of IAdapterPresentationForm derived class
     outgoingClaims = new Claim[0];
     return new MyPresentationForm();

     }

Let's update it so it doesn't always return MyPresentationForm().  For this you can create one simple utility method within your class:

    static bool ValidateProofData(IProofData proofData, IAuthenticationContext authContext)
     {
     if (proofData == null || proofData.Properties == null || !proofData.Properties.ContainsKey("ChallengeQuestionAnswer"))
     {
     throw new ExternalAuthenticationException("Error - no answer found", authContext);
     }

     if ((string)proofData.Properties["ChallengeQuestionAnswer"] == "adfabric")
     {
     return true;
     }
     else
     {
     return false;
     }
     }

Then, update TryEndAuthentication as below:

    public IAdapterPresentation TryEndAuthentication(IAuthenticationContext authContext, IProofData proofData, HttpListenerRequest request, out Claim[] outgoingClaims)
     {
     outgoingClaims = new Claim[0];
     if (ValidateProofData(proofData, authContext))
     {
     //authn complete - return authn method
     outgoingClaims = new[] 
     {
     // Return the required authentication method claim, indicating the particulate authentication method used.
     new Claim( "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", 
     "http://example.com/myauthenticationmethod1" )
     };
     return null;
     }
     else
     {
     //authentication not complete - return new instance of IAdapterPresentationForm derived class
     return new MyPresentationForm();
     }
     }

Now you have to update the adapter on the test box.  You must first undo the AD FS policy, then un-register from AD FS and restart AD FS, then remove the .dll from the GAC, then add the new .dll to the GAC, then register it in AD FS, restart AD FS, and re-configure AD FS policy.

## Deploy and configure the updated adapter on your test AD FS machine

### Clear AD FS Policy

Clear all MFA related checkboxes in the MFA UI, shown below, then click OK.

![clear policy](media/ad-fs-build-custom-auth-method/Dn783423.c111b4e7-5b05-413c-8b0f-222a0e91ac1f(MSDN.10).jpg "clear policy")

### Unregister provider (Windows PowerShell)

`PS C:\> Unregister-AdfsAuthenticationProvider –Name “YourAuthProviderName”`

Example:`PS C:\> Unregister-AdfsAuthenticationProvider –Name “MyMFAAdapter”`

Note that the value you pass for “Name” is the same value as “Name” you provided to the Register-AdfsAuthenticationProvider cmdlet.  It is also the “Name” property that is output from Get-AdfsAuthenticationProvider.

Note that before you unregister a provider, you must remove the provider from the AdfsGlobalAuthenticationPolicy (either by clearing the checkboxes you checked in AD FS management snap-in or by using Windows PowerShell.)

Note that the AD FS service must be restarted after this operation.

### Remove assembly from GAC

1.  First, use the following command to find the fully qualified strong name of the entry:`C:\>.\gacutil.exe /l <yourAdapterAssemblyName>`

    Example:`C:\>.\gacutil.exe /l mfaadapter`

2.  Then, use the following command to remove it from the GAC:`.\gacutil /u “<output from the above command>”`

    Example:`C:\>.\gacutil /u “mfaadapter, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e675eb33c62805a0, processorArchitecture=MSIL”`

### Add the updated assembly to GAC

Make sure you paste the updated .dll locally first. `C:\>.\gacutil.exe /if .\MFAAdapter.dll`

### View assembly in the GAC (cmd line)

`C:\> .\gacutil.exe /l mfaadapter`

### Register your provider in AD FS

1.  `PS C:\>$typeName = "MFAadapter.MyAdapter, MFAadapter, Version=1.0.0.1, Culture=neutral, PublicKeyToken=e675eb33c62805a0, processorArchitecture=MSIL”`

2.  `PS C:\>Register-AdfsAuthenticationProvider -TypeName $typeName -Name “MyMFAAdapter1”`

3.  Restart the AD FS service.

### Create the authentication policy using the AD FS Management snap-in

1.  Open the AD FS Management snap-in (from the Server Manager **Tools** menu).

2.  Click **Authentication Policies**.

3.  Under **Multi-Factor Authentication**, click the **Edit** link to the right of **Global Settings**.

4.  Under **Select additional authentication methods**, check the box for your provider's AdminName. Click **Apply**.

5.  To provide a “trigger” to invoke MFA using your adapter, under Locations check both **Extranet** and **Intranet**, for example. Click **OK**.

### Authenticate with MFA using your adapter

Finally, perform the steps below to test your adapter:

1.  Ensure the AD FS global Primary authentication type is configured as **Forms Authentication** for both Extranet and Intranet (this makes it easier to authenticate as a specific user).

    1.  In the AD FS management snap-in, under **Authentication Policies**, in the **Primary Authentication** area, click **Edit** next to **Global Settings**.

        1.  Or just click the **Primary** tab from the Multi-factor policy UI.

2.  Ensure **Forms Authentication** is the only option checked for both the **Extranet** and the **Intranet** authentication method.  Click **OK**.

3.  Open the IDP initiated sign-on html page (https://\<fsname\>/adfs/ls/idpinitiatedsignon.htm) and sign in as a valid AD user in your test environment.

4.  Enter the credentials for primary authentication.

5.  You should see the MFA forms page with example challenge text appear.

    1.  If you have more than one adapter configured, you will see the MFA choice page with your friendly name.

You should see a successful sign-in when entering “adfabric” at the MFA authentication page.

![sign in with adapter](media/ad-fs-build-custom-auth-method/Dn783423.630d8a91-3bfe-4cba-8acf-03eae21530ee(MSDN.10).jpg "sign in with adapter")

![sign in with adapter](media/ad-fs-build-custom-auth-method/Dn783423.c340fa73-f70f-4870-b8dd-07900fea4469(MSDN.10).jpg "sign in with adapter")

## See Also

#### Other Resources

[Additional Authentication Methods](https://msdn.microsoft.com/library/dn758113\(v=msdn.10\))  
[Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](https://msdn.microsoft.com/library/dn280949\(v=msdn.10\))

