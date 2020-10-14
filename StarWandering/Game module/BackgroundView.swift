
import UIKit

class BackgroundView: UIView {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstImageView.frame = self.frame
        secondImageView.frame = self.frame
    }
    
    func startAnimate() {
        firstImageView.frame.origin.y -= self.frame.height
        UIView.animate(withDuration: 20, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.secondImageView.frame.origin.y = self.frame.maxY
            self.firstImageView.frame.origin.y = 0
        }, completion: nil)
        
    }


}
