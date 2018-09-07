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
var teamSharks: [String: Any] = ["name": "Sharks",      "practiceTime": "March 17, 1pm", "players": []]
var teamDragons: [String: Any] = ["name": "Dragons",    "practiceTime": "March 17, 3pm", "players": []]
var teamRaptors: [String: Any] = ["name": "Raptors",    "practiceTime": "March 18, 1pm", "players": []]
let teamSharksIndex = 0
let teamDragonsIndex = 1
let teamRaptorsIndex = 2
var teams = [teamSharks, teamDragons, teamRaptors]

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
 Used in addPlayers to get the index of the team to start adding to.

 This is for the case where the number of players doesn't perfectly divide into the number of teams.
 For example teamSharks.count == 3, teamDragons.count == 3, teamRaptors.count == 2.
 The index returned would be 2 because we should start adding players for teamRaptors instead of starting at index 0 again (teamSharks).
*/
func getStartTeamIndex() -> Int {
    var lastCount = 0
    for i in 0..<teams.count {
        let team = teams[i]
        if team.count < lastCount {
            return i
        }
        lastCount = i
    }
    return 0
}

/**
 Add players to teams.

 Uses a round-robin way to add them so they are distributed evenly.

 - parameter playerArray: The players to add to teams.
*/
func addPlayers(_ playerArray: [[String: Any]]) {
    var index = getStartTeamIndex()
    for p in playerArray {
        var team = teams[index]
        var players = team["players"] as! [[String: Any]]
        players.append(p)
        // Because collections are copied when they are assigned, the modified copy has to be assigned back to the original variables
        team["players"] = players
        teams[index] = team

        // Increment index and go back to 0 if the index reached teams.count so that the index does not go out of bounds
        index += 1
        index %= teams.count
    }
}

// Add players
addPlayers(experiencedPlayers)
addPlayers(inexperiencedPlayers)
// Assign teams players back to original variables since the change happened on the copy
teamSharks["players"] = teams[teamSharksIndex]["players"]
teamDragons["players"] = teams[teamDragonsIndex]["players"]
teamRaptors["players"] = teams[teamRaptorsIndex]["players"]

// Part 3:
// Assemble letters
var letters: [String] = []

/**
 Create letters for a team.

 - Parameter team: The team to create letters for.
 - Returns: The letters for the team.
*/
func createLetters(for team: [String: Any]) -> [String] {
    let teamName = team["name"] as! String
    let practiceTime = team["practiceTime"] as! String
    var teamLetters: [String] = []
    for player in team["players"] as! [[String: Any]] {
        let guardians = player["guardians"]!
        let playerName = player["name"]!
        let letter = "Dear \(guardians), \(playerName) will be in the \(teamName) team. We will meet for practice on \(practiceTime)."
        teamLetters.append(letter)
    }
    return teamLetters
}

// Create letters for all the teams
for team in teams {
    letters += createLetters(for: team)
}

// Print all the letters
for letter in letters {
    print(letter)
}
