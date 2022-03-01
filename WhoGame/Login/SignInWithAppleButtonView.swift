//
//  SignInWithAppleButtonView.swift
//  VitaMi
//
//  Created by Иван Маришин on 16.10.2021.
//

import AuthenticationServices
import SwiftUI

struct SignInWithAppleButtonView: View {
    
    @State private var currentNonce: String?
    
    var body: some View {
        SignInWithAppleButton(.continue,
                              onRequest: { request in
            let nonce = FBAuth.randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.fullName, .email]
            request.nonce = FBAuth.sha256(nonce)
        }, onCompletion: { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let authResult):
                switch authResult.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        print("Unable to fetch identity token")
                        return
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    
                    FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { (result) in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case.success(let authDataResult):
                            let signInWithAppleResult = (authDataResult, appleIDCredential)
                            FBAuth.handle(signInWithAppleResult) { (result) in
                                switch result {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .success( _):
                                    print("Successful login")
                                }
                            }
                        }
                    }
                default :
                    break
                }
            }
        })
            .frame(width: 200, height: 44)
            .signInWithAppleButtonStyle(.white)
            .blendMode(.overlay)
        
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButtonView()
    }
}
