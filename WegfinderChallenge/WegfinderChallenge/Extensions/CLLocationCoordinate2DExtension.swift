//
//  CLLocationCoordinate2DExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D {

    func openMaps(with name: String? = .none) {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: self))
        destination.name = name
        MKMapItem.openMaps(with: [destination], launchOptions: .none)
    }

}
