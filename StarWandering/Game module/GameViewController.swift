import UIKit

class GameViewController: UIViewController {
    
//MARK: Properties
    private var spaceShip: SpaceShip?
    private var coordinator: GameCoordinator?
    private var catcher: CollisionCatcher?
    private var displaylink: CADisplayLink?
    private var menuView: InGameMenuView?
    private var endView: EndGameView?
    
    var gameView: GameView?
    var backgroundView: BackgroundView?
    
//MARK: LifeCycle methods
    override func loadView() {
        super.loadView()
        
        gameView = Bundle.main.loadNibNamed("GameView", owner: self, options: nil)?.first as? GameView
        backgroundView = Bundle.main.loadNibNamed("BackgroundView", owner: self, options: nil)?.first as? BackgroundView
        endView = Bundle.main.loadNibNamed("EndGameView", owner: self, options: nil)?.first as? EndGameView
        menuView = Bundle.main.loadNibNamed("InGameMenuView", owner: self, options: nil)?.first as? InGameMenuView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundView!)
        self.view.addSubview(gameView!)
        
        gameView?.delegate = self
        spaceShip = gameView?.spaceShip
        spaceShip?.delegate = self
        menuView?.delegate = self
        endView?.delegate = self
    
        coordinator = GameCoordinator(of: gameView!)
        catcher = CollisionCatcher(of: gameView!)
        
        displaylink = CADisplayLink(target: self, selector: #selector(catchCollision))
        displaylink?.add(to: .current, forMode: .default)
    }
    
    override func viewDidLayoutSubviews() {
        menuView?.frame = self.view.frame
        endView?.frame = self.view.frame
        gameView?.frame = self.view.frame
        backgroundView?.frame = self.view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coordinator?.startAnimatingAsteroids()
        
        backgroundView?.startAnimate()
    }
    
//MARK: Methods
    @objc func catchCollision() {
        if let view = gameView {
            for i in view.subviews {
                if let item = i as? GameObject {
                    if item.isCollisable{
                        catcher?.catchCollisions(of: item)
                    }
                }
            }
        }
    }
    
    func saveResult() {
        if let score = gameView?.score, score > 0 {
            let date = Date()
            let result = Result(value: score, date: date)
            ResultsManager.shared.saveNewResult(result)
        }
    }

}


//MARK: GameViewDelegate
extension GameViewController: GameViewDelegate {
    func didUserSwipe(to direction: GameCoordinator.ItemMoveDirection) {
        coordinator?.moveItem(spaceShip!, direction: direction)
    }
    
    func didUserTap() {
        spaceShip?.bulletShot()
    }
    
    func didUserPause() {
        coordinator?.pauseAnimations()
        self.view.addSubview(menuView!)
    }
}

//MARK: SpaceShipDelegate
extension GameViewController: SpaceShipDelegate {
    func didShipExplose(_ ship: SpaceShip) {
        coordinator?.pauseAnimations()
        self.view.addSubview(endView!)
    }
    
    func didShot(_ ship: SpaceShip, by bullet: Bullet) {
        coordinator?.addAnimatedBullet(bullet, of: ship)
    }
}

//MARK: InGameMenuViewDelegate
extension GameViewController: InGameMenuViewDelegate {
    func didUserTapContinue(_ view: InGameMenuView) {
        view.removeFromSuperview()
        coordinator?.resumeAnimations()
    }
    
    func didUserTapMenu(_ view: InGameMenuView) {
        saveResult()
        navigationController?.popToRootViewController(animated: true)
    }
}

//MARK: EndGameViewDelegate
extension GameViewController: EndGameViewDelegate {
    func didUserTapGameOver(_ view: EndGameView) {
        saveResult()
        navigationController?.popToRootViewController(animated: true)
    }
}

