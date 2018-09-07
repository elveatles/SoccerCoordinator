// Part 1
// Define players (from SoccerPlayerInfo.xlsl)
let players = [
    ["name": "Joe Smith",           "height": 42.0, "experience": true,   "guardians": "Jim and Jan Smith"],
    ["name": "Jill Tanner",         "height": 36.0, "experience": true,   "guardians": "Clara Tanner"],
    ["name": "Bill Bon",            "height": 43.0, "experience": true,   "guardians": "Sara and Jenny Bon"],
    ["name": "Eva Gordon",          "height": 45.0, "experience": false,  "guardians": "Wendy and Mike Gordon"],
    ["name": "Matt Gill",           "height": 40.0, "experience": false,  "guardians": "Charles and Sylvia Gill"],
    ["name": "Kimmy Stein",         "height": 41.0, "experience": false,  "guardians": "Bill and Hillary Stein"],
    ["name": "Sammy Adams",         "height": 45.0, "experience": false,  "guardians": "Jeff Adams"],
    ["name": "Karl Saygan",         "height": 42.0, "experience": true,   "guardians": "Heather Bledsoe"],
    ["name": "Suzane Greenberg",    "height": 44.0, "experience": true,   "guardians": "Henrietta Dumas"],
    ["name": "Sal Dali",            "height": 41.0, "experience": false,  "guardians": "Gala Dali"],
    ["name": "Joe Kavalier",        "height": 39.0, "experience": false,  "guardians": "Sam and Elaine Kavalier"],
    ["name": "Ben Finkelstein",     "height": 44.0, "experience": false,  "guardians": "Aaron and Jill Finkelstein"],
    ["name": "Diego Soto",          "height": 41.0, "experience": true,   "guardians": "Robin and Sarika Soto"],
    ["name": "Chloe Alaska",        "height": 47.0, "experience": false,  "guardians": "David and Jamie Alaska"],
    ["name": "Arnold Willis",       "height": 43.0, "experience": false,  "guardians": "Claire Willis"],
    ["name": "Phillip Helm",        "height": 44.0, "experience": true,   "guardians": "Thomas Helm and Eva Jones"],
    ["name": "Les Clay",            "height": 42.0, "experience": true,   "guardians": "Wynonna Brown"],
    ["name": "Herschel Krustofski", "height": 45.0, "experience": true,   "guardians": "Hyman and Rachel Krustofski"]
]

// Part 2
// Initialize teams
var teamSharks: [String: Any] =     ["name": "Sharks",  "practiceTime": "March 17, 1pm", "players": []]
var teamDragons: [String: Any] =    ["name": "Dragons", "practiceTime": "March 17, 3pm", "players": []]
var teamRaptors: [String: Any] =    ["name": "Raptors", "practiceTime": "March 18, 1pm", "players": []]
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
 Another example: teamSharks.count == 2, teamDragons.count == 2, teamRaptors.count == 3.
 The index returned would be 4 (gets mapped to 2) for teamDragons going in the reverse direction.

 - Returns: The index to start with.
 */
func getStartTeamIndex() -> Int {
    for i in 1..<teams.count {
        let team = teams[i]
        let teamPlayers = team["players"] as! [[String: Any]]
        let prevTeam = teams[i - 1]
        let prevTeamPlayers = prevTeam["players"] as! [[String: Any]]
        if teamPlayers.count < prevTeamPlayers.count {
            // Index is going forwards
            return i
        } else if teamPlayers.count > prevTeamPlayers.count {
            // Index is going backwards
            return i - 1 + teams.count
        }
    }
    return 0
}

/**
 Add players to teams.

 Sorts the player array by height and adds the players like

 0, 1, 2, 2, 1, 0, 0, 1, 2, 2, 1, 0, etc.

 This is to evenly distribute by height.

 - parameter playerArray: The players to add to teams.
*/
func addPlayers(_ playerArray: [[String: Any]]) {
    // Extra Credit:
    // Sort the player array by height
    var sortedPlayerArray = playerArray
    sortedPlayerArray.sort { (a, b) -> Bool in
        let aHeight = a["height"] as! Double
        let bHeight = b["height"] as! Double
        return aHeight < bHeight
    }

    var expandedIndex = getStartTeamIndex()
    var index = expandedIndex
    // Loop through the players and add them to the teams.
    for p in sortedPlayerArray {
        // This makes the index go forward and backward
        if expandedIndex >= teams.count {
            index = teams.count * 2 - expandedIndex - 1
        } else {
            index = expandedIndex
        }
        var team = teams[index]
        var players = team["players"] as! [[String: Any]]
        players.append(p)
        // Because collections are copied when they are assigned, the modified copy has to be assigned back to the original variables
        team["players"] = players
        teams[index] = team

        // expandedIndex is double the team size so the index can go forward and backward.
        // Use %= to set expandedIndex back to 0 when it gets to double the team size.
        expandedIndex += 1
        expandedIndex %= teams.count * 2
    }
}

// Add players
addPlayers(experiencedPlayers)
addPlayers(inexperiencedPlayers)
// Assign teams players back to original variables since the change happened on the copy
teamSharks["players"] = teams[teamSharksIndex]["players"]
teamDragons["players"] = teams[teamDragonsIndex]["players"]
teamRaptors["players"] = teams[teamRaptorsIndex]["players"]

// Extra Credit
/**
 Get the average height of a team.

 - Parameter team: The team to get the average height for.
 - Returns: The average height.
*/
func getAverageHeight(for team: [String: Any]) -> Double {
    var result = 0.0
    let teamPlayers = team["players"] as! [[String: Any]]
    for player in teamPlayers {
        let height = player["height"] as! Double
        result += height
    }
    result /= Double(teamPlayers.count)
    return result
}

// Get the average height for each team and print the results
let teamSharksAverageHeight = getAverageHeight(for: teamSharks)
let teamDragonsAverageHeight = getAverageHeight(for: teamDragons)
let teamRaptorsAverageHeight = getAverageHeight(for: teamRaptors)
print("Average height for Sharks: \(teamSharksAverageHeight)")
print("Average height for Dragons: \(teamDragonsAverageHeight)")
print("Average height for Raptors: \(teamRaptorsAverageHeight)")

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
        let letter = "Dear \(guardians), \(playerName) will be on the \(teamName) team. We will meet for practice on \(practiceTime)."
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
