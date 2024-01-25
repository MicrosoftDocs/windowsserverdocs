---
title: Windows LAPS passwords and passphrases
description: Documents password and passphrase details for Windows Local Administrator Password Solution (Windows LAPS).
author: jay98014
ms.author: jsimmons
ms.date: 12/25/2023
ms.topic: conceptual
---

# Windows LAPS passwords and passphrases

Learn about how passwords and passphrases are created for Windows Local Administrator Password Solution (Windows LAPS).

## Overview

The primary purpose of Windows LAPS is regularly rotate the password of a local Windows account. It's important to understand how Windows LAPS generates random passwords (or random passphrases).

## Password character sets

Windows LAPS supports five different complexity settings that can be used to generate random passwords. The PasswordComplexity policy setting is used to choose which character sets are used when creating a password:

|PasswordComplexity setting|Character sets|
|---|---|
|1|"ABCDEFGHIJKLMNOPQRSTUVWXYZ"|
|2|"ABCDEFGHIJKLMNOPQRSTUVWXYZ"<br/><br/>"abcdefghijklmnopqrstuvwxyz"|
|3|"ABCDEFGHIJKLMNOPQRSTUVWXYZ"<br/><br/>"abcdefghijklmnopqrstuvwxyz"<br/><br/>"0123456789"|
|4|"ABCDEFGHIJKLMNOPQRSTUVWXYZ"<br/><br/>"abcdefghijklmnopqrstuvwxyz"<br/><br/>"0123456789"<br/><br/>",.-+;!#&@{}[]$/()%"|
|5|"ABCDEFGHJKLMNPRSTUVWXYZ"<br/><br/>"abcdefghijkmnpqrstuvwxyz"<br/><br/>"23456789"<br/><br/>"!#%+@:=?*"|

When a complexity setting with multiple character sets is chosen, Windows LAPS ensures that the resultant password contains at least one character randomly chosen from each character set.

The length of passwords is controlled using the PasswordLength policy setting. Passwords created by Windows LAPS default to 14 characters in length, and can be configured to be anywhere from 8-64 characters in length.

Password complexity setting five is equivalent to password complexity setting four, with  the following modifications made to improve readability and avoid confusion. The differences between setting four and setting five are as follows:

- Removes the letters 'I', 'O', 'Q', 'l', and 'o'
- Removes the numbers '0' and '1'
- Removes the symbols ',', '.', '&', '{', '}', '[', ']', '(', ')', and ';'
- Adds the symbols ':', '=', '?', and '*'

> [!IMPORTANT]
> The PasswordComplexity setting of '5' is supported in Windows 11 Insider Preview Build 26040 and later.

## Passphrase word lists

Windows LAPS supports three different complexity settings that can be used to generate random passphrases. The PasswordComplexity policy setting is used to choose which word lists are used when creating a passphrase:

|PasswordComplexity setting|Description|Number of words in list|
|---|---|---|
|6|Long words|7776|
|7|Short words|1276|
|8|Short words with unique prefixes|1276|

The length of passphrases is controlled using the PassphraseLength policy setting. Passphrases created by Windows LAPS default to six words in length, and can be configured to be anywhere from three to 10 terms in length. The first character of each word is always capitalized for improved readability. No punctuation or other dividing characters are used between words.

Example of a passphrase created with six words taken from the "Long words" list:

`SkiingProduceIdentifyStarlitOctaneDistress`

Passphrase word lists were taken from ["Deep Dive: EFF's New Wordlists for Random Passphrases"](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases) by [Electronic Frontier Foundation](https://www.eff.org/), and are used under a CC-BY-3.0 Attribution license. The specific contents of all Windows LAPS passphrase word lists can be downloaded from [Windows LAPS Passphrase Word Lists](https://go.microsoft.com/fwlink/?linkid=2255471). Microsoft made slight modifications to the original word lists; all changes are detailed in the downloadable lists.

> [!IMPORTANT]
> Windows LAPS passphrase support is supported in Windows 11 Insider Preview Build 26040 and later.

## Entropy considerations

Windows LAPS creates truly random passwords and passphrases (no human bias is possible). It's therefore simple to calculate the resultant bits of entropy for a password\passphrase of a given length. The following table lists the resulting bits of entropy across a sample set of password\passphrase lengths.

The supported password complexity settings are listed across the top of the table, and password\passphrase lengths are listed down the left hand side. The entropy values for the *default* policy length settings are **bolded**:

|PasswordComplexity setting -><br/><br/>Password or passphrase length<br/><br/>V|1|2|3|4|5|6|7|8|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|3||||||39|31|31|
|4||||||52|41|41|
|5||||||65|52|52|
|**6**||||||**78**|**62**|**62**|
|7||||||90|72|72|
|8|38|46|48|51|48|103|83|83|
|9|42|51|54|57|54|116|93|93|
|10|47|57|60|63|60|129|103|103|
|11|52|63|65|70|66|||
|12|56|68|71|76|72|||
|13|61|74|77|82|78|||
|**14**|**66**|**80**|**83**|**89**|**84**|||
|20|94|114|119|126|120|||
|40|188|228|238|253|240|||
|60|282|342|357|379|360|||

At the higher end of the allowable length ranges, the entropy levels could be considered excessive for most normal IT environments. Consider that there's usually a security versus usability tradeoff involved. For example, it's difficult for human beings to read and type long and complex passwords. Switching to passphrases is a useful way to improve these issues while still retaining a reasonable amount of entropy. If maximizing security is a paramount concern you might instead consider alternative protections, for example maintaining the managed account in a disabled state by default.

## See also

- [Key concepts in Windows LAPS](laps-concepts-overview.md)
- [Windows LAPS account management modes](laps-concepts-account-management-modes.md)

## Next steps

Now that you understand how passwords and passphrases are created, take a look at these other sections.

- [Get started with Windows LAPS for Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS for Microsoft Entra ID](laps-scenarios-azure-active-directory.md)
