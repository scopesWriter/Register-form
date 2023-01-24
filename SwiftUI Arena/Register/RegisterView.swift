//
//  RegisterView.swift
//  SwiftUI Arena
//
//  Created by Bishoy Badea [Pharma] on 15/01/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel: RegisterViewModel
    @FocusState var isInputActive: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Register")
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            TextField("enter your name", text: $viewModel.fullname)
                .foregroundColor(.gray)
                .autocapitalization(.words)
                .keyboardType(.namePhonePad)
                .padding()
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
            TextField("enter your email", text: $viewModel.email)
                .foregroundColor(.gray)
                .padding()
                .focused($isInputActive)
                .keyboardType(.emailAddress)
            TextField("enter your mobile number", text: $viewModel.mobileNumber)
                .foregroundColor(.gray)
                .focused($isInputActive)
                .keyboardType(.numberPad)
                .padding()
            Button("Sign up") {
                viewModel.didTapOnSignUpButton.send()
            }
            .foregroundColor(.red)
            .opacity(viewModel.isSignUpEnabled ? 1 : 0)
            Spacer()
            if !viewModel.isValidMobileNumber {
                Spacer().frame(height: 1)
                Text("invalid mobile number")
                    .foregroundColor(.red)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 30)
            }
            
            if !viewModel.isValidEmail {
                Spacer().frame(height: 1)
                Text("invalid email address")
                    .foregroundColor(.red)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 30)
            }
            
            if !viewModel.isValidFullName {
                Spacer().frame(height: 1)
                Text("invalid full name")
                    .foregroundColor(.red)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 30)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init())
    }
}
