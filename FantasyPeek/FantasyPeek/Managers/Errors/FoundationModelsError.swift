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
}
