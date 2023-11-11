//
//  CBPeripheralStateExtension.swift
//  ARICategoryKit
//
//  Created by marc zhao on 2022/5/20.
//

import CoreBluetooth


public extension CBPeripheralState {
    
    /// convert CBPeripheral state to string
    /// - Returns: return state string 
    func string() ->String {
        switch self {
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting"
        case .connected:
            return "Connected"
        case .disconnecting:
            return "Disconnecting"
        @unknown default:
            return "Unknown"
        }
       
    }
    
}


