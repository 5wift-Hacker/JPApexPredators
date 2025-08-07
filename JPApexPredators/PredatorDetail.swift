//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by John Newman on 6/8/2025.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    @State var position: MapCameraPosition
    
    //creates a space where you can bundle groups of transitions or animations together
    @Namespace var namespace
    
    let predator: ApexPredator
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                
                ZStack(alignment: .bottomTrailing) {
                    
                    //background
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1),
                            ],
                                           startPoint: .top,
                                           endPoint: .bottom)
                        }
                    
                    //dinosaur image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                    //geo makes size of iphone screen
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3.7)
                    //flips image
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                VStack(alignment: .leading) {
                    //dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    //current location
                    Map(position: $position) {
                        Annotation(predator.name, coordinate: predator.location) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .symbolEffect(.pulse)
                        }
                        .annotationTitles(.hidden)
                    }
                    .frame(height: 125)
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .padding([.leading,  .bottom], 5)
                            .padding(.trailing, 8)
                            .background (.black.opacity(0.33))
                            .clipShape(.rect(bottomTrailingRadius: 15))
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    
                    //this is not working, fix this nav link
                    VStack {
                        NavigationLink {
                            PredatorMap(position: .camera(MapCamera(
                                centerCoordinate: predator.location,
                                distance: 1000,
                                heading: 250,
                                pitch: 80))
                            )
                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                            
                        } label: {
                            
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .matchedTransitionSource(id: 1, in: namespace)
                    }
                    .padding(.trailing, 30)
                    .padding(.top, 5)
                    .frame(width: geo.size.width, alignment: .trailing)
                    
                    //appears in
                    Text("Appears in:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    
                    //movie moments
                    Text("Movie moments:")
                        .font(.title3)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    //link to webpage
                    Text("Read more:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
        }
        .ignoresSafeArea()
        //clears the upper nav blur layer
        .toolbarBackgroundVisibility(.automatic)
    }
}

#Preview {
    
    let predator = Predators().apexPredators[2]
    
    
    NavigationStack {
        PredatorDetail(position: .camera(
            MapCamera(centerCoordinate: predator.location,
                      distance: 30000)), predator: predator)
    }
        .preferredColorScheme(.dark)
}
