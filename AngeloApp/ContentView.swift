// ContentView.swift
// AngeloApp
// Created by Joseph Brinker on 9/27/24.

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: Model
    
    @State private var showingSheet2 = false
    @State private var showingSheet3 = false
    
    
    @State private var upgrades: [UpgradeData] = [
        UpgradeData(name: "Court Side Tickets", generation: 0.5, cost: 5, amount: 0, logo: "IceCream"),
        UpgradeData(name: "Pizza Sponsor", generation: 5, cost: 25, amount: 0, logo: "PizzaSponsor"),
        UpgradeData(name: "Beer Sponsor", generation: 25, cost: 50, amount: 0, logo: "BeerSponsor"),
        UpgradeData(name: "Season Tickets", generation: 100, cost: 250, amount: 0, logo: "SeasonTickets"),
        UpgradeData(name: "Suite Tickets", generation: 250, cost: 500, amount: 0, logo: "SuiteTickets"),
        UpgradeData(name: "Courtside Tickets", generation: 500, cost: 1000, amount: 0, logo: "CourtsideTickets"),
        UpgradeData(name: "Star Player", generation: 1000, cost: 5000, amount: 0, logo: "StarPlayer"),
        UpgradeData(name: "Gatorade", generation: 2500, cost: 10000, amount: 0, logo: "Gatorade"),
        UpgradeData(name: "Athletic Sponsor", generation: 10000, cost: 100000, amount: 0, logo: "SportswearSponsor")
    ]
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 400, height: 100)
                        .opacity(0.50)
                        .border(.white)
                    HStack {
                        HStack{
                            //Number formatting
                            Image("Basketball")
                            
                            if model.ballCount >= 1000000000 {
                                let  roundedNumber = String(format: "%.2f", (model.ballCount / 1000000000))
                                Text("\(roundedNumber) B")
                                    .foregroundStyle(.white)
                            }
                            else if model.ballCount >= 1000000{
                                let roundedNumber = String(format: "%.2f", (model.ballCount / 1000000))
                                Text("\(roundedNumber) M")
                                    .foregroundStyle(.white)
                            }
                            else{
                                let roundedNumber = String(format: "%.0f", model.ballCount)
                                Text("\(roundedNumber)")
                                    .foregroundStyle(.white)
                            }
                        }
                        .font(.system(size: 40))
                        Spacer()
                        //Screen3 Icon
                        Button{
                            showingSheet3.toggle()
                        } label: {
                            Image(systemName: "checklist")
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                        }
                        .sheet(isPresented: $showingSheet3){
                            Screen3()
                        }
                        
                        //Screen2 Icon
                        Button{
                            showingSheet2.toggle()
                        } label: {
                            Image(systemName: "trophy.fill")
                                .foregroundColor(.yellow)
                                .fontWeight(.thin)
                                .font(.system(size: 40))
                        }
                        .sheet(isPresented: $showingSheet2){
                            Screen2()
                        }
                        
                        
                        
                        
                    }
                    .padding(.trailing, 20)
                    
                }
                
                ScrollView {
                    ForEach(upgrades.indices, id: \.self) { index in
                        Upgrade(upgrade: $upgrades[index])
                    }
                    
                    let roundedNumber = String(format: "%.2f", model.generation)
                    Text("\(roundedNumber)/sec")
                        .foregroundStyle(.gray)
                        .padding(.top, -20)
                }
            }
        }
    }
}
            
struct UpgradeData {
    var name: String
    var generation: Double
    var cost: Double
    var amount: Int
    var logo: String
}

struct Upgrade: View {
    @Binding var upgrade: UpgradeData
    @EnvironmentObject var model: Model
    var body: some View {
        HStack(alignment: .top){
            // Team Logo & Amount
            VStack{
                ZStack(alignment: .bottom){
                    ZStack{
                        Circle()
                            .frame(height: 89)
                            .foregroundStyle(.white)
                        Image(upgrade.logo)
                    }
                    // Amount
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 75, height: 21)
                            .foregroundStyle(.gray)
                        Text("\(upgrade.amount)")
                            .foregroundStyle(.white)
                            .font(.headline)
                        
                    }
                }
            }
            // Body & Description
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 198, height: 89)
                    .foregroundStyle(.upgradeBody)
                // Text Descriptions
                VStack{
                    Text(upgrade.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    let formattedGeneration = String(format: "%.1f", upgrade.generation)
                    Text(formattedGeneration + " /sec")
                        .fontWeight(.light)
                        .italic()
                    let formattedCost = String(format: "%.2f", upgrade.cost)
                    Text(formattedCost + " balls")
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
            }
            // Button
            Button("Buy") {
                if(model.ballCount - upgrade.cost >= 0.0){
                    model.ballCount -= upgrade.cost
                    buyUpgrade()
                }
            }
            .frame(width: 49, height: 89)
            .background(.upgradeBuy)
            .foregroundStyle(.white)
            .cornerRadius(8)
        }
        // gives more space for each individual upgrade data
        .padding()
    }
    
    private func buyUpgrade() {
        // Increase amount by 1
        upgrade.amount += 1
        
        // Double the cost after each purchase
        upgrade.cost *= 1.25
        
        // Increase the generation
        model.generation += upgrade.generation
        upgrade.generation *= 1.15
    }
}

#Preview {
    let model = Model()
    
    return ContentView()
        .environmentObject(model)
}

