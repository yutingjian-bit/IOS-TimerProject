//
//  SignUpView.swift
//  TimerApp
//
//  Created by Mary Berridge on 3/5/2026.
//

import SwiftUI

struct SignUpView: View{
    @State private var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            //Spacer()
            Text("PomEggDoro")
                .font(.largeTitle)
                .bold()
                .padding(20)
            
            Text("Hatch your productivity companion")
            
            //image/logo can be placed here
            
            
            Spacer(minLength: 200)
            
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
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 300)
                    .frame(height:50)
                    .font(.title2)
                    .background(Color.blue)
                    .clipShape(Capsule())
            })
            
            .padding(10)
            
            //note: content view is the login view
            NavigationLink(destination: ContentView(), label: {
                Text("Already have an account? \nLogin instead")
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

#Preview {
    SignUpView()
}
