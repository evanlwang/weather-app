//
//  ContentView.swift
//  Weather
//
//  Created by Evan Wang on 5/29/20.
//  Copyright © 2020 Evan Wang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var state = ""
    @State var temperature = 0
    @State var description = "Clear"
    @State var getTemp = false
    @State var city = "Lansing"
    
    var body: some View {
        ZStack {
            bgColors[description]
            VStack (alignment: .center){
                VStack {
                    if getTemp {
                        Text("\(city), \(States[state]!)")
                            .foregroundColor(Color.white)
                            .font(.system(size: 40))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        Text("\(description)")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                            .padding(.bottom, 60)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        Image(systemName: icon[description]!)
                            .foregroundColor(Color.white)
                            .font(.system(size: 120))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .padding(.bottom)
                        HStack (spacing: 5) {
                            Text("\(self.temperature)")
                                .foregroundColor(Color.white)
                                .font(.system(size: 90))
                                .offset(x: 15)
                            HStack (spacing: 4) {
                                Image(systemName: "circle")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 8, weight: .black))
                                Text("C")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, weight: .medium))
                            }
                            .offset(x: 13, y: -22)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        
                    }
                }
                TextField("Enter a city", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 100)
                    .padding(.bottom)

                    
                Button(action: {
                    self.getWeatherData()
                    self.getTemp.toggle()
                }) {
                    Text("Check Weather")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 20, weight: .medium))
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.getWeatherData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getWeatherData() {
    let jsonURLString = "http://api.weatherstack.com/current?access_key=28fbb0f64e525f60eafed869b51e6863&query=\(city)"
    
    guard let url = URL(string: jsonURLString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }
        
        guard let data = data else { return }
        
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data)
            
            self.state  = weather.location?.region ?? ""
            self.temperature  = (weather.current?.temperature) ?? 0
            self.description = weather.current?.weather_descriptions[0] ?? ""
            
            self.getTemp.toggle()
            
        } catch let err {
            print("Json Err", err)
        }
    }.resume()
}
}

