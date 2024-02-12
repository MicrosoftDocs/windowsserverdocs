---
title: Add branding to the Dashboard, Remote Web Access, and Launchpad
description: How to add branding materials to your Dashboard, Remote Web Access, and Launchpad screens.
ms.date: 04/10/2014
ms.topic: article
ms.assetid: 166262f8-b2a5-4b1c-a4a7-a141e1c54f10
author: nnamuhcs
ms.author: wscontent
manager: mtillman
---

# Add Branding to the Dashboard, Remote Web Access, and Launchpad

> Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can make many branding additions by adding entries in the registry. All branding entries in the registry for the operating system are located under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\OEM`.

For co-branding purposes, the  Windows Server Essentials logo must have a minimum width of **170 pixels**, keeping the correct aspect ratio, with **96 DPI**.

## To add branding by changing the registry

1. On the server, move your mouse to the upper right corner of the screen, and click **Search**.

2. In the Search box, type **regedit**, and then click the **Regedit** application.

3. In the navigation pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**. If the **OEM** key doesn't exist, you can create it:

    1. Right-click **Windows Server**, click **New**, and then click **Key**.

    2. Type **OEM** for the name of the key.

4. (Optional) If you're creating an entry for a logo, you can create different keys to differentiate the language versions of the logo. For example, if you have both English and German versions of a logo, you can create an en-us key and a de-de key. Because all of the logo files are stored in the same folder, you must provide instances of the logo image file with a unique name for each language. For example, you would create a file called DashboardLogo_en.png and DashboardLogo_de.png.

5. Either right-click **OEM** or right-click the appropriate language key, click **New**, and then click **String Value**.

6. Enter the name of the string, and then press ENTER. For more info about the string names and data values, see the **Registry strings and values** section of this article.

7. Enter the name of the string, and then press ENTER. For more info about the string names and data values, see the **Registry strings and values** section of this article.

8. Right-click the new string, and then click **Modify**.

9. Enter the value from the table that is associated with the string name, and then click **OK**.

10. If you are creating an entry for a logo image or appended links, copy the file to `%programFiles%\Windows Server\Bin\OEM`. If the OEM directory does not exist, create it.

11. If you make changes to Remote Web Access after the customer takes possession of the server, they must turn on Remote Web Access by:

    1. On the Dashboard, click **Settings**, and then click the **Anywhere Access** tab.

    2. If **Anywhere Access** is turned on, click **Configure**, and then clear Remote Web Access checkbox on the **Choose Anywhere Access features to enable** page of the **Set up Anywhere Access** wizard.

    3. Click **Configure**.

### Registry strings and values

The following table provides information about the available string names and data values.

| Branding location | Description | String name | Data value |
|--|--|--|--|
| Dashboard logo | Adds the logo image to the Dashboard. The Dashboard logo must be in .png format and must not be larger than 350 pixels wide by 38 pixels high.<p>**Important:** To co-brand the Dashboard with your logo, you must edit the artwork tile that's provided on the OPK DVD and append your company logo to the image while following the appropriate white space requirements. | DashboardLogo | Enter the name of the logo image file. |
| DashboardClientLogo | Adds the logo image to the Dashboard client sign in screen. | DashboardClientLogo | Enter the name of the logo image file. |
| Website background picture | Changes the background image displayed on the Remote Web Access sign in page. Typical resolutions will appear as follows:<ul><li>**1024x768 pixels** - This resolution precisely fills the sign in page.</li><li>**800x600 pixels** - This resolution centers the image on the page and appears with a black border.</li><li>**1280x720 pixels** - This resolution centers the image. Any pixels that exceed 1024x720 won't appear. | LogonBackground | Enter the name of background image file. |
| Website title | Replaces the title of the Remote Web Access site from  Windows Server Essentials to your specified title. | WebsiteName | Enter the new Remote Web Access site title. |
| Website logo | Changes the default logo on the Remote Web Access site. The expected size of the logo is 32 pixels by 32 pixels. If your logo is smaller or larger than this, it will be stretched or reduced to match these dimensions. | WebsiteLogo | Enter the name of the logo image file |
| Appended Website logo | Your partner logo will display just below the Microsoft logo that appears on the Remote Web Access site. The expected size of the logo is 200 pixels high by 50 pixels wide. If your logo is larger than this, it will be made smaller to fit while maintaining the original aspect ratio. If your logo is smaller than this, it will be centered within the 200 by 50 pixel space and neither the size nor aspect ratio will be changed. | OEMLogo | Enter the name of the logo image file. |
| Links on the website Home page and sign in page | Appends links to the sign in page and home page of the Remote Web Access site. The XML file that contains the link information must be located in `%programFiles%\Windows Server\Bin\OEM` folder. | LinksXML | Refer to the LinksXML elements table for a list of the elements and descriptions. |
| Launchpad logo | Adds the logo image to the Launchpad. The Launchpad logo must be in .png format and must not taller than 64 pixels. | LaunchpadLogo | Enter the name of the logo image file. |

#### XML linking format

You must format the links on the website **Home** page and the sign in page as:

```xml
<OemLinks>
    <LogonLinks>
        <Link Name=LogonLinkName>
        <Text>LogonLinkDescription</Text>
        <Url>LogonLinkURL</Url>
        <Icon>LinkIcon</Icon>
        </Link>
    </LogonLinks>

    <HomepageLinks>
        <Link Name=HomepageLinkName>
        <Text>HomepageLinkDescription</Text>
        <Url>HomepageLinkURL</Url>
        <Icon>HomepageLinkIcon</Icon>
        </Link>
    </HomepageLinks>
</OemLinks>
```

### LinksXML elements

| LinksXML element | Description |
|--|--|
| LogonLinks | The parent entry for sign in links. |
| Link Name | The sign in link name. |
| Text | The text displayed as the sign in page link. |
| URL | The URL that resolves to the sign in page link. |
| Icon | The name of the icon file for the sign in link. This file should be in the same folder location as the .xml file. Icon images should be 16x16 pixels and in .png format. If you don't provide an icon, the default link icon image is used. |
| HomepageLinks | The parent entry for the **Home** page. |
| Link Name | The **Home** page link name. |
| Text | The text that appears as the **Home** page link. |
| URL | The URL that resolves to the **Home** page link. |
| Icon | The name of the icon file for the **Home** page link. This file should be in the same folder location as the .xml file. Icon images should be 16x16 pixels and in .png format. If you don't provide an icon, the default **Home** page link icon image is used. |

## Additional references

- [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)

- [Additional Customizations](Additional-Customizations.md)

- [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)

- [Testing the Customer Experience](Testing-the-Customer-Experience.md)