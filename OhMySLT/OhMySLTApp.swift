//
//  OhMySLTApp.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import SwiftUI

@main
struct OhMySLTApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var menu: OhMyMenu!
    
    private var vm: UsageViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.vm = UsageViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(named: "network_check")
            statusButton.title = ""
        }
        
        self.menu = OhMyMenu()
        statusItem.menu = menu.build(vm: self.vm)
    }
    
}

class OhMyMenu: NSObject {
    let menu = NSMenu()

    func build(vm: UsageViewModel) -> NSMenu {
        let contentView = NSHostingController(rootView: MenuView(vm: vm))
        contentView.view.frame.size = NSSize(width: 300, height: 320)

        let customMenuItem = NSMenuItem()
        customMenuItem.view = contentView.view
        menu.addItem(customMenuItem)

        return menu
    }
}
