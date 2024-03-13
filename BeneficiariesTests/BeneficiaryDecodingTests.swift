//
//  BeneficiaryDecodingTests.swift
//  BeneficiariesTests
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation
import XCTest
@testable import Beneficiaries

final class BeneficiaryDecodingTests: XCTestCase {
    
    func testCanDecodeBeneficiaryModels() {
        guard let data = JSONLoader().loadJSONData(from: .beneficiaries) else {
            XCTFail("Failed to load beneficiaries json data")
            return
        }
        
        let beneficiaries = (try? JSONDecoder().decode([Beneficiary].self, from: data)) ?? []
        XCTAssertEqual(beneficiaries.count, 5)
        XCTAssertEqual(beneficiaries[0].firstName, "John")
    }
}
