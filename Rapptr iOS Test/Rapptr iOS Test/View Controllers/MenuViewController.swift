//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Initializers
    
    let chatButton = RMenuButton(title: "CHAT", image: "ic_chat")
    let loginButton = RMenuButton(title: "LOGIN", image: "ic_login")
    let animationButton = RMenuButton(title: "ANIMATION", image: "ic_animation")
    
    let image = UIImageView()
    
    // MARK: - Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureImageBackground()
        configureNavBar()
        
        configureChatButton()
        configureLoginButton()
        configureAnimationButon()
    
    }
    //MARK: - UI
    
    func configureNavBar() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.titleTextAttributes = [.foregroundColor: RColors.headerTextColor!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        apperance.backgroundColor = RColors.headerColor
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    }
    
    func configureViewController() {
        title = NavigationTitles.codinTasks
    }
    
    private func configureImageBackground() {
        view.addSubview(image)
        
        image.image = RImages.mainMenu
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    //MARK: - Helper Methods
    
    @objc func pushToChatVC() {
        let chatVC = ChatViewController(nibName: ViewControllers.chatVC, bundle: nil)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @objc func pushToLogiVC() {
        let chatVC = LoginViewController(nibName: ViewControllers.loginVC, bundle: nil)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @objc func pushToAnimatioVC() {
        let chatVC = AnimationViewController(nibName: ViewControllers.animationVC, bundle: nil)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    // MARK: - Action Button
    
     func configureChatButton() {
        view.addSubview(chatButton)
         chatButton.addTarget(self, action: #selector(pushToChatVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            chatButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 227),
            chatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            chatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            chatButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(pushToLogiVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureAnimationButon() {
        view.addSubview(animationButton)
        animationButton.addTarget(self, action: #selector(pushToAnimatioVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            animationButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            animationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            animationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            animationButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
}
    




