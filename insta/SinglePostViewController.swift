//
//  SinglePostViewController.swift
//  insta
//
//  Created by Tu Le
//

import UIKit
import Parse

class SinglePostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var post : PFObject!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentTableView: UITableView!
    var comments = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set image of post
        let imageFile = post["image"] as! PFFileObject
        let urlStr = imageFile.url!
        let url = URL(string: urlStr)!
        imageView.af.setImage(withURL: url)
        
        // get the author
        let user = post["author"] as! PFUser
        
        // set profile image
        setProfilePic(photoFile: user["profile_pic"] as? PFFileObject, profileImage: profileImageView)
        
        // set username and caption
        nameLabel.text = user.username
        captionLabel.text = post["caption"] as! String
        
        // set table delegate & data source
        commentTableView.delegate = self
        commentTableView.dataSource = self
        loadComments()
        commentTableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    
    func loadComments() {
        comments = (post["comments"] as? [PFObject]) ?? []
        commentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        let comment = comments[indexPath.section]
        cell.commentLabel.text = comment["text"] as? String
        
        let user = comment["author"] as! PFUser
        cell.nameLabel.text = user.username
        
        setProfilePic(photoFile: user["profile_pic"] as? PFFileObject, cell: cell)
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
