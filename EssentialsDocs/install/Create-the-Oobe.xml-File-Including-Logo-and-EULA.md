---
title: "Create the Oobe.xml File Including Logo and EULA"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8a7b3cc1-21bb-4344-8110-f5d5959b370d
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create the Oobe.xml File Including Logo and EULA

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add your own End User License Agreement (EULA) to Initial Configuration by using the Oobe.xml file. The Oobe.xml is a file used to provide text and images for Initial Configuration, Windows Welcome, and other pages presented to the end user. You can add multiple Oobe.xml files to customize the content based on the language and country or region selections of the end user. For more information, see the [Windows Assessment and Deployment Kit for Windows 8](https://go.microsoft.com/fwlink/?LinkId=248694) documentation.  
  
 The EULA for your company is displayed in addition to the Microsoft EULA. The Microsoft EULA will be the first EULA displayed during the initial configuration end user experience, and then your EULA will be displayed. Your EULA can be placed anywhere on the server and you specify the location in the Oobe.xml file.  
  
#### To add your company EULA and logo  
  
1. Open the Oobe.xml file in a text editor, such as Notepad.  
  
2. Within the <logopath\></logopath\> tags, enter the absolute path to your logo file. This file should contain a 32-bit portable network graphics (.png) file that is 240x 100 pixels.  
  
3. Within the <eulafilename\></eulafilename\> tags, enter the absolute path to the EULA file. The EULA file must be a rich-text format (.rtf) file.  
  
4. Within the <name\></name\> tags, enter your company name.  
  
    The following example shows the tags in an Oobe.xml file:  
  
   ```  
  
   <FirstExperience>  
      <oobe>  
         <oem>  
            <name>Fabrikam</name>  
            <logopath>c:\fabrikam\fabrikam.png</logopath>  
            <eulafilename>c:\fabrikam\fabrikam_eula.rtf</eulafilename>  
         </oem>  
      </oobe>  
   </FirstExperience>  
  
   ```  
  
5. Save the file.  
  
6. Place the Oobe.xml file in one of the following locations:  
  
   |Oobe.xml Location|Condition for determining location|  
   |-----------------------|----------------------------------------|  
   |%windir%\system32\oobe\info\|The server is shipping in a single country/region and a single language system.|  
   |%windir%\system32\oobe\info\default\\<language\>|The server is shipping in a single country/region and multiple languages system.|  
   |%windir%\system32\oobe\info\\<country/region>\ and %windir%\system32\oobe\info\\<country/region>\\<language\>\|The server is shipping to more than one country/region and the settings require customizations on a per-country/region basis, each with a single language. Where <country/region> is the decimal version of the geographical location identifier (GeoID) of the country or region where the server is being deployed, and <language\> is the decimal version of the locale identifier (LCID).|  
  
   If you have an alternative company logo with white text, it may display better in the setup flow due to the blue background.  You can optionally specify this logo by setting a registry key and value.  
  
#### To specify a company logo by setting the OEM registry key  
  
1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
2.  In the Search box, type **regedit**, and then click the Regedit application.  
  
3.  In the navigation pane, navigate to  **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**. If the OEM key does not exist, create the key as follows:  
  
    1.  Right-click **Windows Server**, click **New**, and then click **Key**.  
  
    2.  For key name, type **OEM**.  
  
4.  (Optional) If you are creating an entry for a logo, you can create different keys to differentiate the language versions of the logo. For example, if you have both English and German versions of a logo, you can create an en-us key and a de-de key. Because all of the logo files are stored in the same folder, you must provide instances of the logo image file with a unique name for each language. For example, you can create a file called LogoWithWhiteText_en.png and LogoWithWhiteText_de.png.  
  
5.  Either right-click **OEM** or right-click the appropriate language key, click to **New**, and then click **String Value**.  
  
6.  Enter LogoWithWhiteText as the string, and then press ENTER.  
  
7.  Right-click the new string, and then click **Modify**.  
  
8.  Enter the path that contains the logo image, and then click OK.  
  
## See Also  
 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)