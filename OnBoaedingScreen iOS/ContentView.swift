//
//  ContentView.swift
//  OnBoaedingScreen iOS
//
//  Created by Junaed Muhammad Chowdhury on 29/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("SIGNED_IN") var currentUserSignedIn : Bool = false
    
    var body: some View {
        ZStack {
            //Background
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height
            ).ignoresSafeArea()
            
            if currentUserSignedIn{
                ProfileView().transition(.asymmetric(insertion: .move(edge: .bottom), removal:  .move(edge: .top)))
            }else{
                OnBoardingView().transition(.asymmetric(insertion: .move(edge: .top), removal:  .move(edge: .bottom)))
            }
        }
        //.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
