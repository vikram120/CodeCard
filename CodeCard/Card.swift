//
//  Card.swift
//  CodeCard
//
//  Created by Vikram Kunwar on 07/03/24.
//

import Foundation

struct Card: Codable {
    let id: String
    let nameEnglish: String
    let nameJapanese: String
    let abilityEnglish: String
    let abilityJapanese: String
    let types: [String]
    let imageUrls: [String]
}
