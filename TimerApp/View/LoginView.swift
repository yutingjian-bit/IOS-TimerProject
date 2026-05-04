//
//  LoginView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI
//note: content view is the login view

struct ContentView: View {
    @State private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                //Spacer()
                Text("PomEggDoro")
                    .font(.largeTitle)
                    .bold()
                    .padding(20)
                
                Text("Hatch your productivity companion")
                
        
                //image
                ZStack{
                    Image("Egg1a") //left egg
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 240, alignment: .leading)
                    
                    Image("Egg3a") //left egg
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 240, alignment: .trailing)
                    
                    Image("Egg4a") //middle egg
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                    
                    Image("Egg1b") //cat
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 250)
                }
                
                //Spacer(minLength: 200)
                
                //note: username and password also not set up yet. for now they are text fields
                
                //username text entry
                Text("Username")
                    .frame(maxWidth: 300, alignment: .leading)
                TextField("Enter your username", text: $loginViewModel.userName)
                    .textFieldStyle(.roundedBorder)
                
                //password text entry
                Text("Password")
                    .frame(maxWidth: 300, alignment: .leading)
                SecureField("Enter your password", text: $loginViewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                //note: login and sign in buttons not with functionality yet. they are placeholder buttons that navigates to the home page for now
                
                NavigationLink(destination: HomeScreenView(), label: {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 300)
                        .frame(height:50)
                        .font(.title2)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                .padding(10)
                
                
                NavigationLink(destination: SignUpView(), label: {
                    Text("Don't have an account? \nSign up instead")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: 300)
                    // .frame(height:50)
                        .font(.title2)
                })
                
                Spacer()
                
                
            }
    }
    }
}

#Preview {
    ContentView()
}
