# FiveM [EssentialMode] CarWash

Quick Disclaimer: this script is an edited version of [this one](https://forum.fivem.net/t/release-carwash-updated/9615), to add a payment functionality nothing else!

This is my first Lua script, lets start with something simple.

Hello everyone, I made this edit a couple of days ago and gave it to the Real Men of Genius community (the owners of the Revolution Life RP servers) so they could use it on their servers, if you play there (my rp name is "Tyreese Wills") you might find this is not completely equal, that's because 1- they have a custom money system they do not use EssentialMode, 2- they edited the messages to their liking and 3- I also made some edits after giving them the script.

### Requirements

>[EssentialMode Base](https://github.com/FiveM-Scripts/essentialmode)

### Installation

>1- Drag and Drop the carwash folder into the resources folder;
>
>2- add this line "    - carwash" on citmp-server.yml under the "AutoStartResources:".

**Extremelly important: step 2 needs to be bellow the "    - essentialmode" line so the requirements load first.**

### Optional

If you wish to edit how much money is spent to wash the car open "carwash_client.lua" with your favorite text editor (notepad++ recommended) and edit the value on the variable "price" to whatever number you want:

![Full size preview](http://image.prntscr.com/image/f289eae816f84ae5918d8035d26b4291.png)
