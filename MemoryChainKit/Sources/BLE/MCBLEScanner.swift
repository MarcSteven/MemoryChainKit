//
//  MCBLEScanner.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/19.
//  Copyright © 2018-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//
import CoreBluetooth

@objc protocol MCBLEScannerDelegate {
    /**
    had connected with device 已经连接到设备
     @parameter : device list
     */
    @objc optional func didScannedDevices(_ scannedDevices:NSArray)
    /** check the connection status*/
    @objc optional func didCheckConnectionStatus(status:Int)
}

// DisplayPeripheral: Type of Device will be returned as a scanned device.
struct ScannedPeripheral {
    var peripheral: CBPeripheral?
    var lastRSSI: NSNumber?
    var isConnectable: Bool?
    var localName: String?
}

class BLEDeviceScan: NSObject, DeviceScaningDelegate {
   weak var delegate: MCBLEScannerDelegate?
    var peripherals: [ScannedPeripheral] = []
    override init() {
        super.init()
    }
    // To Scan all Devices
    func scanAllDevices() {
        MCBLEManager.shared().scaningDelegate = self
        MCBLEManager.shared().scanAllDevices()
    }
    // To Scan Devices by Their Services UUIDs
    func scanDeviceByServiceUUID(serviceUUIDs: NSArray?, options: [String : Any]?) {
        MCBLEManager.shared().scaningDelegate = self
        MCBLEManager.shared().scanDevice(serviceUUIDs: serviceUUIDs, options: options)
    }
    // Stop Scan
    func stopScan() {
        MCBLEManager.shared().stopScan()
    }
    // This will be triggered once BLE Device will be discoverd.
    func bleManagerDiscover(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        for (index, foundPeripheral) in peripherals.enumerated() {
            if foundPeripheral.peripheral?.identifier == peripheral.identifier {
                peripherals[index].lastRSSI = RSSI
                return
            }
        }
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as? Bool
        let localName = advertisementData["kCBAdvDataLocalName"] as? String
        let displayPeripheral = ScannedPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: isConnectable, localName: localName)
        peripherals.append(displayPeripheral)
        delegate?.didScannedDevices?((peripheral as? NSArray)!) 
    }
    
    // This will be trigerred once device cinfiguration status will be changed.
    func scanningStatus(status: Int) {
        delegate?.didCheckConnectionStatus?(status: status)
    }
}
