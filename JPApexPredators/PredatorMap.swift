//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by John Newman on 7/8/2025.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    
    @State var position: MapCameraPosition
    @State var satellite: Bool = false
    let predators = Predators()
    
    var body: some View {
        
        //starting position vs other annotations in multiple locations
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(color: .white, radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
        
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    )
    .preferredColorScheme(.dark)
}
