//
//  String+SLTLabels.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-10.
//

import Foundation

extension String {
    
    func toHuman() -> String {
        if (self == "Standard") {
            return "Day Time"
        } else if (self == "Total (Standard + Free)") {
            return "Total"
        } else {
            return self
        }
    }
    
}
