//
//  LeagueInfoViewModel.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 7/9/25.
//

/// The view model for an individual league
struct LeagueInfoViewModel: Equatable {
    let id: String
    let name: String
    let avatar: String?

    init(id: String, name: String, avatar: String?) {
        self.id = id
        self.name = name
        self.avatar = avatar
    }

    init(sleeperLeagueInfo: SleeperLeagueInfoModel) {
        id = sleeperLeagueInfo.leagueID
        name = sleeperLeagueInfo.name
        avatar = "\(SleeperManager.avatarBaseURL)/thumbs/\(sleeperLeagueInfo.avatar ?? "")"
    }
}
