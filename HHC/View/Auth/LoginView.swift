//
//  LoginView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager: SessionManager
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {

            Image("HHC_4inBug")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(75)
                .padding()
            TextField("Email", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
                .autocapitalization(.none)
            Button("Login", action: {
                sessionManager.login(
                    username: username,
                    password: password)
            })
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            Spacer()
            Button("Don't have an account? Sign up.", action: sessionManager.showSignUp)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
