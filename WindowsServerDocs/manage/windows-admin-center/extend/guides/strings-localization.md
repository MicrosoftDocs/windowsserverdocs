---
title: Strings and localization in Windows Admin Center
description: Learn about getting your strings ready for localization in Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 05/02/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Strings and localization in Windows Admin Center #

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

Let’s go more in-depth into the Windows Admin Center Extensions SDK and talk about strings and localization.

To enable localization of all strings that are rendered on the presentation layer, take advantage of the strings.resjson file under /src/resources/strings - it's already set up. When you need to add a new string to your extension, add it to this resjson file as a new entry. The existing structure follows this format:

``` ts
"<YourExtensionName>_<Component>_<Accessor>": "Your string value goes here.",
```

You can use any format you like for the strings, but be aware that the generation process (the process that takes the resjson and outputs the usable TypeScript class) converts underscore (_) to periods (.).

For example, this entry:
``` ts
"HelloWorld_cim_title": "CIM Component",
```
Generates the following accessor structure:
``` ts
MsftSme.resourcesStrings<Strings>().HelloWorld.cim.title;
```
