
import UIKit

class CollisionCatcher {
    
//MARK: Properties
    private var gameView: UIView?
    
//MARK: Initialization
    init(of view: UIView) {
        self.gameView = view
    }
    
//MARK: Methods
    func catchCollisions(of object: GameObject?) {
        if let gameField = gameView, let object = object {
            let subviews = gameField.subviews
            for view in subviews {
                if let view = view as? GameObject {
                    guard let frame = view.layer.presentation()?.frame else {continue}
                    guard let objectFrame = object.layer.presentation()?.frame else {continue}
                    if frame.intersects(objectFrame) {
                        object.didCollided(with: view)
                    }
                }
            }
        }
    }
    
    
}
