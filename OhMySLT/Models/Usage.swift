//
//  Usage.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usage = try? JSONDecoder().decode(Usage.self, from: jsonData)

import Foundation

// MARK: - Usage
struct Usage: Codable {
    let isSuccess: Bool
    let dataBundle: DataBundle
}

// MARK: - DataBundle
struct DataBundle: Codable {
    let status, reportedTime: String
    let myPackageSummary, bonusDataSummary, freeDataSummary, vasDataSummary, extraGBDataSummary: Summary?
    let myPackageInfo: MyPackageInfo

    enum CodingKeys: String, CodingKey {
        case status
        case reportedTime = "reported_time"
        case myPackageSummary = "my_package_summary"
        case bonusDataSummary = "bonus_data_summary"
        case freeDataSummary = "free_data_summary"
        case vasDataSummary = "vas_data_summary"
        case extraGBDataSummary = "extra_gb_data_summary"
        case myPackageInfo = "my_package_info"
    }
}

// MARK: - MyPackageInfo
struct MyPackageInfo: Codable {
    let packageName: String
    let usageDetails: [UsageDetail]
    let reportedTime: String

    enum CodingKeys: String, CodingKey {
        case packageName = "package_name"
        case usageDetails
        case reportedTime = "reported_time"
    }
}

// MARK: - UsageDetail
struct UsageDetail: Codable {
    let name: String
    let used, limit, remaining: FlexibleValue?
    let percentage: Int
    let volumeUnit, expiryDate: String
    let unsubscribable: Bool
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case name, limit, remaining, used, percentage
        case volumeUnit = "volume_unit"
        case expiryDate = "expiry_date"
        case unsubscribable, timestamp
    }
}

// MARK: - Summary
struct Summary: Codable {
    let limit, used: FlexibleValue?
    let volumeUnit: String

    enum CodingKeys: String, CodingKey {
        case limit, used
        case volumeUnit = "volume_unit"
    }
}
