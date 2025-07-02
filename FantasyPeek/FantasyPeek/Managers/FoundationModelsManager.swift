//
//  FoundationModelsManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

import FoundationModels

// The device must support Apple Intelligence.
// The device must have Apple Intelligence turned on in System Settings.
// The device must have sufficient battery and not be in Game Mode.
// Models may not be available if the device is in low battery mode or it becomes too warm.
// https://developer.apple.com/documentation/foundationmodels/generating-content-and-performing-tasks-with-foundation-models
protocol FoundationModelsManaging {
    func sendPrompt(prompt: String) async throws -> String
}

final class FoundationModelsManager: FoundationModelsManaging {
    /// Reference to the system language model.
    private var model = SystemLanguageModel.default

    let session: LanguageModelSession

    init(instructions: String) {
        // Create session with passed in instructions
        self.session = LanguageModelSession(instructions: instructions)
    }

    func sendPrompt(prompt: String) async throws -> String {
        switch model.availability {
        case .available:
            // Max temperature for more creative responses
            let options = GenerationOptions(temperature: 2.0)
            // Send prompt to session and receive a response
            return try await session.respond(to: prompt, options: options).content
        case .unavailable(.deviceNotEligible):
            throw FoundationModelsError.deviceNotEligible
        case .unavailable(.appleIntelligenceNotEnabled):
            throw FoundationModelsError.appleIntelligenceNotEnabled
        case .unavailable(.modelNotReady):
            throw FoundationModelsError.modelNotReady
        case .unavailable(let other):
            throw FoundationModelsError.unknown
        }
    }

}
