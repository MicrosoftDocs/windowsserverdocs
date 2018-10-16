---
title: Windows Admin Center UI text and design style guide
description: Windows Admin Center UI text and design style guide SDK
ms.technology: manage
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 10/16/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Windows Admin Center UI text and design style guide

>Applies To: Windows Admin Center

This topic describes the general approach to writing user interface (UI) text for the Windows Admin Center, as well as some specific conventions and approaches we're taking.

Windows Admin Center and any extensions should follow [Microsoft's voice principles](https://docs.microsoft.com/style-guide/brand-voice-above-all-simple-human) so that the experience is easy to use and friendly. This style guide builds on these voice principles as well as the [Microsoft Writing Style Guide](https://docs.microsoft.com/style-guide/welcome/), so make sure to check out both of those resources for info on such things as [accessibility](https://docs.microsoft.com/style-guide/accessibility/accessibility-guidelines-requirements), [acronyms](https://docs.microsoft.com/style-guide/acronyms), and [word choice](https://docs.microsoft.com/style-guide/word-choice/) such as [please](https://docs.microsoft.com/style-guide/a-z-word-list-term-collections/p/please), and [sorry](https://docs.microsoft.com/style-guide/a-z-word-list-term-collections/s/sorry).

## Buttons

- Buttons should be one word whenever possible, especially if you plan to localize your tool.
- Button labels should be concise, specific, and self-explanatory. Instead of a generic "Submit" button, use a verb corresponding to the user action, such as "Create", "Delete", "Add", "Format", etc.
- If a button follows a question, its label should correspond clearly to the question (typically "Yes" or "No").

## Capitalization

We follow the Microsoft style for [Capitalization](https://docs.microsoft.com/style-guide/capitalization) - use sentence-style capitalization for pretty much everything.

However, Windows Admin Center is making a couple exceptions:

| UI element              |Capitalization|Comments|
|-------------------------|--------------|--------|
|Badges (such as PREVIEW) |All caps      ||
|Everything else          |Sentence-style|However, there are a few exceptions where we surface object properties from WMI or PowerShell that's outside of our control.|

## Confirmation messages

Confirmation dialogs are useful when continuing might have unexpected results, such as data loss. They should contain scannable, useful info with a clear outcome, especially for events that can’t be reversed. 

- Make sure a confirmation is necessary. If there’s no new info to offer (for example, “Are you sure?”) then a confirmation message may not be necessary.  
- Verify that the customer wants to proceed with the action.
- Make sure the main instruction (heading) and explanatory text (body) aren’t redundant.
- In the heading, define the possible outcomes as a question or a statement about what will happen next. For example, “Erase all data on this drive? or “You’re about to erase all your data”.
- Add details in the body. If there’s a variable, such as the name of the item you’re about change, include it here.
- Include a simple question (either in the header or in the body) that frames a clear choice between two action buttons.
- For a complex choice, use Yes/No buttons, which encourage careful reading. For a simpler choice, use buttons that are specific to the action, such as Delete all or Cancel.



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

## Help links

Here are some tips from our Windows style guide:

### When should we provide a Help link?

Almost never. Provide a help link only when:

- There's an obvious and important question that customers are likely to have while they're in the UI the answer to which will help them succeed at the UI task. 
- There's not enough room in the UI to provide the amount of information necessary for users to succeed at the UI task. 

### Where should help links appear? 

- Text links should appear as close to the UI element that the help is directed at as possible. 
- If you must provide a text link that applies to an entire UI screen, place it at the bottom left of the screen. 
- If you provide a link through a Help button (?), the tooltip should be "Help."

### What URL should we use?

Never link directly to a web address--instead use a redirection service.

Microsoft developers should use an FWLink except when it's a help link that users might have to manually type, in which case use an aka.ms link (as long as the target of the URL is a website that automatically recognizes the browser locale, such as Docs.microsoft.com)

### Text guidelines 

- Use full sentences.
- Do not include ending punctuation except for question marks. 
- You don't need to use the same text as the task title; use text that makes sense in the context of the UI, but make sure that there's a logical connection between the two. For example: 
- Help link: What are the risks of allowing exceptions? 
- Help topic title: "Allowing a program to communicate through Windows Firewall"
- Be as specific as possible about the content of the help topic. 
    - Our style
        - How does Windows Firewall help protect my computer?
        - Why highlights can improve a picture
    - Not our style
        - More information about Windows Firewall
        - Learn more about color management
        - Learn more
- Use the entire sentence for the link text, not just the key words. 
    - Our style 
        - [What are the risks of allowing exceptions?]()
    - Not our style
        - What are the [risks of allowing exceptions]()? 

## Punctuation

- No ending punctuation (periods, question marks) for headings or incomplete sentences. An exception is in a confirmation dialog where the heading asks the question
- Use Microsoft Style Guide's guidance on [periods](https://docs.microsoft.com/style-guide/punctuation/periods) and [question marks](https://docs.microsoft.com/style-guide/punctuation/question-marks).

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
|In progress         |Start with the verb of the action you're performing and end with ellipses to indicate an ongoing operation. Here's an example:<br> *Creating the volume "Customer data"...*|
|Success             |Start with "Successfully" and end with what the software just did. Here's an example:<br> *Successfully created the volume "Customer data".*|
|Failure             |Start with "Couldn't" and end with what the software couldn't do. Here's an example:<br> *Couldn't create the volume "Customer data".*|
