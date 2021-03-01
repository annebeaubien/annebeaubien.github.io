//
//  File.swift
//  
//
//  Created by Chris Jensen on 1/3/21.
//

import Foundation

extension TimeInterval {
    func format(using units: NSCalendar.Unit = [.hour, .minute]) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .full
        return formatter.string(from: self) ?? "N/A"
    }
}
