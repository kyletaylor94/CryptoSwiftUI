//
//  ChartView.swift
//  CrypToSwiFt
//
//  Created by Turdesán Csaba on 2023. 04. 13..
//

import SwiftUI
import Charts

struct ChartView: View {
    let viewModel: CoinDetailsSectionViewModel
    
    var body: some View {
        Chart{
            ForEach(viewModel.chartData){item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Price", item.value)
                )
                .interpolationMethod(.linear)
            }
        }
        .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.startDate, upper: viewModel.endDate)))
        
        .chartXAxis {
            AxisMarks(position: .bottom, values: viewModel.xAxisValues){ value in
                AxisGridLine()
                AxisValueLabel(){
                    if let dateValue = value.as(Date.self){
                        Text(dateValue.asShortDateString())
                    }
                }
            }
        }
        .foregroundColor(.red)
        .shadow(color: .red,radius: 10)
        
        .chartYAxis{
            AxisMarks(position: .leading, values: viewModel.yAxisValues) { value in
                AxisGridLine()
                AxisValueLabel(){
                    if let doubleValue = value.as(Double.self){
                        Text(doubleValue.formattedWithAbbreviations())
                    }
                }
             
            }
        }
        .foregroundColor(.red)
        .shadow(color: .red,radius: 20)
        .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.minPrice, upper: viewModel.maxPrice)))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(viewModel: CoinDetailsSectionViewModel(coin: dev.coin))
    }
}
