//
//  ConfirmationView.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var confirmationCode = ""
    
    let username: String
    
    var body: some View {
        VStack {
            Image("HHC_4inBug")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(75)
                .padding()
            Text("UserName: \(username)")
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
            TextField("Confirmation Code", text: $confirmationCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all, 20)
                .autocapitalization(.none)
            Button("Confirm", action: {
                sessionManager.confirm(
                    username: username,
                    code: confirmationCode)
            })
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "dummy")
    }
}
