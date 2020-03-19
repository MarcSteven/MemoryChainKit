//
//  MCBLEDeviceRSSI.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/17.
//  Copyright © 2018-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//
import Foundation
import CoreBluetooth

// ReadRSSIDelegate Protocol: Implement to get RSSI Value Success or failure.
protocol ReadRSSIDelegate:class {
    func postRSSIValue(peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber)
    func postRSSIValueFailed(error: Error?)
}
class BLEDeviceRSSI: NSObject, ReadRSSIValueDelegate {
    
    weak var delegate: ReadRSSIDelegate?
    
    override init() {
        super.init()
        MCBLEManager.shared().readRSSIdelegate = self  //BLEManager.getSharedBLEManager().readRSSIdelegate = self
    }
    // Read RSSI Value
    func readRSSI(peripheral: CBPeripheral) {
        //BLEManager.getSharedBLEManager().readRSSI(peripheral: peripheral)
    }
    // This Methid will be triggered once RSSI value will be fetched.
    func bleManagerReadRSSIValue(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if error != nil {
         delegate?.postRSSIValueFailed(error: error)
        } else {
            delegate?.postRSSIValue(peripheral: peripheral, didReadRSSI: RSSI)
        }
    }
}
