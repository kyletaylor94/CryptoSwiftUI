//
//  CoinDetailsViewModel.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import Foundation
import Kingfisher

class CoinDetailsSectionViewModel {
    
    private let coin: CoinsModel
    
//chart config
    var chartData = [ChartData]()
    
    var startDate = Date()
    var endDate = Date()
    
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var navName: String{
        return coin.name
    }
    
    var navImage: KFImage{
        let coinImAge = KFImage(URL(string: coin.image))
        return coinImAge
    }
    
    
    var overviewSectionModel: CoinDetailSectionModel{
//price stats
        let price = coin.currentPrice.toCurrency()
        let pricePercentChange = coin.priceChangePercentage24H
        
        let priceStats = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
//market cap stats
        let marketCap = coin.marketCap ?? 0
        let marketCapPercentChange = coin.marketCapChange24H
        
        let marketCapStats = StatisticModel(title: "Market Capitalization", value: "\(marketCap.formattedWithAbbreviations())", percentageChange: marketCapPercentChange)
        
//rank stats
        let rank = coin.marketCapRank ?? 0
        let rankStat = StatisticModel(title: "Rank", value: "\(rank)", percentageChange: nil)
//volume stats
        let volume = coin.totalVolume ?? 0
        let volStat = StatisticModel(title: "Volume", value: volume.formattedWithAbbreviations(), percentageChange: nil)
        
        return CoinDetailSectionModel(title: "OverView", stats: [priceStats, marketCapStats, rankStat, volStat])
    }
    
    var additionalDetailsSectionModel: CoinDetailSectionModel{
//24 high
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = StatisticModel(title: "24H High", value: high, percentageChange: nil )
//24 low
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: "24H Low", value: low, percentageChange: nil)
//24 price change
        let priceChange24 = coin.priceChange24H.toCurrency()
        let priceChange24Percentage = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Change", value:  priceChange24, percentageChange: priceChange24Percentage)
//24 hnmarket cap change
        let marketCapChange24 = coin.marketCapChange24H ?? 0
        let marketCaptoPercentage = coin.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: " $\(marketCapChange24.formattedWithAbbreviations())", percentageChange: marketCaptoPercentage)
        
        return CoinDetailSectionModel(title: "Additional Details", stats: [highStat, lowStat, priceChangeStat, marketCapChangeStat])
    }
    
    init(coin: CoinsModel){
        self.coin = coin
        configureChartData()
        
        print("DEBUG: Coin is \(self.coin.name)")
    }
    
    func configureChartData(){
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        
        self.endDate = Date(coinGecckoString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        
        self.xAxisValues = [startDate, endDate]
        
        for price in priceData.reversed(){
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}
