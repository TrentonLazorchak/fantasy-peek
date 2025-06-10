//
//  LeagueModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/9/25.
//

struct SleeperLeagueInfoModel: Codable {
    let leagueId: String
    let name: String
    let totalRosters: Int
    let status: String?
    let sport: String?
    let season: String?
    let seasonType: String?
    let draftId: String?
    let previousLeagueId: String?
    let avatar: String?
    let companyId: String?
    let loserBracketId: String?

    let rosterPositions: [String]?
    let metadata: [String: String]?
    let scoringSettings: [String: Double]?
    let settings: SleeperLeagueSettings?

    enum CodingKeys: String, CodingKey {
        case leagueId = "league_id"
        case name
        case totalRosters = "total_rosters"
        case status
        case sport
        case season
        case seasonType = "season_type"
        case draftId = "draft_id"
        case previousLeagueId = "previous_league_id"
        case avatar
        case companyId = "company_id"
        case loserBracketId = "loser_bracket_id"
        case rosterPositions = "roster_positions"
        case metadata
        case scoringSettings = "scoring_settings"
        case settings
    }
}

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
