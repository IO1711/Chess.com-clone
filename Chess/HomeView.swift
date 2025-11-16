//
//  HomeView.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI

/*struct HomeView: View {
    
    var body: some View {

            NavigationStack {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                    VStack(spacing: 24) {
                        HStack{
                            Image("noimage")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Image("blue_league")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Spacer()
                            
                            Image("icon")
                                .resizable()
                                .frame(width: 130, height: 40)
                            
                            Spacer()
                            
                            Image(systemName: "person.2")
                                .symbolRenderingMode(.multicolor)
                                .foregroundStyle(.white, .cyan)
                                .font(.system(size: 30))
                        }
                        .padding(.horizontal)
                        
                        /*Text("Chess")
                            .font(.largeTitle.bold())
                        
                        Text("Play online, practice vs bot, or analyze games.")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        // This is your "Play" button → opens board screen
                        NavigationLink {
                            ChessBoardScreen()
                        } label: {
                            Text("Play")
                                .font(.headline)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }*/
                        
                        List {
                            HStack(alignment: .top){
                                Image("recommended")
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .border(Color(red: 67/255, green: 69/255, blue: 74/255), width: 4)
                                
                                VStack(alignment: .leading){
                                    Text("Recommended Match")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .font(.title)
                                    Text("Similar skill")
                                        .foregroundStyle(.gray)
                                    HStack{
                                        Text("Opponent")
                                            .foregroundStyle(.white)
                                        Text("(2833)")
                                            .foregroundStyle(.gray)
                                    }
                                    
                                }
                            }
                            .listRowBackground(Color(red: 38/255, green: 39/255, blue: 41/255))
                            .listRowInsets(EdgeInsets())
                            
                            
                            HStack(alignment: .top){
                                Image("puzzle_page")
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .border(Color(red: 67/255, green: 69/255, blue: 74/255), width: 4)
                                
                                VStack(alignment: .leading){
                                    Text("Solve puzzles")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    Text("Continue your journey!")
                                        .foregroundStyle(.gray)
                                    
                                }
                            }
                            .listRowBackground(Color(red: 38/255, green: 39/255, blue: 41/255))
                            .listRowInsets(EdgeInsets())
                            
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color(red: 38/255, green: 39/255, blue: 41/255))
                        .padding(1)
                        
                        
                        Spacer()
                        
                        
                        NavigationLink {
                            ChessBoardScreen()
                                .ignoresSafeArea()
                        } label: {
                            /*Button(action: {
                                
                            }) {
                                Text("Play")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        Color(red: 141/255, green: 199/255, blue: 62/255)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 14,
                                                                style: .continuous))
                                    .shadow(color: .black.opacity(0.5), radius: 10, y: 4)
                            }
                            .padding(.horizontal, 5)
                            //.padding(.vertical, 8)
                            .transition(.opacity)*/
                            Text("Play")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    Color(red: 141/255, green: 199/255, blue: 62/255)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 14,
                                                            style: .continuous))
                                .shadow(color: .black.opacity(0.5), radius: 10, y: 4)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 8)
                                .transition(.opacity)
                        }
                        
                    }
                    //.padding(.horizontal)
                    
                    
                }
            }
            
    }
}


#Preview {
    HomeView()
}*/

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                HStack{
                    Image("noimage")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Image("blue_league")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Spacer()
                    
                    Image("icon")
                        .resizable()
                        .frame(width: 130, height: 40)
                    
                    Spacer()
                    
                    Image(systemName: "person.2")
                        .symbolRenderingMode(.multicolor)
                        .foregroundStyle(.white, .cyan)
                        .font(.system(size: 30))
                }
                .padding(.horizontal)

                List {
                    HStack(alignment: .top){
                        Image("recommended")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .border(Color(red: 67/255, green: 69/255, blue: 74/255), width: 4)
                        
                        VStack(alignment: .leading){
                            Text("Recommended Match")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .font(.title)
                            Text("Similar skill")
                                .foregroundStyle(.gray)
                            HStack{
                                Text("Opponent")
                                    .foregroundStyle(.white)
                                Text("(2833)")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .listRowBackground(Color(red: 38/255, green: 39/255, blue: 41/255))
                    .listRowInsets(EdgeInsets())
                    
                    HStack(alignment: .top){
                        Image("puzzle_page")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .border(Color(red: 67/255, green: 69/255, blue: 74/255), width: 4)
                        
                        VStack(alignment: .leading){
                            Text("Solve puzzles")
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text("Continue your journey!")
                                .foregroundStyle(.gray)
                        }
                    }
                    .listRowBackground(Color(red: 38/255, green: 39/255, blue: 41/255))
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
                .background(Color.black) // important so List doesn't leak system gray
                .padding(1)
                
                Spacer()
                
                NavigationLink {
                    ChessBoardScreen()
                        .navigationBarBackButtonHidden(false) // if you want no bar on board
                } label: {
                    Text("Play")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Color(red: 141/255, green: 199/255, blue: 62/255)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14,
                                                    style: .continuous))
                        .shadow(color: .black.opacity(0.5), radius: 10, y: 4)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 8)
                        .transition(.opacity)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

