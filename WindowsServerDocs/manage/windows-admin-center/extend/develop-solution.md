---
title: Develop a solution extension
description: Develop a solution extension Windows Admin Center SDK (Project Honolulu)
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 09/18/2018
---

# Develop a solution extension

>Applies to: Windows Admin Center, Windows Admin Center Preview

Solutions primarily define a unique type of object you wish to manage through Windows Admin Center.  These solutions/connection types are included with Windows Admin Center by default:

* Windows Server connections
* Windows PC connections
* Failover cluster connections
* Hyper-converged cluster connections

When you select a connection from the Windows Admin Center connection page, the solution extension for that connection's type is loaded, and Windows Admin Center will attempt to connect to the target node. If the connection is successful, the solution extension's UI will load, and Windows Admin Center will display the tools for that solution in the left navigation pane.

If you would like to build a management GUI for services not defined by the default connection types above, such a network switch, or other hardware not discoverable by computer name, you may want to create your own solution extension.

> [!NOTE]
> Not familiar with the different extension types? Learn more about the [extensibility architecture and extension types](understand-extensions.md).

## Prepare your environment

If you haven't already, [prepare your environment](prepare-development-environment.md) by installing dependencies and global prerequisites required for all projects.

## Create a new solution extension with the Windows Admin Center SDK ##

Once you have all the dependencies installed, you are ready to create your new solution extension.  Create or browse to a folder that contains your project files, open a command prompt, and set that folder as the working directory.  Using the Windows Admin Center SDK that was installed previously, create a new extension with the following syntax:

```
wac create --company "{!Company Name}" --solution "{!Solution Name}" --tool "{!Tool Name}" --version latest
```

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!Company Name}``` | Your company name (with spaces) | ```Contoso Inc``` |
| ```{!Solution Name}``` | Your solution name (with spaces) | ```Contoso Foo Works Suite``` |
| ```{!Tool Name}``` | Your tool name (with spaces) | ```Manage Foo Works``` |

Here's an example usage:

```
wac create --company "Contoso Inc" --solution "Contoso Foo Works Suite" --tool "Manage Foo Works"
```

This creates a new folder inside the current working directory using the name you specified for your solution, copies all the necessary template files into your project, and configures the files with your company, solution, and tool name.

> [!NOTE]
> The --version flag in this command specifies which version of the Windows Admin Center SDK you'd like to target. Read about how to [target a different version](target-sdk-version.md) of the Windows Admin Center SDK to keep up your extension up to date with the latest SDK and platform changes.

Next, change directory into the folder just created, then install required local dependencies by running the following command:

```
npm install
```

Once this completes, you've set up everything you need to load your new extension into Windows Admin Center.

## Add content to your extension

Now that you've created an extension with the Windows Admin Center SDK, you are ready to customize content.  See these guides for examples of what you can do:

- Add an [empty module](guides/add-module.md)
- Add an [iFrame](guides/add-iframe.md)
- Create a [custom connection provider](guides/create-connection-provider.md)
- Modify [root navigation behavior](guides/modify-root-navigation.md)

Even more examples can be found in our Developer Guide. The Developer Guide is a fully functioning solution extension that can be side-loaded into Windows Admin Center, and contains a rich collection of sample functionality and tool examples that you can browse and use in your own extension. 

Enable the Developer Guide extension on the **Advanced** page of your Windows Admin Center settings. 

## Build and side load your extension

Next, build and side load your extension into Windows Admin Center.  Open a command window, change directory to your source directory, then you're ready to build.

* Build and serve with gulp:

    ```
    gulp build
    gulp serve --port 4201
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
