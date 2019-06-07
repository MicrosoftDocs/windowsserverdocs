---
title: Develop a gateway plugin
description: Develop a gateway plugin Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Develop a gateway plugin

>Applies To: Windows Admin Center, Windows Admin Center Preview

A Windows Admin Center gateway plugin enables API communication from the UI of your tool or solution to a target node.  Windows Admin Center hosts a gateway service that relays commands and scripts from gateway plugins to be executed on target nodes. The gateway service can be extended to include custom gateway plugins that support protocols other than the default ones.

These gateway plugins are included by default with Windows Admin Center:

* PowerShell gateway plugin
* WMI gateway plugin

If you would like to communicate with a protocol other than PowerShell or WMI, such as with REST, you can build your own gateway plugin.  Gateway plugins are loaded into a separate AppDomain from the existing gateway process, but use the same level of elevation for rights.

> [!NOTE]
> Not familiar with the different extension types? Learn more about the [extensibility architecture and extension types](understand-extensions.md).

## Prepare your environment

If you haven't already, [prepare your environment](prepare-development-environment.md) by installing dependencies and global prerequisites required for all projects.

## Create a gateway plugin (C# library)

To create a custom gateway plugin, create a new C# class that implements the ```IPlugIn``` interface from the ```Microsoft.ManagementExperience.FeatureInterfaces``` namespace.  

> [!NOTE]
> The ```IFeature``` interface, available in earlier versions of the SDK, is now flagged as obsolete.  All gateway plugin development should use IPlugIn (or optionally the HttpPlugIn abstract class).

### Download sample from GitHub

To get started quickly with a custom gateway plugin, you can clone or download a copy of our [sample C# plugin project](https://github.com/Microsoft/windows-admin-center-sdk/tree/master/GatewayPluginExample/Plugin) from our Windows Admin Center SDK [GitHub site](https://aka.ms/wacsdk).

### Add content

Add new content to your cloned copy of the [sample C# plugin project](https://github.com/Microsoft/windows-admin-center-sdk/tree/master/GatewayPluginExample/Plugin) project (or your own project) to contain your custom APIs, then build your custom gateway plugin DLL file to be used in the next steps.

### Deploy plugin for testing

Test your custom gateway plugin DLL by loading it into Windows Admin Center gateway process.

Windows Admin Center looks for all plugins in a ```plugins``` folder in the Application Data folder of the current machine (using the CommonApplicationData value of the Environment.SpecialFolder enumeration). On Windows 10 this location is ```C:\ProgramData\Server Management Experience```.  If the ```plugins``` folder doesn't exist yet, you can create the folder yourself.

> [!NOTE]
> You can override the plugin location in a debug build by updating the "StaticsFolder" configuration value. If you're debugging locally, this setting is in the App.Config of the Desktop solution. 

Inside the plugins folder (in this example, ```C:\ProgramData\Server Management Experience\plugins```)

* Create a new folder with the same name as the ```Name``` property value of the ```Feature``` in your custom gateway plugin DLL (in our sample project, the ```Name``` is "Sample Uno")
* Copy your custom gateway plugin DLL file to this new folder
* Restart the Windows Admin Center process

After the Windows Admin process restarts, you will be able to exercise the APIs in your custom gateway plugin DLL by issuing a GET, PUT, PATCH, DELETE, or POST to ```http(s)://{domain|localhost}/api/nodes/{node}/features/{feature name}/{identifier}```

### Optional: Attach to plugin for debugging

In Visual Studio 2017, from the Debug menu, select "Attach to Process". In the next window, scroll through the Available Processes list and select SMEDesktop.exe, then click "Attach". Once the debugger starts, you can place a breakpoint in your feature code and then exercise through the above URL format. For our sample project (feature name: "Sample Uno") the URL is: "<http://localhost:6516/api/nodes/fake-server.my.domain.com/features/Sample%20Uno>"

## Create a tool extension with the Windows Admin Center CLI ##

Now we need to create a tool extension from which you can call your custom gateway plugin.  Create or browse to a folder where you want to store your project files, open a command prompt, and set that folder as the working directory.  Using the Windows Admin Center CLI that was installed earlier, create a new extension with the following syntax:

```
wac create --company "{!Company Name}" --tool "{!Tool Name}"
```

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!Company Name}``` | Your company name (with spaces) | ```Contoso Inc``` |
| ```{!Tool Name}``` | Your tool name (with spaces) | ```Manage Foo Works``` |

Here's an example usage:

```
wac create --company "Contoso Inc" --tool "Manage Foo Works"
```

This creates a new folder inside the current working directory using the name you specified for your tool, copies all the necessary template files into your project, and configures the files with your company and tool name.  

Next, change directory into the folder just created, then install required local dependencies by running the following command:

```
npm install
```

Once this completes, you've set up everything you need to load your new extension into Windows Admin Center. 

## Connect your tool extension to your custom gateway plugin

Now that you've created an extension with the Windows Admin Center CLI, you are ready to connect your tool extension to your custom gateway plugin, by following these steps:

- Add an [empty module](guides/add-module.md)
- Use your [custom gateway plugin](guides/use-custom-gateway-plugin.md) in your tool extension
 
## Build and side load your extension

Next, build and side load your extension into Windows Admin Center.  Open a command window, change directory to your source directory, then you're ready to build.

* Build and serve with gulp:

    ```
    gulp build
    gulp serve -p 4201
    ```

Note that you need to choose a port that is currently free. Make sure you do not attempt to use the port that Windows Admin Center is running on.

Your project can be side loaded into a local instance of Windows Admin Center for testing by attaching the locally served project into Windows Admin Center.

* Launch Windows Admin Center in a web browser
* Open the debugger (F12)
* Open the Console and type the following command:

    ```
    MsftSme.sideLoad("http://localhost:4201")
    ```

*	Refresh the web browser

Your project will now be visible in the Tools list with (side loaded) next to the name.

## Target a different version of the Windows Admin Center SDK

Keeping your extension up to date with SDK changes and platform changes is easy.  Read about how to [target a different version](target-sdk-version.md) of the Windows Admin Center SDK.