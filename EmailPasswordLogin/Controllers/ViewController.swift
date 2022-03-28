//
//  ViewController.swift
//  EmailPasswordLogin
//
//  Created by Никита Коголенок on 28.03.22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // MARK: - GUI Variable
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let emailTF = UITextField()
        emailTF.placeholder = "Enter email"
        emailTF.layer.borderWidth = 1
        emailTF.autocapitalizationType = .none
        emailTF.layer.borderColor = UIColor.black.cgColor
        emailTF.backgroundColor = .white
        emailTF.leftViewMode = .always
        emailTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailTF
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.placeholder = "Enter password"
        passwordTF.layer.borderWidth = 1
        passwordTF.isSecureTextEntry = true
        passwordTF.layer.borderColor = UIColor.black.cgColor
        passwordTF.backgroundColor = .white
        passwordTF.leftViewMode = .always
        passwordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passwordTF
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviewsandAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createUIFrame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Methods
    func addSubviewsandAction() {
        view.addSubview(label)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
        view.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            label.isHidden = true
            button.isHidden = true
            emailTextField.isHidden = true
            passwordTextField.isHidden = true
            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20,
                                         y: 150,
                                         width: view.frame.size.width-40,
                                         height: 50)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
    }
    
    func createUIFrame() {
        label.frame = CGRect(x: 0,
                             y: 100,
                             width: view.frame.size.width,
                             height: 80)
        
        emailTextField.frame = CGRect(x: 20,
                                      y: label.frame.origin.y+label.frame.size.height+10,
                                      width: view.frame.size.width-40,
                                      height: 50)
        
        passwordTextField.frame = CGRect(x: 20,
                                         y: emailTextField.frame.origin.y+emailTextField.frame.size.height+10,
                                         width: view.frame.size.width-40,
                                         height: 50)
        
        button.frame = CGRect(x: 20,
                              y: passwordTextField.frame.origin.y+passwordTextField.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 50)
    }
    
    // MARK: - Action
    @objc private func didTapButton() {
        print("Continue")
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { print("Missing field data"); return }
        
        // Get auth instance
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else { self.showCreateAccount(email: email, password: password); return }
            print("You have signed in")
            self.label.isHighlighted = true
            self.emailTextField.isHighlighted = true
            self.passwordTextField.isHighlighted = true
            self.button.isHighlighted = true
            
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        })
    }
    
    func showCreateAccount(email: String, password: String) {
        let alertController = UIAlertController(title: "Create Account",
                                                message: "Would you like to create an account",
                                                preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let self = self,
                      error == nil
                else { print("Account creation error"); return }
                print("You have signed in")
                self.label.isHighlighted = true
                self.emailTextField.isHighlighted = true
                self.passwordTextField.isHighlighted = true
                self.button.isHighlighted = true
                
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
            })
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        })
        
        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            label.isHidden = false
            button.isHidden = false
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            
            signOutButton.removeFromSuperview()
        }
        catch {
            print("An error occurred")
        }
    }
}
