//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 10
        messageBubble.layer.borderWidth = 1
        messageBubble.layer.borderColor = RColors.bubbleBorderColor?.cgColor
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
    }
    
    // MARK: - Public
    public func setCellData(message: MessageData) {
        
        header.text = message.username
        body.text = message.message
        
        ChatClient.shared.downloadImage(from: message.avatarUrl) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let image):
                    self.avatarImageView.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
