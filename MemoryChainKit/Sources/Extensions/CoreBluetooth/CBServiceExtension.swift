//
//  CBServiceExtension.swift
//  ARICategoryKit
//
//  Created by marc zhao on 2022/6/14.
//

import CoreBluetooth


public extension CBService {
     func characteristicWithUUID(_ uuid: CBUUID) -> CBCharacteristic? {
        guard let characteristics = self.characteristics else {
            return nil
        }
        
        return characteristics.filter { $0.uuid == uuid }.first
    }
    
     func characteristicsWithUUIDs(_ characteristicsUUIDs: [CBUUID]) -> (foundCharacteristics: [CBCharacteristic], missingCharacteristicsUUIDs: [CBUUID]) {
        assert(characteristicsUUIDs.count > 0)
        
        guard let currentCharacteristics = self.characteristics , currentCharacteristics.count > 0 else {
            return (foundCharacteristics: [], missingCharacteristicsUUIDs: characteristicsUUIDs)
        }
        
        let currentCharacteristicsUUID = currentCharacteristics.map { $0.uuid }
        
        let currentCharacteristicsUUIDSet = Set(currentCharacteristicsUUID)
        let requestedCharacteristicsUUIDSet = Set(characteristicsUUIDs)
        
        let foundCharacteristicsUUIDSet = requestedCharacteristicsUUIDSet.intersection(currentCharacteristicsUUIDSet)
        let missingCharacteristicsUUIDSet = requestedCharacteristicsUUIDSet.subtracting(currentCharacteristicsUUIDSet)
        
        let foundCharacteristics = currentCharacteristics.filter { foundCharacteristicsUUIDSet.contains($0.uuid) }
        
        return (foundCharacteristics: foundCharacteristics, missingCharacteristicsUUIDs: Array(missingCharacteristicsUUIDSet))
    }
}
