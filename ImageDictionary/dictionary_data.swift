//
//  dictionary_data.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 19/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import Foundation
import UIKit
//백과사전 검색결과 데이터
class Dictionary_Data {
    var title:String?
    var link:String?
    var image:UIImage?
    var description:String?
    var thumbnail:String?
    
    init()
    {
        
    }
    
    func getPosterImage() {
        guard thumbnail != nil else {
            return
        }
        if let url = URL(string: thumbnail!) {
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    self.image = image
                }
            }
        }
        return
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellIdentifier", for: indexPath) as! MoviesTableViewCell
        let movie = movies[indexPath.row]
        
        // cell 구성 부분 생략
        
        // Async activity
        // 영화 포스터 이미지 불러오기
        if let posterImage = movie.image {
            cell.posterImageView.image = posterImage
        } else {
            cell.posterImageView.image = UIImage(named: "noImage")
            DispatchQueue.main.async(execute: {
                movie.getPosterImage()
                guard let thumbImage = movie.image else {
                    return
                }
                cell.posterImageView.image = thumbImage
            })
        }
        return cell
    }
}
