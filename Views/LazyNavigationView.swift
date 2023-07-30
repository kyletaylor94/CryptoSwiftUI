//
//  LazyNavigationView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 14..
//

import SwiftUI

struct LazyNavigationView<Content: View> : View{
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content{
        build()
    }
}
