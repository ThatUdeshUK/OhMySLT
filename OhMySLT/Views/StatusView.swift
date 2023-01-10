//
//  StatusView.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-10.
//

import SwiftUI

struct StatusView: View {
    
    private var status: String
    
    init(status: String) {
        self.status = status
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.status.capitalized)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding()
            Divider()
        }.background(getColor())
    }
    
    func getColor() -> Color {
        if status == Constants.Bundle.normal {
            return Color.green
        } else if  status == Constants.Bundle.throttled {
            return Color.yellow
        } else {
            return Color.white
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(status: "NORMAL")
    }
}
