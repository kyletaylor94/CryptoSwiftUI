//
//  AllCoinsView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI

struct AllCoinsView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("All Coins")
                .font(.headline)
                .padding()
            HStack{
                Text("Coin")
                    
                Spacer()
                
                Text("Prices")
                    
            }
            .foregroundColor(.gray)
            .font(.caption)
            .padding(.horizontal)
    //coinsrowview
            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(viewModel.coins) { coin in
                        NavigationLink {
                            LazyNavigationView(                            CoinDetailsView(coin: coin)
)
                        } label: {
                            CoinsRowView(coin: coin)
                        }

                    }
                }
            }
        }
    }
}

struct AllCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        AllCoinsView(viewModel: HomeViewModel())
    }
}
