//
//  ViewController.swift
//  EmailPasswordLogin
//
//  Created by Никита Коголенок on 28.03.22.
//

import UIKit

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
        emailTF.layer.borderColor = UIColor.black.cgColor
        return emailTF
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.placeholder = "Enter password"
        passwordTF.layer.borderWidth = 1
        passwordTF.isSecureTextEntry = true
        return passwordTF
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
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
        
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Methods
    func addSubviewsandAction() {
        view.addSubview(label)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
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
    }
}
