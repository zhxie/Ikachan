//
//  Collection.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/5.
//

import Foundation

extension Collection {
    func at(index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
}
