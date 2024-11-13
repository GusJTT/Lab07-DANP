//
//  ContentView.swift
//  Lab07
//
//  Created by Gustavo on 12/11/24.
//

import SwiftUI
import MapKit

struct VistaMapa: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [userLocation]) { location in
                    MapMarker(coordinate: location.coordinate, tint: .blue)
                }
                .onAppear {
                    region.center = userLocation.coordinate
                }
            } else {
                Text("Solicitando acceso a la ubicación...")
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}
