---
title: Add an iFrame to a tool extension
description: Develop a tool extension Windows Admin Center SDK (Project Honolulu) - add an iFrame to a tool extension
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Add an iFrame to a tool extension

>Applies To: Windows Admin Center, Windows Admin Center Preview

In this article, we will add an iFrame to a new, empty tool extension we have created with the Windows Admin Center CLI.

## Prepare your environment ##

If you haven't already, follow the directions in [develop a tool extension](../develop-tool.md) to prepare your environment and create a new, empty tool extension.

## Add a module to your project ##

Add a new [empty module](add-module.md) to your project, to which we will add an iFrame in the next step.  

## Add an iFrame to your module ##

Now we'll add an iFrame to that new, empty module that we just created.

In \src\app\, browse into your module folder, then open file ```{!module-name}.component.html```, found with the following naming convention:

| Value | Explanation | Example filename |
| ----- | ----------- | ------- |
| ```{!module-name}``` | Your module name (lower case, spaces replaced with dashes) | ```manage-foo-works-portal.component.html``` |
    
Add the following content to the html file:

``` html
<div>
  <iframe  style="height: 850px;" src="https://www.bing.com"></iframe>
</div>
```

That's it, you've added an iFrame to your extension.  Next, you can [build and side load](../develop-tool.md#build-and-side-load-your-extension) your extension in Windows Admin Center to see the results.

> [!Note]
> Content Security Policy (CSP) settings could prevent some sites from rendering in an iFrame within Windows Admin Center. You can learn more about this [here](https://content-security-policy.com/). 
