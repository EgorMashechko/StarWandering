
import UIKit

class GameCoordinator {
    
    enum ItemPositionX: UInt {
        case left = 1
        case mid = 2
        case right = 3
    }
    enum ItemSize: UInt {
        case small = 1
        case big = 2
    }
    enum ItemMoveDirection {
        case left
        case right
    }

//MARK: Properties
    private var gameView: UIView
    private var spaceShipSpeed: TimeInterval = 100 / TimeInterval(UserDefaults.standard.integer(forKey: "ship_speed"))
    private var asteroidGenerateInterval: TimeInterval = 2
    private var asteroidImages: [UIImage]?
    private var timer: Timer?
    private lazy var screenBounds = {
           self.gameView.bounds
    }()
    private var midPositionX: CGFloat {
        return screenBounds.midX
    }
    private var leftPositionX: CGFloat {
        return midPositionX - midPositionX / 2
    }
    private var rightPositionX: CGFloat {
        return midPositionX + midPositionX / 2
    }
    private var itemSmallSizeEdge: CGFloat {
        return screenBounds.width / 4
    }
    private var itemBigSizeEdge: CGFloat {
        return screenBounds.width / 2
    }
    
//MARK: Initialization
    init(of view: UIView){
        self.gameView = view
        var images = [UIImage]()
        for i in 1...Int.max {
            guard let image = UIImage(named: "asteroid\(i)") else {break}
            images.append(image)
        }
        self.asteroidImages = images
    }
    
//MARK: Methods
    func startAnimatingAsteroids() {
        self.activateTimer()
    }
    
    private func activateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: asteroidGenerateInterval, repeats: true) { (_) in
            self.addAnimatedAsteroid()
        }
        timer?.fire()
    }
    
//MARK: asteroid_methods
    private func addAnimatedAsteroid() {
        if let itemXPos = GameCoordinator.ItemPositionX(rawValue: UInt.random(in: 1...3)), let itemSize = GameCoordinator.ItemSize(rawValue: UInt.random(in: 1...2)) {
            if let asteroid = generateAsteroid(by: itemXPos, and: itemSize) {
                asteroid.delegate = self
                asteroid.frame.origin.y -= asteroid.frame.height
                self.gameView.insertSubview(asteroid, at: 0)
                UIView.animate(withDuration: spaceShipSpeed, delay: 2, options: .curveLinear, animations: {
                    asteroid.frame.origin.y = self.screenBounds.height
                }) { (_) in
                    asteroid.removeFromSuperview()
                }
            }
        }
    }
    
    private func generateAsteroid(by positionID: GameCoordinator.ItemPositionX, and sizeID: GameCoordinator.ItemSize) -> Asteroid? {
        let asteroid = Asteroid(frame: .zero)
        asteroid.contentMode = .scaleToFill
        switch sizeID {
        case .big:
            asteroid.frame.size = CGSize(width: itemBigSizeEdge, height: itemBigSizeEdge)
        case .small:
            asteroid.frame.size = CGSize(width: itemSmallSizeEdge, height: itemSmallSizeEdge)
        }
        switch positionID {
        case .left :
            asteroid.center.x = leftPositionX
        case .mid :
            asteroid.center.x = midPositionX
        case .right:
            asteroid.center.x = rightPositionX
        }
        guard let images = asteroidImages else {return asteroid}
        let image = images[Int.random(in: 0...(images.count - 1))]
        asteroid.image = image
        return asteroid
    }
    
//MARK: bullet_methods
    func addAnimatedBullet(_ bullet: Bullet, of ship: SpaceShip) {
        bullet.center = ship.center
        self.gameView.addSubview(bullet)
        UIView.animate(withDuration: 0.3, animations: {
            bullet.center.y = 0 - bullet.bounds.height
        }) { (_) in
            bullet.removeFromSuperview()
        }
    }
    
//MARK: general_methods
    func moveItem(_ item: UIView, direction: GameCoordinator.ItemMoveDirection) {
        switch direction {
        case .left:
            switch item.center.x {
            case midPositionX:
                animatedMove(item: item, to: leftPositionX)
            case rightPositionX:
                animatedMove(item: item, to: midPositionX)
            default:
                return
            }
        case .right:
            switch item.center.x {
            case midPositionX:
                animatedMove(item: item, to: rightPositionX)
            case leftPositionX:
                animatedMove(item: item, to: midPositionX)
            default:
                return
            }
        }
    }
    
    private func animatedMove(item: UIView, to posX: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            item.center.x = posX
        }
    }
    
//MARK: pause_animating_methods
    func pauseAnimations() {
        timer?.invalidate()
        for view in gameView.subviews where view is GameObject {
            view.layer.pause()
        }
    }
    
    func resumeAnimations() {
        self.activateTimer()
        for view in gameView.subviews where view is GameObject {
            view.layer.resume()
        }
    }
    
}

//MARK: Asteroid delegate
extension GameCoordinator: AsteroidDelegate {
    func didAsteroidExplose(_ asteroid: Asteroid) {
        (gameView as? GameView)?.increaseScore()
    }
}
