//
//  BeneficiariesViewModel.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import Combine
import Foundation

protocol BeneficiariesViewModelProtocol {
    
    var beneficiaries: [Beneficiary] { get }
    
    func loadBeneficiaries() async throws
}

final class BeneficiariesViewModel: BeneficiariesViewModelProtocol {
    
    // MARK: Properties
    
    private(set) var beneficiaries = [Beneficiary]()
    private let jsonLoader: JSONLoaderProtocol
    
    // MARK: Initialization
    
    init(jsonLoader: JSONLoaderProtocol = JSONLoader()) {
        self.jsonLoader = jsonLoader
    }
    
    // MARK: Methods
    
    // Made async to mock an api call
    func loadBeneficiaries() async throws {
        // Mock request time
        try await Task.sleep(for: .seconds(2))
        
        guard let data = jsonLoader.loadJSONData(from: .beneficiaries),
              let beneficiaries = try? JSONDecoder().decode([Beneficiary].self, from: data) else {
            throw BeneficiariesViewModelError.failedToLoadBeneficiaries
        }
        
        self.beneficiaries = beneficiaries.sorted(by: { $0.firstName < $1.firstName })
    }
}

extension BeneficiariesViewModel {
    
    enum BeneficiariesViewModelError: Error {
        case failedToLoadBeneficiaries
        
        var description: String {
            switch self {
            case .failedToLoadBeneficiaries:
                "Failed to load your beneficiaries. Please try again."
            }
        }
    }
}
