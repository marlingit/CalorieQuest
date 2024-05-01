//
//  CreateAccount.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Binding var authenticationComplete: Bool
    
    @State var pagenumber: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            if pagenumber == 1 {
                OnboardingOne(pagenumber: $pagenumber)
            } else if pagenumber == 2 {
                OnboardingTwo(pagenumber: $pagenumber)
            } else {
                OnboardingThree(pagenumber: $pagenumber, authenticationComplete: $authenticationComplete)
            }
            
            Spacer()
            
            Text("\(pagenumber)/3")
                .font(.custom("Urbanist", size: 18))
                .fontWeight(.heavy)
                .padding()
                .background(Color.black.opacity(0.25), in: RoundedRectangle(cornerRadius: 25))
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    /*
    private func makeAttributedString() -> AttributedString {
            var text = AttributedString("By creating an account, you agree to our\nPrivacy Policy and Terms of Service.")
            
            if let privacyRange = text.range(of: "Privacy Policy") {
                text[privacyRange].foregroundColor = .blue
                text[privacyRange].link = URL(string: "https://www.quickparksolutions.com")
            }
            
            if let termsRange = text.range(of: "Terms of Service") {
                text[termsRange].foregroundColor = .blue
                text[termsRange].link = URL(string: "https://www.quickparksolutions.com")
            }
            
            return text
        }
    
    private func makeAttributedString2() -> AttributedString {
            var text = AttributedString("Already have an Account?\nLogin Instead")
            
            if let privacyRange = text.range(of: "Login Instead") {
                text[privacyRange].foregroundColor = .blue
            }
            
            return text
        }
     */
}

struct OnboardingOne: View {
    
    @Binding var pagenumber: Int
    
    @State private var firstname: String = ""
    @State private var firstnameTextFieldEditingActive = false
    
    @State private var lastname: String = ""
    @State private var lastnameTextFieldEditingActive = false
    
    @State private var missingFieldAlertVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("Welcome,")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 42)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("What's your name?")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    TextField("First Name", text: $firstname, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                firstnameTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                firstnameTextFieldEditingActive = false
                                missingFieldAlertVisible = false
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
                        .opacity(firstnameTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Last Name", text: $lastname, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                lastnameTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                lastnameTextFieldEditingActive = false
                                missingFieldAlertVisible = false
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
                        .opacity(lastnameTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 28)
                
                HStack(spacing: 0) {
                    
                    Button {
                        missingFieldAlertVisible = false
                        
                        if firstname.isEmpty || lastname.isEmpty {
                            missingFieldAlertVisible = true
                        } else {
                            
                            UserDefaults.standard.set(firstname, forKey: "firstname")
                            UserDefaults.standard.set(lastname, forKey: "lastname")
                            
                            withAnimation() {
                               // authenticationComplete = true
                                pagenumber = 2
                            }
                        }
                    } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(firstname.isEmpty || lastname.isEmpty ? Color.black.opacity(0.5) : Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                      //  .disabled(firstname.isEmpty || lastname.isEmpty ? true : false)
                    
                    Spacer()
                }
                
                if missingFieldAlertVisible {
                    Text("First Name & Last Name text fields required.")
                        .foregroundStyle(.red)
                        .font(.custom("Urbanist", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 12)
                }
                
                /*
                HStack(spacing: 0) {
                    Text(makeAttributedString())
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .lineSpacing(4)
                    
                    Spacer()
                }
                .padding(.top, 18)
                */
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
            /*
            Text(makeAttributedString2())
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .lineSpacing(4)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
            */
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingTwo: View {
    
    @Binding var pagenumber: Int
    
    @AppStorage("firstname") var firstName: String = ""
    
    @State private var height: String = ""
    @State private var heightTextFieldEditingActive = false
    
    @State private var weight: String = ""
    @State private var weightTextFieldEditingActive = false
    
    @State private var missingFieldAlertVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation() {
                    pagenumber = 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 12)
                    .frame(width: 50, height: 50)
            }
            
            Group {
                Text("Hello \(firstName),")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Let's tailor your experience.")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Height", text: $height, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                heightTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                heightTextFieldEditingActive = false
                                missingFieldAlertVisible = false
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
                        .opacity(heightTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Weight", text: $weight, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                weightTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                weightTextFieldEditingActive = false
                                missingFieldAlertVisible = false
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
                        .opacity(weightTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 28)
                
                HStack(spacing: 0) {
                    
                    Button {
                        missingFieldAlertVisible = false
                        
                        if height.isEmpty || weight.isEmpty {
                            missingFieldAlertVisible = true
                        } else {
                            
                            UserDefaults.standard.set(height, forKey: "height")
                            UserDefaults.standard.set(weight, forKey: "weight")
                            
                            withAnimation() {
                               // authenticationComplete = true
                                pagenumber = 3
                            }
                        }
                    } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(height.isEmpty || weight.isEmpty ? Color.black.opacity(0.5) : Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                      //  .disabled(firstname.isEmpty || lastname.isEmpty ? true : false)
                    
                    Spacer()
                }
                
                if missingFieldAlertVisible {
                    Text("Height and Weight text fields required.")
                        .foregroundStyle(.red)
                        .font(.custom("Urbanist", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 12)
                }
                
                /*
                HStack(spacing: 0) {
                    Text(makeAttributedString())
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .lineSpacing(4)
                    
                    Spacer()
                }
                .padding(.top, 18)
                */
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
            /*
            Text(makeAttributedString2())
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .lineSpacing(4)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
            */
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingThree: View {
    
    @Binding var pagenumber: Int
    
    @Binding var authenticationComplete: Bool
    
    @AppStorage("firstname") var firstName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation() {
                    pagenumber = 2
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 12)
                    .frame(width: 50, height: 50)
            }
            
            Group {
                Text("You're Ready to Go!")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Here's what to do.")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    
                    Button {
                        withAnimation() {
                            authenticationComplete = true
                        }
                    } label: {
                        Text("Let's Go!")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                //  .disabled(firstname.isEmpty || lastname.isEmpty ? true : false)
                
                Spacer()
                }
                
                /*
                HStack(spacing: 0) {
                    Text(makeAttributedString())
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .lineSpacing(4)
                    
                    Spacer()
                }
                .padding(.top, 18)
                */
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
            /*
            Text(makeAttributedString2())
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .lineSpacing(4)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
            */
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
