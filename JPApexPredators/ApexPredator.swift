//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by John Newman on 4/8/2025.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Identifiable, Decodable {
    let id: Int
    
    let name: String
    
    let type: APType
    
    let latitude: Double
    let longitude: Double
    
    let movies: [String]
    
    let movieScenes: [MovieScene]
    
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum APType: String, Decodable, CaseIterable, Identifiable {
    
    var id: APType {
        self
    }
    
    case all, land, air, sea
    
    var background: Color {
        
        switch self {
        case .all:
                .clear
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
