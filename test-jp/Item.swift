//
//  Item.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

@Model
final class ElaboratedItem {
    var label: String
    
    init(label: String) {
        self.label = label
    }
}
