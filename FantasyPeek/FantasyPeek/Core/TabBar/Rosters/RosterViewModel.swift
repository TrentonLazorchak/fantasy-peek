//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

import Observation

@Observable @MainActor
final class RosterViewModel {
    let foundationModelsManager: FoundationModelsManaging
    let team: TeamViewModel
    let refreshAction: (Bool) async -> Void

    init(team: TeamViewModel,
         refreshAction: @escaping (Bool) async -> Void,
         foundationModelsManager: FoundationModelsManaging = FoundationModelsManager()) {
        self.team = team
        self.refreshAction = refreshAction
        self.foundationModelsManager = foundationModelsManager
    }

    var generatedTeamName: String?
    var aiError: String?
    var showAIErrorAlert: Bool = false
    var isAILoading: Bool = false

    func generateTeamName() async {
        isAILoading = true
        do {
            let prompt = "Generate a new team name for this team. Only return the generated name of the team."
            let instructions = "You are an AI tool in a fantasy football app. Here is data about the current team: \(team.summary)"
            generatedTeamName = try await foundationModelsManager.sendPrompt(prompt: prompt, instructions: instructions)
            isAILoading = false
        } catch let error as FoundationModelsError {
            print(error.localizedDescription)
            aiError = error.localizedDescription
            showAIErrorAlert = true
            isAILoading = false
        } catch {
            print(error.localizedDescription)
            aiError = error.localizedDescription
            showAIErrorAlert = true
            isAILoading = false
        }
    }
}
