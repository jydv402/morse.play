# What I have done
- Built the basic MVP 1
- Contains just the text to morse code conversion
- UI layer gets and input from the user and shows the converted text
```mermaid
---
title: MVP 1
---
flowchart LR
    UI input --> Notifier (MorseConverterProvider.textToMorse()) --> Service (Does the conversion -> MorseService.textToMorse()) --> Update state and UI rebuilt 

```