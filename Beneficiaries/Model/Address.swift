//
//  Address.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation

struct Address {
    let city: String
    let country: String
    let firstLineMailing: String
    let secondLineMailing: String?
    let stateCode: String
    let zipCode: String
}

// Mark: - Codable

extension Address: Codable {
    
    enum CodingKeys: String, CodingKey {
        case city
        case country
        case firstLineMailing
        case secondLineMailing = "scndLineMailing"
        case stateCode
        case zipCode
    }
}
