//
//  Country.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/22.
//  Copyright © 2019 Memory Chain  network technology(Shenzhen) co,LTD. All rights reserved.
//

import Foundation

/// Class to define a country
open class Country: NSObject {
    
    open var countryCode    : String
    open var phoneExtension : String
    open var isMain         : Bool
    open var countryName    : String
    
    public static var emptyCountry    : Country { return Country(countryCode: "", phoneExtension: "", isMain: true, countryName: "") }
    
    public static var currentCountry  : Country {
        
        let localIdentifier = Locale.current.identifier //returns identifier of your telephones country/region settings
        
        let locale = NSLocale(localeIdentifier: localIdentifier)
        if let countryCode = locale.object(forKey: .countryCode) as? String {
            return Countries.countryFromCountryCode(countryCode.uppercased())
        }
        
        return Country.emptyCountry
    }
    
    
    /// Constructor to initialize a country
    ///
    /// - Parameters:
    ///   - countryCode: the country code
    ///   - phoneExtension: phone extension
    ///   - isMain: Bool
    public init(countryCode: String, phoneExtension: String, isMain: Bool, countryName: String) {
        
        self.countryCode = countryCode
        self.phoneExtension = phoneExtension
        self.isMain = isMain
        self.countryName = countryName
    }
    
    /// Obatin the country name based on current locale
    @objc open var name: String {

//        let localIdentifier = Locale.current.identifier //returns identifier of your telephones country/region settings
//        let locale = NSLocale(localeIdentifier: localIdentifier)

//        if let country:String = locale.displayName(forKey: .countryCode, value: countryCode.uppercased()) {
//            return country
//        if let country:String = countryName {
//            return countryName
//        }else{
//            return "Invalid country code"
//        }
        return countryName
    }
}

/// compare to country
///
/// - Parameters:
///   - lhs: Country
///   - rhs: Country
/// - Returns: Bool
public func ==(lhs: Country, rhs: Country) -> Bool {
    return lhs.countryCode == rhs.countryCode
}
