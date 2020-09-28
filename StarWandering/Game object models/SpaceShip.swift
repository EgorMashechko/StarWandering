
import UIKit

//MARK: Delegate
protocol SpaceShipDelegate: AnyObject {
    func didShot(_ ship: SpaceShip, by bullet: Bullet)
    func didShipExplose(_ ship: SpaceShip)
}

class SpaceShip: GameObject {
    
    weak var delegate: SpaceShipDelegate?

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
            if let object = object as? Asteroid {
                if object.isCollisable {
                    self.isCollisable = false
                    animatedExplose {
                        self.removeFromSuperview()
                        self.delegate?.didShipExplose(self)
                    }
                }
            }
        }
    }
    
    func bulletShot() {
        let size = CGSize(width: self.bounds.width / 10, height: self.bounds.height / 10)
        let frame = CGRect(origin: .zero, size: size)
        let bullet = Bullet(frame: frame)
        bullet.image = UIImage(named: "bullet")
        delegate?.didShot(self, by: bullet)
    }
    
}

