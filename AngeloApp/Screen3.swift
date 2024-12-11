//
//  ContentView.swift
//  Test NBPlay
//
//  Created by Cynthia Shelby on 10/8/24.
//

import SwiftUI

struct Screen3: View {
    @State var textFieldText: String = ""
    @EnvironmentObject var model: Model

    var body: some View {
        ZStack {
            Image("Background")
            VStack {
                Text("Completed Tasks")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
                    .padding()
                Text("Every 1 task = 1% gain for generation")
                    .foregroundStyle(.white)
                Text("(15 tasks max)")
                    .foregroundStyle(.white)
                    .fontWeight(.light)
                    .padding()
                
                TextField("Enter task amount", text: $textFieldText)
                    .padding()
                    .background(Color.white.opacity(10).cornerRadius(10))
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 5))
                    .foregroundColor(.black)
                    .frame(maxWidth: 300)
                    .padding()
                
                Button(action: {
                    if(Double(textFieldText) ?? 0 >= 0.0 && Double(textFieldText) ?? 0 < 16.0){
                        model.generation *= (1 + ((Double(textFieldText) ?? 0) / 100))
                    }
                    textFieldText = ""
                }, label: {
                    Text("Submit".uppercased())
                        .padding()
                        .frame(maxWidth: 190)
                        .background(Color.upgradeBuy.cornerRadius(10))
                        .foregroundColor(.white)
                        .font(.headline)
                })
            }
        }
    }
}
        
#Preview {
    let model = Model()
    
    Screen3()
        .environmentObject(model)
}
