//
//  ViewController.swift
//  Lesson20.2
//
//  Created by Владислав Пуцыкович on 2.01.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    var teams: [Team] = []
    
    var championsLeague: [ChampionsLeague] = []

    var tableView = UITableView()
    
    let identificator = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        createTeams()
    }
    
    func createTable() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identificator)
        
        self.view.addSubview(tableView)
    }
    
    func createTeams() {
        let arsenal = Team("Арсенал", "Англия")
        let city = Team("Манчестер сити", "Англия")
        let united = Team("Манчестер юнайтед", "Англия")
        let chelsea = Team("Челси", "Англия")
        let tot = Team("Тотенхэм", "Англия")
        let bavaria = Team("Бавария", "Германия")
        let borrusia = Team("Боррусия", "Германия")
        let shalke = Team("Шальке", "Германия")
        let real = Team("Реал Мадрид", "Испания")
        let barca = Team("Барселона", "Испания")
        let atletico = Team("Атлетико Мадрид", "Испания")
        
        championsLeague.append(ChampionsLeague(group: "A", teams: [arsenal, borrusia, shalke, real]))
        championsLeague.append(ChampionsLeague(group: "B", teams: [city, united, bavaria, barca]))
        championsLeague.append(ChampionsLeague(group: "C", teams: [chelsea, tot, atletico]))
    }
    
    // MARK: DataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identificator)
        cell.textLabel?.text = "\(championsLeague[indexPath.section].teams[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(championsLeague[indexPath.section].teams[indexPath.row].country)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return championsLeague[0].teams.count
        case 1 :
            return championsLeague[1].teams.count
        case 2 :
            return championsLeague[2].teams.count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return championsLeague[section].group
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .green
        button.addAction(UIAction(handler: {_ in self.addRow(section)}), for: .touchUpInside)
        footerView.addSubview(button)
        return footerView
    }
    
    func addRow(_ sender: Int) {
        championsLeague[sender].teams.append(Team("Ливерпуль", "Англия"))
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return championsLeague.count
    }
    // MARK: Drag and Drop

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = championsLeague[sourceIndexPath.section].teams.remove(at: sourceIndexPath.row)
        championsLeague[destinationIndexPath.section].teams.insert(mover, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = championsLeague[indexPath.section].teams[indexPath.row]
        return [dragItem]
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            championsLeague[indexPath.section].teams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

}

