//
//  RosterViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

import Observation
import SwiftUI

@Observable @MainActor
final class RosterViewModel {
    let foundationModelsManager: FoundationModelsManaging
    let team: TeamViewModel
    let refreshAction: (Bool) async -> Void
    let updateLoadingAction: (Bool) -> Void

    init(team: TeamViewModel,
         refreshAction: @escaping (Bool) async -> Void,
         foundationModelsManager: FoundationModelsManaging = FoundationModelsManager(),
         updateLoadingAction: @escaping (Bool) -> Void) {
        self.team = team
        self.refreshAction = refreshAction
        self.foundationModelsManager = foundationModelsManager
        self.updateLoadingAction = updateLoadingAction
    }

    var generatedTeamName: String?
    var aiError: String?
    var showAIErrorAlert: Bool = false
    var isGenerateTeamNameLoading: Bool = false
    
    var aiModalTitle: String = ""
    var aiModalBody: String = ""
    var showAIModal: Bool = false

    func generateTeamName() async {
        isGenerateTeamNameLoading = true
        generatedTeamName = nil
        do {
            let prompt = "Generate a creative fantasy football team name. Only return the name. Maximum three words."
            let instructions = """
            You are an assistant in a fantasy football app. Based on the following team data, suggest a creative and relevant team name. The name should be no more than three words long. Only output the team name — no explanations or extra text.

            Here is the team:

            \(team.summary)
            """
            generatedTeamName = try await foundationModelsManager.sendPrompt(prompt: prompt, instructions: instructions)
            isGenerateTeamNameLoading = false
        } catch let error as FoundationModelsError {
            print(error.localizedDescription)
            aiError = error.localizedDescription
            generatedTeamName = nil
            showAIErrorAlert = true
            isGenerateTeamNameLoading = false
        } catch {
            print(error.localizedDescription)
            aiError = nil
            generatedTeamName = nil
            showAIErrorAlert = true
            isGenerateTeamNameLoading = false
        }
    }
    
    func rateMyTeam() async {
        updateLoadingAction(true)
        
        do {
            let prompt = "Rate this fantasy football team. Rate it based on 0-10, 10 being the best. You can use decimals too. Give detailed feedback on why you rated it that way."
            let instructions = """
            You are an assistant in a fantasy football app. Based on the following team data, judge this team and rate it. Provide detailed feedback on why and how you are rating

            Here is the team:

            \(team.summary)
            """
            aiModalTitle = "Rate My Team"
            aiModalBody = try await foundationModelsManager.sendPrompt(prompt: prompt, instructions: instructions)
            updateLoadingAction(false)
            showAIModal = true
        } catch let error as FoundationModelsError {
            print(error.localizedDescription)
            aiError = error.localizedDescription
            showAIErrorAlert = true
            updateLoadingAction(false)
        } catch {
            print(error.localizedDescription)
            aiError = nil
            showAIErrorAlert = true
            updateLoadingAction(false)
        }
    }
}
