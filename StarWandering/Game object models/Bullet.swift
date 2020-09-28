
import UIKit

class Bullet: GameObject {
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    override func didCollided(with object: GameObject?) {
        if let object = object as? Asteroid {
            if object.isCollisable {
                self.removeFromSuperview()
            }
        }
    }
    

}
