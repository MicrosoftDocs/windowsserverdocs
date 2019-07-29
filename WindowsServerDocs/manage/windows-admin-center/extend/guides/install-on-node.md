---
title: Develop a tool extension
description: Develop a tool extension Windows Admin Center SDK (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 09/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Install extension payload on a managed node

>Applies To: Windows Admin Center, Windows Admin Center Preview

## Setup
> [!NOTE]
> To follow this guide, you will need build 1.2.1904.02001 or higher. To check your build number open Windows Admin Center and click the question mark in the top right.

If you haven't already, create a [tool extension](../develop-tool.md) for Windows Admin Center. After you have completed this make note of the values used when creating an extension:

| Value | Explanation | Example |
| ----- | ----------- | ------- |
| ```{!Company Name}``` | Your company name (with spaces) | ```Contoso``` |
| ```{!Tool Name}``` | Your tool name (with spaces) | ```InstallOnNode``` |

Inside your tool extension folder create a ```Node``` folder (```{!Tool Name}\Node```). Anything placed in this folder will be copied to the managed node when using this API. Add any files necessary for your use case. 

Also create a ```{!Tool Name}\Node\installNode.ps1``` script. This script will be ran on the managed node once all files are copied from the ```{!Tool Name}\Node``` folder to the managed node. Add any additional logic for your use case. An example ```{!Tool Name}\Node\installNode.ps1``` file:

``` ps1
# Add logic for installing payload on managed node
echo 'Success'
```

> [!NOTE]
> ```{!Tool Name}\Node\installNode.ps1``` has a specific name that the API will look for. Changing the name of this file will cause an error.


## Integration with UI

Update ```\src\app\default.component.ts``` to the following:

``` ts
import { Component } from '@angular/core';
import { AppContextService } from '@microsoft/windows-admin-center-sdk/angular';
import { Observable } from 'rxjs';

@Component({
  selector: 'default-component',
  templateUrl: './default.component.html',
  styleUrls: ['./default.component.css']
})

export class DefaultComponent {
  constructor(private appContextService: AppContextService) { }

  public response: any;
  public loading = false;

  public installOnNode() {
    this.loading = true;
    this.post('{!Company Name}.{!Tool Name}', '1.0.0',
      this.appContextService.activeConnection.nodeName).subscribe(
        (response: any) => {
          console.log(response);
          this.response = response;
          this.loading = false;
        },
        (error) => {
          console.log(error);
          this.response = error;
          this.loading = false;
        }
      );
  }

  public post(id: string, version: string, targetNode: string): Observable<any> {
    return this.appContextService.node.post(targetNode,
      `features/extensions/${id}/versions/${version}/install`);
  }

}
```
Update placeholders to values that were used when creating the extension:
``` ts
this.post('contoso.install-on-node', '1.0.0',
      this.appContextService.activeConnection.nodeName).subscribe(
        (response: any) => {
          console.log(response);
          this.response = response;
          this.loading = false;
        },
        (error) => {
          console.log(error);
          this.response = error;
          this.loading = false;
        }
      );
```

Also update ```\src\app\default.component.html``` to:
``` html
<button (click)="installOnNode()">Click to install</button>
<sme-loading-wheel *ngIf="loading" size="large"></sme-loading-wheel>
<p *ngIf="response">{{response}}</p>
```
And lastly ```\src\app\default.module.ts```:
``` ts
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { LoadingWheelModule } from '@microsoft/windows-admin-center-sdk/angular';
import { DefaultComponent } from './default.component';
import { Routing } from './default.routing';

@NgModule({
  imports: [
    CommonModule,
    LoadingWheelModule,
    Routing
  ],
  declarations: [DefaultComponent]
})
export class DefaultModule { }

```

## Creating and installing a NuGet Package

The last step is building a NuGet package with the files we have added and then installing that package in Windows Admin Center.

Follow the [Publishing Extensions](../publish-extensions.md) guide if you have not created an extension package before. 
> [!IMPORTANT]
> In your .nuspec file for this extension, it is important that the ```<id>``` value matches the name in your project's ```manifest.json``` and the ```<version>``` matches what was added to ```\src\app\default.component.ts```. Also add an entry under ```<files>```: 
> 
> ```<file src="Node\**\*.*" target="Node" />```.

``` xml
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">
  <metadata>
    <id>contoso.install-on-node</id>
    <version>1.0.0</version>
    <authors>Contoso</authors>
    <owners>Contoso</owners>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <projectUrl>https://msft-sme.myget.org/feed/windows-admin-center-feed/package/nuget/contoso.sme.install-on-node-extension</projectUrl>
    <licenseUrl>http://YourLicenseLink</licenseUrl>
    <iconUrl>http://YourLogoLink</iconUrl>
    <description>Install on node extension by Contoso</description>
    <copyright>(c) Contoso. All rights reserved.</copyright> 
  </metadata>
    <files>
    <file src="bundle\**\*.*" target="ux" />
    <file src="package\**\*.*" target="gateway" />
    <file src="Node\**\*.*" target="Node" />
  </files>
</package>
```

Once this package is created, add a path to that feed. In Windows Admin Center go to Settings > Extensions > Feeds and add the path to where that package exists. When your extension is done being installed, you should be able to click the ```install``` button and the API will be called.  