---
title: Use a custom gateway plugin in your tool extension
description: Develop a tool extension Windows Admin Center SDK (Project Honolulu) - use a custom gateway plugin in your tool extension
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Use a custom gateway plugin in your tool extension

>Applies To: Windows Admin Center, Windows Admin Center Preview

In this article, we will use a custom gateway plugin in a new, empty tool extension we have created with the Windows Admin Center CLI.

## Prepare your environment ##

If you haven't already, follow the directions in [develop a tool extension](../develop-tool.md) to prepare your environment and create a new, empty tool extension.

## Add a module to your project ##

If you haven't already, add a new [empty module](add-module.md) to your project, which we will use in the next step.  

## Add integration to custom gateway plugin ##

Now we'll use a custom gateway plugin in the new, empty module that we just created.

### Create plugin.service.ts

Change to the directory of the new tool module created above (```\src\app\{!Module-Name}```), and create a new file ```plugin.service.ts```.

Add the following code to the file just created:
``` ts
import { Injectable } from '@angular/core';
import { AppContextService, HttpService } from '@microsoft/windows-admin-center-sdk/angular';
import { Cim, Http, PowerShell, PowerShellSession } from '@microsoft/windows-admin-center-sdk/core';
import { AjaxResponse, Observable } from 'rxjs';

@Injectable()
export class PluginService {
    constructor(private appContextService: AppContextService, private http: Http) {
    }
    
    public getGatewayRestResponse(): Observable<any> {
        let callUrl = this.appContextService.activeConnection.nodeName;

        return this.appContextService.node.get(callUrl, 'features/Sample%20Uno').map(
            (response: any) => {
                return response;
            }
        )
    }
}
```

Change references to ```Sample Uno``` and ```Sample%20Uno``` to your feature name as appropriate.

[!WARNING]
> It is recommended that the built in ```this.appContextService.node``` is used for calling any API that is defined in your custom gateway plugin. This will ensure that if credentials are required inside of your gateway plugin that they will be handled properly.

### Modify module.ts

Open the ```module.ts``` file of the new module created earlier (i.e. ```{!Module-Name}.module.ts```):

Add the following import statements:

``` ts
import { HttpService } from '@microsoft/windows-admin-center-sdk/angular';
import { Http } from '@microsoft/windows-admin-center-sdk/core';
import { PluginService } from './plugin.service';
```

Add the following providers (after declarations):

``` ts
  ,
  providers: [
    HttpService,
    PluginService,
    Http
  ]
```

### Modify component.ts

Open the ```component.ts``` file of the new module created earlier (i.e. ```{!Module-Name}.component.ts```):

Add the following import statements:

``` ts
import { ActivatedRouteSnapshot } from '@angular/router';
import { AppContextService } from '@microsoft/windows-admin-center-sdk/angular';
import { Subscription } from 'rxjs';
import { Strings } from '../../generated/strings';
import { PluginService } from './plugin.service';
```

Add the following variables:

``` ts
  private serviceSubscription: Subscription;
  private responseResult: string;
```

Modify the constructor and modify/add the following functions:

``` ts
  constructor(private appContextService: AppContextService, private plugin: PluginService) {
    //
  }

  public ngOnInit() {
    this.responseResult = 'click go to do something';
  }

  public onClick() {
    this.serviceSubscription = this.plugin.getGatewayRestResponse().subscribe(
      (response: any) => {
        this.responseResult = 'response: ' + response.message;
      },
      (error) => {
        console.log(error);
      }
    );
  }
```

### Modify component.html ###

Open the ```component.html``` file of the new module created earlier (i.e. ```{!Module-Name}.component.html```):

Add the following content to the html file:
``` html
<button (click)="onClick()" >go</button>
{{ responseResult }}
```

## Build and side load your extension

Now you are ready to [build and side load](../develop-tool.md#build-and-side-load-your-extension) your extension in Windows Admin Center.
