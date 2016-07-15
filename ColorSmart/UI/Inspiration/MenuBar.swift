
import UIKit

@objc
protocol MenuBarDelegate {
    
    optional func scrollToMenuIndex(menuIndex: Int)
}

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       // cv.pagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var headerTitles = [String]()
    
    var delegate: MenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews(){
    
        collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.clearColor()

        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        collectionView.selectItemAtIndexPath(selectedIndexPath, animated: false, scrollPosition: .None)
        
        setupHorizontalBar()
        
    }
    
    var horizontalBarLeftConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftConstraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: horizontalBarView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        horizontalBarLeftConstraint?.priority = 250
        
        let bottomConstraint = NSLayoutConstraint.init(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: horizontalBarView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)

        let heightConstraint = NSLayoutConstraint.init(item: horizontalBarView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 4)
        
        let widthConstraint = NSLayoutConstraint.init(item: horizontalBarView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1/3, constant: 0)
        
        self.addConstraint(horizontalBarLeftConstraint!)
        self.addConstraint(bottomConstraint)
        self.addConstraint(heightConstraint)
        self.addConstraint(widthConstraint)
    }
    
    func updateHeaderTitles(titles : NSArray){
    
        self.headerTitles = titles as! [String]
        collectionView.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        delegate?.scrollToMenuIndex!(indexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerTitles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MenuCell
        
        cell.titlLbl.text = headerTitles[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(140, frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    

}

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let titlLbl: UILabel = {
        let lbl = BottomAlignedLabel()
        lbl.font = UIFont(name: "OpenSans-Regular", size: 12)
        lbl.textColor = UIColor.rgb(101, green: 109, blue: 120)
        lbl.textAlignment = .Center
        return lbl
    }()

    func setupViews() {
        
        addSubview(titlLbl)
        
        addConstraintsWithFormat("H:[v0(140)]", views: titlLbl)
        addConstraintsWithFormat("V:[v0(28)]", views: titlLbl)
        
        addConstraint(NSLayoutConstraint(item: titlLbl, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titlLbl, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }
    
}








