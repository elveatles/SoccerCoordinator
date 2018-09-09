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
var teamSharks: [[String: Any]] = []
var teamDragons: [[String: Any]] = []
var teamRaptors: [[String: Any]] = []
let numberOfTeams = 3

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

// Sort experience players in ascending order.
experiencedPlayers.sort { (a, b) -> Bool in
    let aHeight = a["height"] as! Double
    let bHeight = b["height"] as! Double
    return aHeight < bHeight
}

// Sort inexperienced players in decending order.
// This bring each team's average height closer to each other as apposed to ascending order for both.
inexperiencedPlayers.sort { (a, b) -> Bool in
    let aHeight = a["height"] as! Double
    let bHeight = b["height"] as! Double
    return aHeight > bHeight
}

/**
 Add players to each team in a round-robin way.

 - Parameter playersToAdd: The players to add to the teams.
*/
func addPlayers(_ playersToAdd: [[String: Any]]) {
    var i = 0
    for player in playersToAdd {
        switch i {
        case 0: teamSharks.append(player)
        case 1: teamDragons.append(player)
        case 2: teamRaptors.append(player)
        default: print("Error: i should be 0...2. i: \(i)")
        }

        i += 1
        // Go back to 0 if index reaches teams.count
        i %= numberOfTeams
    }
}

// Add experienced and inexperienced players
addPlayers(experiencedPlayers)
addPlayers(inexperiencedPlayers)

// Show the team players
teamSharks
teamDragons
teamRaptors

// Extra Credit
/**
 Get the average height of a team.

 - Parameter team: The team to get the average height for.
 - Returns: The average height.
*/
func getAverageHeight(for team: [[String: Any]]) -> Double {
    var result = 0.0
    for player in team {
        let height = player["height"] as! Double
        result += height
    }
    result /= Double(team.count)
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
func createLetters(for team: [[String: Any]], teamName: String, practiceTime: String) -> [String] {
    var teamLetters: [String] = []
    for player in team {
        let guardians = player["guardians"]!
        let playerName = player["name"]!
        let letter = "Dear \(guardians), \(playerName) will be on the \(teamName) team. We will meet for practice on \(practiceTime)."
        teamLetters.append(letter)
    }
    return teamLetters
}

// Create letters for all the teams
letters += createLetters(for: teamSharks, teamName: "Sharks", practiceTime: "March 17, 3pm")
letters += createLetters(for: teamDragons, teamName: "Dragons", practiceTime: "March 17, 1pm")
letters += createLetters(for: teamRaptors, teamName: "Raptors", practiceTime: "March 18, 1pm")

// Print all the letters
for letter in letters {
    print(letter)
}
