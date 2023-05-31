//
//  OnBoardingView.swift
//  OnBoaedingScreen iOS
//
//  Created by Junaed Muhammad Chowdhury on 29/5/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    //    OnBoardingState:
    //     0 - Welcome Screen
    //     1 - Add Name
    //     2 - Add Age
    //     3 - Add Gender
    
    @State private var onBoardingState = 0
    
    // ONBOARDING INPUTS
    @State private var name = ""
    @State private var age: Double = 30
    @State private var gender: String = ""
    
    // FOR TRANSECTION ANIMATUIN
    let transition : AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading)
    )
    
    // FOR ALERT
    @State private var alertTitle = ""
    @State private var showAlert = false
    
    // APP STORAGES
    @AppStorage("NAME") var currentUserName: String?
    @AppStorage("AGE") var currentUserAge: Int?
    @AppStorage("GENDER") var currentUserGender: String?
    @AppStorage("SIGNED_IN") var currentUserSignedIn : Bool = false
    
    var body: some View {
        ZStack {
            
            ZStack {
                switch onBoardingState{
                case 0:
                    welcomeScrtion.transition(transition)
                case 1:
                    addNameSection.transition(transition)
                case 2:
                    addAgeSection.transition(transition)
                case 3:
                    addGenderSection.transition(transition)
                    
                    
                default:
                    Text("")
                }
            }
            
            
            VStack {
                Spacer()
                bottomButton
            }.padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle))
        }
    }
    
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView().background(Color.purple)
    }
}

//MARK: - COMPONENTS
extension OnBoardingView {
    @ViewBuilder
    private var bottomButton: some View{
        Text(
            onBoardingState == 0 ? "SIGN UP" :
                onBoardingState == 3 ? "FINISH" :
                "Next"
        )
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .animation(nil, value: onBoardingState) /**Remove the animation fron this part**/
        .onTapGesture {
            handleNextButtonPressed()
        }
    }
    
    @ViewBuilder
    private var welcomeScrtion: some View{
        VStack(spacing: 40) {
            Spacer()
            
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Find your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
                .overlay(alignment: .bottom) {
                    Capsule()
                        .frame(height: 3)
                }
            
            Text("This is the #1 app for finding your match online! In this project we are practicing on Boarding screen in swiftui.")
                .fontWeight(.medium)
            
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var addNameSection: some View{
        VStack(spacing: 20) {
            Spacer()
            
            
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
    
            
            TextField("", text: $name,
                      prompt: Text("Your name here...").foregroundColor(.gray))
            .font(.headline)
            .frame(height: 55)
            .foregroundColor(.black)
            .accentColor(.gray)
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(10)
            
            
            Spacer()
            Spacer()
        }
        .padding(30)
        
    }
    
    
    @ViewBuilder
    private var addAgeSection: some View{
        VStack(spacing: 20) {
            Spacer()
            
            
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("\(String(format: "%.0f",age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            Slider(value: $age, in: 18...100, step: 1)
                .tint(.white)
            
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    @ViewBuilder
    private var addGenderSection: some View{
        VStack(spacing: 20) {
            Spacer()
            
            
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            Menu {
                Picker(selection: $gender, label: EmptyView()) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Non-Binary").tag("Non-Binary")
                }
                .labelsHidden()
                .pickerStyle(InlinePickerStyle())
            } label: {
                Text( gender.isEmpty ? "Select a gender" : gender)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.purple)
                    .background(.white)
                    .cornerRadius(10)
            }
            
            
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
}


//MARK: - FUNCTIONS
extension OnBoardingView{
    
    func handleNextButtonPressed(){
        //Check Inputs
        switch onBoardingState{
        case 1:
            guard !name.isEmpty else{
                showAlert(title: "Your name must be at least 3 characters long! 😑")
                return
            }
         case 3:
            guard !gender.isEmpty else{
                showAlert(title: "Please select a gender before moving forward! 😒")
                return
            }
            
            
        default:
            break
        }
        
        
        //Go To Next Section
        if onBoardingState == 3{
            //Sign In
            signIn()
        }else{
            withAnimation(.spring()) {
                onBoardingState += 1
            }
        }
    }
    
    
    func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
    
    func signIn(){
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    
}


