//
//  CatNode.swift
//  Cat Nap
//
//  Created by Van Luu on 02/07/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode {

}

extension CatNode: CustomNodeEvents {
  func didMoveToScene() {
    print("cat added to scene")
  }
}
