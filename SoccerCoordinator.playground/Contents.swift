// Part 1
// Define players (from SoccerPlayerInfo.xlsl)
let players = [
    ["name": "Joe Smith",           "height": 42, "experience": true,   "guardians": "Jim and Jan Smith"],
    ["name": "Jill Tanner",         "height": 36, "experience": true,   "guardians": "Clara Tanner"],
    ["name": "Bill Bon",            "height": 43, "experience": true,   "guardians": "Sara and Jenny Bon"],
    ["name": "Eva Gordon",          "height": 45, "experience": false,  "guardians": "Wendy and Mike Gordon"],
    ["name": "Matt Gill",           "height": 40, "experience": false,  "guardians": "Charles and Sylvia Gill"],
    ["name": "Kimmy Stein",         "height": 41, "experience": false,  "guardians": "Bill and Hillary Stein"],
    ["name": "Sammy Adams",         "height": 45, "experience": false,  "guardians": "Jeff Adams"],
    ["name": "Karl Saygan",         "height": 42, "experience": true,   "guardians": "Heather Bledsoe"],
    ["name": "Suzane Greenberg",    "height": 44, "experience": true,   "guardians": "Henrietta Dumas"],
    ["name": "Sal Dali",            "height": 41, "experience": false,  "guardians": "Gala Dali"],
    ["name": "Joe Kavalier",        "height": 39, "experience": false,  "guardians": "Sam and Elaine Kavalier"],
    ["name": "Ben Finkelstein",     "height": 44, "experience": false,  "guardians": "Aaron and Jill Finkelstein"],
    ["name": "Diego Soto",          "height": 41, "experience": true,   "guardians": "Robin and Sarika Soto"],
    ["name": "Chloe Alaska",        "height": 47, "experience": false,  "guardians": "David and Jamie Alaska"],
    ["name": "Arnold Willis",       "height": 43, "experience": false,  "guardians": "Claire Willis"],
    ["name": "Phillip Helm",        "height": 44, "experience": true,   "guardians": "Thomas Helm and Eva Jones"],
    ["name": "Les Clay",            "height": 42, "experience": true,   "guardians": "Wynonna Brown"],
    ["name": "Herschel Krustofski", "height": 45, "experience": true,   "guardians": "Hyman and Rachel Krustofski"]
]

// Part 2
// Initialize teams
let numTeams = 3
var teamSharks: [[String: Any]] = []
var teamDragons: [[String: Any]] = []
var teamRaptors: [[String: Any]] = []

// Divide players into experienced and inexperienced players
var experiencedPlayers: [[String: Any]] = []
var inexperiencedPlayers: [[String: Any]] = []

for p in players {
    let experience = p["experience"] as! Bool
    if experience {
        experiencedPlayers.append(p)
    } else {
        inexperiencedPlayers.append(p)
    }
}

/**
 Add players evenly to the available teams.

 Uses a round-robin way to add the players.

 - parameter playersArray: The players to add to the teams.
*/
func addPlayersToTeams(_ playersArray: [[String: Any]]) {
    var teamIndex = 0
    for p in playersArray {
        switch teamIndex {
        case 0: teamSharks.append(p)
        case 1: teamDragons.append(p)
        case 2: teamRaptors.append(p)
        default: print("Error: teamIndex should be 0...2.")
        }
        teamIndex += 1
        teamIndex %= numTeams
    }
}

// Add the players to the teams
addPlayersToTeams(experiencedPlayers)
addPlayersToTeams(inexperiencedPlayers)

teamSharks
teamDragons
teamRaptors

// Part 3:
// Assemble letters
