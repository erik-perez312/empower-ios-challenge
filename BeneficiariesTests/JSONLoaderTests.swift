//
//  JSONLoaderTests.swift
//  JSONLoaderTests
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation
import XCTest
@testable import Beneficiaries

final class JSONLoaderTests: XCTestCase {
    
    func testCanLoadJSONFile() {
        let data = JSONLoader().loadJSONData(from: .beneficiaries)
        XCTAssertNotNil(data)
    }
}
