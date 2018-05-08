---
title: Using PowerShell in your extension
description: Using PowerShell in your extension Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 05/02/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Using PowerShell in your extension #

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

Let’s go more in-depth into the Windows Admin Center Extensions SDK - let's talk about adding PowerShell commands to your extension.

## PowerShell in TypeScript ##

The gulp build process has a generate step that will take any ".ps1" that is placed in the "/src/resources/scripts" folder and build them into the "powershell-scripts" class under the "/src/generated" folder.

>[!NOTE] 
> Don't manually update the "powershell-scripts.ts" nor the "strings.ts" files. Any change you make will be overwritten on the next generate.

### Adding your own PowerShell script ##

We'll add more information about adding your own PowerShell script soon.

### Managing PowerShell sessions ###

When you're working with PowerShell in Windows Admin Center, sessions are a required component of the script execution process. To run scripts on remote managed servers, PowerShell uses runspaces. Windows Admin Center wraps runspace creation and management in a PowerShellSession object to manage lifetime, and enable runspace reuse for sequential script execution.

Every component needs to create a reference to a session object that is created by the AppContextService class using three different options:
<!-- I don't 100% get this part - it looks like you're adding 3 arguments - nodeName, <session key>, and <PowerShellSessionRequestOptions>. I got that from looking at the examples, not the text. We need to rework those paras explaining. -->
``` ts
this.psSession = this.appContextService.powerShell.createSession(this.appContextService.activeConnection.nodeName);
```

By providing the node name to the createSession method, a new PowerShell session is created, used, and then immediately destroyed upon completion of the PowerShell call. This functionality is good for one-off calls, but repeated use can affect performance. A session takes approximately 1 second to create, so continuously recycling sessions can cause slowdowns.

``` ts
this.psSession = this.appContextService.powerShell.createSession(this.appContextService.activeConnection.nodeName, '<session key>');
```

The first optional parameter is the \<session key\> parameter. This creates a keyed session that can be looked up and reused, even across components (meaning that Component1 can create a session with key "SME-ROCKS," and Component2 can use that same session).  

``` ts
this.psSession = this.appContextService.powerShell.createSession(this.appContextService.activeConnection.nodeName, '<session key>', <PowerShellSessionRequestOptions>);
```
<!-- The second optional parameter is \<PowerShellSessionRequestOptions\> that does ... ? -->
### Common patterns ###

In most situations, create a keyed session in the **ngOnInit** method, and then dispose of it in an **ngOnDestroy**. Follow this pattern when there are multiple PowerShell scripts in a component but the underlying session IS NOT shared across components.

For best results, make sure session creation is managed inside of components rather than services - this helps ensure that lifetime and cleanup can be managed properly.