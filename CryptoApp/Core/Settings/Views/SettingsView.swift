//
//  SettingView.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 28.10.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/SwiftfulThinking")!
    let coffeeURL = URL(string: "https://www.bymecoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personURL = URL(string: "https://makhachkala.hh.ru/resume/d2ed51f4ff0b56d55e0039ed1f3469716b5870?hhtmFrom=resume_list")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                
                List {
                    swiftfilThinkingSection
                        .listRowBackground(Color.theme.background)
                    coingeckoSection
                        .listRowBackground(Color.theme.background)
                    developerSection
                        .listRowBackground(Color.theme.background)
                    applicationSection
                        .listRowBackground(Color.theme.background)
                }
            }
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(presentationMode: _presentationMode)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftfilThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on Youtube")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link(destination: youtubeURL) {
                Text("Youtube")
            }
            Link(destination: coffeeURL) {
                Text("Coffe")
            }
        }
    }
    private var coingeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptecurrency data that is used in app come from a free API from CoinGecko Prices may be slightly delayed")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
    
            Link(destination: coingeckoURL) {
                Text("Visit Coingecko")
            }
        }
    }
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("I ios developer...............")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
    
            Link(destination: personURL) {
                Text("My resume")
            }
        }
    }
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link(destination: defaultURL) {
                Text("Terms of Service")
            }
            Link(destination: defaultURL) {
                Text("Privacy Policy")
            }
            Link(destination: defaultURL) {
                Text("Company website")
            }
            Link(destination: defaultURL) {
                Text("Learn more")
            }
        }
    }
}
