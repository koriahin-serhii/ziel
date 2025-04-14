//
//  ContentView.swift
//  ziel
//
//  Created by Serhii Koriahin on 14.04.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var bluetoothManager = BluetoothManager()

    var body: some View {
        VStack {
            Text("Bluetooth Devices")
                .font(.headline)

            if bluetoothManager.bluetoothState != .poweredOn {
                Text("Bluetooth is not available or powered off.")
                    .foregroundColor(.red)
            } else {
                List(bluetoothManager.discoveredDevices, id: \.identifier) { device in
                    HStack {
                        Text(device.name ?? "Unknown Device")
                        Spacer()
                        Button("Connect") {
                            bluetoothManager.connectToDevice(device)
                        }
                    }
                }
            }

            if let connectedDevice = bluetoothManager.connectedDevice {
                Text("Connected to: \(connectedDevice.name ?? "Unknown Device")")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .onAppear {
            bluetoothManager.startScanning()
        }
        .onDisappear {
            bluetoothManager.stopScanning()
        }
    }
}

#Preview {
    ContentView()
}
