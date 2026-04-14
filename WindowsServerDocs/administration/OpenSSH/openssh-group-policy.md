---
ms.date:  2/12/2024 
contributor:  damaerte
keywords:  OpenSSH, SSH, Win32-OpenSSH
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
title:  Manage OpenSSH with Group Policy
description: Learn how to create a Group Policy object for OpenSSH
---

# How to manage OpenSSH with Group Policy
Group Policy allows you to specify managed configurations for users and computers. This page will help you create a Group Policy object to manage the OpenSSH Server component.

## Prerequisites
Before you start, the following prerequisites must be met:
- You have administrator rights on the local device and the appropriate permissions to update Group Policy on your domain controller
- You are managing the in-box version of OpenSSH
- You are managing Operating Systems where both OpenSSH and Group Policy are present

## Create a Group Policy Object
To create a Group Policy to manage OpenSSH perform the following steps:
1. Open the Group Policy Management tool.
2. In the navigation pane, expand `Forest: your forest name`, expand `Domains`, expand your domain.
3. Select `Group Policy Objects`.
4. Right-click `Group Policy Objects`, then select New to create a new Object.
5. Name the Object so that it can be identified as managing OpenSSH.
    :::image type="content" source="media/openssh-gpo.png" alt-text="Screenshot of OpenSSH Group Policy.":::
6. Double-click the new Object.
7. Navigate to the `Settings` tab.
8. Right-click on `Computer Configuration`, then select `Edit...`.
9. In the navigation pane, expand `Computer Configuration`, expand `Policies`, expand `Windows Settings`, expand `Security Settings`, then select `System Services`.
10. Double-click `OpenSSH SSH Server` in the services list.
11. Click the checkmark `Define this policy setting`.
12. Select the desired service startup mode; `Automatic`, `Manual`, `Disabled`.
    :::image type="content" source="media/openssh-policy.png" alt-text="Screenshot of OpenSSH Group Policy Object.":::
13. Select `Apply`.
