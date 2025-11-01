# Project Development Log: Morse.Play Web

**Goal:** Build a Neo-Brutalist/Retro-Vibe, adaptive web application for Morse Code conversion and learning.

##  Architectural Foundation & Pivot

The project was rebuilt from scratch to target the web platform and adopt modern, scalable state management.

### Decision: Riverpod vs. Bloc

The original Bloc architecture was replaced by **Riverpod (Notifier/Provider)**.

| Component | Old Architecture (Bloc) | New Architecture (Riverpod) | Rationale |
| :--- | :--- | :--- | :--- |
| **State Mgt.** | `morse_event.dart`, `morse_state.dart`, `morse_bloc.dart` | `MorseConverterNotifier` and `MorseConverterState` | Significantly reduced boilerplate, improved type safety, and simpler state flow for smaller features. |
| **Logic Layer** | Mixed into `morse_bloc.dart` and UI (`textfield.dart`) | Dedicated `MorseService` and `MorseAudioService` | Enforces strict **Separation of Concerns**. Logic is now testable and UI-agnostic. |
| **Cleanup** | Manual `Bloc.close()` | Automatic `ref.onDispose` callback on Providers | Guarantees resource cleanup (e.g., `AudioPlayer`) without manual lifecycle management. |

### New Layered Structure

The project now follows a clean, layered architecture:

*   **`lib/services`**: Business Logic (`MorseService`) and Hardware Control (`MorseAudioService`).
*   **`lib/models`**: Immutable Data Structures (`MorseConverterState`, `AppSection`).
*   **`lib/providers`**: State Controllers (`NavNotifier`, `MorseConverterNotifier`) and Service Access (`morseServiceProvider`, `audioServiceProvider`).
*   **`lib/screens`**: Presentation/UI Layer (`PlatformDecider`, `TheHomePage`).

##  Core Feature Implementation (MVP 1)

The primary Text-to-Morse conversion and audio playback loop are complete.

### Text-to-Morse Conversion Flow

The UI calls the Notifier, which reads the Service to perform the conversion and update the state.

```mermaid
---
title: Text to Morse Code Conversion Flow
---
flowchart LR
    A[TheHomePage: TextField.onChanged]
    B{ref.read(ConverterNotifier).textToMorse(text)}
    C[Service: morseService.textToMorse]
    D[Model: MorseConverterState.copyWith]
    E[UI Rebuilds (Output Text)]

    A --> B
    B --> C
    C --> D
    D --> E
```

### Audio Playback Flow

The audio system was implemented using the standardized **WPM (Words Per Minute)** timing ratios (1:3:7 units). State tracking was added to the Notifier to manage the Play/Stop button UI.

```mermaid
---
title: Audio Playback Flow (Play/Stop Toggle)
---
flowchart TD
    A[TheHomePage: ElevatedButton.onPressed]
    B{ref.read(ConverterNotifier).playMorse()}
    C{Check State: isPlaying?}
    D[Service: audioService.stopAudio()]
    E[State: isPlaying = false]
    F[State: isPlaying = true]
    G[Service: audioService.playMorse(morseCode)]
    H[Audio Finished/Stopped]

    A --> B
    B --> C
    C -- Yes (Stop) --> D --> E
    C -- No (Play) --> F --> G
    G -- on complete/error --> H
    H --> E
```

**Key Technical Decisions:**
*   **WPM Standard:** Audio timings in `MorseAudioService` are based on a 1:3:7 unit ratio for Dot/Dash/Pause, ensuring correct Morse pacing.
*   **Resource Cleanup:** `audioServiceProvider` uses `ref.onDispose(() => audioService.dispose())` to prevent memory leaks from the `AudioPlayer`.

##  Adaptive UI Shell & Navigation

A top-level screen (`PlatformDecider`) was created to manage responsiveness and global navigation state.

### Adaptive Layout Flow

The UI adapts to the screen width using Flutter's `LayoutBuilder`, ensuring a native feel on all platforms.

```mermaid
---
title: Adaptive UI Shell (PlatformDecider)
---
flowchart TD
    A[PlatformDecider.build]
    B{LayoutBuilder: constraints.maxWidth < 600?}
    C[Mobile/Narrow UI]
    D[Desktop/Wide UI]
    E[UI: BottomNavigationBar]
    F[UI: NavigationRail]
    G[Body: getPage(AppSection)]

    A --> B
    B -- Yes --> C
    B -- No --> D
    C --> E & G
    D --> F & G
```

### Navigation State Management

The `NavNotifier` manages the `AppSection` enum, which is watched by the `PlatformDecider` to swap the central body content.

*   **Desktop:** Uses `NavigationRail` to call `navNotifier.changeSection(AppSection)`.
*   **Mobile:** **(Pending Implementation)** Will use a styled `BottomNavigationBar` to call `navNotifier.changeSection(AppSection)`.

##  Next Steps (Phase 6)

1.  **Mobile Navigation:** Implement the styled `BottomNavigationBar` in `PlatformDecider`.
2.  **Neo-Brutalist UI:** Implement the `BrutalistContainer` widget and apply it to `TheHomePage` to achieve the desired high-contrast, retro aesthetic.
3.  **Morse Book:** Implement `MorseBookScreen` to read the data from `MorseService` and display it in a responsive grid.
