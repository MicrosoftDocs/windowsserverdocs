---
title: Display language scenarios for Windows MultiPoint Server 2012
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed56d41f-7cf8-481b-b749-b01be6060c1e
author: lizap
manager: jwhit
---
# Display language scenarios for Windows MultiPoint Server 2012
This appendix describes how to mix languages in a multi\-language installation of [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)]. Find out which language packs are fully localized, which are supported, and what to expect when the default system language or a user’s display language is not fully localized.  
  
> [!NOTE]  
> To find out how to change the default system language or a user’s display language, see [Change the display language in Windows MultiPoint Server 2012](../../../compute/remote-desktop-services/multipoint-1/Change-the-display-language-in-Windows-MultiPoint-Server-2012.md).  
  
## Which languages can I use?  
**Fully localized language packs** \- MultiPoint Server is available fully localized in the following languages. If you apply one of those language packs to the server, the MultiPoint Server Dashboard, MultiPoint Manager, and the desktop display the selected language.  
  
**Table: The 18 languages in which MultiPoint Server is fully localized**  
  
||||  
|-|-|-|  
|Arabic|German|Polish|  
|Chinese Traditional|Hebrew|Portuguese \(Brazil\)|  
|Chinese \(Hong Kong SAR\)|Hungarian|Portuguese \(Portugal\)|  
|Chinese \(Simplified\)|Italian|Russian|  
|English|Japanese|Spanish|  
|French|Korean|Turkish|  
  
> [!IMPORTANT]  
> Arabic and Hebrew are only available by applying a Windows Server 2012 Language Pack to another DVD language such as English. Complete DVD images of MultiPoint Server 2012 are available for all of the other languages.  
  
**Other supported language packs** \- Windows MultiPoint Server supports all the language packs that are available for Windows Server 2012. However, if you apply a language pack for which MultiPoint Server is not fully localized, the desktop displays the selected language, but the MultiPoint Server Dashboard and MultiPoint Manager display the default language for the MultiPoint Server system. For a list of available language packs, see [Windows Server 2012 language packs](http://www.microsoft.com/oem/en/installation/downloads/Pages/Windows-Server-2012-Language-Packs.aspx?mtag=TW-P-S12#fbid=25o0epAptQN) \(http:\/\/www.microsoft.com\/oem\/en\/installation\/downloads\/Pages\/Windows\-Server\-2012\-Language\-Packs.aspx?mtag\=TW\-P\-S12\#fbid\=25o0epAptQN\) in Microsoft’s OEM Partner Center.  
  
## Display language scenarios  
When you change the language pack used by the MultiPoint Server system or a user account, the language displayed in different areas of the product depends on whether MultiPoint Server is fully localized in the selected language.  
  
### Simple Scenarios  
  
#### Apply a language pack that is one of the 18 MultiPoint Server languages  
If you start with any language of Windows MultiPoint Server and apply a different language pack from the MultiPoint Server list of 18, MultiPoint Manager, the Multipoint Server Dashboard, and the desktop all display the new language.  
  
#### Apply a language pack that is not one of the 18 MultiPoint Server languages  
If you start with any language of MultiPoint Server and apply a language pack that is not one of the 18 MultiPoint Server languages, the desktop displays the new language, and MultiPoint Manager and the MultiPoint Server Dashboard display English.  
  
### Complex Scenarios  
  
#### Set a fully localized display language  
If you install one of the 18 language packs for which MultiPoint Server is fully localized, and you set the MultiPoint Server system to use that language \(that is, as the display language for a user account and also as the language of the Welcome screen and system accounts\), as described in [Change the display language in Windows MultiPoint Server 2012](../../../compute/remote-desktop-services/multipoint-1/Change-the-display-language-in-Windows-MultiPoint-Server-2012.md), MultiPoint Manager, the MultiPoint Dashboard, and the MultiPoint Server setup screens display the language that you installed and set.  
  
#### Set a display language that is not fully localized  
If you install a language pack for which MultiPoint Server is not fully localized, the language displayed in MultiPoint Manager and the MultiPoint Server setup screens might be English, depending on how you set the display language for the system. The following two scenarios describe this behavior:  
  
-   **Set the display language for the user account, and do not set the language for the Welcome screen and system accounts**  
  
    If you set the display language for the user account to a language that is not one of the fully localized languages, but you do not set the language for the Welcome screen and system accounts, MultiPoint Manager and the MultiPoint Dashboard display English, and the MultiPoint Server setup screens display the language of the fully localized version of MultiPoint Server that you installed.  
  
    For example, if you installed the German version of MultiPoint Server and the Polish language pack, MultiPoint Manager and the MultiPoint Dashboard display English, and the MultiPoint Server setup screens display German.  
  
-   **Set the language for the Welcome screen and system accounts, and do not set the display language for the user account**  
  
    If you set the language for the Welcome screen and system accounts to a language in which MultiPoint Server is not fully localized, but you do not set the display language for the user account, MultiPoint Manager displays the language of the fully localized version of MultiPoint Server that you installed, and the MultiPoint Server setup screens display English.  
  
    For example, if you installed the German version of MultiPoint Server and the Polish language pack, MultiPoint Manager will displays in German, and the MultiPoint Server setup screens will display in English.  
  
