---
author: daniellee-msft
---

# Publishing Extensions #

Once you've developed your extension, you will want to publish it and make it available to others to test or use. Depending on your audience and purpose of publishing, there are a few different options for publishing which we'll introduce below along with the steps and requirements for publishing.

## Deciding where to publish to ##

### Publishing to the Windows Admin Center extension feed ###
By default, Windows Admin Center is connected to a NuGet feed maintained by the Windows Admin Center product team at Microsoft. Preview versions or updates of some extensions developed by Microsoft will be published to this feed and available to all Windows Admin Center users. External developers planning to build and release extensions publicly may also submit a request to publish to this feed.

### Publishing to a different NuGet feed ###
You may also create your own NuGet feed to publish your extensions to using one of the many [different options for setting up a private source or using a NuGet hosting service](https://docs.microsoft.com/en-us/nuget/hosting-packages/overview). The NuGet feed must support the NuGet v2 API. Since Windows Admin Center does not currently support feed authentication, the feed needs to be configured to allow read access to anyone.

### Publishing to a file share ###
To restrict access of your extension to your organization or to a limited group of people, you can use an SMB file share as an extension feed. In this case, the file share and folder permissions will be applied for allowing access to the feed.

## Preparing to publish your extension ##
Here's a list of things you should prepare if you are planning on publishing to the Windows Admin Center extension feed. You may want to consider some of these even if you are publishing to your own feed or a file share.

### Extension development policies and guidelines ###
[TODO]

### Submit an extension review request to Microsoft ###
Since the Windows Admin Center extensions platform is still in preview, we want to work closely with extension developers to help on development issues and help make sure you are delivering a quality product and experience to users. 

Before releasing the initial version of your extension, we recommend that you submit an extension review request to Microsoft at least one month before release to ensure we have sufficient time to review and for you to make any changes to your extension if necessary. You will also need to submit a request for releasing updates to your extension. While depending on the scope of change, the turnaround time for update reviews should generally be shorter.

Once the extension review is complete and your extension is approved, we will publish your extension to the Windows Admin Center feed.

To submit an extension review request, enter the following information and send as an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Review%20Request). We will reply to your email within a week.

```
Windows Admin Center Extension Review Request
1. Name and email address of extension owner/developer (up to 3 users). If you will be releasing an extension on behalf of your company, provide your company email address.
2. Company name (Only required if you are releasing an extension on behalf of your company):
3. Extension name:
4. Release target date (estimate):
5. For new extension submission - Extension description (early design wireframes, screen mockups or product screenshots are highly recommended):
6. For extension update review – Description of changes (please include product screenshots if UI has been significantly changed):
```

### Consider releasing as a Preview release ###
If you are releasing a preview version of your extension for evaluation purposes, we recommend that you:
- Append "(Preview)" to the end of your extension's title in the .nuspec file
- Explain the limitations in your extension's description in the .nuspec file
- Add the Preview badge UI in your extension 
- [TODO] Add link to Preview badge UI example

### Prepare a project website and end user license agreement ###
We recommend that you have a project website including the following:
- Detailed description of your extension including screenshots or video
- Email address or website feature to receive feedback or questions

You may also want to include an end user license agreement (EULA) for your extension. Make sure that there are no conflicting terms with the Windows Admin Center SDK EULA. You can provide a URL to your EULA in the .nuspec file as described below. 
[TODO] Add link to SDK EULA

## Preparing your extension for publishing ##
You may want to send us your extension under development to expedite the review process, and you will need to send us your final extension package for us to approve and publish to the Windows Admin Center feed. Here are the steps for preparing your extension package for review.

### 1. Build your extension ###
Run "gulp build" and make sure the build is successful.

### 2. Create the .nuspec file ###
To create the NuGet package, you need to first create a .nuspec file. A .nuspec file is an XML manifest that contains NuGet package metadata. This manifest is used both to build the package and to provide information to consumers.
	
Here's an example .nuspec file and the list of required or recommended properties. For the full schema, see the [.nuspec reference] (https://docs.microsoft.com/en-us/nuget/reference/nuspec). Save the .nuspec file to your project's root folder with a file name of your choice.

```xml
<?xml version="1.0"?>
<package>
    <metadata>
    <packageTypes>
        <packageType name="WindowsAdminCenterExtension" />
    </packageTypes>
    <id>msft.sme.hello-extension</id>
    <title>Microsoft Hello Extension</title>
    <version>1.0.0</version>
    <authors>Microsoft</authors>
    <description>Developer tools for the Honolulu platform.</description>
    <iconUrl>https://winadmincenterassets.blob.core.windows.net/extensionassets/ms-logo.png</iconUrl>
    <projectUrl>https://msft-sme.myget.org/feed/sme-public-feed/package/nuget/msft.sme.hello-extension</projectUrl>
    <licenseUrl>https://technet.microsoft.com/en-us/library/cc976720.aspx</licenseUrl>
    <copyright>(c) Microsoft Corporation. All rights reserved.</copyright> 
    </metadata>
    <files>
    <file src="bundle\**\*.*" target="ux" />
    </files>
</package>
```

#### Required or Recommended Properties ####
| Property Name | Required / Recommended | Description |
| ---- | ---- | ---- |
| packageType | Required | Use "WindowsAdminCenterExtension" which is the NuGet package type defined for Windows Admin Center extensions. |
| id | Required | Package identifier that is unique within the feed. See [Choosing a unique package identifier](https://docs.microsoft.com/en-us/nuget/create-packages/creating-a-package#choosing-a-unique-package-identifier-and-setting-the-version-number) for guidance. |
| title | Required for publishing to the Windows Admin Center feed | Friendly name for the package that is displayed in Windows Admin Center Extension Manager. |
| version | Required | Extension version. Using [Semantic Versioning (SemVer convention)](http://semver.org/spec/v1.0.0.html) is recommended but not required. |
| authors | Required | If publishing on behalf of your company, use your company name. |
| description | Required | Provide a description of the extension's functionality. |
| iconUrl | Recommended when publishing to the Windows Admin Center feed | URL for icon to display in the Extension Manager. |
| projectUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's website. If you do not have a separate website, use the URL for the package webpage on the NuGet feed. |
| licenseUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's end user license agreement. |

### 3. Build the extension NuGet package ###
Using the .nuspec file you created above, you will now create the NuGet package .nupkg file which you can upload and publish to the NuGet feed.
1. Download the nuget.exe CLI tool from the [NuGet client tools website](https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools).
2. Run "nuget.exe pack [.nuspec file name]" to create the .nupkg file.

### 4. Signing your extension NuGet package ###
Any .dll files included in your extension are required to be signed with a certificate from a trusted Certificate Authority (CA). By default, unsigned .dll files will be blocked from being executed. 

We also highly recommend that you sign the extension NuGet package to ensure the integrity of the package. While Windows Admin Center currently does not verify the package signing, we plan to implement this in the future.

### 5. Test your extension NuGet package ###
Test your package on a file share or test feed before publishing, and make sure the properties are displayed correctly in Extension Manager and you can successfully install and uninstall your extension.




