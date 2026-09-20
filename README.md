# ACWW Town Rating
These lua scripts will draw your town rating on screen.

# Features
- Walk in an acre to draw its info on screen
- Count trees, flowers, items and weeds in each acre
- On the minimap menu, hold Start to draw a global view of your town's acres and their rating

# How town rating works
Your town is split in 16 chunks of 16x16 tiles called "acres". Each acre is rated individually to determine your global town rating.<br><br>
There are 3 possible ratings for an acre: perfect, acceptable and unacceptable. Having a perfect town requires having 8 or more perfect acres and exactly 0 unacceptable acres.<br><br>
For more info on how to achieve a perfect acre, check the [Thonky guide](https://www.thonky.com/acww/perfect-town-guide). This script heavily relies on this guide even if it is not exactly 100% accurate. To make it short, a perfect acre must have at least 3 flowers, between 12 and 15 trees and not more than 2 items and 2 weeds.

# Installing
- Download the [DeSmuME emulator](https://github.com/TASEmulators/desmume/releases/latest)
- Download the [code of the repo](https://github.com/Anthcny144/ACWW-town-rating/archive/refs/heads/main.zip)
- Extract the content and move `lua5.1.dll` and `lua51.dll` to the root of your DeSmuME folder 
- Open the emulator, load your ROM and load your save file (File -> Import Backup Memory...)
- Open a lua window: Tools -> Lua Scripting -> New Lua Script Window...
- Load the lua scripts: click "Browse..." and choose `Main.lua`. Make sure the `Scripts` folder is located in the same directory as `Main.lua`
- If nothing is drawn on screen despite being in an acre, try to disable 3D upscaling: Config -> 3D Settings

# Compatibility
The script only supports the european version for now, and only works on DeSmuME.