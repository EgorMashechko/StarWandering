
import UIKit

//MARK: Delegate
protocol AsteroidDelegate: AnyObject {
    func didAsteroidExplose(_ asteroid: Asteroid)
}

class Asteroid: GameObject {
    
//MARK: Properties
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
                if let damageLvl = (object as! Bullet).damageLevel {
                    self.healthPoints -= Int(damageLvl)
                    guard self.healthPoints <= 0 else {return}
                    animatedExplose {
                        self.removeFromSuperview()
                        self.delegate?.didAsteroidExplose(self)
                    }
                }
            }
        }
    }

}

