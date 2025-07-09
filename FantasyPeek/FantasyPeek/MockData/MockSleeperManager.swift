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

    let leaguesResult: Result<[SleeperLeagueInfoModel]?, Error>
    let leagueInfoResult: Result<SleeperLeagueInfoModel, Error>
    let rostersResult: Result<[SleeperRosterModel], Error>
    let usersResult: Result<[SleeperUserModel], Error>
    let nflPlayersResult: Result<SleeperPlayersResponse, Error>
    
    init(leaguesResult: Result<[SleeperLeagueInfoModel]?, Error>,
         leagueInfoResult: Result<SleeperLeagueInfoModel, Error>,
         rostersResult: Result<[SleeperRosterModel], Error>,
         usersResult: Result<[SleeperUserModel], Error>,
         nflPlayersResult: Result<SleeperPlayersResponse, Error>) {
        self.leaguesResult = leaguesResult
        self.leagueInfoResult = leagueInfoResult
        self.rostersResult = rostersResult
        self.usersResult = usersResult
        self.nflPlayersResult = nflPlayersResult
    }
    
    func fetchAllLeagues(username: String, season: String) async throws -> [SleeperLeagueInfoModel]? {
        switch leaguesResult {
        case .success(let success): return success
        case .failure(let error): throw error
        }
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
                  starters: ["Player"],
                  players: ["Bench"],
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
            playerID: "PlayerID", fullName: "FullName", position: "QB", team: "WAS"
        ), "Bench": .init(
            playerID: "BenchPlayerID", fullName: "BenchFullName", position: "RB", team: "BAL"
        )]
        
        return
            .init(leaguesResult: .success([leagueInfo]),
                  leagueInfoResult: .success(leagueInfo),
                  rostersResult: .success(rostersModel),
                  usersResult: .success(usersModel),
                  nflPlayersResult: .success(nflPlayersResponse))
    }
    
    static var sampleFailure: MockSleeperManager {
        return .init(leaguesResult: .failure(URLError(.badServerResponse)),
                     leagueInfoResult: .failure(URLError(.badServerResponse)),
                     rostersResult: .failure(URLError(.badServerResponse)),
                     usersResult: .failure(URLError(.badServerResponse)),
                     nflPlayersResult: .failure(URLError(.badServerResponse)))
    }
    
}
#endif
