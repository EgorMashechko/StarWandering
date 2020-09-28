
import UIKit

//MARK: Delegate
protocol AsteroidDelegate: AnyObject {
    func didAsteroidExplose(_ asteroid: Asteroid)
}

class Asteroid: GameObject {
    
    weak var delegate: AsteroidDelegate?

//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    override func didCollided(with object: GameObject?) {
        if self.isCollisable {
            if object is Bullet {
                animatedExplose {
                    self.removeFromSuperview()
                    self.delegate?.didAsteroidExplose(self)
                }
            }
        }
    }

}

