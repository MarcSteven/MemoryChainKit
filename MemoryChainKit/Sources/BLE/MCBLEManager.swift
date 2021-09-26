//
//  MCBLEManager.swift
//  VeryProfit
//
//  Created by Marc Steven on 2018/8/19.
//  Copyright © 2018-2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//


import Foundation
import CoreBluetooth
// DeviceScaningDelegate Protocol: Implements to get scanning devices
protocol DeviceScaningDelegate:AnyObject {
    func scanningStatus(status: Int)
    func bleManagerDiscover(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
}
// DeviceConnectionDelegate Protocol: Implements to get Connection/Disconnection Success or Failure
protocol DeviceConnectionDelegate:AnyObject {
    func bleManagerConnectionFail (_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?)
    func bleManagerDidConnect(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    func bleManagerDisConect(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
}
// ServicesDiscoveryDelegate Protocol: Implements to get Services,Characteristics and Descriptors Discovery
protocol DiscoverableServicesDelegate:AnyObject {
    func bleManagerDiscoverService (_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    func bleManagerDiscoverCharacteristics (_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    func bleManagerDiscoverDescriptors (_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?)
}
// ReadWirteCharteristicDelegate Protocol: Implements to get Read,Write and Notify Characterisctis and Descriptors
protocol ReadWirteCharteristicDelegate:AnyObject {
    
    func bleManagerDidUpdateValueForChar(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    func bleManagerDidWriteValueForChar(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
    func bleManagerDidUpdateValueForDesc(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?)
    func bleManagerDidWriteValueForDesc(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?)
    func bleManagerDidUpdateNotificationState(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?)
}
// ReadRSSIValueDelegate Protocol: Implements to get RSSI Value
protocol ReadRSSIValueDelegate:AnyObject {
    func bleManagerReadRSSIValue(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?)
}

private var shared: MCBLEManager? = nil

open class MCBLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private static var sharedBLEManager:MCBLEManager = {
        let bleManger = MCBLEManager()
        return bleManger
    }()
    var centralManager: CBCentralManager?
    weak var scaningDelegate: DeviceScaningDelegate?
    weak var connectionDelegate: DeviceConnectionDelegate?
    weak var discoveryDelegate: DiscoverableServicesDelegate?
    weak var readWriteCharDelegate: ReadWirteCharteristicDelegate?
    weak var readRSSIdelegate: ReadRSSIValueDelegate?
    weak var stopScanTimer: Timer?
    class func shared() ->MCBLEManager {
        return sharedBLEManager
    }
   // MARK: Intializing BLE CentralManager
    func initCentralManager(queue: DispatchQueue?, options: [String : Any]?) {
        if self.centralManager == nil {
            centralManager = CBCentralManager(delegate: self, queue: queue, options: options)
        }
    }
    // MARK: BLE CBCentralManagerDelegpublic ate
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 10.0, *) {
            switch central.state {
            case CBManagerState.unauthorized:
                scaningDelegate?.scanningStatus(status:CBManagerState.unauthorized.rawValue)
                break
            case CBManagerState.poweredOff:
                scaningDelegate?.scanningStatus(status:CBManagerState.poweredOff.rawValue)
                break
            case CBManagerState.resetting:
                scaningDelegate?.scanningStatus(status:CBManagerState.resetting.rawValue)
                break
            case CBManagerState.poweredOn:
                scaningDelegate?.scanningStatus(status:CBManagerState.poweredOn.rawValue)
                break
            default:
                break
            }
        } else {

           let cmState: CBCentralManagerState = (CBCentralManagerState)(rawValue: central.state.rawValue)!
            switch cmState {
            case CBCentralManagerState.unauthorized:
                scaningDelegate?.scanningStatus(status:CBCentralManagerState.unauthorized.rawValue)
                break
            case CBCentralManagerState.poweredOff:
                scaningDelegate?.scanningStatus(status:CBCentralManagerState.poweredOff.rawValue)
                break
            case CBCentralManagerState.poweredOn:
                scaningDelegate?.scanningStatus(status:CBCentralManagerState.poweredOn.rawValue)
                break
            case CBCentralManagerState.resetting:
                scaningDelegate?.scanningStatus(status:CBCentralManagerState.resetting.rawValue)
                break
            default:
                break
            }             }
    }
   public  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheral.delegate = self
        scaningDelegate?.bleManagerDiscover(central, didDiscover: peripheral, advertisementData: advertisementData, rssi: RSSI)
    }
  public   func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        connectionDelegate?.bleManagerDidConnect(central, didConnect: peripheral)
    }
  public   func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        connectionDelegate?.bleManagerConnectionFail(central, didFailToConnect: peripheral, error: error)
    }
   public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectionDelegate?.bleManagerDisConect(central, didDisconnectPeripheral: peripheral, error: error)
    }
    // MARK: BLE CBPeripheralDelegate
   public  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        discoveryDelegate?.bleManagerDiscoverService(peripheral, didDiscoverServices: error)
    }
   public  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        discoveryDelegate?.bleManagerDiscoverCharacteristics(peripheral, didDiscoverCharacteristicsFor: service, error: error)
    }
  public  func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        discoveryDelegate?.bleManagerDiscoverDescriptors(peripheral, didDiscoverDescriptorsFor: characteristic, error: error)
    }
  public   func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        readWriteCharDelegate?.bleManagerDidUpdateValueForChar(peripheral, didUpdateValueFor: characteristic, error: error)
    }
