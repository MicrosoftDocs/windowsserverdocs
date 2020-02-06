---
title: Windows Admin Center UI text and design style guide
description: Windows Admin Center UI text and design style guide SDK
ms.technology: manage
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 01/17/2020
ms.localizationpriority: medium
ms.prod: windows-server
---

# Windows Admin Center UI text and design style guide

>Applies To: Windows Admin Center

This topic describes the general approach to writing user interface (UI) text for the Windows Admin Center, as well as some specific conventions and approaches we're taking.

Windows Admin Center and any extensions should follow [Microsoft's voice principles](https://docs.microsoft.com/style-guide/brand-voice-above-all-simple-human) so that the experience is easy to use and friendly. This style guide builds on these voice principles as well as the [Microsoft Writing Style Guide](https://docs.microsoft.com/style-guide/welcome/), so make sure to check out both of those resources for info on such things as [accessibility](https://docs.microsoft.com/style-guide/accessibility/accessibility-guidelines-requirements), [acronyms](https://docs.microsoft.com/style-guide/acronyms), and [word choice](https://docs.microsoft.com/style-guide/word-choice/) such as [please](https://docs.microsoft.com/style-guide/a-z-word-list-term-collections/p/please), and [sorry](https://docs.microsoft.com/style-guide/a-z-word-list-term-collections/s/sorry).

## Buttons

- Buttons should be one word whenever possible, especially if you plan to localize your tool. Two or three is OK but try to avoid longer. If you have four words or longer, it'd be better to use a link control.
- Button labels should be concise, specific, and self-explanatory. Instead of a generic "Submit" button, use a verb corresponding to the user action, such as "Create", "Delete", "Add", "Format", etc.
- If a button follows a question, its label should correspond clearly to the question (typically "Yes" or "No").

## Capitalization

We follow the Microsoft style for [Capitalization](https://docs.microsoft.com/style-guide/capitalization) - use sentence-style capitalization for pretty much everything.

| UI element              |Capitalization|Comments|
|-------------------------|--------------|--------|
|Badges (such as PREVIEW) |All caps      ||
|Everything else          |Sentence-style|However, there are a few exceptions where we surface object properties from WMI or PowerShell that's outside of our control.|

## Colons

Use colons to introduce lists. For example:

    Choose one of the following:
    Cats
    Dogs
    Quokkas

Don't use colons in UI text when a label is on a different line from the thing it labels or when there's a clear distinction between the label and the thing it's labeling.

Use colons in UI text when a label is on the same line as the text it labels and you need to keep the two elements from running together.

## Confirmation messages

Confirmation dialogs are useful when continuing might have unexpected results, such as data loss. They should contain scannable, useful info with a clear outcome, especially for events that can't be reversed. 

- Make sure a confirmation is necessary. If there's no new info to offer (for example, “Are you sure?”) then a confirmation message may not be necessary.  
- Verify that the customer wants to proceed with the action.
- Make sure the main instruction (heading) and explanatory text (body) aren't redundant.
- In the heading, define the possible outcomes as a question or a statement about what will happen next. For example, “Erase all data on this drive? or “You're about to erase all your data”.
- Add details in the body. If there's a variable, such as the name of the item you're about change, include it here.
- Include a simple question (either in the header or in the body) that frames a clear choice between two action buttons.
- For a complex choice, use Yes/No buttons, which encourage careful reading. For a simpler choice, use buttons that are specific to the action, such as Delete all or Cancel.

## First-run experiences

The first time a user visits a page, you have an opportunity to help them get started with your tool. This could be:

- A text string in an empty page with short instructions on how to get started - for example, "Select 'Add' to add an app."
- A link to the control that gets the user started - for example, "Add an app to get started."
- A small and short animation or video showing the user how to get started

Here are some tips from our Windows style guide:

### 1. Be helpful

- Avoid marketing style and language.
- When you demo or suggest something, make sure the end result is clear; just showing the customer how to do something isn't effective if they don't know why they are doing it.
- Don't present tips if the customer doesn't need them.

### 2. Show, don't tell

Keep your text simple as possible (think small animations or videos).

### 3. Don't overwhelm

- Limit pop-ups and tips to 4 per usage session combined—including system notifications and shell notifications.
- Make sure the timing of pop-ups is helpful.
- Don't prevent the customer from doing something.
- Make sure pop-ups are easily dismissed.

### 4. Keep it contextual

- Teaching moments are most effective when presented at the right time.
- If you create tutorials or slideshows, keep the info concrete.
- No marketing “fluff”—focus on specific tips and tricks.
- Provide a way for customers to return to the tutorial later, if relevant (people often don't retain info the first time, but setup instructions might only be relevant once).
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

Never link directly to a web address—instead use a redirection service.

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

## Error messages

Here's some guidance adapted from the Windows Style Guide:

Writing a good message is a balance between providing enough explanation but not being overly technical; between being casual and personable but not annoying or offensive.

### General guidelines

Use one message per error case.

#### Headings

- Keep it brief and explain concisely what the problem is or **ideally what to do**. <br>Some UI surfaces may have headings that truncate instead of wrapping when they're too long, so keep an eye out for these.
- Use the solution in the heading if it's a simple step.
- Make sure that the heading relates directly to the button in case the reader ignores the body text.
- Avoid using "There was a problem" in headings, unless you have no other choice. Be more specific about the problem.
- Avoid using variables (such as file, folder, and app names) in headings. Put them in the body.

#### Body

- If the heading sufficiently explains the problem or solution, you don't need body text.
- Don't repeat the title in the message with slightly different wording.
- Communicate clearly and concisely what the solution is.
- Focus on giving the facts first.
- Don't blame users for the error.
- If there is an error code associated with the error and if you think that including the error code might help the customer or Microsoft support to research the issue, include it directly below the body text and write it as follows:

    Error code: ####

    If the customer has all the info necessary to resolve the error without the code, you don't need to include it.

#### Buttons

- Write button text so that it's a specific response to the main instruction. If that's not possible, use "Close" for the dismissal button text (instead of "Okay" or "Done").
- If you have more than one button, make the leftmost button the action the user is encouraged to take. Make the rightmost button the more conservative action, such as "Cancel."

#### Help links

Only consider Help links for error messages that you can't make specific and actionable.

## Null state text

Here's some help from the Windows Style Guide.

Null state occurs when customer data or content is absent from an app or feature, when no results are returned after a search, or when required information is missing from a form, such as billing information for a transaction.

### Guidelines

- If possible, use null state situations as an opportunity to educate people about how to use the feature (for example, how to add music, where to find pictures, etc.)  
  - If you have a title in your UI, explain the action to take to “fix” the null state (for example, “Add some music”) 
  - Have fun with the text. This space can be an opportunity to provide delight since it will probably not be seen several times. 
  - Avoid “It's lonely in here.” This is sad and has been overused. 
  - Avoid questions like “Haven't connected your printer?” Okay to use once, but this format tends to get overused, and questions put extra burden/pressure on the customer. It can also feel condescending. 
  - Variety in null state text is a good thing. 

### Examples

- "Add someone as a favorite, and you'll see them here."
- "Got any achievements or game clips you're particularly proud of? Add them to your showcase."
- "No one's in a party yet. Start one up!"
- "When someone adds you as a friend, you'll see them here."
- "When you do stuff like unlock achievements, record game clips, and add friends, you'll see it all here."
- "Your favorite friends will show up here, so you can see when they're online and what they're up to."

## Punctuation

- No ending punctuation (periods, question marks) for headings or incomplete sentences. An exception is in a confirmation dialog where the heading asks the question
- Use Microsoft Style Guide's guidance on [periods](https://docs.microsoft.com/style-guide/punctuation/periods) and [question marks](https://docs.microsoft.com/style-guide/punctuation/question-marks).

## Status messages

Status messages consist of pop-up (toast) messages and notifications.

|String type         | Notes                               |
|------------        |-------------------------------------|
|Toast               |Sentence case with ending punctuation - ideally with an object variable so users can understand what object the message applies to in case they've navigated away from the object|
|Notification heading (title) |Sentence case without ending punctuation (it's a heading) - ideally with an object variable|
|Notification details|Full sentences, ideally with a link to the UI that displays the object|

Here are some detailed recommendations for notification messages:

|String type         | Notes                               |
|------------        |-------------------------------------|
|Started             |Omit when possible - usually you can just skip to the in-progress message to minimize the number of distractions.|
|In progress         |Start with the verb of the action you're performing and end with ellipses to indicate an ongoing operation. Here's an example:<br> *Creating the volume 'Customer data'...* <br><br>When there are multiple variables, use this pattern: <br>*Deleting the following virtual machine: {0}; Host: {1}* |
|Success             |Start with "Successfully" and end with what the software just did. Here's an example:<br> *Successfully created the volume 'Customer data'.*|
|Failure             |Start with "Couldn't" and end with what the software couldn't do. Here's an example:<br> *Couldn't create the volume 'Customer data'.*|

## Tooltips

Good tooltips briefly describe unlabeled controls or provide a bit of additional info for labeled controls, when this is useful. They can also help customers navigate the UI by offering additional—not redundant—information about control labels, icons, links, etc.

Tooltips should be used sparingly or not at all. They can be an interruption to the customer, so don't include a tooltip that simply repeats a label or states the obvious. It should always add valuable info.

|    Context                                 |    How to write the tooltips    |
|    -----------------------                 |    -------------------------    |
|When a control or UI element is unlabeled...|Use a simple, descriptive noun phrase. For example:<br> Highlighting pen |
|When a UI element is labeled, but its purpose needs clarification…|<ul><li>Briefly describe what you can do with this UI element. </li><li>Use the imperative verb form. For example, "Find text in this file" (not "Finds text in this file").</li><li>Don't include end punctuation unless there are multiple complete sentences.</li> </ul>|
|When a text label is truncated or likely to truncate in some languages…|<ul><li>Provide the untruncated label in the tooltip.</li><li>Optional: On another line, provide a clarifying description, but only if needed.</li><li>Don't provide a tooltip if the untruncated info is provided elsewhere on the page or flow.</li></ul>|
|If a keyboard shortcut is available…|<ul><li>Optional: Provide the keyboard shortcut in parentheses following the label or descriptive phrase, e.g. "Print (Ctrl+P)" or "Find text in this file (Ctrl+F)"</li><li>It's OK to add a useful keyboard shortcut to a clarifying tooltip, but avoid adding a tooltip only to show a keyboard shortcut. </li></ul>|