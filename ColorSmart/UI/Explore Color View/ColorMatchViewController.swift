//
//  ColorMatchViewController.swift
//  ColorSmart
//
//  Created by David on 1/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import UIKit

class ColorMatchViewController: CenterViewController, UINavigationControllerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let options = ["LIBRARY", "CAMERA"]
    let offset : CGFloat = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView?.registerNib(UINib(nibName: "ColorMatchCellView" , bundle:nil), forCellWithReuseIdentifier: "ColorMatchCellView")
        
        self.addTopBarOnView(view)
        toolBar.setBackBtnTitle("COLOR MATCH")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = containerView.frame
        frame.origin.y = CGRectGetMaxY(toolBar.frame)
        frame.size.height = CGRectGetHeight(view.bounds) - CGRectGetHeight(toolBar.bounds)
        containerView.frame = frame
        
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        if isiPad(){
            collectionView.collectionViewLayout.invalidateLayout()
        }
        
    }
    
}

extension ColorMatchViewController : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorMatchCellView", forIndexPath: indexPath) as? ColorMatchCellView
        let title = self.options[indexPath.row]
        cell?.titleLbl.text = title
        
        let cellImage = (indexPath.row == 0) ? "Library Icon white" : "Camera Icon white"
        cell?.imageView.image = UIImage.init(named: cellImage)
        return cell!
    }
    
}

extension ColorMatchViewController : UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var imagePicker : UIImagePickerController?
        
        if indexPath.row == 0 {
        
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                
                imagePicker = UIImagePickerController()
                imagePicker!.delegate = self
                imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker!.allowsEditing = true
                
            }

        }else{
        
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                imagePicker = UIImagePickerController()
                imagePicker!.delegate = self
                imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker!.allowsEditing = false
            }

        }
        
        if imagePicker != nil {
            self.presentViewController(imagePicker!, animated: true, completion: nil)
        }
        
    }
}

extension ColorMatchViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        
        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation){
            
            return CGSizeMake(CGRectGetWidth(bounds)/2  , CGRectGetHeight(bounds))
            
        }
        
        return CGSizeMake(CGRectGetWidth(bounds), CGRectGetHeight(bounds)/2)

    }
}

extension ColorMatchViewController : UIImagePickerControllerDelegate{

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let nibName = isiPad() ? "ColorMatchPickerViewController_iPad" : "ColorMatchPickerViewController_iPhone"
        let colorPicker = ColorMatchPickerViewController(nibName: nibName, bundle: nil)
        colorPicker.pickerImage =  image
        self.navigationController?.pushViewController(colorPicker, animated: true)
        
    }

}

