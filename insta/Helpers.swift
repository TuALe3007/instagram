//
//  Helpers.swift
//  insta
//
//  Created by Tu Le
//

import Foundation
import Parse
import AlamofireImage

func setProfilePic(photoFile: PFFileObject?, profileImage: UIImageView!) {
    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    profileImage.clipsToBounds = true
    if photoFile != nil {
        let urlStr = photoFile!.url!
        let url = URL(string: urlStr)!
        profileImage.af.setImage(withURL: url)
    }
}

func setProfilePic(photoFile: PFFileObject?, cell: PostCell) {
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
    cell.profileImage.clipsToBounds = true
    if photoFile != nil {
        let urlStr = photoFile!.url!
        let url = URL(string: urlStr)!
        cell.profileImage.af.setImage(withURL: url)
    }
}

func setProfilePic(photoFile: PFFileObject?, cell: CommentCell) {
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
    cell.profileImage.clipsToBounds = true
    if photoFile != nil {
        let urlStr = photoFile!.url!
        let url = URL(string: urlStr)!
        cell.profileImage.af.setImage(withURL: url)
    }
}
