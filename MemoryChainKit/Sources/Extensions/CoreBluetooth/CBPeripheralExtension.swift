//
//  CBPeripheralExtension.swift
//  ARICategoryKit
//
//  Created by marc zhao on 2022/4/22.
//

import Foundation
import CoreBluetooth

public extension CBPeripheral {
    
    /// find service via udid
    /// - Parameter udid: udid
    /// - Returns: return the service
    func findService(with udid:CBUUID) ->CBService?{
        return services?.first {$0.uuid == udid}
    }
    
    func servicesWithUUIDs(_ servicesUUIDs: [CBUUID]) -> (foundServices: [CBService], missingServicesUUIDs: [CBUUID]) {
            assert(servicesUUIDs.count > 0)
            
            guard let currentServices = self.services , currentServices.count > 0 else {
                return (foundServices: [], missingServicesUUIDs: servicesUUIDs)
            }
            
            let currentServicesUUIDs = currentServices.map { $0.uuid }
            
            let currentServicesUUIDsSet = Set(currentServicesUUIDs)
            let requestedServicesUUIDsSet = Set(servicesUUIDs)
            
            let foundServicesUUIDsSet = requestedServicesUUIDsSet.intersection(currentServicesUUIDsSet)
            let missingServicesUUIDsSet = requestedServicesUUIDsSet.subtracting(currentServicesUUIDsSet)
            
            let foundServices = currentServices.filter { foundServicesUUIDsSet.contains($0.uuid) }
            
            return (foundServices: foundServices, missingServicesUUIDs: Array(missingServicesUUIDsSet))
        }
        
    }

    





