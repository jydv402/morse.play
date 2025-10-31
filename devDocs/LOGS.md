# What I have done
- Built the basic MVP 1
- Contains just the text to morse code conversion
- UI layer gets and input from the user and shows the converted text
```mermaid
---
title: MVP 1
---
graph LR
    class UIInput
    class Notifier
    class Service
    class UpdateStateAndUI

    UIInput --> Notifier[textToMorse()]
    Notifier --> Service[textToMorse()]
    Service --> UpdateStateAndUI[]

```