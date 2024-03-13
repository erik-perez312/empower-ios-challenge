//
//  Beneficiary.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation

struct Beneficiary {
    let address: Address
    let beneficiaryType: BeneficiaryType
    let dateOfBirth: String
    let designationCode: Designation
    let firstName: String
    let lastName: String
    let middleName: String?
    let phoneNumber: String
    let ssn: String
}

// MARK: - Codable

extension Beneficiary: Codable {
    
    enum CodingKeys: String, CodingKey {
        case address = "beneficiaryAddress"
        case beneficiaryType = "beneType"
        case dateOfBirth
        case designationCode
        case firstName
        case lastName
        case middleName
        case phoneNumber
        case ssn = "socialSecurityNumber"
    }
}
