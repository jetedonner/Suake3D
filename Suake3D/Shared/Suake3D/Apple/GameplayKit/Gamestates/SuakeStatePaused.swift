//
//  SuakeStateReadyToPlay.swift
//  Suake3D
//
//  Created by Kim David Hauser on 21.07.20.
//  Copyright © 2020 Kim David Hauser. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class SuakeStatePaused: SuakeBaseState {
    
    init(game: GameController) {
        super.init(game: game, stateDesc: GameStates.pausedState)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass == SuakeStatePlaying.self /*|| stateClass == SuakeStateMainMenu.self*/)
    }
    
    override func willExit(to nextState: GKState) {
        self.game.scene.isPaused = true
        self.game.scnView.isPlaying = false
    }
    
    override func didEnter(from previousState: GKState?) {
        if(previousState is SuakeStatePlaying || previousState is SuakeStateReadyToPlay){
            self.game.physicsHelper.togglePause(time: self.game.physicsHelper.lastUpdateTime)
//            self.game.playerEntityManager.isPaused = true
            self.game.overlayManager.showOverlay4GameState(type: .paused)
//            self.game.overlayManager.paused.runAnimation()
//            self.game.scnView.overlaySKScene = self.game.overlayManager.paused.sceneNode
            
//            self.game.overlayManager.paused.loadScene()
        }
    }
}
