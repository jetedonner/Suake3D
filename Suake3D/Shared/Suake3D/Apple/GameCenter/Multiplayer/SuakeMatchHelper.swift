//
//  SuakeMatchHelper.swift
//  Suake3D
//
//  Created by Kim David Hauser on 25.03.21.
//

import Foundation
import SceneKit
import GameKit

struct GameData: Codable {
//    var players: [Player] = []
    var time: Int = 60
    var keyPress:Int = 0
    var ext:Data!
}

struct GameDataExt: Codable {
//    var players: [Player] = []
    var time: Int = 60
    var typeValue:Int = 0
}

extension GameData {
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func decode(data: Data) -> GameData? {
        return try? JSONDecoder().decode(GameData.self, from: data)
    }
}

extension GameDataExt {
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func decode(data: Data) -> GameDataExt? {
        return try? JSONDecoder().decode(GameDataExt.self, from: data)
    }
}

class SuakeMatchHelper:SuakeGameClass, GKMatchDelegate{
    
    var match:GKMatch!
    
    override init(game: GameController) {
        super.init(game: game)
    }
        
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        if(self.match != match){
            return
        }
        
    }
    
    func sendGameData(gameData:GameData) {
        guard let match = match else { return }
        
        do {
            guard let data = gameData.encode() else { return }
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Send gameData failed \(error)")
        }
    }
    
    func sendGameDataExt(gameData:GameData, gameDataExt: GameDataExt) {
        guard let match = match else { return }
        
        do {
            var tmpData = gameData
            guard let dataExt = gameDataExt.encode() else { return }
            tmpData.ext = dataExt
            guard let data = tmpData.encode() else { return }
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Send gameData failed")
        }
    }
}
