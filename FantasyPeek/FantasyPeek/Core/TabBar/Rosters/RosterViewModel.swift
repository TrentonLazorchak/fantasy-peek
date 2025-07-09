//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

import Observation

/// A view model used by the roster view
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

    /// Calls FoundationModels to generate a team name based on the currently selected roster information
    func generateTeamName() async {
        isAILoading = true
        generatedTeamName = nil
        do {
            let prompt = "Generate a creative fantasy football team name. Only return the name. Maximum three words."
            let instructions = """
            You are an assistant in a fantasy football app. \
            Based on the following team data, suggest a creative and relevant team name. \
            The name should be no more than three words long. Only output the team name — no explanations or extra text.

            Here is the team:

            \(team.summary)
            """
            generatedTeamName = try await foundationModelsManager.sendPrompt(prompt: prompt, instructions: instructions)
            isAILoading = false
        } catch let error as FoundationModelsError {
            print(error.localizedDescription)
            aiError = error.localizedDescription
            showAIErrorAlert = true
            isAILoading = false
        } catch {
            print(error.localizedDescription)
            aiError = nil
            showAIErrorAlert = true
            isAILoading = false
        }
    }
}
