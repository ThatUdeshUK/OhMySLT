//
//  ErrorView.swift
//  OhMySLT
//
//  Created by 27k on 2023-02-21.
//

import SwiftUI

struct ErrorView: View {
    private var message: String
    private var actionName: String
    private var action: () -> Void
    
    init(message: String, actionName: String, action: @escaping () -> Void) {
        self.message = message
        self.actionName = actionName
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "exclamationmark.triangle").scaleEffect(0.9)
                Text(message)
            }
            Button(action: self.action) {
                Text(self.actionName).foregroundColor(.white)
            }.buttonStyle(.borderedProminent)
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Unknown Error", actionName: "Settings", action: {})
    }
}
