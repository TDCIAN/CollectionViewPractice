//
//  ProfileController.swift
//  CollectionViewPractice
//
//  Created by APPLE on 2020/01/19.
//  Copyright © 2020 JeongminKim. All rights reserved.
//

import UIKit
import SnapKit

// 아이덴티파이어 만들 때는 클래스 밖에서 만든다
// 헤더를 위한 아이덴티파이어
private let headerIdentifer = "ProfileHeader"
private let cellIdentifier = "ProfileCell"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    // 콜렉션뷰에 다양한 아이템을 넣기 위해서는 배열을 사용하게 될 수밖에 없음을 알고 있어라
    var images: [UIImage] = [#imageLiteral(resourceName: "venom-6"), #imageLiteral(resourceName: "venom02"), #imageLiteral(resourceName: "carnage-2"), #imageLiteral(resourceName: "venom-7"), #imageLiteral(resourceName: "venom-8"), #imageLiteral(resourceName: "venom-10"), #imageLiteral(resourceName: "carnage"), #imageLiteral(resourceName: "carnage-venom"), #imageLiteral(resourceName: "venom-4"), #imageLiteral(resourceName: "venom-8"), #imageLiteral(resourceName: "venom-1"), #imageLiteral(resourceName: "venom-8"), #imageLiteral(resourceName: "venom-10"), #imageLiteral(resourceName: "carnage"), #imageLiteral(resourceName: "carnage-venom")]
    // ----------------------------------------
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 콜렉션뷰니까 그냥 백그라운드 하면 안 되고 콜렉션뷰의 백그라운드로 해야된다
        collectionView.backgroundColor = .systemOrange
        
        // 헤더(ProfileHeader.swift) 등록하는 부분
        collectionView!.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifer)
        
        // 셀(ProfileCell.swift) 등록하는 부분
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // 탈모부분 없앨 것인가 남겨둘 것인가 결정하는 부분 -> never로 하면 노치까지 다 쓴다
        // .automatic과 .always는 노치 안 쓴다
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    

}

// MARK: - UICollectionViewDelegate/DataSource

extension ProfileController {
    
    // 보여질 헤더를 위해 이게 필요하다 -> 콜렉션뷰의 헤더를 담당하는 부분
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { // ProfileHeader와 연결되는 부분
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifer, for: indexPath) as! ProfileHeader
        
        return header
    }
    
    // 셀 몇 개 보여줄거야?
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count // 배열 안의 컨텐츠 숫자만큼의 셀을 만들겠다
    }
    
    
    // 셀의 개수만큼 반복해서 호출되는 함수, 셀에 보여줄 내용을 결정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        
        print("내가 호출됐다 ---> \(indexPath.row)")
        // 셀마다 다른 이미지가 들어가기 위해서 이렇게 해줘야 한다
        cell.image = images[indexPath.row]
        // -------------------------------------
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    // 헤더의 넓이와 높이를 어떻게 할 것이냐?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 // minimumLineSpacingForSectionAt: 위에 셀과 아래 셀 간의 간격을 결정(행 간의 간격)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2 // minimumInteritemSpacingForSectionAt: 같은 행 내 셀 간의 간격을 설정(열 간의 간격)
    }
    
    // 아이템마다의 크기를 어떻게 할 것인가
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 5) / 3 // 뒤에 나누기 안 해주면 그냥 가득 차버린다. 나누는 숫자가 커질수록 셀의 크기는 작아짐
        return CGSize(width: width, height: width) // 정사각형
    }
    
}


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

