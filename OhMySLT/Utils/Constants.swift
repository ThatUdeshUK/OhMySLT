//
//  Constants.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import Foundation

struct Constants {
    struct Urls {
        static let usageSummary = URL(string: "https://omniscapp.slt.lk/mobitelint/slt/api/BBVAS/UsageSummary")!
    }
    struct Keys {
        static let clientID = "41aed706-8fdf-4b1e-883e-91e44d7f379b"
    }
    struct Bundle {
        static let normal = "NORMAL"
        static let throttled = "THROTTLED"
    }
}
