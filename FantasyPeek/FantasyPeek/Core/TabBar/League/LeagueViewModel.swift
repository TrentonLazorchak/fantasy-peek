//
//  LeagueViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/1/25.
//

import Foundation

@Observable @MainActor
final class LeagueViewModel {

    let sleeperManager: SleeperManaging
    let foundationModelsManager: FoundationModelsManaging
    let leagueID: String?

    init(manager: SleeperManaging = SleeperManager(),
         foundationModelsManager: FoundationModelsManaging = FoundationModelsManager(),
         leagueID: String?) {
        self.sleeperManager = manager
        self.foundationModelsManager = foundationModelsManager
        self.leagueID = leagueID
    }

    var leagueAvatarURLString: String?
    var leagueName: String = ""
    var season: String?
    var teams: [TeamViewModel] = []

    // AI
    var generatedLeagueName: String?
    var aiError: String?
    var showAIErrorAlert: Bool = false
    var isAILoading: Bool = false

    var viewState: ViewState = .initial
    enum ViewState {
        case initial
        case loading
        case loaded
        case failure
    }

    func fetchLeagueInfo(isRefresh: Bool = false) async {
        viewState = isRefresh ? .loading : .initial

        do {
            guard let leagueID else {
                viewState = .failure
                return
            }
            let leagueInfo = try await sleeperManager.fetchLeagueInfo(leagueID: leagueID, useCache: !isRefresh)
            leagueAvatarURLString = "\(SleeperManager.avatarBaseURL)/\(leagueInfo.avatar ?? "")"
            leagueName = leagueInfo.name
            season = leagueInfo.season

            teams = try await RostersViewModel.getTeams(sleeperManager: sleeperManager, leagueID: leagueID, useCache: !isRefresh)

            viewState = .loaded
        } catch {
            print("Error: \(error.localizedDescription)")
            viewState = .failure
        }
    }

    func generateLeagueName() async {
        isAILoading = true
        do {
            let prompt = "Generate a new team name for this league. Only return the generated name of the league."
            let instructions = "You are an AI tool in a fantasy football app. Here is data about the entire league: \(leagueSummary)"
            generatedLeagueName = try await foundationModelsManager.sendPrompt(prompt: prompt, instructions: instructions)
        } catch let error as FoundationModelsError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }

    private var leagueSummary: String {
        var lines: [String] = []

        lines.append("League Name: \(leagueName)")
        lines.append("Season: \(season ?? "Unknown")")
        lines.append("Sport: NFL") // TODO: When adding more sports, allow to change this

        for (index, team) in teams.enumerated() {
            lines.append("Team #\(index): \(team.summary)")
        }

        return lines.joined(separator: "\n")
    }

}
