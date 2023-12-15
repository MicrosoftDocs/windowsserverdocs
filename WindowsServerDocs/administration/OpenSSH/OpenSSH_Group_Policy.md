---
ms.date:  12/15/2023 
contributor:  damaerte
keywords:  OpenSSH, SSH, Win32-OpenSSH
title:  Manage OpenSSH with Group Policy
---

# How to manage OpenSSH with Group Policy
## Prerequisits
Before you start, the following prerequisites must be met:
- You have administrator rights on the local device and the appropriate permissions to update Group Policy on your domain controller
- You are managing the in-box version of OpenSSH
- You are managing Operating Systems where both OpenSSH and Group Policy are present

## Create a Group Policy Object
To create a Group Policy to manage OpenSSH perform the following steps:
1. Open the Group Policy Management tool
2. In the navigation pane, expand `Forest: your forest name`, expand `Domains`, expand your domain
3. Select `Group Policy Objects`
4. Right-click `Group Policy Objects`, then select New to create a new Object
5. Name the Object so that it can be identified as managing OpenSSH
6. Double-click the new Object
7. Right-click on `Computer Configuration`, then select `Edit...`
8. In the navigation pane, expand `Computer Configuration`, expand `Policies`, expand `Windows Settings`, expand `Security Settings`, then select `System Services`
9. Double-click `OpenSSH SSH Server` in the services list
10. Click the checkmark `Define this policy setting`
11. Select the desired service startup mode; `Automatic`, `Manual`, `Disabled`
12. Select `Apply`
