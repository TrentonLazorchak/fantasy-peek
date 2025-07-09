//
//  MockFoundationModelsManager.swift
//  FantasyPeek
//
//  Created by TEST Trenton on 7/9/25.
//

// Only includes in debug builds and automated test targets. Excludes this code from release
#if DEBUG || canImport(XCTest)
final class MockFoundationModelsManager: FoundationModelsManaging {

    let promptResult: Result<String, Error>
    
    init(promptResult: Result<String, Error>) {
        self.promptResult = promptResult
    }
    
    func sendPrompt(prompt: String, instructions: String) async throws -> String {
        switch promptResult {
        case .success(let result): return result
        case .failure(let error): throw error
        }
    }
    
    static var sampleSuccess: MockFoundationModelsManager {
        .init(promptResult: .success("Example Response"))
    }
    
    static var sampleFailure: MockFoundationModelsManager {
        .init(promptResult: .failure(FoundationModelsError.appleIntelligenceNotEnabled))
    }
    
}

#endif
