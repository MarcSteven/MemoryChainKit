//
//  MCBLEDiscoverableDeviceService.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/17.
//  Copyright © 2018-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//
import Foundation
import CoreBluetooth

// DiscoveryDelegate Protocol: Implement to get Discover Services,Characteristics and Descriptors success and Failure.
@objc protocol DiscoveryDelegate {
    @objc optional func postDiscoveredServices(discoveredServices: NSArray)
    @objc optional func postDicoverdServiceFailed(error: NSError?)
    @objc optional func postDiscoverdCharacteristices(discoveredCharacteristics: NSArray)
    @objc optional func PostDicoverdCharacteristicesFailed(error: NSError?)
    @objc optional func postDiscoveredDiscriptors(discoveredDiscriptors: NSArray)
    @objc optional func postDicoverdDiscriptorsFailed(error: NSError?)

}
class BLEDeviceDiscoverServices: NSObject, DiscoverableServicesDelegate {
    var services: [CBService] = []
    var characterstics: [CBCharacteristic] = []
    var descriptors: [CBDescriptor] = []
    weak var delegate: DiscoveryDelegate?
    override init() {
        super.init()
    }
    // Discover All Services.
    func discoverAllServices(peripheral: CBPeripheral) {
       MCBLEManager.shared().discoveryDelegate = self
       MCBLEManager.shared().discoverAllServices(peripheral: peripheral)
    }
    // Discover Specific Services.
    func discoverServiceByUUIDs(servicesUUIDs: NSArray, peripheral: CBPeripheral) {
        MCBLEManager.shared().discoveryDelegate = self
        MCBLEManager.shared().discoverServiceByUUIDs(servicesUUIDs: servicesUUIDs as NSArray, peripheral: peripheral)
    }
    // Discover all Characteristics by any Service.
    func discoverAllCharacteristics(peripheral: CBPeripheral, service: CBService) {
        MCBLEManager.shared().discoveryDelegate = self
        MCBLEManager.shared().discoverAllCharacteristics(peripheral: peripheral, service: service)
    }
    // Discover Specific Characteristics by any Service.
    func discoverCharacteristicsByUUIDs(charUUIds: NSArray, peripheral: CBPeripheral, service: CBService) {
        MCBLEManager.shared().discoveryDelegate = self
        MCBLEManager.shared().discoverCharacteristicsByUUIDs(charUUIds: charUUIds as NSArray, peripheral: peripheral, service: service)
    }
    // Discover Descriptors By Characteristics.
    func discoverDescriptorsByCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        MCBLEManager.shared().discoveryDelegate = self
        MCBLEManager.shared().discoverDescriptorsByCharacteristic(peripheral: peripheral, characteristic: characteristic)
    }
    // This method will be triggered once Services will be discovered.
    func bleManagerDiscoverService(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            delegate?.postDicoverdServiceFailed!(error: error as NSError?)
        } else {
            services.removeAll()
            peripheral.services?.forEach({ (service) in
                services.append(service)
            })
            delegate?.postDiscoveredServices!(discoveredServices: services as NSArray)
        }
    }
    
    // This Method will be triggered once Characteristics will be Discovered.
    func bleManagerDiscoverCharacteristics(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if error != nil {
            delegate?.PostDicoverdCharacteristicesFailed!(error: error as NSError?)
        } else {
            characterstics.removeAll()
            service.characteristics?.forEach({ (characteristic) in
                characterstics.append(characteristic)
            })
            delegate?.postDiscoverdCharacteristices!(discoveredCharacteristics: characterstics as NSArray)
        }
    }
    // This Mehtod will be triggered once Descriptors will be discovered.
    func bleManagerDiscoverDescriptors(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.postDicoverdDiscriptorsFailed!(error: error as NSError?)
        } else {
            characteristic.descriptors?.forEach({ (descriptor) in
                descriptors.append(descriptor)
            })
            delegate?.postDiscoveredDiscriptors!(discoveredDiscriptors: descriptors as NSArray)
        }
    }
}
