//
//  ChartData.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import Foundation

struct ChartData: Identifiable{
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
