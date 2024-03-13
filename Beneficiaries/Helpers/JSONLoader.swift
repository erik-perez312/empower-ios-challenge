//
//  JSONLoader.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import Foundation

protocol JSONLoaderProtocol {
    func loadJSONData(from file: JSONFile) -> Data?
}

struct JSONLoader: JSONLoaderProtocol {
    
    func loadJSONData(from file: JSONFile) -> Data? {
        guard let path = Bundle.main.path(forResource: file.rawValue, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
