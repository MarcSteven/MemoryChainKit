//
//  CLPlacemarkExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/4.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//



import UIKit
import CoreLocation

public extension CLPlacemark {
    /// Returns a single string with the address information of a placemark formatted
    @objc func formattedAddress() -> String? {
        var address = ""
        if let number = subThoroughfare {
            address.append(number + " ")
        }
        if let street = thoroughfare {
            address.append(street)
        }
        address.append("\n")
        if let city = locality {
            address.append(city)
        }
        if let zipCode = postalCode {
            address.append(", " + zipCode)
        }
        if let country = country {
            address.append(", " + country)
        }
        return address
    }
}
