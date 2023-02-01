//
//  VASUsage.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-27.
//

import Foundation

// MARK: - VASUsage
struct VASUsage: Codable {
    let isSuccess: Bool
    let dataBundle: VASDataBundle
}

// MARK: - DataBundle
struct VASDataBundle: Codable {
    let packageSummary: Summary
    let usageDetails: [UsageDetail]
    let reportedTime: String

    enum CodingKeys: String, CodingKey {
        case packageSummary = "package_summary"
        case usageDetails
        case reportedTime = "reported_time"
    }
}
