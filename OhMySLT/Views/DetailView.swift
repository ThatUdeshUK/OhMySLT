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
                    if let remaining = usageDetail.remaining {
                        Text(remaining + "GB Remaining").opacity(0.6)
                    } else {
                        EmptyView()
                    }
                }
                Spacer()
                HStack(alignment: .lastTextBaseline) {
                    Text(usageDetail.used)
                        .font(.system(size: 28))
                        .opacity(0.8)
                    if let limit = usageDetail.limit {
                        Text("/ " + limit + " GB")
                            .font(.system(size: 16))
                            .opacity(0.5)
                    } else {
                        EmptyView()
                    }
                }
            }
            ProgressView(value: Float(100 - usageDetail.percentage), total: 100.0)
            Divider()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(usage: UsageDetail(name: "Free", used: "60", limit: "100", remaining: "40", percentage: 40, volumeUnit: "GB", expiryDate: "12/11/2022", unsubscribable: false, timestamp: 0))
    }
}
