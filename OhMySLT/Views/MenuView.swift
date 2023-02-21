//
//  ContentView.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import SwiftUI

struct MenuView: View {
    
    @AppStorage("subscriberID") private var subscriberID = ""
    @AppStorage("accessToken") private var accessToken = ""
    
    @StateObject private var vm: UsageViewModel
    @State private var configError: ConfigError?
    
    init(vm: UsageViewModel) {
        self._vm = StateObject(wrappedValue: vm)
        self._configError = State(initialValue: nil)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Text("OhMySLT")
                    .font(.title)
                    .fontDesign(.rounded)
                Spacer()
                Button{
                    openSettings()
                } label: {
                    Image(systemName: "gearshape.fill")
                }.buttonStyle(.borderless)
            }.padding()
            
            if let status = vm.usage?.dataBundle.status {
                StatusView(status: status)
            } else {
                EmptyView()
            }
            
            VStack(alignment: .center, spacing: 0) {
                List((vm.usage?.dataBundle.myPackageInfo.usageDetails ?? []) + (vm.vasUsage?.dataBundle.usageDetails ?? []) + (vm.extraUsage?.dataBundle.usageDetails ?? []), id: \.name) { usageDetail in
                    DetailView(usage: usageDetail)
                }
                .scrollIndicators(.never)
                
                if configError != nil {
                    ErrorView(message: mapConfigError(error: configError!), actionName: "Open Settings") {
                        openSettings()
                    }
                }
            }
            .task {
                do {
                    try await vm.populateUsage(
                        subscriberID: subscriberID,
                        clientID: Constants.Keys.clientID,
                        authToken: accessToken
                    )
                    configError = nil
                } catch ConfigError.invalidSubscriberID {
                    configError = ConfigError.invalidSubscriberID
                } catch ConfigError.invalidAccessToken {
                    configError = ConfigError.invalidAccessToken
                    print("Invalid Access Token")
                } catch {
                    print("Unexpected Error")
                    print(error)
                }
            }
        }.frame(width: 300)
    }
    
    func mapConfigError(error: ConfigError) -> String {
        switch error {
        case .invalidAccessToken:
            return "Valid Access Token is not set"
        case .invalidSubscriberID:
            return "Valid Subscriber ID is not set"
        case .invalidResfreshToken:
            return "Valid Refresh Token is not set"
        }
    }
    
    func openSettings() {
        if #available(macOS 13, *) {
            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        } else {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
        NSApp.activate(ignoringOtherApps: true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(vm: UsageViewModel())
    }
}
