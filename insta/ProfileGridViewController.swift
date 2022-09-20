//
//  ProfileGridViewController.swift
//  insta
//
//  Created by Tu Le
//

import UIKit
import AlamofireImage
import Parse

class ProfileGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var posts = [PFObject]()
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfileInfo()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let width = (view.frame.size.width-layout.minimumInteritemSpacing*2)/3
        layout.itemSize = CGSize(width: width, height: width)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPosts()
        loadProfileInfo()
        
    }
    
    func loadProfileInfo() {
        
        // set profile image
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        if user["profile_pic"] != nil {
            let imageFile = user["profile_pic"] as! PFFileObject
            let urlStr = imageFile.url!
            let url = URL(string: urlStr)!
            profileImage.af.setImage(withURL: url)
        }
        
        // set username
        username.text = user.username
    }
    
    func loadPosts() {
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"]).whereKey("author", equalTo: user)
        query.limit = 20
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.item]
        let imageFile = post["image"] as! PFFileObject
        let urlStr = imageFile.url!
        let url = URL(string: urlStr)!
        cell.photoView.af.setImage(withURL: url)
        return cell
        
    }
    
    // prep for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueToSinglePost" else {return}
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = posts[indexPath.item]
        // pass the selected movie to details view controller
        let singlePostVC = segue.destination as! SinglePostViewController
        singlePostVC.post = post
        
        
    }
    

}
