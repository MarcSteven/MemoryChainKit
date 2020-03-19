//
//  MCBLEDeviceProperty.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/19.
//  Copyright © 2018-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation
import CoreBluetooth

// PropertiesDelegate Protocol: Implement to get properties of scanned devices.
@objc protocol PropertiesDelegate {
    @objc optional func postWriteCharacteristicValue(peripheral: CBPeripheral, char: CBCharacteristic)
    @objc optional func postWriteCharacteristicValueFailed(error: Error?)
    @objc optional func postReadCharacteristicValue(peripheral: CBPeripheral, char: CBCharacteristic)
    @objc optional func postReadCharacteristicValueFailed(error: Error?)
    @objc optional func postNotifyValueUpdate(peripheral: CBPeripheral, char: CBCharacteristic)
    @objc optional func postNotifyValueUpdateFailed(error: Error?)
    @objc optional func postWriteDescriptorValue(peripheral: CBPeripheral, desc: CBDescriptor)
    @objc optional func postWriteDescriptorValueFailed(error: Error?)
    @objc optional func postReadDecriptorValue(peripheral: CBPeripheral, desc: CBDescriptor)
    @objc optional func postReadDecriptorValueFailed(error: Error?)
}
class BLEDeviceProperties: NSObject, ReadWirteCharteristicDelegate {
    weak var delegate: PropertiesDelegate?
    override init() {
        super.init()
        
    }
    // Wrie value for any Characteristic.
    func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, char: CBCharacteristic, type: CBCharacteristicWriteType) {
        MCBLEManager.shared().readWriteCharDelegate = self
        //MCBLEManager.getSharedBLEManager().readWriteCharDelegate = self
        MCBLEManager.shared().writeCharacteristicValue(peripheral: peripheral, data: data, char: char, type: type)
    }
    // Read value for any Characteristic.
    func readCharacteristicValue(peripheral: CBPeripheral, char: CBCharacteristic) {
        MCBLEManager.shared().readWriteCharDelegate = self
        MCBLEManager.shared().readCharacteristicValue(peripheral: peripheral, char: char)
    }
    // To Set Enable Notify value for any Characteristic.
    func setNotifyValue(peripheral: CBPeripheral, enabled: Bool, char: CBCharacteristic) {
        MCBLEManager.shared().readWriteCharDelegate = self
        MCBLEManager.shared().setNotifyValue(peripheral: peripheral, enabled: enabled, char: char)
    }
    // Write Descriptor value for any descriptor.
    func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor) {
        MCBLEManager.shared().readWriteCharDelegate = self
       MCBLEManager.shared().writeDescriptorValue(peripheral: peripheral, data: data, descriptor: descriptor)
    }
    // Read Descriptor value for any descriptor.
    func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor) {
        MCBLEManager.shared().readWriteCharDelegate = self
        MCBLEManager.shared().readDescriptorValue(peripheral: peripheral, descriptor: descriptor)
    }
    // This method will be triggered once Characteristics will be updated.
    func bleManagerDidWriteValueForChar(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.postWriteCharacteristicValueFailed!(error: error)
        } else {
            delegate?.postWriteCharacteristicValue!(peripheral: peripheral, char: characteristic)
        }
    }
    // This Mehtod will be triggered once Characteristics will be read.
    func bleManagerDidUpdateValueForChar(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.postReadCharacteristicValueFailed!(error: error)
        } else {
            delegate?.postReadCharacteristicValue!(peripheral: peripheral, char: characteristic)
        }
    }
    // This Mehtod will be triggered once Descriptor will be updated.
    func bleManagerDidWriteValueForDesc(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        if error != nil {
            delegate?.postWriteDescriptorValueFailed!(error: error)
        } else {
            delegate?.postWriteDescriptorValue!(peripheral: peripheral, desc: descriptor)
        }
    }
    // This Mehtod will be triggered once Descriptor will be read.
    func bleManagerDidUpdateValueForDesc(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        if error != nil {
            delegate?.postReadDecriptorValueFailed!(error: error)
        } else {
            delegate?.postReadDecriptorValue!(peripheral: peripheral, desc: descriptor)
        }
    }
    // This Mehtod will be triggered once Characteristics will be Notified.
    func bleManagerDidUpdateNotificationState(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            delegate?.postNotifyValueUpdateFailed!(error: error)
        } else {
         delegate?.postNotifyValueUpdate!(peripheral: peripheral, char: characteristic)
        }
    }
}
