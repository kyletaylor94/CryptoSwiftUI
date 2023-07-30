//
//  CoinsRowView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI

struct CoinsRowView: View {
    let coin: CoinsModel
    
    var body: some View {
        HStack(spacing: 6){
            //market cap rank
            Text(coin.marketCapRank!.description)
                .font(.caption)
                .foregroundColor(.gray)
                
            //Image(systemName: coin.image)
            AsyncImage(url: URL(string: coin.image)) { phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                } else {
                    ProgressView()
                        .frame(width: 32, height: 32)
                }
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading,4)
                    .foregroundColor(Color("textcolor"))
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 6)
            }
            .padding(.leading, 2)
            
            Spacer()
            VStack(alignment: .trailing, spacing: 4){
                Text(coin.currentPrice.toCurrency())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading,4)
                    .foregroundColor(Color("textcolor"))
                Text(coin.priceChangePercentage24H.toPercentage())
                    .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
                    .padding(.leading,6)
                    .font(.caption)
            }
            .padding(.leading, 2)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
/*
struct CoinsRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsRowView(coin: coin)
    }
}
*/
