
import UIKit

//MARK: Delegate
protocol EndGameViewDelegate: AnyObject {
    func didUserTapGameOver(_ view: EndGameView)
}

class EndGameView: UIView {
    
    weak var delegate: EndGameViewDelegate?

//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: Methods
    @IBAction func onButton(_ sender: Any) {
        delegate?.didUserTapGameOver(self)
    }

}
