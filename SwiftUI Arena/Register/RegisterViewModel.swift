//
//  RegisterViewModel.swift
//  SwiftUI Arena
//
//  Created by Bishoy Badea [Pharma] on 15/01/2023.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    // MARK: - Inputs
    let didTapOnChangeMobile = PassthroughSubject<Void, Never>()
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var mobileNumber: String = ""
    let didTapOnSignUpButton = PassthroughSubject<Void, Never>()
    let didTapOnLoginButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Outputs
    @Published private(set) var isValidFullName: Bool = false
    @Published private(set) var isValidEmail: Bool = false
    @Published private(set) var isValidMobileNumber: Bool = false
    @Published private(set) var isSignUpEnabled: Bool = false
    @Published private(set) var isSigningUp: Bool = false
    @Published var shouldShowToast: Bool = false
    @Published private(set) var toastMessage: String = ""
    // Cancelables
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setUpBinding()
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    private func setUpBinding() {
        
        $fullname
            .map { $0.isValidName }
            .assign(to: &$isValidFullName)
        
        $email
            .map { $0.isValidEmail }
            .assign(to: &$isValidEmail)
        
        $mobileNumber
            .map { $0.isValidMobileNumber }
            .assign(to: &$isValidMobileNumber)
        
        Publishers
            .CombineLatest3($fullname, $email, $mobileNumber)
            .sink { [weak self] input in
                guard let self = self else { return }
                let (fullname, email, mobileNumber) = input
                let isCommonInputValid = fullname.isValidName && (email.isValidEmail || email.isEmpty) && mobileNumber.isValidMobileNumber
                self.isSignUpEnabled = isCommonInputValid
            }
            .store(in: &subscriptions)
            
        didTapOnSignUpButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isSigningUp = false
                print("sign up action here !")
            }
            .store(in: &subscriptions)
    }
}

