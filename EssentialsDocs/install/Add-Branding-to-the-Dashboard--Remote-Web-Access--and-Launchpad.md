---
title: "Add Branding to the Dashboard, Remote Web Access, and Launchpad"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 04/10/2014
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 166262f8-b2a5-4b1c-a4a7-a141e1c54f10
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Branding to the Dashboard, Remote Web Access, and Launchpad

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_Branding"></a> Add Branding to the Dashboard, Remote Web Access, and Launchpad  
 You can make many branding additions by adding entries in the registry. All branding entries in the registry for the operating system are located under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\OEM.  
  
 All co-branding must meet the following logo requirements:  
  
-   The  Windows Server Essentials logo must have a minimum width of **170 pixels**, keeping the correct aspect ratio, with **96 DPI**.  
  
#### To add branding by changing the registry  
  
1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
2.  In the Search box, type **regedit**, and then click the **Regedit** application.  
  
3.  In the navigation pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**. If the **OEM** key does not exist, complete the following steps to create it:  
  
    1.  Right-click **Windows Server**, click **New**, and then click **Key**.  
  
    2.  Type **OEM** for the name of the key.  
  
4.  (Optional) If you are creating an entry for a logo, you can create different keys to differentiate the language versions of the logo. For example, if you have both English and German versions of a logo, you can create an en-us key and a de-de key. Because all of the logo files are stored in the same folder, you must provide instances of the logo image file with a unique name for each language. For example, you would create a file called DashboardLogo_en.png and DashboardLogo_de.png.  
  
5.  Either right-click **OEM** or right-click the appropriate language key, click to **New**, and then click **String Value**.  
  

