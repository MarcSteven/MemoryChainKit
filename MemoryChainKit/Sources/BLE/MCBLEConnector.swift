//
//  MCBLEConnector.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//
import Foundation
import CoreBluetooth


// PairUnPairDeviceDelegate Protocol: Implement to get Device pairing and unpairing Success and Failure.
@objc protocol PairUnPairDeviceDelegate {
@objc optional    func devicePairedSuccessfully(peripheral: CBPeripheral)
@objc optional    func devicePairedFailed(peripheral: CBPeripheral, error: Error?)
@objc optional    func deviceUnpairedSuccessfully(peripheral: CBPeripheral, error: Error?)
}
class BLEDeviceConnection: NSObject, DeviceConnectionDelegate {
    weak var delegate: PairUnPairDeviceDelegate?
    override init() {
        super.init()
    }
    // Connect Scanned device.
    func connectScannedDevice(peripheral: CBPeripheral, options: [String : Any]?) {
        MCBLEManager.shared().connectionDelegate = self
        MCBLEManager.shared().connectPeripheralDevice(peripheral: peripheral, options: options)    }
    // Disconnect Scanned Device
    func disConnectScannedDevice(peripheral: CBPeripheral) {
       
        MCBLEManager.shared().connectionDelegate = self
        MCBLEManager.shared().disconnectPeripheralDevice(peripheral: peripheral)
        
    }
    // This Method will be trigered once device connection will be intrupped or failed to connect due to any reason.
    func bleManagerConnectionFail(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        delegate?.devicePairedFailed!(peripheral: peripheral, error: error)
    }
    // This method will be triggered once device will be connected.
    func bleManagerDidConnect(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.devicePairedSuccessfully!(peripheral: peripheral)
    }
    // This method will be triggered once device will be disconnected.
    func bleManagerDisConect(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        delegate?.deviceUnpairedSuccessfully!(peripheral: peripheral, error: error)
    }
}
