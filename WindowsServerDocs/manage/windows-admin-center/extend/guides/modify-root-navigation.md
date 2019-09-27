---
title: Modify root navigation behavior
description: Develop a solution extension Windows Admin Center SDK (Project Honolulu) - modify root navigation behavior
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 08/07/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Modify root navigation behavior for a solution extension

>Applies To: Windows Admin Center, Windows Admin Center Preview

In this guide we will learn how to modify the root navigation behavior for your solution to have different connection list behavior, as well as how to hide or show the tools list.

## Modifying root navigation behavior

Open manifest.json file in {extension root}\src, and find the property "rootNavigationBehavior". This property has two valid values: "connections" or "path". The "connections" behavior is detailed later in the documentation.

### Setting path as a rootNavigationBehavior

Set the value of ```rootNavigationBehavior``` to ```path```, and then delete the ```requirements``` property, and leave the ```path``` property as an empty string. You have completed the minimal required configuration to build a solution extension. Save the file, and gulp build -> gulp serve as you would a tool, and then side load the extension into your local Windows Admin Center extension.

A valid manifest entryPoints array looks like this:
```
    "entryPoints": [
        {
          "entryPointType": "solution",
          "name": "main",
          "urlName": "testsln",
          "displayName": "resources:strings:displayName",
          "description": "resources:strings:description",
          "icon": "sme-icon:icon-win-powerShell",
          "path": "",
          "rootNavigationBehavior": "path"
        }
    ],
```

Tools built with this kind of structure will not required connections to load, but won't have node connectivity functionality either.

### Setting connections as a rootNavigationBehavior

When you set the ```rootNavigationBehavior``` property to ```connections```, you are telling the Windows Admin Center Shell that there will be a connected node (always a server of some type) that it should connect to, and verify connection status. With this, there are 2 steps in verifying connection. 1) Windows Admin Center will attempt to make an attempt to log into the node with your credentials (for establishing the remote PowerShell session), and 2) it will execute the PowerShell script you provide to identify if the node is in a connectable state.

A valid solution definition with connections will look like this:

``` json
        {
          "entryPointType": "solution",
          "name": "example",
          "urlName": "solutionexample",
          "displayName": "resources:strings:displayName",
          "description": "resources:strings:description",
          "icon": "sme-icon:icon-win-powerShell",
          "rootNavigationBehavior": "connections",
          "connections": {
            "header": "resources:strings:connectionsListHeader",
            "connectionTypes": [
                "msft.sme.connection-type.example"
                ]
            },
            "tools": {
                "enabled": false,
                "defaultTool": "solution"
            }
        },
```

When the rootNavigationBehavior is set to "connections" you are required to build out the connections definition in the  manifest. This includes the "header" property (will be used to display in your solution header when a user selects it from the menu), a connectionTypes array (this will specify which connectionTypes are used in the solution. More on that in the connectionProvider documentation.).

## Enabling and disabling the tools menu ##

Another property available in the solution definition is the "tools" property. This will dictate if the tools menu is displayed, as well as the tool that will be loaded. When enabled, Windows Admin Center will render the left hand tools menu. With defaultTool, it is required that you add a tool entry point to the manifest in order to load the appropriate resources. The value of "defaultTool" needs to be the "name" property of the tool as it is defined in the manifest.
