---
title: Credential limit per app
description: Troubleshooting an issue where only twenty credentials can be used per app.
ms.topic: troubleshooting
author: HeidiLohr
manager: lizross
ms.author: helohr
ms.date: 12/14/2020
ms.localizationpriority: medium
---
# Credential limit per app

Windows only allows up to 20 credentials per app. If you need to have more than 20 credentials per app, follow the instructions in this article.

## Bypass the 20 credential limit

To bypass the 20 credential limit:

1. Open PowerShell as an administrator.
2. Set the **HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Vault\MaxPerAppCredentialNumber** DWORD registry entry value to a number greater than 20.
3. Restart your machine.
4. Test out your settings by creating a new set of credentials in the Remote Desktop client.

## Potential risks

When changing this registry setting, it's important to keep these things in mind:

- This is an admin operation. Any errors introduced into the registry could cause your machine to become unstable. Users should change the registry entries at their own risk.
- This registry change will affect all apps on your machine.
