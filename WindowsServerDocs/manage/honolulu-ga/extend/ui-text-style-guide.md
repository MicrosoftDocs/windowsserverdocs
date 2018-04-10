---
# Mandatory fields. See more on aka.ms/skyeye/meta.
title: Intent and product brand in a unique string of 43-59 chars including spaces - do not include site identifier (it is auto-generated.)
description: 115-145 characters including spaces. Edit the intro para describing article intent to fit here. This abstract displays in the search result.
keywords: Don’t add or edit keywords without consulting your SEO champ.
author: jasongerend
ms.author: jgerend
ms.date: 04/03/2018
ms.topic: article-type-from-white-list
# Use only one of the following. Use ms.service for services, ms.prod for on-prem. Remove the # before the relevant field.
# product-name-from-white-list
# manager: MSFT-alias-manager-or-PM-counterpart
---
# Windows Admin Center UI text and design style guide

This topic describes the general approach to writing user interface (UI) text for the Windows Admin Center, as well as some specific conventions and approaches we're taking.

Windows Admin Center and any extensions should follow [Microsoft's voice principles](https://docs.microsoft.com/style-guide/brand-voice-above-all-simple-human) so that the experience is easy to use and friendly. This style guide builds on these voice principles as well as the [Microsoft Writing Style Guide](https://docs.microsoft.com/en-us/style-guide/welcome/), so make sure to check out both of those resources for info on such things as [accessibility](https://docs.microsoft.com/en-us/style-guide/accessibility/accessibility-guidelines-requirements), [acronyms](https://docs.microsoft.com/en-us/style-guide/acronyms), and [word choice](https://docs.microsoft.com/en-us/style-guide/word-choice/) such as [please](https://docs.microsoft.com/en-us/style-guide/a-z-word-list-term-collections/p/please), and [sorry](https://docs.microsoft.com/en-us/style-guide/a-z-word-list-term-collections/s/sorry).

## Capitalization

We follow the Microsoft style for [Capitalization](https://docs.microsoft.com/en-us/style-guide/capitalization) - use sentence-style capitalization for pretty much everything.

However, Windows Admin Center is making a few exceptions:

| UI element              |Capitalization|Comments|
|-------------------------|--------------|--------|
|Tool and extension names |Title-style   |Keeps all tools & extension names consistent in the TOC & first heading within a tool.|
|Badges (such as PREVIEW) |All caps      ||
|Everything else          |Sentence-style|However, there are a few exceptions where we surface object properties from WMI or PowerShell that's outside of our control.|

## Punctuation

- No ending punctuation (periods, question marks) for headings or incomplete sentences. An exception is in a confirmation dialog where the heading asks the question
- Use Microsoft Style Guide's guidance on [periods](https://docs.microsoft.com/style-guide/punctuation/periods) and [question marks](https://docs.microsoft.com/en-us/style-guide/punctuation/question-marks).

## Buttons

- Buttons should be one word whenever possible, especially if you plan to localize your tool.
- Button labels should be concise, specific, and self-explanatory. Instead of a generic "Submit" button, use a verb corresponding to the user action, such as "Create", "Delete", "Add", "Format", etc.
- If a button follows a question, its label should correspond clearly to the question (typically "Yes" or "No").

## Confirmation messages

- Use an "Are you sure?" message only if the consequence of the action is dire or potentially expensive; otherwise, it's an annoying interruption. For example, taking important resources offline, deleting data, or signing up for a paid service would warrant a confirmation message, while creating a local VM or folder wouldn't.
- Be specific about the consequences, if known.
- Use [Yes] or [No] buttons if it's important for customers to understand the consequences before making a decision, even though this isn't as specific as we usually like to be. [Yes] [No] makes customers read the message.
- If it's really important customers pay attention before doing something - such as deleting all their critical data - use an extra control for confirmation, such as a checkbox or a textbox asking the user to type the volume name or similar.

## Empty pages (first-run experiences)

The first time a user visits a page, you have an opportunity to help them get started with your tool. This could be:

- A text string in an empty page with short instructions on how to get started - for example, "Select 'Add' to add an app."
- A link to the control that gets the user started - for example, "Add an app to get started."
- A small and short animation or video showing the user how to get started

Here are some tips from our Windows style guide:

### 1. Be helpful

- Avoid marketing style and language.
- When you demo or suggest something, make sure the end result is clear; just showing the customer how to do something isn’t effective if they don’t know why they are doing it.
- Don’t present tips if the customer doesn’t need them.

### 2. Show, don't tell

Keep your text simple as possible (think small animations or videos).

### 3. Don't overwhelm

- Limit pop-ups and tips to 4 per usage session combined—including system notifications and shell notifications.
- Make sure the timing of pop-ups is helpful.
- Don’t prevent the customer from doing something.
- Make sure pop-ups are easily dismissed.

### 4. Keep it contextual

- Teaching moments are most effective when presented at the right time.
- If you create tutorials or slideshows, keep the info concrete.
- No marketing “fluff”—focus on specific tips and tricks.
- Provide a way for customers to return to the tutorial later, if relevant (people often don’t retain info the first time, but setup instructions might only be relevant once).
- Empty-state messaging is a natural place for learning and/or delight—keep it simple and informative.

### 5. Minimize painful setup

When you need the customer to perform another action to experience full value (sign-in to an online service, etc.), make it as painless as possible.

- Messaging should be short and direct.
- Avoid sending them away. If possible, provide a means to connect from where they are.
- If you can, allow the option to do it later, and then remind them to do it later.
- If you take them out of their experience, provide a way to switch back quickly and easily.

## Status messages

Status messages consist of pop-up (toast) messages and notifications.

|String type         | Notes                               |
|------------        |-------------------------------------|
|Toast               |Sentence case with ending punctuation - ideally with an object variable so users can understand what object the message applies to in case they've navigated away from the object|
|Notification heading|Sentence case w/out ending punctuation (it's a heading) - ideally with an object variable|
|Notification details|Full sentences, ideally with a link to the UI that displays the object|

Here are some detailed recommendations for notification messages:

|String type         | Notes                               |
|------------        |-------------------------------------|
|Started             |Omit when possible - usually you can just skip to the in-progress message to minimize the number of distractions.|
|In progress         |Start with the verb of the action you're performing and end with elipses to indicate an ongoing operation. Here's an example:<br> *Creating the volume "Customer data"...*|
|Success             |Start with "Successfully" and end with what the software just did. Here's an example:<br> *Successfully created the volume "Customer data".*|
|Failure             |Start with "Couldn't" and end with what the software couldn't do. Here's an example:<br> *Couldn't create the volume "Customer data".*|
