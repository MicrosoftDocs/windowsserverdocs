---
title: Strings and localization in Windows Admin Center
description: Learn about getting your strings ready for localization in Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 06/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Strings and localization in Windows Admin Center #

>Applies To: Windows Admin Center, Windows Admin Center Preview

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
