//
//  BluetoothManager.swift
//  PassKitApp
//
//  Created by Migele Beloded on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothManagerDelegate
{
    func bluetoothReady()
    func bluetoothError(error:String)
}

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    
    private let cbCentralManager    : CBCentralManager!
    private var btStatus            : String!
    var delegate                    : BluetoothManagerDelegate?
    
    class var sharedInstance : BluetoothManager {
        
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : BluetoothManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = BluetoothManager()
        }
        return Static.instance!
    }
    
    // PRIVATE
    private override init() {
        super.init()
        self.cbCentralManager = CBCentralManager(delegate:self, queue:nil)
    }
    
    func getBtStatus()->String
    {
        return self.btStatus;
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        var statusIsOk = false
        
        switch self.cbCentralManager.state {
            
        case .PoweredOff:
            println("CoreBluetooth BLE hardware is powered off")
            self.btStatus = "CoreBluetooth BLE hardware is powered off\n"
            break
        case .PoweredOn:
            println("CoreBluetooth BLE hardware is powered on and ready")
            self.btStatus = "CoreBluetooth BLE hardware is powered on and ready\n"
            // We can now call scanForBeacons
            statusIsOk = true
            break
        case .Resetting:
            println("CoreBluetooth BLE hardware is resetting")
            self.btStatus = "CoreBluetooth BLE hardware is resetting\n"
            break
        case .Unauthorized:
            println("CoreBluetooth BLE state is unauthorized")
            self.btStatus = "CoreBluetooth BLE state is unauthorized\n"
            
            break
        case .Unknown:
            println("CoreBluetooth BLE state is unknown")
            self.btStatus = "CoreBluetooth BLE state is unknown\n"
            statusIsOk = false
            break
        case .Unsupported:
            println("CoreBluetooth BLE hardware is unsupported on this platform")
            self.btStatus = "CoreBluetooth BLE hardware is unsupported on this platform\n"
            break
            
        default:
            break
        }
        
        println("self.bluetoothManager.state = \(self.cbCentralManager.state)");
            
        if statusIsOk {
            delegate?.bluetoothReady()
        }
        else //if btStatus != "unknown"
        {
            delegate?.bluetoothError(btStatus)
        }
    }
}
