---
title: Modify root navigation behavior
description: Develop a solution extension Windows Admin Center SDK - modify root navigation behavior
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/01/2023
---

# Modify root navigation behavior for a solution extension

Applies to: Windows Admin Center, Windows Admin Center Preview

This article provides guidance on how to modify the root navigation behavior for your solution to have different connection list behavior. You'll also learn how to hide or show the tools list.

## Modifying root navigation behavior

Open manifest.json file in {extension root}\src, and find the property "rootNavigationBehavior". This property has two valid values: "connections" or "path". The "connections" behavior is detailed later in the documentation.

### Setting path as a rootNavigationBehavior

Set the value of ```rootNavigationBehavior``` to ```path```, and then delete the ```requirements``` property, and leave the ```path``` property as an empty string. You've completed the minimal required configuration to build a solution extension. Save the file, gulp build -> gulp serve as you would with a tool, and then side load the extension into your local Windows Admin Center extension.

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

Tools built with this kind of structure don't require connections to load, but don't have node connectivity functionality either.

### Setting connections as a rootNavigationBehavior

When you set the ```rootNavigationBehavior``` property to ```connections```, you're telling the Windows Admin Center Shell that there's a connected node (always a server of some type) that it should connect to verify connection status. There are two steps in verifying a connection.

1. Windows Admin Center attempts to make an attempt to log into the node with your credentials (for establishing the remote PowerShell session).
1. Windows Admin Center executes the PowerShell script you provide to verify if the node is in a connectable state.

A valid solution definition with connections looks like this:

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

When the rootNavigationBehavior is set to "connections", you're required to build out the connections definition in the  manifest. This includes the "header" property (displays in your solution header when a user selects it from the menu), and a connectionTypes array (specifies which connectionTypes are used in the solution. More on this in the connectionProvider documentation.

## Enabling and disabling the tools menu

Another property available in the solution definition is the Tools property. The Tools property decides whether the Tools menu is displayed, and which tool will be loaded. When enabled, Windows Admin Center renders the left hand Tools menu. With defaultTool, it's required that you add a tool entry point to the manifest in order to load the appropriate resources. The value of "defaultTool" needs to be the "name" property of the tool as it's defined in the manifest.