# __CIS*3260 - Software Design IV__
### **Milestone 3 - A-IM**
**Due:** 13/11/2023 
<br>

### **By Group 1**
<u>Members:</u>
- Jose Cortez
- Chris Fitzgerald
- Samuel Guilbeault
- Abdullah Khan
- Shayan Mohammed
- Austin Van Braeckel

## Task
### Implemented **Fanorona** by Group 2 based on their design
***Notes:***
- Some parts of the design were not possible to implement due to design flaws, which is explained in the internal documentation of the code, which are comments starting with *DESIGN FLAW ->*
- The program is mostly functional due to stubbing-out functions that weren't implementable
  - However, the game is not fully playable in this state due to the design flaws, but it is mostly playable, being able to move pieces and capture pieces

## How to Run:
Simply use ruby to run the "RunFanorona.rb" file to start the game, which is not part of the design, but is used to show the functionality/correctness of the code we developed for this design.

    ruby RunFanorona.rb

This will start the game and allow the user to interact with it via the terminal/command line, as specified by the design.

<br>

***Notes:***
- option 2 when starting a game, "Join game", is not connected to anything, as the design doesn't detail what should be done (no functions for it exists)
  - it will have no ouput if selected in the keyboard/text UI
  - Not implementable since the game is single-player, and this feature is not detailed at all in the design anyways
