//
//  LoginView.swift
//  RecipesApp
//
//  Created by Consultant on 8/11/23.
//

import SwiftUI
//Google Login
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct LoginScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator

    @AppStorage("myArrayKey") private var arrayRawValue = "[]"
    @StateObject var loginViewModel:LoginViewModel = .init()
    
    var body: some View {
//        let otpButtonText = loginViewModel.showOTPField ? "Verify Code" : "Get Code"
//        let textFieldOpacity = loginViewModel.showOTPField ? 1 : 0.4

        ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 8) {
                    Image("app-logo")
                        .resizable()
                        .frame(width: 48, height: 48, alignment: .center)
                    (
                        Text("Wellcome to")
                        +
                        Text("\nFlavor Fusion")
                            .foregroundColor (Color("primaryColor"))
                    )
                    .fontWeight (.bold)
                    .font (.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    Text("Where Every Recipe is a\n Clulinary Delight")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                        .fontWeight(.semibold)
                        .opacity(0.4)
                        .padding(.bottom, 8)
                    Image("fruits-center-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: 320, maxHeight: 320, alignment: .center)

                    if let clientID = FirebaseApp.app()?.options.clientID {
                        CustomButton(
                            text: "Continue with Google",
                            color: .white,
                            textColor: .gray) {}
                        .overlay {
                            GoogleSignInButton {
                                GIDSignIn.sharedInstance.signIn(with: .init(clientID: clientID), presenting: UIApplication.shared.rootController()) {user, error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                    if let user = user {
                                        loginViewModel.logGoogleUser(user: user)
                                    }
                                }
                            }
                            .blendMode(.destinationOver)
                        }
                        .clipped()
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black.opacity(0.05), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 45)
                        .frame(alignment: .center)
                        .padding(.horizontal, 20)
                    }
                    
                    CustomButton(
                        text: "Log in",
                        color: UIColor(named: "primaryColor")!,
                        cornerRadius: 60,
                        textColor: .white) {
                            coordinator.goToEmailLogin()
//                            coordinator.getPage(.emailLogin)
//                                .navigationDestination(for: MainPath.self) { page in
//                                    coordinator.getPage(page)
//                                }
                        }
                        .padding(.horizontal, 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(MainCoordinator())
    }
}