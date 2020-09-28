
import UIKit

//MARK: Delegate
protocol GameViewDelegate: AnyObject {
    func didUserSwipe(to direction: GameCoordinator.ItemMoveDirection)
    func didUserTap()
    func didUserPause()
}

class GameView: UIView {
    
//MARK: Properties
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var spaceShip: SpaceShip!
    private var isNeedCentering = true
    weak var delegate: GameViewDelegate?
    var score = 0 {
        willSet {
            scoreValueLabel.text = String(newValue)
        }
    }
    
//MARK: Initialization
    override func awakeFromNib() {
        setupSpaceShip()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.bounds.width / 6
        let height = self.bounds.height / 9
        spaceShip.frame.size = CGSize(width: width, height: height)
        
        if isNeedCentering {
            let centerPoint = CGPoint(x: self.bounds.midX, y: self.bounds.height - height)
            spaceShip.center = centerPoint
            
            isNeedCentering = false
        }
        
    }
    
    private func setupSpaceShip() {
        if let shipName = UserDefaults.standard.string(forKey: "ship_image_game") {
            if let image = UIImage(named: shipName) {
                spaceShip.image = image
            }
        }
    }

    
    func increaseScore() {
        score += 1
    }
    
    @IBAction func onPauseButton(_ sender: UIButton) {
        delegate?.didUserPause()
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            delegate?.didUserSwipe(to: .left)
        case .right:
            delegate?.didUserSwipe(to: .right)
        default: return
        }
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        delegate?.didUserTap()
    }
    
}
