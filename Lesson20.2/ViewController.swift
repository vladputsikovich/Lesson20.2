//
//  ViewController.swift
//  Lesson20.2
//
//  Created by Владислав Пуцыкович on 2.01.22.
//

import UIKit

fileprivate struct Constants {
    static let identificator = "MyCell"
    static let rowHeight: CGFloat = 50
    static let addButtonHeight: CGFloat = 30
    static let addButtonText = "Добавить"
}

class ViewController: UIViewController {
    
    var teams: [Team] = []
    var championsLeague: [ChampionsLeague] = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        championsLeague = ChampionsLeague.createTeams()
    }
    
    func createTable() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.identificator)
        
        self.view.addSubview(tableView)
    }
}

// MARK: UITableViewDragDelegate
extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = championsLeague[indexPath.section].teams[indexPath.row]
        return [dragItem]
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: Constants.identificator)
        cell.textLabel?.text = "\(championsLeague[indexPath.section].teams[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(championsLeague[indexPath.section].teams[indexPath.row].country)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsLeague[section].teams.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return championsLeague[section].group
    }
    
    func addRow(_ sender: Int) {
        championsLeague[sender].teams.append(Team("Ливерпуль", "Англия"))
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return championsLeague.count
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = championsLeague[sourceIndexPath.section].teams.remove(at: sourceIndexPath.row)
        championsLeague[destinationIndexPath.section].teams.insert(mover, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            championsLeague[indexPath.section].teams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let button = UIButton()
        button.frame = CGRect(
            x: .zero,
            y: .zero,
            width: self.view.bounds.width,
            height: Constants.addButtonHeight
        )
        button.setTitle(Constants.addButtonText, for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .green
        button.addAction(UIAction(handler: {_ in self.addRow(section)}), for: .touchUpInside)
        footerView.addSubview(button)
        return footerView
    }
}

