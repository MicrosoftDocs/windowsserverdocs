---
title: Publishing Extensions for Windows Admin Center
description: Publishing Extensions for Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: daniellee-msft
ms.author: jol
ms.date: 05/02/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---
# Publishing Extensions

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Once you've developed your extension, you will want to publish it and make it available to others to test or use. Depending on your audience and purpose of publishing, there are a few different options for publishing which we'll introduce below along with the steps and requirements for publishing.

## Deciding where to publish to

### Publishing to the Windows Admin Center extension feed

By default, Windows Admin Center is connected to a NuGet feed maintained by the Windows Admin Center product team at Microsoft. Early preview versions of new extensions developed by Microsoft may be published to this feed and available to Windows Admin Center users. External developers planning to build and release extensions publicly may also [submit a request](#publishing-your-extension-to-the-windows-admin-center-feed) to publish to this feed.

### Publishing to a different NuGet feed

You may also create your own NuGet feed to publish your extensions to using one of the many [different options for setting up a private source or using a NuGet hosting service](https://docs.microsoft.com/en-us/nuget/hosting-packages/overview). The NuGet feed must support the NuGet v2 API. Since Windows Admin Center does not currently support feed authentication, the feed needs to be configured to allow read access to anyone.

### Publishing to a file share

To restrict access of your extension to your organization or to a limited group of people, you can use an SMB file share as an extension feed. In this case, the file share and folder permissions will be applied for allowing access to the feed.

## Preparing your extension for release

Make sure you read and consider the following development topics:

- [Control your tool's visibility](guides/dynamic-tool-display.md)
- [Strings and localization](guides/strings-localization.md)

### Consider releasing as a Preview release

If you are releasing a preview version of your extension for evaluation purposes, we recommend that you:

- Append "(Preview)" to the end of your extension's title in the .nuspec file
- Explain the limitations in your extension's description in the .nuspec file

## Creating an extension package

To make your extension available on a NuGet feed or file share for others to download and install, you need to create a NuGet package.

### 1. Build your extension

Run "gulp build" and make sure the build is successful.

### 2. Create the .nuspec file

To create the NuGet package, you need to first create a .nuspec file. A .nuspec file is an XML manifest that contains NuGet package metadata. This manifest is used both to build the package and to provide information to consumers.

Here's an example .nuspec file and the list of required or recommended properties. For the full schema, see the [.nuspec reference] (https://docs.microsoft.com/en-us/nuget/reference/nuspec). Save the .nuspec file to your project's root folder with a file name of your choice.

```xml
<?xml version="1.0"?>
<package>
    <metadata>
    <packageTypes>
        <packageType name="WindowsAdminCenterExtension" />
    </packageTypes>
    <id>contoso.sme.hello-extension</id>
    <title>Contoso Hello Extension</title>
    <version>1.0.0</version>
    <authors>Contoso</authors>
    <description>Hello World extension by Contoso</description>
    <iconUrl>http://YourLogoLink</iconUrl>
    <projectUrl>https://msft-sme.myget.org/feed/windows-admin-center-feed/package/nuget/contoso.sme.hello-extension</projectUrl>
    <licenseUrl>http://YourLicenseLink</licenseUrl>
    <copyright>(c) Contoso. All rights reserved.</copyright> 
    </metadata>
</package>
```

#### Required or Recommended Properties

| Property Name | Required / Recommended | Description |
| ---- | ---- | ---- |
| packageType | Required | Use "WindowsAdminCenterExtension" which is the NuGet package type defined for Windows Admin Center extensions. |
| id | Required | Unique Package identifier within the feed. See [Choosing a unique package identifier](https://docs.microsoft.com/en-us/nuget/create-packages/creating-a-package#choosing-a-unique-package-identifier-and-setting-the-version-number) for guidance. |
| title | Required for publishing to the Windows Admin Center feed | Friendly name for the package that is displayed in Windows Admin Center Extension Manager. |
| version | Required | Extension version. Using [Semantic Versioning (SemVer convention)](http://semver.org/spec/v1.0.0.html) is recommended but not required. |
| authors | Required | If publishing on behalf of your company, use your company name. |
| description | Required | Provide a description of the extension's functionality. |
| iconUrl | Recommended when publishing to the Windows Admin Center feed | URL for icon to display in the Extension Manager. |
| projectUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's website. If you do not have a separate website, use the URL for the package webpage on the NuGet feed. |
| licenseUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's end user license agreement. |

### 3. Build the extension NuGet package

Using the .nuspec file you created above, you will now create the NuGet package .nupkg file which you can upload and publish to the NuGet feed.

1. Download the nuget.exe CLI tool from the [NuGet client tools website](https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools).
2. Run "nuget.exe pack [.nuspec file name]" to create the .nupkg file.

### 4. Signing your extension NuGet package

Any .dll files included in your extension are required to be signed with a certificate from a trusted Certificate Authority (CA). By default, unsigned .dll files will be blocked from being executed.

We also highly recommend that you sign the extension NuGet package to ensure the integrity of the package. While Windows Admin Center currently does not verify the package signing, we plan to implement this in the future.

### 5. Test your extension NuGet package

Your extension package is now ready for testing! Upload the .nupkg file to a NuGet feed or copy it to a file share. To view and download packages from a different feed or file share, you'll need to [change your feed configuration](../configure/using-extensions.md#installing-extensions-from-a-different-feed) to point to your NuGet feed or file share. When testing, make sure the properties are displayed correctly in Extension Manager and you can successfully install and uninstall your extension.

## Publishing your extension to the Windows Admin Center feed

By publishing to the Windows Admin Center feed, you can make your extension available to any Windows Admin Center user. Since the Windows Admin Center SDK is still in preview, we’d like to work closely with you to help resolve development issues, and, make sure you are able to deliver a quality product and experience to your users.

Before releasing the initial version of your extension, we recommend that you submit an extension review request to Microsoft at least 2-3 weeks before release to ensure we have sufficient time to review and for you to make any changes to your extension if necessary. Once your extension is ready to be published, you'll need to send it to us for review, and if approved, we'll publish it to the feed for you.

Afterwards, if you want to release an update to your extension, you will need to submit another request for review. While depending on the scope of change, the turnaround time for update reviews should generally be shorter.

### Submit an extension review request to Microsoft

To submit an extension review request, enter the following information and send as an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Review%20Request). We will reply to your email within a week.

```
Windows Admin Center Extension Review Request
1. Name and email address of extension owner/developer (up to 3 users). If you will be releasing an extension on behalf of your company, provide your company email address.
2. Company name (Only required if you are releasing an extension on behalf of your company):
3. Extension name:
4. Release target date (estimate):
5. For new extension submission - Extension description (early design wire frames, screen mockups or product screenshots are highly recommended):
6. For extension update review – Description of changes (include product screenshots if UI has been significantly changed):
```

### Submit your extension package for review and publishing

Make sure you follow the instructions above for [creating an extension package](#creating-an-extension-package) and the .nuspec file is defined properly and files are signed. We also recommend that you have a project website including the following:

- Detailed description of your extension including screenshots or video
- Email address or website feature to receive feedback or questions

When you are ready to publish your extension, send an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Package%20Review) and we will provide instructions on how to send us your extension package. Once we receive your package, we will review and if approved, publish to the Windows Admin Center feed.