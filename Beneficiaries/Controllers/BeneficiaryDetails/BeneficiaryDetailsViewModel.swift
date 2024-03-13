//
//  BeneficiaryDetailsViewModel.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/13/24.
//

import Foundation

protocol BeneficiaryDetailsViewModelProtocol {
    var beneficiary: Beneficiary { get }
    
    func formattedBirthDate() -> String
}

final class BeneficiaryDetailsViewModel: BeneficiaryDetailsViewModelProtocol {
    
    // MARK: Properties
    
    let beneficiary: Beneficiary
    
    private var defaultDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        return dateFormatter
    }()
    
    private var expectedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // MARK: Initialization
    
    init(beneficiary: Beneficiary) {
        self.beneficiary = beneficiary
    }
    
    // MARK: Methods
    
    func formattedBirthDate() -> String {
        guard let date = defaultDateFormatter.date(from: beneficiary.dateOfBirth) else {
            return beneficiary.dateOfBirth
        }
        
        return expectedDateFormatter.string(from: date)
    }
}