6.  Enter the name of the string, and then press ENTER. Refer to the [Registry strings and values](Add-Branding-to-the-Dashboard--Remote-Web-Access--and-Launchpad.md#BKMK_RegStrings) table for the string names and data values.  

6.  Enter the name of the string, and then press ENTER. Refer to the [Registry strings and values](../install/Add-Branding-to-the-Dashboard--Remote-Web-Access--and-Launchpad.md#BKMK_RegStrings) table for the string names and data values.  

  
7.  Right-click the new string, and then click **Modify**.  
  
8.  Enter the value from the table that is associated with the string name, and then click **OK**.  
  
9. If you are creating an entry for a logo image or appended links, copy the file to %programFiles%\Windows Server\Bin\OEM. If the OEM directory does not exist, create it.  
  
10. If changes are made that affect Remote Web Access, after the customer takes possession of the server, they must turn on Remote Web Access. Advise the customer to do the following:  
  
    1.  On the Dashboard, click **Settings**, and then click the **Anywhere Access** tab.  
  
    2.  If Anywhere Access is turned on, click **Configure**, and then clear Remote Web Access checkbox on the **Choose Anywhere Access features to enable** page of the Set up Anywhere Access wizard.  
  
    3.  Click **Configure**.  
  
###  <a name="BKMK_RegStrings"></a> The following table lists the location where registry changes affect branding, the string name, and the data value.  
  
### Registry strings and values  
  
|Location of branding|Description|String name|Data value|  
|--------------------------|-----------------|-----------------|----------------|  
|Dashboard logo|Adds the logo image to the Dashboard. The Dashboard logo must be in .png format and must not be larger than 350 pixels wide by 38 pixels high.<br /><br /> **Important:** To cobrand the Dashboard with your logo, you must edit the artwork tile that is provided on the OPK DVD and append your company logo to the image while following the appropriate white space requirements. For additional information see the example tile that is provided.|DashboardLogo|Name of the logo image file|  
|DashboardClientLogo|Adds the logo image to the Dashboard client login screen.|DashboardClientLogo|Name of the logo image file|  
|Website background picture|Changes the background image that is displayed on the Remote Web Access logon page. Typical resolutions will appear as follows:<br /><br /> - 1024x768 pixel resolution will precisely fill the logon page<br /><br /> - 800x600 pixel resolution will be centered on the page and appear with a black border<br /><br /> - 1280x720 pixel resolution will be centered and the pixels that exceed 1024x768 will not appear|LogonBackground|Name of background image file|  
|Website title|Replaces the title of the Remote Web Access site from  Windows Server Essentials to a title that you choose.|WebsiteName|New Remote Web Access site title|  
|Website logo|Changes the default logo on the Remote Web Access site. The expected size of the logo is 32 pixels by 32 pixels. If your logo is smaller or larger than this, it will be stretched or made reduced to match these dimensions|WebsiteLogo|Name of the logo image file|  
|Appended Website logo|Your partner logo will display just below the Microsoft logo that is displayed on the Remote Web Access site. The expected size of the logo is 200 pixels high by 50 pixels wide. If your logo is larger than this, it will be made smaller to fit while maintaining the original aspect ratio. If your logo is smaller than this, it will be centered within the 200 by 50 pixel space and neither the size nor aspect ratio will be changed.|OEMLogo|Name of the logo image file|  

|Links on the Website home page and logon page|Append links to the logon page and home page of the Remote Web Access site. The .xml that contains the link information must be located in %programFiles%\Windows Server\Bin\OEM. The following example shows the format of the .xml file:<br /><br /> <OemLinks\><br /> <LogonLinks\><br /> <Link Name\=LogonLinkName><br /> <Text\>LogonLinkDescription</Text\><br /> <Url\>LogonLinkURL</Url\><br /> <Icon\>LinkIcon</Icon\><br /> </Link\><br /> </LogonLinks\><br /> <HomepageLinks\><br /> <Link Name\=HomepageLinkName><br /> <Text\>HomepageLinkDescription</Text\><br /> <Url\>HomepageLinkURL</Url\><br /> </Link\><br /> </HomepageLinks\><br /> </OemLinks\>|LinksXML|Refer to the [LinksXML elements](Add-Branding-to-the-Dashboard--Remote-Web-Access--and-Launchpad.md#BKMK_Links) table for a list of the elements and descriptions.|  

|Links on the Website home page and logon page|Append links to the logon page and home page of the Remote Web Access site. The .xml that contains the link information must be located in %programFiles%\Windows Server\Bin\OEM. The following example shows the format of the .xml file:<br /><br /> <OemLinks\><br /> <LogonLinks\><br /> <Link Name\=LogonLinkName><br /> <Text\>LogonLinkDescription</Text\><br /> <Url\>LogonLinkURL</Url\><br /> <Icon\>LinkIcon</Icon\><br /> </Link\><br /> </LogonLinks\><br /> <HomepageLinks\><br /> <Link Name\=HomepageLinkName><br /> <Text\>HomepageLinkDescription</Text\><br /> <Url\>HomepageLinkURL</Url\><br /> </Link\><br /> </HomepageLinks\><br /> </OemLinks\>|LinksXML|Refer to the [LinksXML elements](../install/Add-Branding-to-the-Dashboard--Remote-Web-Access--and-Launchpad.md#BKMK_Links) table for a list of the elements and descriptions.|  

|Launchpad logo|Adds the logo image to the Launchpad. The Launchpad logo must be in .png format and must not taller than 64 pixels.|LaunchpadLogo|Name of the logo image file|  
  
###  <a name="BKMK_Links"></a> The following table lists and describes the LinksXML string name elements.  
  
### LinksXML elements  
  
|LinksXML element|Description|  
|----------------------|-----------------|  
|**LogonLinks**|  
|LogonLinkName|The logon link name.|  
|LogonLinkDescription|The text that is displayed as the logon page link.|  
|LogonLinkURL|The url that resolves to the logon page link.|  
|LinkIcon|The name of the icon file for the logon link. This file should be in the same folder location as the .xml file. Link icon images should be 16x16 pixels and should be .png format. If you do not provide a LinkIcon, the default link icon image is used.|  
|**HomepageLinks**|  
|HomepageLinkName|The homepage link name.|  
|HomepageLinkDescription|The text that appears as the homepage link.|  
|HomepageLinkURL|The URL that resolves to the homepage link.|  
|HomepageLinkIcon|The name of the icon file for the homepage link. This file should be in the same folder location as the .xml file. HomepageLinkIcon images should be 16x16 pixels and should be .png format. If you do not provide a HomepageLinkIcon, the default home page link icon image is used.|  
  
## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

