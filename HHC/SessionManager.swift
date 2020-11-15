//
//  SessionManager.swift
//  HHC
//
//  Created by Michael Thomas on 11/13/20.
//

import Amplify
import SwiftUI

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

final class SessionManager: ObservableObject {
    
    @Published var authState: AuthState = .login
    @Environment(\.presentationMode) var presentationMode
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            print("Found User....")
            authState = .session(user: user)
        } else {
            print("Cannot Find User")
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signUp
    }
    
    func showLogin() {
        authState = .login
    }
    
    func signUp(username: String, email: String, name: String, password: String) {
        let attributes = [AuthUserAttribute(.email, value: email),
                          AuthUserAttribute(.name, value: name)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        _ = Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { [weak self] result in
            switch result {
            
            case .success(let signUpResult):
                print("Sign up result", signUpResult)
                
                switch signUpResult.nextStep {
                
                case .done:
                    print("Finished sign up")
                    
                case .confirmUser(let details, _):
                    print(details ?? "no details")
                    
                    DispatchQueue.main.async {
                        self?.authState = .confirmCode(username: username)
                    }
                }
            case .failure(let error):
                print("Sign up error", error)
            }
        }
    }
    
    func  confirm(username: String, code: String) {
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { [weak self] result in
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                }
            case .failure(let error):
                print("failed to confirm code:", error)
            }
        }
    }
    
    func login(username: String, password: String) {
        _ = Amplify.Auth.signIn(
            username: username,
            password: password
        ) { [ weak self ] result in
            switch result {
            case .success(let signInResult):
                print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                }
                
            case .failure(let error):
                print("Login error:", error)
            }
        }
    }
    
    func signOut() {
        _ = Amplify.Auth.signOut { result in
            switch result {
            case .success:
                print("Sign in")
            case .failure(let error):
                print("Sign out error:", error)
            }
            
        }
    }
    
    func observeAuthEvents() {
        _ = Amplify.Hub.listen(to: .auth) { [weak self ] result in
            switch result.eventName {
            case HubPayload.EventName.Auth.signedIn,
                 HubPayload.EventName.Auth.signedOut,
                 HubPayload.EventName.Auth.sessionExpired:
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
            default:
                break
            }
        }
    }
}

