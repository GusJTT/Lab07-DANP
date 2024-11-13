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
        center: CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428), // Ubicación inicial, por ejemplo, Lima, Perú
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack {
            // Verifica si tenemos la ubicación del usuario
            if let userLocation = locationManager.userLocation {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [userLocation]) { location in
                    MapMarker(coordinate: location.coordinate, tint: .blue)
                }
                .onAppear {
                    // Centra el mapa en la ubicación del usuario
                    region.center = userLocation.coordinate
                }
                //.frame(height: 400) // Tamaño del mapa
            } else {
                Text("Solicitando acceso a la ubicación...")
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}
