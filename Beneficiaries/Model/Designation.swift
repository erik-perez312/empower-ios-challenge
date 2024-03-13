//
//  Designation.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation

enum Designation: String, Codable {
    case primary = "P"
    case contingent = "C"
    
    var title: String {
        switch self {
        case .primary: "Primary (P)"
        case .contingent: "Contingent (C)"
        }
    }
}
