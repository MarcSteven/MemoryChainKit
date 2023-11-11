//
//  CBManagerStateExtension.swift
//  ARICategoryKit
//
//  Created by marc zhao on 2022/5/20.
//

import CoreBluetooth



public extension CBManagerState {
    
    /// convert CBManagerState to string
    /// - Returns: return the state string 
    func string() ->String {
        switch self {
        case .resetting:
            return "resettting"
        case .unsupported:
            return "unsupport"
        case .unauthorized:
            return "unauthorized"
        case .poweredOff:
            return "powered off"
        case .poweredOn:
            return "powered on "
        case .unknown:
            return "unknown"
        @unknown default:
            return "unknown"
            
        }
        }
    }
