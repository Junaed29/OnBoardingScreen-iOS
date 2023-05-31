//
//  ProfileView.swift
//  OnBoaedingScreen iOS
//
//  Created by Junaed Muhammad Chowdhury on 29/5/23.
//

import SwiftUI

struct ProfileView: View {
    // APP STORAGES
    @AppStorage("NAME") var currentUserName: String?
    @AppStorage("AGE") var currentUserAge: Int?
    @AppStorage("GENDER") var currentUserGender: String?
    @AppStorage("SIGNED_IN") var currentUserSignedIn : Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                globalBg
                
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFit()
                    Text(currentUserName ?? "Your Name")
                    Text("The user is \(currentUserAge ?? 0) years old")
                    Text("Their gender is \(currentUserGender ?? "Unknown")")
                    
                    Button("SIGN OUT") {
                        signOut()
                    }
                    .padding(.top)
                    .font(.headline)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                }
                .font(.title)
                .foregroundColor(.purple)
                .padding()
                .padding(.vertical, 40)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                //.toolbar(.hidden, for: .navigationBar)
            }
        }
    }
    
    func signOut(){
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
