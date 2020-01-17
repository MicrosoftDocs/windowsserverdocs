---
title: Develop a tool extension
description: Develop a tool extension Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Develop a tool extension

>Applies To: Windows Admin Center, Windows Admin Center Preview

A tool extension is the primary way that users interact with Windows Admin Center to manage a connection, such as a server or cluster. When you click on a connection in the Windows Admin Center home screen and connect, you will then be presented with a list of tools in the left navigation pane. When you click on a tool, the tool extension is loaded and displayed in the right pane.

When a tool extension is loaded, it can execute WMI calls or PowerShell scripts on a target server or cluster and display information in the UI or execute commands based on user input. Tool extensions define which solutions it should be displayed for, resulting in a different set of tools for each solution.

> [!NOTE]
> Not familiar with the different extension types? Learn more about the [extensibility architecture and extension types](understand-extensions.md).

## Prepare your environment

If you haven't already, [prepare your environment](prepare-development-environment.md) by installing dependencies and global prerequisites required for all projects.

## Create a new tool extension with the Windows Admin Center CLI ##

Once you have all the dependencies installed, you are ready to create your new tool extension.  Create or browse to a folder that contains your project files, open a command prompt, and set that folder as the working directory.  Using the Windows Admin Center CLI that was installed previously, create a new extension with the following syntax:

``` cmd
wac create --company "{!Company Name}" --tool "{!Tool Name}"
```

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!Company Name}``` | Your company name (with spaces) | ```Contoso Inc``` |
| ```{!Tool Name}``` | Your tool name (with spaces) | ```Manage Foo Works``` |

Here's an example usage:

``` cmd
wac create --company "Contoso Inc" --tool "Manage Foo Works"
```

This creates a new folder inside the current working directory using the name you specified for your tool, copies all the necessary template files into your project, and configures the files with your company and tool name.  

Next, change directory into the folder just created, then install required local dependencies by running the following command:

``` cmd
npm install
```

Once this completes, you've set up everything you need to load your new extension into Windows Admin Center. 

## Add content to your extension

Now that you've created an extension with the Windows Admin Center CLI, you are ready to customize content.  See these guides for examples of what you can do:

- Add an [empty module](guides/add-module.md)
- Add an [iFrame](guides/add-iframe.md)
 
Even more examples can be found our [GitHub SDK site](https://aka.ms/wacsdk):
-  [Developer Tools](https://github.com/Microsoft/windows-admin-center-sdk/tree/master/windows-admin-center-developer-tools) is a fully functioning extension that can be side-loaded into Windows Admin Center, and contains a rich collection of sample functionality and tool examples that you can browse and use in your own extension.

## Customize your extension's icon

You can customize the icon that shows for your extension in the tool list.  To do this, modify all ```icon``` entries in ```manifest.json``` for your extension:

``` json
"icon": "{!icon-uri}",
```

| Value | Explanation | Example uri |
| ----- | ----------- | ------- |
| ```{!icon-uri}``` | The location of your icon resource | ```assets/foo-icon.svg``` |

NOTE: Currently, custom icons aren't visible when side loading your extension in dev mode.  As a workaround, remove the contents of ```target``` as follows:

``` json
"target": "",
```

This configuration is only valid for side loading in dev mode, so it's important to preserve the value contained in ```target``` and then restore it before publishing your extension.

## Build and side load your extension

Next, build and side load your extension into Windows Admin Center.  Open a command window, change directory to your source directory, then you're ready to build.

* Build and serve with gulp:

    ``` cmd
    gulp build
    gulp serve -p 4201
    ```

Note that you need to choose a port that is currently free. Make sure you do not attempt to use the port that Windows Admin Center is running on.

Your project can be side loaded into a local instance of Windows Admin Center for testing by attaching the locally served project into Windows Admin Center.

* Launch Windows Admin Center in a web browser
* Open the debugger (F12)
* Open the Console and type the following command:

    ``` cmd
    MsftSme.sideLoad("http://localhost:4201")
    ```

*	Refresh the web browser

Your project will now be visible in the Tools list with (side loaded) next to the name.

## Target a different version of the Windows Admin Center SDK

Keeping your extension up to date with SDK changes and platform changes is easy.  Read about how to [target a different version](target-sdk-version.md) of the Windows Admin Center SDK.