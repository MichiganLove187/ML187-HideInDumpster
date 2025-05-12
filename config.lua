Config = {}

-- Framework settings
Config.Framework = "qbcore" -- Options: "qbcore" or "qbox"
Config.Target = "qb-target" -- Options: "qb-target" or "ox_target"

Config.Debug = true

Config.TrashCans = {
    Hash = {218085040, 1748268526, -58485588, 666561306}, -- trash can model
    Distance = 1.5, -- target distance
}

-- Language settings
Lang = {
    Hide = "Hide in Trash Can",
    Exit = "Exit Trash Can",
    NotInside = "You are not inside a trash can",
    SearchFound = "Someone is hiding inside this trash can!",
    SearchEmpty = "No one is inside this trash can."
}
