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

## Add Other Languages for Localization ## 

For localization to other languages, a strings.resjson file needs to be created for each language. These files need to be places in ```\loc\output\{!ExtensionName}\{!LanguageFolder}\strings.resjson```. The available languages with corresponding folders are:

| Language      | Folder      |
| ------------- |-------------|
| Čeština | cs-CZ |
| Deutsch | de-DE |
| English | en-US |
| Español | es-ES |
| Français | fr-FR | 
| Magyar | hu-HU | 
| Italiano | it-IT |
| 日本語 | ja-JP | 
| 한국어 | ko-KR | 
| Nederlands | nl-NL |
| Polski | pl-PL |
| Português (Brasil) | pt-BR |
| Português (Portugal) | pt-PT |
| Русский | ru-RU |
| Svenska | sv-SE |
| Türkçe	| tr-TR |
| 中文(简体) | zh-CN |
| 中文(繁體) | zh-TW |
> [!NOTE]
> If your file structure needs are different inside of loc/output, you will need to adjust the localeOffset for the gulp task ‘generate-resjson-json-localized’ that is in the gulpfile.js. This offset is how deep into the loc folder it should start searching for strings.resjson files.

Each strings.resjson file will be formatted in the same way as previously mentioned at the top of this guide. 

For example, to include a localization for Español include this entry in ```\loc\output\HelloWorld\es-ES\strings.resjson```: 
```json
"HelloWorld_cim_title": "CIM Componente",
```
Anytime that you added localized strings, gulp generate must be ran again in order to have them appear. Run:
``` cmd
gulp generate 
```

To confirm that your strings have been generated navigate to ```\src\app\assets\strings\{!LanguageFolder}\strings.resjson```. Your newly added entry will appear in this file.
Now if you switch the language option in Windows Admin Center, you will be able to see the localized strings in your extension. 
