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
    
    init(vm: UsageViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Text("OhMySLT")
                    .font(.title)
                    .fontDesign(.rounded)
                Spacer()
                Button{
                    if #available(macOS 13, *) {
                        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    } else {
                        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                }.buttonStyle(.borderless)
            }.padding()
            
            if let status = vm.usage?.dataBundle.status {
                StatusView(status: status)
            } else {
                EmptyView()
            }
            
            List(vm.usage?.dataBundle.myPackageInfo.usageDetails ?? [], id: \.name) { usageDetail in
                DetailView(usage: usageDetail)
            }.task {
                do {
                    try await vm.populateUsage(
                        subscriberID: subscriberID,
                        clientID: Constants.Keys.clientID,
                        authToken: accessToken
                    )
                } catch ConfigError.invalidSubscriberID {
                    print("Invalid SubscriberID")
                } catch ConfigError.invalidAccessToken {
                    print("Invalid Access Token")
                } catch {
                    print("Unexpected Error")
                    print(error)
                }
            }
        }.frame(width: 300)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(vm: UsageViewModel())
    }
}
