---
title: Develop a gateway plugin
description: Develop a gateway plugin Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 05/02/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Develop a gateway plugin

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

The gateway service exposes REST APIs for the UI to call and relays commands and scripts to be executed on the target. The gateway service can be extended by gateway plugins that support different protocols. Windows Admin Center is pre-packaged with two gateway plugins, one for executing PowerShell scripts and the other for WMI commands. If you need to communicate with the target through a protocol other than PowerShell or WMI, such as REST, you can build a gateway plugin for this. Gateway plugins will be loaded into a separate AppDomain from the existing gateway process, but use the same level of elevation for rights.

> [!NOTE]
> Not familiar with the different extension types? Learn more about the [extensibility architecture and extension types](understand-extensions.md).

## Prepare your development environment

Follow these step-by-step directions to [prepare](prepare-development-environment.md) your development environment, [clone](prepare-development-environment.md#clone-extension-template) the extension template, and prepare the extension template [for use](prepare-development-environment.md#prepare-extension-template-for-use).

## Developing a gateway plugin

There are two basic requirements for any code that will be hosted as a plugin:
1) It needs to inherit from MarshalByRefObject from the System namespace to allow marshalling across app domains.
2) It needs to implement the IFeature interface from the Microsoft.ManagementExperience.FeatureInterfaces namespace.

An example plugin can be found in the SampleFeature folder.

Once you have implemented your plugin, the next step is to get it loaded in the Gateway process. By default the Gateway process looks for all plugins in a "plugins" folder in the Application Data folder of the current machine (using the CommonApplicationData value of the Environment.SpecialFolder enumeration, on Windows 10 this correlates to: C:\ProgramData\Server Management Experience). You can override this behavior by updating the "StaticsFolder" configuration value. If you're debugging locally, this setting is in the App.Config of the Desktop solution. This override will only work if running a debug build.

Inside the plugins folder (C:\ProgramData\Server Management Experience\plugins), create a new folder who's name matches the Name property value of the Feature that you implemented. Inside the new folder, place your new Feature DLL, and restart the Windows Admin Center process. Once the process starts up again, you will be able to exercise the code by issuing a GET, PUT, PATCH, DELETE, or POST to http(s)://<domain / localhost>/api/nodes/{node}/features/{feature name}/{identifier}

## Testing a gateway plugin

In order to debug a plugin you will need to make sure the feature DLL has be copied to the appropriate "plugins" directory mentioned above. Start Visual Studio (2017), and then click the Debug menu and select "Attach to Process". In the next window, scroll through the Available Processes list and select SMEDesktop.exe, and then click "Attach". Once the debugger starts, you can place a breakpoint in your feature code and then exercise through the above URL format. For our Sample Feature (feature name: "Sample Uno") the URL is: "http://localhost:6516/api/nodes/fake-server.my.domain.com/features/Sample Uno".

## Publishing a gateway plugin

The process to publish a gateway plugin will be available in the future. At this point in time you will need to manually move the DLL as detailed above.

## Calling a gateway plugin from a tool extension

If you haven't already, follow these [step-by-step directions](developing-extensions.md) to create a new, empty project from the extension template. 

Next, we will modify this project to make a call to the gateway plugin that was created in the previous steps.
