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
    
    var formatted: String {
        var result = "\(firstLineMailing)"
        
        if let secondLineMailing = secondLineMailing {
            result += "\n\(secondLineMailing)"
        }
        
        result += "\n\(city), \(stateCode) \(zipCode)\n\(country)"
        
        return result
    }
}

// MARK: - Codable

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
