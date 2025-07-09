//
//  LeagueModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

/// A model for league information retrieved from Sleeper
struct SleeperLeagueInfoModel: Codable {
    let leagueID: String
    let name: String
    let totalRosters: Int
    let status: String?
    let sport: String?
    let season: String?
    let seasonType: String?
    let draftID: String?
    let previousLeagueID: String?
    let avatar: String?
    let companyID: String?
    let loserBracketID: Int?

    let rosterPositions: [String]?
    let metadata: [String: String]?
    let scoringSettings: [String: Double]?
    let settings: SleeperLeagueSettings?

    enum CodingKeys: String, CodingKey {
        case leagueID = "league_id"
        case name
        case totalRosters = "total_rosters"
        case status
        case sport
        case season
        case seasonType = "season_type"
        case draftID = "draft_id"
        case previousLeagueID = "previous_league_id"
        case avatar
        case companyID = "company_id"
        case loserBracketID = "loser_bracket_id"
        case rosterPositions = "roster_positions"
        case metadata
        case scoringSettings = "scoring_settings"
        case settings
    }
}

/// A model for league settings information retrieved from Sleeper
struct SleeperLeagueSettings: Codable {
    let lastScoredLeg: Int?
    let reserveAllowCov: Int?
    let dailyWaiversHour: Int?
    let offseasonAdds: Int?
    let benchLock: Int?
    let capacityOverride: Int?
    let waiverDayOfWeek: Int?
    let type: Int?
    let tradeReviewDays: Int?

    enum CodingKeys: String, CodingKey {
        case lastScoredLeg = "last_scored_leg"
        case reserveAllowCov = "reserve_allow_cov"
        case dailyWaiversHour = "daily_waivers_hour"
        case offseasonAdds = "offseason_adds"
        case benchLock = "bench_lock"
        case capacityOverride = "capacity_override"
        case waiverDayOfWeek = "waiver_day_of_week"
        case type
        case tradeReviewDays = "trade_review_days"
    }
}
