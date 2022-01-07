//
//  ChampionsLeague.swift
//  Lesson20.2
//
//  Created by Владислав Пуцыкович on 2.01.22.
//

import Foundation

struct ChampionsLeague {
    var group: String
    var teams: [Team]
    
    static func createTeams() -> [ChampionsLeague] {
        var championsLeague = [ChampionsLeague]()
        
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
        return championsLeague
    }
}
