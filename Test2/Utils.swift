//
//  Utils.swift
//  Test2
//
//  Created by Robin Despaquis on 25/02/2026.
//

import Foundation
import SwiftUI // Pour utiliser CGFloat

func rightSize(type: String = "deux") -> CGFloat {
    if type == "S" || type == "Q" {
        return 55
    } else if type == "un" {
        return 18
    } else {
        return 30
    }
}
