//
//  PlayerView.swift
//  FantasyPeek
//
//  Created by Trenton Lazorchak on 6/29/25.
//

import SwiftUI

/// A player's football position
enum Position: String, ExpressibleByStringLiteral {
    case quarterBack = "QB"
    case runningBack = "RB"
    case wideReceiver = "WR"
    case tightEnd = "TE"
    case kicker = "K"
    case defense = "DEF"
    case unknown = "N/A"

    init(from positionString: String?) {
        self = Position(rawValue: positionString?.uppercased() ?? "") ?? .unknown
    }

    init(stringLiteral value: StringLiteralType) {
        self.init(from: value)
    }

    var color: Color {
        switch self {
        case .quarterBack: .purple
        case .runningBack: .green
        case .wideReceiver: .orange
        case .tightEnd: .blue
        case .kicker: .red
        case .defense: .brown
        case .unknown: .gray
        }
    }
}

// swiftlint:disable identifier_name
/// A players NFL team they play for
enum NFLTeam: String, ExpressibleByStringLiteral {
    case sf = "SF"
    case kc = "KC"
    case buf = "BUF"
    case cin = "CIN"
    case dal = "DAL"
    case phi = "PHI"
    case mia = "MIA"
    case bal = "BAL"
    case det = "DET"
    case jax = "JAX"
    case nyj = "NYJ"
    case lar = "LAR"
    case min = "MIN"
    case lac = "LAC"
    case cle = "CLE"
    case no = "NO"
    case sea = "SEA"
    case gb = "GB"
    case atl = "ATL"
    case pit = "PIT"
    case chi = "CHI"
    case was = "WAS"
    case ne = "NE"
    case den = "DEN"
    case tb = "TB"
    case ten = "TEN"
    case nyg = "NYG"
    case lv = "LV"
    case ind = "IND"
    case car = "CAR"
    case hou = "HOU"
    case ari = "ARI"
    case unknown = "N/A"
    // swiftlint:enable identifier_name

    init(from abbreviation: String?) {
        self = NFLTeam(rawValue: abbreviation?.uppercased() ?? "") ?? .unknown
    }

    init(stringLiteral value: StringLiteralType) {
        self.init(from: value)
    }

    var fullName: String {
        switch self {
        case .sf: return "San Francisco 49ers"
        case .kc: return "Kansas City Chiefs"
        case .buf: return "Buffalo Bills"
        case .cin: return "Cincinnati Bengals"
        case .dal: return "Dallas Cowboys"
        case .phi: return "Philadelphia Eagles"
        case .mia: return "Miami Dolphins"
        case .bal: return "Baltimore Ravens"
        case .det: return "Detroit Lions"
        case .jax: return "Jacksonville Jaguars"
        case .nyj: return "New York Jets"
        case .lar: return "Los Angeles Rams"
        case .min: return "Minnesota Vikings"
        case .lac: return "Los Angeles Chargers"
        case .cle: return "Cleveland Browns"
        case .no: return "New Orleans Saints"
        case .sea: return "Seattle Seahawks"
        case .gb: return "Green Bay Packers"
        case .atl: return "Atlanta Falcons"
        case .pit: return "Pittsburgh Steelers"
        case .chi: return "Chicago Bears"
        case .was: return "Washington Commanders"
        case .ne: return "New England Patriots"
        case .den: return "Denver Broncos"
        case .tb: return "Tampa Bay Buccaneers"
        case .ten: return "Tennessee Titans"
        case .nyg: return "New York Giants"
        case .lv: return "Las Vegas Raiders"
        case .ind: return "Indianapolis Colts"
        case .car: return "Carolina Panthers"
        case .hou: return "Houston Texans"
        case .ari: return "Arizona Cardinals"
        case .unknown: return "Unknown Team"
        }
    }

    var mainColor: Color {
        switch self {
        case .sf: return Color(red: 170/255, green: 0, blue: 0)
        case .kc: return Color(red: 227/255, green: 24/255, blue: 55/255)
        case .buf: return Color(red: 0, green: 51/255, blue: 141/255)
        case .cin: return Color.orange
        case .dal: return Color(red: 0, green: 34/255, blue: 68/255)
        case .phi: return Color(red: 0, green: 76/255, blue: 84/255)
        case .mia: return Color(red: 0, green: 142/255, blue: 151/255)
        case .bal: return Color.purple
        case .det: return Color(red: 0, green: 118/255, blue: 182/255)
        case .jax: return Color(red: 0, green: 103/255, blue: 120/255)
        case .nyj: return Color.green
        case .lar: return Color(red: 0, green: 53/255, blue: 148/255)
        case .min: return Color.purple
        case .lac: return Color(red: 0, green: 156/255, blue: 222/255)
        case .cle: return Color(red: 255/255, green: 60/255, blue: 0)
        case .no: return Color(red: 211/255, green: 188/255, blue: 141/255)
        case .sea: return Color(red: 0, green: 34/255, blue: 68/255)
        case .gb: return Color(red: 24/255, green: 48/255, blue: 40/255)
        case .atl: return Color.red
        case .pit: return Color.black
        case .chi: return Color(red: 11/255, green: 22/255, blue: 42/255)
        case .was: return Color(red: 90/255, green: 20/255, blue: 20/255)
        case .ne: return Color(red: 0, green: 34/255, blue: 68/255)
        case .den: return Color(red: 251/255, green: 79/255, blue: 20/255)
        case .tb: return Color(red: 213/255, green: 10/255, blue: 10/255)
        case .ten: return Color(red: 12/255, green: 35/255, blue: 64/255)
        case .nyg: return Color(red: 1/255, green: 35/255, blue: 82/255)
        case .lv: return Color.gray
        case .ind: return Color(red: 0, green: 44/255, blue: 95/255)
        case .car: return Color(red: 0, green: 133/255, blue: 202/255)
        case .hou: return Color(red: 3/255, green: 32/255, blue: 47/255)
        case .ari: return Color.red
        case .unknown: return Color.gray
        }
    }
}

/// A view used to display an individual player item
struct PlayerView: View {

    let position: Position
    let name: String
    let team: NFLTeam

    init(position: Position?, name: String?, team: NFLTeam?) {
        self.position = position ?? .unknown
        self.name = name ?? "Unknown"
        self.team = team ?? .unknown
    }

    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(position.color)

                Text(position.rawValue)
                    .foregroundStyle(.white)
            }
            .frame(width: 50, height: 50)

            // Use team name for the defense
            if position == .defense {
                Text(team.fullName)
            } else {
                Text(name)
            }

            Spacer()

            ZStack {
                Rectangle()
                    .foregroundStyle(team.mainColor)
                Text(team.fullName)
                    .foregroundStyle(.white)
            }
            .multilineTextAlignment(.center)
            .frame(width: 100, height: 50)
        }
        .font(.subheadline)
    }

}

#Preview {
    PlayerView(position: .quarterBack, name: "Trenton Lazorchak", team: .was)
}
