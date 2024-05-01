//
//  SignInView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var authenticationComplete: Bool
    
    @State private var email: String = ""
    @State private var emailTextFieldEditingActive = false
    
    @State private var password: String = ""
    @FocusState private var passwordTextFieldEditingActive: Bool
    
    @State private var showSpinner = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("Welcome back,")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 42)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Sign into your Account.")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Email", text: $email, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                emailTextFieldEditingActive = true
                            }
                        } else {
                            withAnimation {
                                emailTextFieldEditingActive = false
                            }
                        }
                    })
                        .foregroundStyle(.black)
                        .tint(.black)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.leading, 2)
                        .padding(.trailing, 12)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(emailTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    SecureField("Password", text: $password)
                        .focused($passwordTextFieldEditingActive)
                        .onChange(of: passwordTextFieldEditingActive) { isFocused in
                            withAnimation {
                                passwordTextFieldEditingActive = isFocused
                            }
                        }
                        .foregroundStyle(.black)
                        .tint(.black)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.leading, 2)
                        .padding(.trailing, 12)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(passwordTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 28)
                
                HStack(spacing: 0) {
                    Button {
                        Task {
                            showSpinner = true
                            do {
                                try await signIn(email: email, password: password)
                            } catch {
                                print("Sign-in failed with error: \(error.localizedDescription)")
                            }
                            showSpinner = false
                        }
                    } label: {
                        if showSpinner {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(height: 55)
                                .padding()
                                .background(Color.black, in: Circle())
                        } else {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 27.5))
                        }
                    }
                    .frame(width: 125)
                    .padding(.top, 50)
                    .disabled(email.isEmpty || password.isEmpty ? true : false)
                    
                    Spacer()
                }
                
                Spacer()
                
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
            
            Text(makeAttributedString2())
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .lineSpacing(4)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func makeAttributedString2() -> AttributedString {
        var text = AttributedString("Don't have an Account?\nSign Up Instead")
        
        if let privacyRange = text.range(of: "Sign Up Instead") {
            text[privacyRange].foregroundColor = .blue
        }
        
        return text
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            withAnimation() {
                authenticationComplete = true
            }
        }
    }
}
