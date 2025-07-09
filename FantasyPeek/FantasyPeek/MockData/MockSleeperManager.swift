//
//  MockSleeperManager.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/8/25.
//

// Only includes in debug builds and automated test targets. Excludes this code from release
#if DEBUG || canImport(XCTest)
import Foundation

/// Mock sleeper managing for automated tests and previews
final class MockSleeperManager: SleeperManaging {

    let leagueInfoResult: Result<SleeperLeagueInfoModel, Error>
    let rostersResult: Result<[SleeperRosterModel], Error>
    let usersResult: Result<[SleeperUserModel], Error>
    let nflPlayersResult: Result<SleeperPlayersResponse, Error>
    
    init(leagueInfoResult: Result<SleeperLeagueInfoModel, Error>,
         rostersResult: Result<[SleeperRosterModel], Error>,
         usersResult: Result<[SleeperUserModel], Error>,
         nflPlayersResult: Result<SleeperPlayersResponse, Error>) {
        self.leagueInfoResult = leagueInfoResult
        self.rostersResult = rostersResult
        self.usersResult = usersResult
        self.nflPlayersResult = nflPlayersResult
    }
    
    func fetchLeagueInfo(leagueID: String, useCache: Bool) async throws -> SleeperLeagueInfoModel {
        switch leagueInfoResult {
        case .success(let success): return success
        case .failure(let error): throw error
        }
    }
    
    func fetchAllRosters(leagueID: String, useCache: Bool) async throws -> [SleeperRosterModel] {
        switch rostersResult {
        case .success(let success): return success
        case .failure(let error): throw error
        }
    }
    
    func fetchAllUsers(leagueID: String, useCache: Bool) async throws -> [SleeperUserModel] {
        switch usersResult {
        case .success(let success): return success
        case .failure(let error): throw error
        }
    }
    
    func fetchAllNFLPlayers() async throws -> SleeperPlayersResponse {
        switch nflPlayersResult {
        case .success(let success): return success
        case .failure(let error): throw error
        }
    }
    
    static var sampleSuccess: MockSleeperManager {
        let leagueInfo = SleeperLeagueInfoModel(
            leagueID: "LeagueID",
            name: "Name",
            totalRosters: 123,
            status: "Status",
            sport: "Sport",
            season: "Season",
            seasonType: "SeasonType",
            draftID: "DraftID",
            previousLeagueID: "PreviousLeagueID",
            avatar: "Avatar",
            companyID: "CompanyID",
            loserBracketID: 123,
            rosterPositions: ["QB", "RB"],
            metadata: ["Key": "Value"],
            scoringSettings: ["Key": 123],
            settings: .init(
                lastScoredLeg: 123,
                reserveAllowCov: 123,
                dailyWaiversHour: 123,
                offseasonAdds: 123,
                benchLock: 123,
                capacityOverride: 123,
                waiverDayOfWeek: 123,
                type: 123,
                tradeReviewDays: 123
            )
        )
        
        let rostersModel: [SleeperRosterModel] = [
            .init(id: 123,
                  ownerID: "OwnerID",
                  leagueID: "LeagueID",
                  starters: ["Starter"],
                  players: ["Players"],
                  settings: .init(wins: 123, losses: 123, ties: 123),
                  metadata: ["Key": "Value"],
                  coOwners: ["CoOwner"])
        ]
        
        let usersModel: [SleeperUserModel] = [
            .init(userID: "UserID",
                  displayName: "DisplayName",
                  avatar: "Avatar",
                  metadata: .init(teamName: "TeamName"))
        ]
        
        let nflPlayersResponse: SleeperPlayersResponse = ["Player": .init(
            playerID: "PlayerID", fullName: "FullName", position: "Position", team: "Team"
        )]
        
        return
            .init(leagueInfoResult: .success(leagueInfo),
                  rostersResult: .success(rostersModel),
                  usersResult: .success(usersModel),
                  nflPlayersResult: .success(nflPlayersResponse))
    }
    
    static var sampleFailure: MockSleeperManager {
        return .init(leagueInfoResult: .failure(URLError(.badServerResponse)),
                     rostersResult: .failure(URLError(.badServerResponse)),
                     usersResult: .failure(URLError(.badServerResponse)),
                     nflPlayersResult: .failure(URLError(.badServerResponse)))
    }
    
}
#endif
