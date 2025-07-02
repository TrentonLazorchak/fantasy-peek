//
//  FoundationModelsError.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/2/25.
//

enum FoundationModelsError: Error {
    // Device is not eligible for AI
    case deviceNotEligible
    // Device is eligible, but apple intelligence is not enabled
    case appleIntelligenceNotEnabled
    // The model isn't ready because it's downloading or because of other system reasons.
    // NOTE: If on simuator, this will hit
    case modelNotReady
    // The model is unavailable for an unknown reason.
    case unknown

    var localizedDescription: String {
        switch self {
        case .deviceNotEligible:
            return "This device is not eligible for Apple Intelligence."
        case .appleIntelligenceNotEnabled:
            return "Apple Intelligence is not enabled on this device."
        case .modelNotReady:
            return "The model is not ready."
        case .unknown:
            return "The model is unavailable for an unknown reason."
        }
    }
}
