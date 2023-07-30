//
//  ContentView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 12..
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    TopMoversView(viewModel: viewModel)
                        
                    Divider()
                    
                    AllCoinsView(viewModel: viewModel)
                }
                
                if viewModel.isLoading {
                    CustomLoadingIndicator()
                }
                
            }
            .navigationTitle("Live Prices")
            }
        
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
