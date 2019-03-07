//
//  Character+syab.swift
//  Pods-SYABFoundation_Example
//
//  Created by xygj on 2019/3/7.
//

import Foundation

public extension Character {
    public var syab_isEmoji: Bool {
        for scalar in unicodeScalars {
            if scalar.syab_isEmoji {
                return true
            }
        }
        return false
    }
}
