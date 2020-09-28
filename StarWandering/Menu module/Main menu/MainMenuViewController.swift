
import UIKit

//MARK: Delegate
protocol MainMenuViewControllerDelegate: AnyObject {
    func didUserTapStart(_ mainMenu: MainMenuViewController)
}

class MainMenuViewController: UIViewController {
    
//MARK: Properties
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var shipImageView: UIImageView!
    weak var delegate: MainMenuViewControllerDelegate?
    
//MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageName = UserDefaults.standard.string(forKey: "ship_image_menu") {
            if let image = UIImage(named: imageName) {
                shipImageView.image = image
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        let size = CGSize(width: self.view.bounds.height * 2, height: self.view.bounds.height)
        backgroundImageView.frame.size = size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundImageView.frame.origin = .zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startBackgroundAnimate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stopBackgroundAnimate()
    }
    
//MARK: Methods
    func changeShipImage(to image: UIImage?) {
        if let newImage = image {
            UIView.transition(with: shipImageView, duration: 0.1, options: .transitionFlipFromRight, animations: {
                self.shipImageView.image = newImage
            }, completion: nil)
        }
    }

    @IBAction func onStartButton(_ sender: UIButton) {
        delegate?.didUserTapStart(self)
    }
    
    private func startBackgroundAnimate() {
        let offsetX = self.backgroundImageView.frame.width - self.view.frame.width
        UIView.animate(withDuration: 60, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.backgroundImageView.frame.origin.x -= offsetX
        }, completion: nil)
    }
    
    private func stopBackgroundAnimate() {
        backgroundImageView.layer.removeAllAnimations()
        self.backgroundImageView.frame.origin = .zero
    }
    
}
