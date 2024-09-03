---
description: "Learn more about Active Directory Fine Grained Password Policies"
title: Configure Fine Grained Password Policies for Active Directory in Windows Server
ms.author: orthomas
author: orin-thomas
ms.date: 07/15/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to configure fine-grained password policies so that I can apply different password and account lockout policies to different sets of users in a domain.
---

# Fine Grained Password Policies

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Fine Grained Password Policies provide you with a way to define different password and account lockout policies for different sets of users in a domain. You can use fine-grained password policies to specify multiple password policies within a single domain and apply different restrictions for password and account lockout policies to different sets of users in a domain. For example, you can apply stricter settings to privileged accounts and less strict settings to the accounts of other users.

Fine-grained password policies apply only to global security groups and user objects. By default, only members of the Domain Admins group can set fine-grained password policies. However, you can also delegate the ability to set these policies to other users.

## Prerequisites

Before you can create fine-grained password policies, you'll need to complete the following prerequisites.

- The domain functional level must be Windows Server 2008 or higher.

- You must be a member of the Domain Admins group.

- On the computer where you'll create fine-grained password policies, you must have either of the following Remote Server Administration Tools (RSAT) installed:

  - Active Directory Administrative Center (ADAC)

  OR

- Active Directory module for Windows PowerShell.

## Create a Grained Password Policy

To create a new fine grained password policy, perform the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to create a fine grained password policy using Active Directory Administrative Center (ADAC):

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC navigation pane, open the **System** container and then choose **Password Settings Container**.

1. In the **Tasks** pane, choose **New**, and then choose **Password Settings**.

1. Fill in or edit fields inside the property page to create a new **Password Settings** object. The **Name** and **Precedence** fields are required.

1. Under **Directly Applies To**, choose **Add**, type the name of the group to which the fine grained password policy, and then choose **OK**.

1. choose **OK** to submit the creation.

### [PowerShell](#tab/powershell)

Here's how to create a fine grained password policy using the [New-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/new-adfinegrainedpasswordpolicy) cmdlet. For example, to create a new fine grained password policy named TestPWD that applies to the group1 group and sets the lockout duration at 30 mins, the maximum password age as 42 days, the minimum password age as 1 day, the minimum password length as 7 characters, the number of remembered passwords as 24, issue the following command:

<!-- PowerShell must be run as admin or you'll receive the message "New-ADFineGrainedPasswordPolicy -Name "DomainUsersPSO" -Precedence 500 -ComplexityEnabled $true -Description "The Domain Users Password Policy" -DisplayName "Domain Users PSO" -LockoutDuration "0.12:00:00" -LockoutObservationWindow "0.00:15:00" -LockoutThreshold 10" -->

```powershell
$policyParams = @{
    Name = "TestPswd"
    ComplexityEnabled = $true
    LockoutDuration = "00:30:00"
    LockoutObservationWindow = "00:30:00"
    LockoutThreshold = "0"
    MaxPasswordAge = "42.00:00:00"
    MinPasswordAge = "1.00:00:00"
    MinPasswordLength = "7"
    PasswordHistoryCount = "24"
    Precedence = "1"
    ReversibleEncryptionEnabled = $false
    ProtectedFromAccidentalDeletion = $true
}

New-ADFineGrainedPasswordPolicy @policyParams
Add-ADFineGrainedPasswordPolicySubject TestPswd -Subjects group1
```

---

## View a resultant set of policies for a user

### [Active Directory Administrative Center](#tab/adac)

Here's how to view the resultant policy that applies to a specific user using Active Directory Administrative Center (ADAC):

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. Navigate to the user for whom you wish to view the resultant policy settings.

1. choose **View Resultant Password Settings** in the **Tasks** pane.

1. Examine the password setting policy and then choose **Cancel**.

### [PowerShell](#tab/powershell)

Here's how to use the [Get-ADUserResultantPasswordPolicy](/powershell/module/activedirectory/get-aduserresultantpasswordpolicy) cmdlet to view the policy that applies to a specific user. For example, to view the resultant policy that applies to user1, run the command:

```powershell
Get-ADUserResultantPasswordPolicy -Identity test1
```

---

## Edit a fine-grained password policy

To edit a fine-grained password policy perform the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to edit a fine grained password policy using Active Directory Administrative Center (ADAC):

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC **Navigation Pane**, expand **System** and then choose **Password Settings Container**.

1. Select the fine grained password policy you wish to edit and choose **Properties** in the **Tasks** pane.

1. Modify the settings that you wish to change and choose **OK**.

### [PowerShell](#tab/powershell)

Here's how to use the [Set-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/set-adfinegrainedpasswordpolicy) cmdlet to modify an existing policy. For example, to change the password history setting of the TestPswd policy, run the following command:

```powershell
Set-ADFineGrainedPasswordPolicy TestPswd -PasswordHistoryCount:"30"
```

---

## Delete a fine-grained password policy

To delete a fine-grained password policy, perform the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to delete a fine grained password policy using Active Directory Administrative Center (ADAC):

To delete a fine-grained password policy

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes** and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC Navigation Pane, expand **System** and then choose **Password Settings Container**.

1. Select the fine grained password policy you wish to remove and in the **Tasks** pane choose **Properties**.

1. Clear the **Protect from accidental deletion** checkbox and choose **OK**.

1. Select the fine grained password policy, and in the **Tasks** pane choose **Delete**.

1. choose **OK** in the confirmation dialog.

### [PowerShell](#tab/powershell)

Here's how to use the [Remove-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/remove-adfinegrainedpasswordpolicy) cmdlet to delete a fine grained password policy. Remember that you will need to remove deletion protection from the policy before you can remove the policy. To remove the TestPswd policy, run the following PowerShell commands:

```powershell
Set-ADFineGrainedPasswordPolicy -Identity TestPswd -ProtectedFromAccidentalDeletion $False
Remove-ADFineGrainedPasswordPolicy TestPswd -Confirm
```

---
