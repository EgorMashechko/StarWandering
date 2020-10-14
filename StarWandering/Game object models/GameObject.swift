
import UIKit

class GameObject: UIImageView {
    
//MARK: Properties
    var healthPoints = 100
    var isCollisable = true
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        fillExplosionImages()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fillExplosionImages()
    }
    
//MARK: Methods
    func animatedExplose(completion: @escaping () -> Void) {
        guard let image = self.animationImages?.first else {
            completion()
            return
        }
        UIView.transition(with: self, duration: 0.03, options: .transitionCrossDissolve, animations: {
            self.image = image
        }) { (_) in
            self.isCollisable = false
            self.animationImages?.removeFirst()
            self.animatedExplose(completion: completion)
        }
    }
    
    private func fillExplosionImages() {
        var images = [UIImage]()
        for i in 1...Int.max {
            if let image = UIImage(named: "explosion\(i)") {
                images.append(image)
            } else {break}
        }
        self.animationImages = images
    }
    
    func didCollided(with object: GameObject?) {
        self.removeFromSuperview()
    }
    
}
