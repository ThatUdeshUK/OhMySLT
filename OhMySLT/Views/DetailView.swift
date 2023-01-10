//
//  DetailView.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-10.
//

import SwiftUI

struct DetailView: View {
    private var usageDetail: UsageDetail
    
    init(usage: UsageDetail) {
        self.usageDetail = usage
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(usageDetail.name.toHuman())
                        .fontWeight(.bold)
                        .font(.title3)
                    if usageDetail.remaining != nil {
                        Text(usageDetail.used + "GB Used").opacity(0.6)
                    }
                }
                Spacer()
                if let limit = usageDetail.limit, let remaining = usageDetail.remaining {
                    HStack(alignment: .lastTextBaseline) {
                        Text(remaining)
                            .font(.system(size: 28))
                            .opacity(0.8)
                        Text("/ " + limit + " GB")
                            .font(.system(size: 16))
                            .opacity(0.5)
                    }
                } else {
                    Text(usageDetail.used)
                        .font(.system(size: 28))
                        .opacity(0.8)
                }
            }
            ProgressView(value: Float(usageDetail.percentage), total: 100.0)
                .tint(getProgressColor(progress: usageDetail.percentage))
            Divider()
        }
    }
    
    func getProgressColor(progress: Int) -> Color {
        if progress > 50 {
            return Color.green
        } else if progress > 20 {
            return Color.yellow
        } else if progress > 5 {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(usage: UsageDetail(name: "Free", used: "60", limit: "100", remaining: "40", percentage: 40, volumeUnit: "GB", expiryDate: "12/11/2022", unsubscribable: false, timestamp: 0))
    }
}