public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        readWriteCharDelegate?.bleManagerDidWriteValueForChar(peripheral, didWriteValueFor: characteristic, error: error)
    }
   public  func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        readWriteCharDelegate?.bleManagerDidUpdateNotificationState(peripheral, didUpdateNotificationStateFor: characteristic, error: error)
    }
  public   func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        readRSSIdelegate?.bleManagerReadRSSIValue(peripheral, didReadRSSI: RSSI, error: error)
    }
   public  func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        readWriteCharDelegate?.bleManagerDidWriteValueForDesc(peripheral, didWriteValueFor: descriptor, error: error)
    }
  public   func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        readWriteCharDelegate?.bleManagerDidUpdateValueForDesc(peripheral, didUpdateValueFor: descriptor, error: error)
    }
    // MARK: Scanning Process
    func scanAllDevices() {
        self.scanDevice(serviceUUIDs: nil, options: nil)
    }
    func scanDevice(serviceUUIDs: NSArray?, options: [String : Any]?) {
        if stopScanTimer != nil {
            stopScanTimer?.invalidate()
            stopScanTimer = nil
        }
        centralManager?.scanForPeripherals(withServices: (serviceUUIDs as? [CBUUID]?)!, options: options)
        self.applyStopScanTimer()
    }
    func stopScan() {
        centralManager?.stopScan()
    }
    @objc func stopScanningAfterInterval() {
            if self.centralManager!.isScanning {
                self.centralManager?.stopScan()
            }
    }
    // MARK: Connection Process
    func connectPeripheralDevice(peripheral: CBPeripheral, options: [String : Any]?) {
        self.centralManager?.connect(peripheral, options: options)
    }
    func disconnectPeripheralDevice(peripheral: CBPeripheral) {
            self.centralManager?.cancelPeripheralConnection(peripheral)
    }
    // MARK: Discover Services
    func discoverAllServices(peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    func discoverServiceByUUIDs(servicesUUIDs: NSArray, peripheral: CBPeripheral) {
        peripheral.discoverServices(servicesUUIDs as? [CBUUID])
    }
    // MARK: Discover Characteristics
    func discoverAllCharacteristics(peripheral: CBPeripheral, service: CBService) {
        peripheral.discoverCharacteristics(nil, for: service)
    }
    func discoverCharacteristicsByUUIDs(charUUIds: NSArray, peripheral: CBPeripheral, service: CBService) {
        peripheral.discoverCharacteristics(charUUIds as? [CBUUID], for: service)
    }
    // MARK: Discover Descriptors
    func discoverDescriptorsByCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        peripheral.discoverDescriptors(for: characteristic)
    }
    func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, char: CBCharacteristic, type: CBCharacteristicWriteType) {
        peripheral.writeValue(data, for: char, type: type)
    }
    // MARK: BLE Properties Reterival
    func readCharacteristicValue(peripheral: CBPeripheral, char: CBCharacteristic) {
        peripheral.readValue(for: char)
    }
    func setNotifyValue(peripheral: CBPeripheral, enabled: Bool, char: CBCharacteristic) {
       peripheral.setNotifyValue(enabled, for: char)
    }
    func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor) {
        peripheral.writeValue(data, for: descriptor)
    }
    func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor) {
        peripheral.readValue(for: descriptor)
    }
    // MARK: Read RSSI Value
    func readRSSI(peripheral: CBPeripheral) {
        peripheral.readRSSI()
    }
    func getConnectedPeripherals(serviceUUIds: NSArray) -> NSArray? {
        return self.centralManager?.retrieveConnectedPeripherals(withServices: (serviceUUIds as? [CBUUID])!) as NSArray?
    }
    func applyStopScanTimer() {
        stopScanTimer = Timer.scheduledTimer(timeInterval: TimeInterval(15.0), target: self, selector: #selector(stopScanningAfterInterval), userInfo: nil, repeats: false)
    }
}
