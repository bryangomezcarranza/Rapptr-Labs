//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var messages: [MessageData] = []
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable(tableView: chatTable)
        configureViewController()
        getChatMessages()
     
    }
    
    // MARK: - Private
    
    private func getChatMessages() {
        ChatClient.shared.fetchChatData { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let message):
                guard let message = message else { return }
                self.messages = message
                self.updateUI()
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.chatTable.reloadData()
        }
    }
    
    private func configureViewController() {
        title = NavigationTitles.chat
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = RColors.viewBackgroundCOlor
        tableView.register(UINib(nibName: RCells.chatCell, bundle: nil), forCellReuseIdentifier: RCells.chatCell)
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

//MARK: - UITableViewDelegate & DataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RCells.chatCell, for: indexPath) as! ChatTableViewCell
        let message = messages[indexPath.row]
        cell.setCellData(message: message)
        return cell
    }
    
}
