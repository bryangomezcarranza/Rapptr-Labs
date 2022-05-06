//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    @IBOutlet weak var rapptrImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureButton()
        configureImageLogo()
    }
    
    private func configureViewController() {
        rapptrImageView.alpha = 0.0
        
        title = NavigationTitles.animation
        view.backgroundColor = RColors.viewBackgroundCOlor
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
    }
//MARK: - UI
    private func configureButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            actionButton.heightAnchor.constraint(equalToConstant: 55),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureImageLogo() {
        rapptrImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rapptrImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            rapptrImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            rapptrImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            rapptrImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Actions
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard let gestureView = sender.view else { return }
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        
        sender.setTranslation(.zero, in: view)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if self.rapptrImageView.alpha == 0.0 {
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseIn) {
                self.rapptrImageView.alpha = 1.0
                self.actionButton.setTitle("FADE OUT", for: .normal)
            }
        } else if self.rapptrImageView.alpha == 1.0 {
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut) {
                self.rapptrImageView.alpha = 0.0
                self.actionButton.setTitle("FADE IN", for: .normal)
            }
        }
    }
}
