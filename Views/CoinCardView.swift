//
//  CoinCardView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI

struct CoinCardView: View {
    let coin: CoinsModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
           // Image(systemName: "bitcoinsign.circle.fill")
            AsyncImage(url: URL(string: coin.image)) { phase in
                if let image = phase.image{
                    image
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.orange)
                        .padding(.bottom, 8)
                }
            }
            HStack(spacing: 2){
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color("textcolor"))
                
                Text(coin.currentPrice.toCurrency())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text(coin.priceChangePercentage24H.toPercentage())
                .font(.title2)
                .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
                
            
        }
        .frame(width: 140, height: 140)
        .background(Color("backgroundcolor"))
        .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.systemGray4), lineWidth: 2)
            .shadow(color: Color.gray.opacity(0.6), radius: 10)
        )
         
    }
}

/*struct CoinCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinCardView(coin: CoinsModel)
    }
}*/
