//
//  CBCharacteristicExtension.swift
//  ARICategoryKit
//
//  Created by marc zhao on 2022/6/14.
//

import CoreBluetooth


public extension CBCharacteristic {
     func descriptorWithUUID(_ uuid: CBUUID) -> CBDescriptor? {
        guard let descriptors = self.descriptors else {
            return nil
        }
        
        return descriptors.filter { $0.uuid == uuid }.first
    }
    
     func descriptorsWithUUIDs(_ descriptorsUUIDs: [CBUUID]) -> (foundDescriptors: [CBDescriptor], missingDescriptorsUUIDs: [CBUUID]) {
        assert(descriptorsUUIDs.count > 0)
        
        guard let currentDescriptors = self.descriptors , currentDescriptors.count > 0 else {
            return (foundDescriptors: [], missingDescriptorsUUIDs: descriptorsUUIDs)
        }
        
        let currentDescriptorsUUIDs = currentDescriptors.map { $0.uuid }
        
        let currentDescriptorsUUIDsSet = Set(currentDescriptorsUUIDs)
        let requestedDescriptorsUUIDsSet = Set(descriptorsUUIDs)
        
        let foundDescriptorsUUIDsSet = requestedDescriptorsUUIDsSet.intersection(currentDescriptorsUUIDsSet)
        let missingDescriptorsUUIDsSet = requestedDescriptorsUUIDsSet.subtracting(currentDescriptorsUUIDsSet)
        
        let foundDescriptors = currentDescriptors.filter { foundDescriptorsUUIDsSet.contains($0.uuid) }
        
        return (foundDescriptors: foundDescriptors, missingDescriptorsUUIDs: Array(missingDescriptorsUUIDsSet))
    }
}

