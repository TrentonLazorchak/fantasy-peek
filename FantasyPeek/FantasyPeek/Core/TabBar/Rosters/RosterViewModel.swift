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
         foundationModelsManager: FoundationModelsManaging? = nil) {
        self.team = team
        self.refreshAction = refreshAction

        let instructions = "You are an AI tool in a fantasy football app. Here is data about the current team: \(team.summary)"
        self.foundationModelsManager = foundationModelsManager ?? FoundationModelsManager(instructions: instructions)
    }

    var generatedTeamName: String?
    var aiError: String?
    var showAIErrorAlert: Bool = false

    var isAILoading: Bool = false

    func generateTeamName() async {
        isAILoading = true
        do {
            let prompt = "Generate a team name for this team. Only return the name of the team."
            generatedTeamName = try await foundationModelsManager.sendPrompt(prompt: prompt)
        } catch FoundationModelsError.deviceNotEligible {
            print("Device not eligible for AI")
        } catch FoundationModelsError.appleIntelligenceNotEnabled {
            print("Not enabled")
        } catch FoundationModelsError.modelNotReady {
            print("Not ready")
        } catch FoundationModelsError.unknown {
            print("Unknown") // device eligibility error
        } catch {
            print("Other") // sending prompt error
        }
    }
}
