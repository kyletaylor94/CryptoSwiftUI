//
//  HomeViewModel.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI

class HomeViewModel: ObservableObject{
    @Published var coins = [CoinsModel]()
    @Published var topCoins = [CoinsModel]()
    @Published var isLoading = true
    
    init(){
        fetchCoinData()
    }
    
    func fetchCoinData(){
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                self.isLoading = false
                print("DEBUG: URLSession was ended by this errorCode: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse{
                print("DEBUG: RESPONSE CODE IS \(response.statusCode)")
            }
            guard let data = data else { return }
            
            do{
                let coins = try JSONDecoder().decode([CoinsModel].self, from: data)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.coins = coins
                    self.configureTopMovingCoins()
                }
            } catch let error{
                DispatchQueue.main.async {
                    self.isLoading = false

                }
                print("DEBUG: Failad to decode with error: \(error) ")
            }
            
        }
        .resume()
    }
    
    func configureTopMovingCoins(){
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H})
        self.topCoins = Array(topMovers.prefix(10))
    }
}
