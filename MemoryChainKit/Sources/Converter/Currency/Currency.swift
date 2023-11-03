//
//  Currency.swift
//  MemoryChainKit
//
//  Created by MarcSteven on 2021/11/27.
//  Copyright © 2021 Marc Steven(https://https://github.com/MarcSteven). All rights reserved.
//

import Foundation


// You can visit here about the currency  https://en.wikipedia.org/wiki/Currency

enum Currency :String,CaseIterable {
   case USD = "USD"
   case EUR = "EUR"
    case JPY = "JPY"
    case GBP = "GBP"
    case AUD = "AUD"
    case CAD = "CAD"
    case CHF = "CHF"
    case CNY = "CNY"
    case HKD = "HKD"
    case NZD = "NZD"
    case SEK = "SEK"
    case KRW = "KRW"
    case SGD = "SGD"
    case NOK = "NOK"
    case MXN = "MXN"
    case INR = "INR"
    case RUB = "RUB"
    case ZAR = "ZAR"
    case TRY = "TRY"
    case BRL = "BRL"
    case TWD = "TWD"
    case DKK = "DKK"
    case PLN = "PLN"
    case THB = "THB"
    case IDR = "IDR"
    case HUF = "HUF"
    case CZK = "CZK"
    case ILS = "ILS"
    case CLP = "CLP"
    case PHP = "PHP"
    case AED = "AED"
    case COP = "COP"
    case SAR = "SAR"
    case MYR = "MYR"
    case RON = "RON"
    case BGN = "BGN"
    case ISK = "ISK"
    case HRK = "HRK"
    
    
    static func nameWithFlag(for currency : Currency) -> String {
            return (Currency.flagsByCurrencies[currency] ?? "?") + " " + currency.rawValue
        }
    
    
    static let allNamesWithFlags:[String] = {
        var nameWithFlags :[String] = []
        for currency in Currency.allCases {
            nameWithFlags.append(Currency.nameWithFlag(for: currency))
        }
        return nameWithFlags
    }()
    
    static let flagsByCurrencies : [Currency : String] = [
            .AUD : "🇦🇺", .INR : "🇮🇳", .TRY : "🇹🇷",
            .BGN : "🇧🇬", .ISK : "🇮🇸", .USD : "🇺🇸",
            .BRL : "🇧🇷", .JPY : "🇯🇵", .ZAR : "🇿🇦",
            .CAD : "🇨🇦", .KRW : "🇰🇷",
            .CHF : "🇨🇭", .MXN : "🇲🇽",
            .CNY : "🇨🇳", .MYR : "🇲🇾",
            .CZK : "🇨🇿", .NOK : "🇳🇴",
            .DKK : "🇩🇰", .NZD : "🇳🇿",
            .EUR : "🇪🇺", .PHP : "🇵🇭",
            .GBP : "🇬🇧", .PLN : "🇵🇱",
            .HKD : "🇭🇰", .RON : "🇷🇴",
            .HRK : "🇭🇷", .RUB : "🇷🇺",
            .HUF : "🇭🇺", .SEK : "🇸🇪",
            .IDR : "🇮🇩", .SGD : "🇸🇬",
            .ILS : "🇮🇱", .THB : "🇹🇭",
        ]
}
