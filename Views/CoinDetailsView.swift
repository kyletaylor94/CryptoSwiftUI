//
//  CoinDetailsView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI
import Kingfisher

struct CoinDetailsView: View {
    
    let viewModel: CoinDetailsSectionViewModel
    
    init(coin: CoinsModel){
        self.viewModel = CoinDetailsSectionViewModel(coin: coin)
    }
    
    var body: some View {
            ScrollView {
                //chart
                ChartView(viewModel: viewModel)
                    .frame(height: 250)
                    .padding(.vertical)
                //overview
                CoinDetailsSection(model: viewModel.overviewSectionModel)
                   .padding(.vertical)
                
                Divider()
                //additional details
                CoinDetailsSection(model: viewModel.additionalDetailsSectionModel)
                    .padding(.vertical)

            }
            .navigationTitle(viewModel.navName)
            .toolbar{
                ToolbarItem(placement: .principal){
                    viewModel.navImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
            }
            
            .padding()
      
    }
}

struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsView(coin: dev.coin)
    }
}
