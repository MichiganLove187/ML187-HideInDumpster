# ML187 Hide in Dumpster

A script that allows players to hide inside trash cans and dumpsters. Police officers can search trash cans to find hidden players.

## Features
- Hide inside trash cans/dumpsters
- Exit trash cans/dumpsters
- Police can search trash cans to find hidden players

## Framework Support
This script supports both QBCore and QBox frameworks. You can select which framework to use in the config.lua file.

## Target System Support
This script supports both qb-target and ox_target systems. You can select which target system to use in the config.lua file.

## Installation

1. Place the `ml187-hideindumpster` folder in your server's resources directory
2. Add `ensure ml187-hideindumpster` to your server.cfg
3. Configure the script in `config.lua` to match your server's needs
4. Set the `Config.Framework` option to either "qbcore" or "qbox" depending on your server
5. Set the `Config.Target` option to either "qb-target" or "ox_target" depending on your server

## Configuration

In `config.lua`, you can configure:
- Which framework to use (QBCore or QBox)
- Which target system to use (qb-target or ox_target)
- Trash can model hashes
- Target interaction distance
- Language settings

## Dependencies
- QBCore or QBox framework
- qb-target or ox_target

## Usage
- Approach a trash can and use the target system to interact with it
- Select "Hide in Trash Can" to hide inside
- Select "Exit Trash Can" to get out
- Police officers can select "Search Trash Can" to check if someone is hiding inside
