---
title: Change the display language in Windows MultiPoint Server 2012
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd5bb3ac-dea2-49ed-b346-4e344e628688
---
# Change the display language in Windows MultiPoint Server 2012
[!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] supports multi\-language installations. Each user can choose their preferred desktop language, and they can see that language on any station that they log on to, even if that station is shared by more than one user. By default, new users pick up the language and location of MultiPoint Server.  
  
MultiPoint Server is fully localized in 18 languages, and supports all language packs that are available for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], although the level of support is more limited for languages for which MultiPoint Server is not fully localized. For a list of available languages, and information about the interplay between fully localized language packs and supported language packs in various display language scenarios, see [Display language scenarios for Windows MultiPoint Server 2012](../Topic/Display-language-scenarios-for-Windows-MultiPoint-Server-2012.md).  
  
## Setting the display language  
After MultiPoint Server is installed, you can change the display language for MultiPoint Server and for individual users. By default, new users pick up the language and location of MultiPoint Server. After you install a language pack for one user, it is available to all users.  
  
The language for the MultiPoint Server system and for an individual user is determined by different settings in Control Panel:  
  
-   **System display language** \- Update **Region** settings on the server to set the display language for the Welcome screen and logon screens, and the default language for new user accounts.  
  
-   **User’s primary language** \- To change the display language of the menus and dialog boxes that a specific user sees, log on as that user, and update **Languages** settings.  
  
#### To change the system display language for [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)]  
  
1.  If disk protection is enabled, disable it before you make these changes:  
  
    1.  From the **Start** screen, open **MultiPoint Manager**.  
  
    2.  On the **Home** tab, click **Disable disk protection**, and then click **OK**.  
  
    3.  When the computer restarts, log on as Administrator.  
  
    > [!IMPORTANT]  
    > If you make these changes when disk protection is enabled, your changes will be discarded the next time the computer restarts.  
  
2.  On the **Start** screen, type **Region**. On the **Search** pane, click **Settings**. Then click **Region** in the search results on the left side of the page.  
  
3.  Click the **Administrative** tab, and then click **Copy Settings**.  
  
4.  In the **Region** dialog box, confirm that the display language, input language \(for the keyboard\), and location under **Current user** are the ones that you want to apply to the system.  
  
5.  To apply your settings to the MultiPoint Server system, select the **Check the Welcome screen and system accounts** check box  
  
6.  To make your settings the default settings for new user accounts, select the **New user accounts** check box.  
  
7.  Click **OK**.  
  
8.  Turn disk protection back on \(recommended\). On the **Home** tab of MultiPoint Manager, click **Enable disk protection**. The computer restarts automatically, and the updates are applied.  
  
    \-Or\-  
  
    If you do not want to enable disk protection, restart the computer to apply the updates.  
  
#### To change a user’s primary language  
  
1.  Log on to a station with the account that the person uses in MultiPoint Server.  
  
2.  On the **Start** screen, type **Language**. Under **Search**, click **Settings** In the **Settings** results on the left, click **Language**.  
  
3.  Use **Add a language** to add the language that the user needs to use.  
  
4.  To make the language the user’s primary language, move it to the top of the list.  
  
