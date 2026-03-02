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

func pluriel(index: Int, value: Int) -> String {
    var text: String = ""
    
    if (index == 1) {
        if (value > 1) {
            text = "parties jouées"
        } else {
            text = "partie jouée"
        }
    } else if (index == 2) {
        if (value > 1) {
            text = "cartes piochées"
        } else {
            text = "carte piochée"
        }
        
    } else if (index == 3) {
        if (value > 1) {
            text = "minutes jouées"
        } else {
            text = "minute jouée"
        }
    }
    
    return text
}

func numberToText(value: Int) -> String {
    var text: String = "\(value)"
    
    if (value < 10) {
        text = "0\(value)"
    }
    
    return text
}
