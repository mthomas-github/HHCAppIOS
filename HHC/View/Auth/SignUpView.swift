//
//  SignUpView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var fullname = ""
    @State var email = ""
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
            TextField("Name", text: $fullname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
                .autocapitalization(.none)
            Button("Create Account", action: {
                sessionManager.signUp(
                    username: email,
                    email: email,
                    name: fullname,
                    password: password)
            })
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
            Spacer()
            Button("Already have an account? Log in.", action: sessionManager.showLogin)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
