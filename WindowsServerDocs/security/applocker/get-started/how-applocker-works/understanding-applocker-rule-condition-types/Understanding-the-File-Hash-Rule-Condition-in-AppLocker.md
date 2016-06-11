---
title: Understanding the File Hash Rule Condition in AppLocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2b200b9c-dd27-4a4e-ac90-9bcf42b14f1d
---
# Understanding the File Hash Rule Condition in AppLocker
This topic explains the AppLocker file hash rule condition, the advantages and disadvantages, and how it is applied.

File hash rules use a system\-computed cryptographic hash of the identified file. For files that are not digitally signed, file hash rules are more secure than path rules. The following table describes the advantages and disadvantages of the file hash condition.

|File hash condition advantages|File hash condition disadvantages|
|----------------------------------|-------------------------------------|
|Because each file has a unique hash, a file hash condition applies to only one file.|Each time that the file is updated \(such as a security update or upgrade\), the file's hash will change. As a result, you must manually update file hash rules.|

For an overview of the three types of AppLocker rule conditions and explanations of the advantages and disadvantages of each, see [Understanding AppLocker Rule Condition Types]().

## See Also
[How AppLocker Works]()


