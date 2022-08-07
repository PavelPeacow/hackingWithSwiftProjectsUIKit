//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Павел Кай on 07.08.2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
