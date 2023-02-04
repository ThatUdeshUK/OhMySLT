//
//  SettingsView.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-10.
//

import SwiftUI
import LaunchAtLogin
import Foundation

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            AdvancedSettingsView()
                .tabItem {
                    Label("Advanced", systemImage: "star")
                }
                .tag(Tabs.advanced)
        }
        .padding(20)
        .frame(width: 480, height: 360)
    }
}

struct GeneralSettingsView: View {
    @AppStorage("subscriberID") private var subscriberID = ""
    @AppStorage("accessToken") private var accessToken = ""
    @AppStorage("refreshToken") private var refreshToken = ""

    var body: some View {
        Form {
            TextField("Subscriber ID or SLT Number", text: $subscriberID, prompt: Text("94XXXXXXXXX"))
                .padding(.bottom)
            TextField("MySLT Access Token", text: $accessToken)
            TextField("MySLT Refresh Token", text: $refreshToken)
        }
        .padding(20)
        .frame(width: 350, height: 100)
    }
}

struct AdvancedSettingsView: View {    
    var body: some View {
        VStack(alignment: .center) {
            LaunchAtLogin.Toggle().padding(.bottom)
            Button("Quit OhMySLT"){
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(20)
        .frame(width: 350, height: 100)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

