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
    /// Used to send a prompt to FoundationModels, in order to receive a response from AI
    /// - Parameters:
    ///   - prompt: The prompt as a string to pass to FoundationModels
    ///   - instructions: The instructions to give to the model
    /// - Returns: The response received
    func sendPrompt(prompt: String, instructions: String) async throws -> String
}

/// An implementation of FoundationModelsManaging using FoundationModels
final class FoundationModelsManager: FoundationModelsManaging {
    /// Reference to the system language model.
    private var model = SystemLanguageModel.default

    func sendPrompt(prompt: String, instructions: String) async throws -> String {
        let session = LanguageModelSession(instructions: instructions)
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
        case .unavailable:
            throw FoundationModelsError.unknown
        }
    }

}
