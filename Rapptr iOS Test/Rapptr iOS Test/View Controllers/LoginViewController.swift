//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    let usernameTextField = RTextField(placeHolder: "Email", isSecureText: false)
    let passwordTextField = RTextField(placeHolder: "Password", isSecureText: true)
    let loginButton = RLoginButton(title: "LOGIN")
    let backgroundImage = UIImageView()
    
    var timeItTook: Double = 0.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureBackgroundImage()
        
        configureUsernameTextField()
        configurePasswordTextField()
        configureLoginButton()
        
        createDismissKeyboardTapGesture()
        
    }
    
    func configureViewController() {
        title = NavigationTitles.login
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    //MARK: - Helper Methods
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func alertForSuccesCase(with apiTime: Double) {
        DispatchQueue.main.async {
            let alertMessage = UIAlertController(title: "Success", message: "You have succesfully logged in! Your API Call time was: \(apiTime) milliseconds", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default) { _  in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertMessage.addAction(okButton)
            self.present(alertMessage, animated: true)
        }
    }
    
    func alertForFailureCase(error: RError) {
        DispatchQueue.main.async {
            let alertMessage = UIAlertController(title: "Error", message: "Ther was en error login in. Error Message: \(error.rawValue)", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default) { _  in
                self.dismiss(animated: true)
            }
            alertMessage.addAction(okButton)
            self.present(alertMessage, animated: true)
        }
    }
    
    //MARK: - Programatic UI
    func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = RImages.login
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.tag = 0
        usernameTextField.delegate = self
        
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.tag = 1
        passwordTextField.delegate = self
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 24),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Button Action
    @objc func loginButtonTapped() {
        
        let start = DispatchTime.now()
        
        guard  let email = usernameTextField.text, let password = passwordTextField.text else { return }
        
        LoginClient.shared.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.alertForSuccesCase(with: self.timeItTook)
            case .failure(let error):
                self.alertForFailureCase(error: error)
            }
        }
        
        let end = DispatchTime.now()
        let diff = end.uptimeNanoseconds - start.uptimeNanoseconds
        let time = Double(diff) / 1000000
        self.timeItTook = time
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//MARK: - Textfield Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
