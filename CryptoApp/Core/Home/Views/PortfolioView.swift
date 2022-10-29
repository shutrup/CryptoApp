//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 24.10.2022.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSelection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) { 
                    XMarkButton(presentationMode: _presentationMode)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            })
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(HomeViewModel())
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green: Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    private var portfolioInputSelection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Amount holding:")
                
                Spacer()
                
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            
            HStack {
                Text("Current value:")
                
                Spacer()
                
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolio = vm.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolio.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin, let amount = Double(quantityText) else {return}
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring()) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}