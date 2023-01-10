//
//  UsageViewModel.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import Foundation

// MARK: UsageViewModel
@MainActor
class UsageViewModel: ObservableObject {
    
    @Published var usage : Usage?
    
    func populateUsage(subscriberID: String, clientID: String, authToken: String) async throws {
        guard subscriberID.starts(with: "94"), subscriberID.count == 11 else {
            throw ConfigError.invalidSubscriberID
        }
        
        let usage = try await WebService().getUsage(
            url: Constants.Urls.usageSummary.appending(
                queryItems: [URLQueryItem(name: "subscriberID", value: subscriberID)]
            ),
            authToken: authToken,
            clientId: clientID
        )
        self.usage = usage
    }
    
}
