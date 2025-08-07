//
//  Predators.swift
//  JPApexPredators
//
//  Created by John Newman on 4/8/2025.
//

import Foundation //access to some decoding

class Predators {
    
    var allApexPredators: [ApexPredator] = []
    
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        //Bundle is main system files or imported files
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("error decoding json data: \(error)")
            }
            
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        guard !searchTerm.isEmpty else { return apexPredators }
        
        return apexPredators.filter {
            $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            }else {
                predator1.id < predator2.id
            }
            
        }
    }
    
    func filter(by type: APType) {
        if type == .all {
            apexPredators = allApexPredators
        }else {
            apexPredators = allApexPredators.filter { $0.type == type }
        }
    }
    
}
