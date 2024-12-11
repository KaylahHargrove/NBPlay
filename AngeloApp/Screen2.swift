//
//  ContentView.swift
//  screen2
//
//  Created by Maha Ali on 10/7/24.
//


import SwiftUI

struct Screen2: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .center){
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 400, height: 100)
                        .opacity(0.50)
                        .border(.white)
                        
                    HStack {
                        Text("Progression")
                        //Text("\(model.ballCount)")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                    }
                }
                .font(.system(size: 40))
                
                //Teams
                ScrollView(.vertical){
                    Team(name: "Minnesota Timerbwolves", cost: 2940000000, logo: "team2")
                    Team(name: "Detroit Pistons", cost: 3100000000, logo: "team1")
                    Team(name:"Milwakee Bucks", cost: 3200000000, logo: "team6")
                    Team(name: "Philidaelphia 76ers", cost: 4130000000, logo: "team3")
                    Team(name:"Miami Heat", cost: 4170000000, logo: "team5")
                    Team(name: "Golden State Warriors", cost: 8280000000, logo: "team4")
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct Team: View {
    let name: String
    let cost: Double
    let logo: String
    @State private var showAlert = false
    @State private var bought = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                //Team Logo & Amount
                VStack{
                    ZStack(alignment: .bottom){
                        ZStack{
                            Image(logo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                        }}}
                
                ZStack {
                    Button(action: {
                        showAlert = true
                    }) {
                        VStack {
                            Text(name)
                                .font(.title2)
                                .fontWeight(.bold)
                            let formattedCost = String(format: "%.2f", cost / 1000000000)
                            Text("Cost: \(formattedCost) Billion")
                        }
                        .disabled(cost > model.ballCount)
                        .frame(maxWidth: 300, maxHeight: 90)
                        .foregroundStyle(.white)
                        .background(bought ? Color.upgradeBuy.opacity(0.5): (cost > model.ballCount ? Color.gray : Color.upgradeBuy))
                        .cornerRadius(15)
                    }
                    .alert("Confirmation", isPresented: $showAlert) {
                        Button("OK", role: .cancel){
                            bought = true
                            model.ballCount -= cost
                            model.generation += 5000000
                        }
                        Button("Cancel", role:.destructive){}
                    }
                    
                    message:{
                        Text("You selected \(name) for \(cost). Do you want to proceed?")
                    }}
                .disabled(cost > model.ballCount)
                .disabled(bought)
            }
            .padding()
        }
    }}

#Preview {
    let model = Model()
    
    Screen2()
        .environmentObject(model)
}
