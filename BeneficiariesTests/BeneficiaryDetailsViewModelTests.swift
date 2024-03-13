//
//  BeneficiaryDetailsViewModelTests.swift
//  BeneficiariesTests
//
//  Created by Erik Perez on 3/13/24.
//

import Foundation
import XCTest
@testable import Beneficiaries

final class BeneficiaryDetailsViewModelTests: XCTestCase {
    
    func testBirthDateFormattedCorrectly() {
        guard let data = JSONLoader().loadJSONData(from: .beneficiaries) else {
            XCTFail("Failed to load beneficiaries json data")
            return
        }
        
        let beneficiaries = (try? JSONDecoder().decode([Beneficiary].self, from: data)) ?? []
        
        let viewModel = BeneficiaryDetailsViewModel(beneficiary: beneficiaries[0])
        
        XCTAssertEqual(viewModel.formattedBirthDate(), "04/20/1979")
    }
}
