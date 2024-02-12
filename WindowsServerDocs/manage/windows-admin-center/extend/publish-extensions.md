---
title: Publishing extensions for Windows Admin Center
description: Publishing extensions for Windows Admin Center (Project Honolulu)
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 04/01/2023
---
# Publishing Extensions

Applies to: Windows Admin Center, Windows Admin Center Preview

After you've developed your extension, you'll want to publish it and make it available to others to test or use. In this article, we introduce a few publishing options along with the steps and requirements depending on your audience and purpose of publishing.

## Publishing Options

There are three primary options for configurable package sources that Windows Admin Center supports:

- Microsoft public Windows Admin Center NuGet feed
- Your own private NuGet feed
- Local or network file share

### Publishing to the Windows Admin Center extension feed

By default, Windows Admin Center is connected to a NuGet feed maintained by the Windows Admin Center product team at Microsoft. Early preview versions of new extensions developed by Microsoft can be published to this feed and made available to Windows Admin Center users. External developers planning to build and release extensions publicly can also submit a request to [Publish your extension to the Windows Admin Center feed](#publish-your-extension-to-the-windows-admin-center-feed). Prior to publishing to this feed, external developers have to agree to Windows Admin Center's [Extension Publisher Agreement](/legal/windows-server/windows-admin-center/extensions-publishers-agreement) and [Extension Participation Policy](/legal/windows-server/windows-admin-center/extensions-participation-policy).

### Publishing to a different NuGet feed

You can also create your own NuGet feed to publish your extensions to using one of the many [different options for setting up a private source or using a NuGet hosting service](/nuget/hosting-packages/overview). The NuGet feed must support the NuGet v2 API. Because Windows Admin Center doesn't currently support feed authentication, the feed needs to be configured to allow read access to anyone.

### Publishing to a file share

To restrict access of your extension to your organization or to a limited group of people, you can use an SMB file share as an extension feed. When using a file share to host your extension feed, file and folder permissions are applied to manage access to the feed.

## Preparing your extension for release

Make sure you read and consider the following development articles:

- [Control your tool's visibility](guides/dynamic-tool-display.md)
- [Strings and localization](guides/strings-localization.md)

### Consider releasing as a Preview release

If you're releasing a preview version of your extension for evaluation purposes, we recommend that you:

- Append "(Preview)" to the end of your extension's title in the `.nuspec` file
- Explain the limitations in your extension's description in the `.nuspec` file

## Creating an extension package

Windows Admin Center utilizes NuGet packages and feeds for distributing and downloading extensions. For your package to be shipped, you need to generate a NuGet package containing your plugins and extensions. A single package can contain a UI extension and a Gateway plugin. The following section walks you through the process.

### Build your extension

As soon as you're ready to start packaging your extension, create a new directory on your file system, open a console, and then CD into it. This directory is the root directory that we use to contain all the nuspec and content directories that make up our package. We call this folder _NuGet Package_ for the rest of this article.

#### UI Extensions

To begin the process on gathering all the content needed for a UI extension, run "gulp build" on your tool and make sure the build is successful. This process packages all the components together in a folder called "bundle" located in the root directory of your extension (at the same level of the src directory). Copy this directory and all its contents into the "NuGet Package" folder.

#### Gateway Plugins

Using your build infrastructure (which could be as simple as opening Visual Studio and selecting the Build button), compile and build your plugin. Open up your build output directory, copy the DLL or DLLs that represent your plugin and put them in a new folder inside the "NuGet Package" directory called "package". You don't need to copy the FeatureInterface DLL, only the DLL or DLLs that represent your code.

### Create the nuspec file

To create the NuGet package, you need to first create a `.nuspec` file. A `.nuspec` file is an XML manifest that contains NuGet package metadata. This manifest is used both to build the package and to provide information to consumers. Place this file at the root of the "NuGet Package" folder.

Here's an example `.nuspec` file and the list of required or recommended properties. For the full schema, see the [nuspec reference](/nuget/reference/nuspec). Save the `.nuspec` file to your project's root folder using a file name of your choice.

> [!IMPORTANT]
> The `<id>` value in the `.nuspec` file needs to match the `"name"` value in your project's `manifest.json` file, or else your published extension won't load successfully in Windows Admin Center.

```xml
<?xml version="1.0">
<package>
  <metadata>
    <id>contoso.project.extension</id>
    <version>1.0.0</version>
    <title>Contoso Hello Extension</title>
    <authors>Contoso</authors>
    <owners>Contoso</owners>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <projectUrl>https://msft-sme.myget.org/feed/windows-admin-center-feed/package/nuget/contoso.sme.hello-extension</projectUrl>
    <licenseUrl>http://YourLicenseLink</licenseUrl>
    <iconUrl>http://YourLogoLink</iconUrl>
    <description>Hello World extension by Contoso</description>
    <copyright>(c) Contoso. All rights reserved.</copyright>
    <tags></tags>
  </metadata>
  <files>
    <file src="bundle\**\*.*" target="ux" />
    <file src="package\**\*.*" target="gateway" />
  </files>
</package>
```

#### Required or Recommended Properties

| Property Name | Required / Recommended | Description |
| ---- | ---- | ---- |
| packageType | Required | Use `WindowsAdminCenterExtension`, which is the NuGet package type defined for Windows Admin Center extensions. |
| ID | Required | Unique Package identifier within the feed. This value needs to match the "name" value in your project's manifest.json file.  See [Choosing a unique package identifier](/nuget/create-packages/creating-a-package#choosing-a-unique-package-identifier-and-setting-the-version-number) for guidance. |
| title | Required for publishing to the Windows Admin Center feed | Friendly name for the package that's displayed in Windows Admin Center Extension Manager. |
| version | Required | Extension version. Using [Semantic Versioning (SemVer convention)](http://semver.org/spec/v1.0.0.html) is recommended but not required. |
| authors | Required | If publishing on behalf of your company, use your company name. |
| description | Required | Provide a description of the extension's functionality. |
| iconUrl | Recommended when publishing to the Windows Admin Center feed | URL for icon to display in the Extension Manager. |
| projectUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's website. If you don't have a separate website, use the URL for the package webpage on the NuGet feed. |
| licenseUrl | Required for publishing to the Windows Admin Center feed | URL to your extension's end user license agreement. |
| files | Required | These two settings set up the folder structure that Windows Admin Center expects for UI extensions and Gateway plugins. |

### Build the extension NuGet package

Using the `.nuspec` file you created, you now need to create the NuGet package `.nupkg` file, which you can upload and publish to the NuGet feed.

1. Download the nuget.exe CLI tool from the [NuGet client tools website](/nuget/install-nuget-client-tools).
1. Run `nuget.exe pack <>.nuspec file name>` to create the `.nupkg` file.

### Sign your extension NuGet package

Any `.dll` files included in your extension are required to be signed with a certificate from a trusted Certificate Authority (CA). By default, unsigned `.dll` files are blocked from being executed when Windows Admin Center is running in Production Mode.

We recommend that you sign the extension NuGet package to ensure the integrity of the package.

> [!NOTE]
> If you plan on your extension supporting [Windows Defender Application Control](../extend/guides/application-control-infrastructure-extensions.md), your package and all files within must be signed. [Learn more about signing with Windows Defender Application Control.](/windows/security/application-security/application-control/windows-defender-application-control/deployment/use-code-signing-for-better-control-and-protection) 

### Test your extension NuGet package

Your extension package is now ready for testing! Upload the `.nupkg` file to a NuGet feed or copy it to a file share. To view and download packages from a different feed or file share, you need to [change your feed configuration](../configure/using-extensions.md#installing-extensions-from-a-different-feed) to point to your NuGet feed or file share. When testing, make sure the properties are displayed correctly in Extension Manager, and you can successfully install and uninstall your extension.

## Publish your extension to the Windows Admin Center feed

By publishing to the Windows Admin Center feed, you can make your extension available to any Windows Admin Center user. Because the Windows Admin Center SDK is still in preview, we'd like to work closely with you to help resolve development issues and help you deliver a quality product and experience to your users.

Prior to submitting an extension review request to Microsoft, you must send an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Review%20Request) expressing the intent to publish an extension to the public feed. We provide you with copies of the Extension Publisher Agreement and the Extension Participation Policy to review and acknowledge in writing.

Before releasing the initial version of your extension, we recommend that you submit an extension review request to Microsoft at least 2-3 weeks before release. Allowing 2-3 weeks before release ensures we have sufficient time to review and for you to make any changes to your extension if necessary. After your extension is ready to be published, you'll need to send it to us for review. If your extension is approved, we publish it to the feed for you. By sending Microsoft your extension package, you agree to be bound by the terms of the Extension Publisher Agreement and the Extension Participation Policy.

Afterwards, if you want to release an update to your extension, you need to submit another request for review. Depending on the scope of change, turnaround times for update reviews are generally shorter.

### Submit an extension review request to Microsoft

To submit an extension review request, provide the following information and send as an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Review%20Request). We reply to your email within a week.

Windows Admin Center - Extension review request information:

- Name and email address of extension owner/developer (up to 3 users). If you're releasing an extension on behalf of your company, provide your company email address.
- Company name (Only required if you're releasing an extension on behalf of your company)
- Extension name
- Release target date (estimate)
- For new extension submission - Extension description (early design wire frames, screen mockups, or product screenshots recommended)
- For extension update review – Description of changes (include product screenshots if UI significantly changed)

### Submit your extension package for review and publishing

Make sure you follow the preceding instructions for [creating an extension package](#creating-an-extension-package) and the `.nuspec` file is defined properly and files are signed. We also recommend that you have a project website including:

- Detailed description of your extension including screenshots or video
- Email address or website feature to receive feedback or questions

When you're ready to publish your extension, send email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Package%20Review). We provide instructions on how to send us your extension package. After we receive your package, we'll review it. After your extension package is approved, we'll publish to the Windows Admin Center feed.
